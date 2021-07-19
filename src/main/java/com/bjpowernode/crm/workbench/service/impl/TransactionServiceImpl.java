package com.bjpowernode.crm.workbench.service.impl;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.StyleSet;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.settings.bean.*;
import com.bjpowernode.crm.settings.mapper.*;
import com.bjpowernode.crm.workbench.base.*;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.workbench.service.TransactionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.*;

//交易
@Service
public class TransactionServiceImpl implements TransactionService {
    //注入mapper层对象
    @Autowired
    private TransactionMapper transactionMapper;

    //注入user
    @Autowired
    private UserMapper userMapper;
    //注入custacts
    @Autowired
    private CustomerMapper customerMapper;

    //注入activity
    @Autowired
    private ActivityMapper activityMapper;

    //注入contactsMapper
    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private TransactionRemarkMapper transactionRemarkMapper;

    @Autowired
    private TransactionHistoryMapper transactionHistoryMapper;

    @Override
    public PageInfo<Transaction> selectTransaction(Integer currentPage, Integer rowsPerPage,Transaction transaction1) {
        Example example = new Example(Transaction.class);
        Example.Criteria criteria = example.createCriteria();
        //所有者
        if (StrUtil.isNotEmpty(transaction1.getOwner())) {
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + transaction1.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }

        if (StrUtil.isNotEmpty(transaction1.getName())) {
            criteria.andLike("name", "%" + transaction1.getName() + "%");
        }
        //客户名称
        if (StrUtil.isNotEmpty(transaction1.getCustomerId())) {
            Example example1 = new Example(Customer.class);
            example1.createCriteria().andLike("name", "%" + transaction1.getCustomerId() + "%");
            List<Customer> customers = customerMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (Customer customer : customers) {
                list.add(customer.getId());
            }
            criteria.andIn("customerId",list);
        }
        if (!"请选择".equals(transaction1.getStage())) {
            criteria.andLike("stage", "%" + transaction1.getStage() + "%");
        }
        if (!"请选择".equals(transaction1.getType())) {
            criteria.andLike("type", "%" + transaction1.getType() + "%");
        }
        if (!"请选择".equals(transaction1.getSource())) {
            criteria.andLike("source", "%" + transaction1.getSource() + "%");
        }
        //联系人名称
        if (StrUtil.isNotEmpty(transaction1.getContactsId())) {
            Example example1 = new Example(Contacts.class);
            example1.createCriteria().andLike("fullname", "%" + transaction1.getContactsId() + "%");
            List<Contacts> contacts = contactsMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (Contacts contacts1 : contacts) {
                list.add(contacts1.getId());
            }
            criteria.andIn("contactsId",list);
        }


        PageHelper.startPage(currentPage,rowsPerPage);
        List<Transaction> transactions = transactionMapper.selectByExample(example);
        for (Transaction transaction : transactions) {
            User user = userMapper.selectByPrimaryKey(transaction.getOwner());
            transaction.setOwner(user.getName());
            //客户名称
            Customer customer = customerMapper.selectByPrimaryKey(transaction.getCustomerId());
            transaction.setCustomerId(customer.getName());
            //类型
            Activity activity = activityMapper.selectByPrimaryKey(transaction.getActivityId());
            transaction.setActivityId(activity.getName());
            //联系人名称
            Contacts contacts = contactsMapper.selectByPrimaryKey(transaction.getContactsId());
            transaction.setContactsId(contacts.getFullname());
        }
        PageInfo<Transaction> pageInfo = new PageInfo(transactions);

        return pageInfo;
    }
    //查询客户信息
    @Override
    public List<String> queryCustomerName(String customerName,User user) {
        Example example = new Example(Customer.class);
        example.createCriteria().andLike("name","%" + customerName + "%");
        List<Customer> customers = customerMapper.selectByExample(example);
        List<String> list = new ArrayList<>();
        if (customers.size() == 0){
            //说明没有
            Customer customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setOwner(user.getId());
            int count = customerMapper.insertSelective(customer);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__Customer_add);
            }
            list.add(customer.getName());
        }
        for (Customer customer : customers) {
            list.add(customer.getName());
        }

        return list;
    }
    //查询所有市场活动
    @Override
    public List<Activity> selectAc(String name) {
        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(name)){
            criteria.andLike("name","%" + name + "%");

        }
        List<Activity> activityList = activityMapper.selectByExample(example);
        for (Activity activity : activityList) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activityList;
    }
    //查询联系人
    @Override
    public List<Contacts> selectAc1(String fullname) {
        Example example = new Example(Contacts.class);
        Example.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(fullname)){
            criteria.andLike("fullname","%" + fullname + "%");
        }
        List<Contacts> contacts = contactsMapper.selectByExample(example);

        return contacts;
    }

    //添加和修改             《修改有个bug    必须修改市场活动和联系人》搞定了
    @Override
    public ResultVo addTranUpdate(Transaction transaction, User user) {
        ResultVo resultVo = new ResultVo();
        int count = 0;
        //添加
        if (transaction.getId() != null && !"".equals(transaction.getId())){
            //修改
            transaction.setEditBy(user.getName());
            transaction.setEditTime(DateTimeUtil.getSysTime());
            //查询到补全的内容来和客户表查询
            Customer customer = new Customer();
            customer.setName(transaction.getCustomerId());
            List<Customer> select = customerMapper.select(customer);
            for (Customer customer1 : select) {
                transaction.setCustomerId(customer1.getId());
            }
            //市场活动
            Activity activity = new Activity();
            activity.setName(transaction.getActivityId());
            List<Activity> select1 = activityMapper.select(activity);
            for (Activity activity1 : select1) {
                transaction.setActivityId(activity1.getId());
            }
            //联系人
            Contacts contacts = new Contacts();
            contacts.setFullname(transaction.getContactsId());
            List<Contacts> select2 = contactsMapper.select(contacts);
            for (Contacts contacts1 : select2) {
                transaction.setContactsId(contacts1.getId());
            }
            count = transactionMapper.updateByPrimaryKeySelective(transaction);
            if (count == 0){
                throw new CrmException(CrmEnum.Tran__update_edit);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改交易成功!");
        }else {
            transaction.setId(UUIDUtil.getUUID());
            transaction.setCreateBy(user.getName());
            transaction.setCreateTime(DateTimeUtil.getSysTime());
            //查询到补全的内容来和客户表查询
            Customer customer = new Customer();
            customer.setName(transaction.getCustomerId());
            List<Customer> select = customerMapper.select(customer);
            for (Customer customer1 : select) {
                transaction.setCustomerId(customer1.getId());
            }
            //添加
            count = transactionMapper.insertSelective(transaction);
            if (count == 0){
                throw new CrmException(CrmEnum.Tran__add_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加交易成功!");
        }
        return resultVo;
    }

    //修改的查询方法
    @Override
    public Transaction selectTran(String id) {
        Transaction transaction = transactionMapper.selectByPrimaryKey(id);
        //客户
        Customer customer = customerMapper.selectByPrimaryKey(transaction.getCustomerId());
        transaction.setCustomerId(customer.getName());
        //市场活动
        Activity activity = activityMapper.selectByPrimaryKey(transaction.getActivityId());
        transaction.setActivityId(activity.getName());
        //联系人
        Contacts contacts = contactsMapper.selectByPrimaryKey(transaction.getContactsId());
        transaction.setContactsId(contacts.getFullname());
        return transaction;
    }

    //删除的方法
    @Override
    public ResultVo deletesTran(String ids) {
        String[] idss = ids.split(",");
        List<String> id = Arrays.asList(idss);
        Example example = new Example(Transaction.class);
        example.createCriteria().andIn("id",id);
        int count = transactionMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Tran__delete_delete);
        }
        ResultVo resultVo = new ResultVo();
        resultVo.setOk(true);
        resultVo.setMessage("删除成功！共删除【"+count+"】条记录!");

        return resultVo;
    }
    //删除的方法
    @Override
    public ResultVo deleteTran(String id) {
        ResultVo resultVo = new ResultVo();
        int count = transactionMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.Tran__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功!");

        return resultVo;
    }

    //详情页查询的方法
    @Override
    public Transaction queryTransaction(String id) {
        Transaction transaction = transactionMapper.selectByPrimaryKey(id);
        //所有者
        User user = userMapper.selectByPrimaryKey(transaction.getOwner());
        transaction.setOwner(user.getName());
        //联系人
        Contacts contacts = contactsMapper.selectByPrimaryKey(transaction.getContactsId());
        transaction.setContactsId(contacts.getFullname());
        //客户
        Customer customer = customerMapper.selectByPrimaryKey(transaction.getCustomerId());
        transaction.setCustomerId(customer.getName());
        //市场活动
        Activity activity = activityMapper.selectByPrimaryKey(transaction.getActivityId());
        transaction.setActivityId(activity.getName());
        //查询备注
        List<TransactionRemark> transactionRemarks = transactionRemarkMapper.selectAll();
        for (TransactionRemark transactionRemark : transactionRemarks) {
            //头像
            User user1 = userMapper.selectByPrimaryKey(transactionRemark.getOwner());
            transactionRemark.setImg(user1.getImg());
            //交易名称
            Transaction transaction1 = transactionMapper.selectByPrimaryKey(transactionRemark.getTranId());
            transactionRemark.setTranId(transaction1.getName());
        }
        transaction.setTransactionRemarks(transactionRemarks);
        //查询交易历史
        TransactionHistory transactionHistory1 = new TransactionHistory();
        transactionHistory1.setTranId(id);
        List<TransactionHistory> transactionHistories = transactionHistoryMapper.select(transactionHistory1);
        for (TransactionHistory transactionHistory : transactionHistories) {
            Transaction transaction1 = transactionMapper.selectByPrimaryKey(transactionHistory.getTranId());
            transactionHistory.setTranId(transaction1.getName());
        }
        transaction.setTransactionHistories(transactionHistories);

        return transaction;
    }

    //查询当前阶段的所有图标
    @Override
    public Map<String, Object> queryStages(String id, Map<String, String> map, Integer index,User user) {
        Map<String,Object> map1 = new HashMap<>();
        int count = 0;
        //状态
        String currentStage = null;
        //可能性
        String currentPossibility = null;
        //把map转换为list集合
        Set<Map.Entry<String, String>> entries = map.entrySet();
        List<Map.Entry<String, String>> list = new ArrayList<>(entries);
        Transaction transaction = transactionMapper.selectByPrimaryKey(id);
        //定义变量作为下标
        int position = 0;
        //判断
        if (index == null){
            //没有点击图标
            currentStage = transaction.getStage();
            currentPossibility = transaction.getPossibility();
        }else {
            //点击图标了
            position = index;
            //取出index对应的阶段和可能性
             currentStage = list.get(position).getKey();
             currentPossibility = list.get(position).getValue();
             Transaction transaction1 = new Transaction();
             transaction1.setStage(currentStage);
             transaction1.setPossibility(currentPossibility);
             transaction1.setActivityId(transaction.getActivityId());
             transaction1.setCustomerId(transaction.getCustomerId());
             transaction1.setContactsId(transaction.getContactsId());
             transaction1.setOwner(transaction.getOwner());
             transaction1.setEditBy(user.getName());
             transaction1.setEditTime(DateTimeUtil.getSysTime());
             transaction1.setCreateBy(transaction.getCreateBy());
             transaction1.setCreateTime(transaction.getCreateTime());
             transaction1.setId(transaction.getId());
             transaction1.setDescription(transaction.getDescription());
             transaction1.setContactSummary(transaction.getContactSummary());
             transaction1.setExpectedDate(transaction.getExpectedDate());
             transaction1.setImg(transaction.getImg());
             transaction1.setMoney(transaction.getMoney());
             transaction1.setNextContactTime(transaction.getNextContactTime());
             transaction1.setName(transaction.getName());
             transaction1.setSource(transaction.getSource());
             transaction1.setType(transaction.getType());
             //修改
             count = transactionMapper.updateByPrimaryKeySelective(transaction1);
            if (count == 0){
                throw new CrmException(CrmEnum.TranHistory__update_edit);
            }

            map1.put("transaction",transaction1);

             //添加一条历史记录
            TransactionHistory transactionHistory = new TransactionHistory();
            transactionHistory.setId(UUIDUtil.getUUID());
            transactionHistory.setTranId(id);
            transactionHistory.setMoney(transaction.getMoney());
            transactionHistory.setExpectedDate(transaction.getExpectedDate());
            transactionHistory.setStage(currentStage);
            transactionHistory.setPossibility(currentPossibility);
            transactionHistory.setCreateBy(user.getName());
            transactionHistory.setCreateTime(DateTimeUtil.getSysTime());
             count = transactionHistoryMapper.insertSelective(transactionHistory);
            if (count == 0){
                throw new CrmException(CrmEnum.TranHistory__add_add);
            }
            map1.put("transactionHistory",transactionHistory);
        }
        //查询信息
        //定义一个集合对象保存图标信息
        List<TranStageIcon> tranStageIcons = new ArrayList<>();
        //定义一个pointer:第一个可能性为0的阶段的索引位置
        int pointer = 0;
        for (int i = 0;i < list.size(); i++){
            Map.Entry<String, String> entry = list.get(i);
            //可能性
            String possibility = entry.getValue();
            if ("0".equals(possibility)){
                //说明失败了
                pointer = i;
                break;
            }
        }
        for (int i = 0; i < list.size(); i++) {
            Map.Entry<String, String> entry = list.get(i);
            String possibility = entry.getValue();
            //可能性
            if (currentPossibility.equals(possibility)){
                //当前位置
                position = i;
                break;
            }
        }
        if ("0".equals(currentPossibility)){
            //可以确定是失败了,但不知道是在哪里失败
            for (int i = 0; i < list.size(); i++) {
                TranStageIcon tranStageIcon = new TranStageIcon();
                Map.Entry<String, String> entry = list.get(i);
                //阶段
                String stage = entry.getKey();
                //可能性
                String possibility = entry.getValue();
                if ("0".equals(possibility)){
                    if (currentStage.equals(stage)){
                        //红X的位置
                        tranStageIcon.setType("红X");
                    }else {
                        //黑X的位置
                        tranStageIcon.setType("黑X");
                    }
                }else {
                    //黑圈
                    tranStageIcon.setType("黑圈");
                }
                tranStageIcon.setTitle(stage+":"+possibility);
                tranStageIcon.setIndex(String.valueOf(i));
                tranStageIcons.add(tranStageIcon);
            }
        }else {
            //成功的交易中   最后两个是黑X
            for (int i = 0; i < list.size(); i++) {
                TranStageIcon tranStageIcon = new TranStageIcon();
                Map.Entry<String, String> entry = list.get(i);
                //阶段
                String stage = entry.getKey();
                //可能性
                String possibility = entry.getValue();
                if (i < position){
                    tranStageIcon.setType("绿圈");
                }else if (i == position){
                    tranStageIcon.setType("锚点");
                }else if (i > position && i < pointer){
                    tranStageIcon.setType("黑圈");
                }else {
                    tranStageIcon.setType("黑X");
                }
                tranStageIcon.setTitle(stage+":"+possibility);
                tranStageIcon.setIndex(String.valueOf(i));
                tranStageIcons.add(tranStageIcon);
            }
        }
        map1.put("tranStageIcons",tranStageIcons);

        return map1;
    }

    //添加备注
    @Override
    public ResultVo addRemark(TransactionRemark transactionRemark,User user) {
        ResultVo resultVo = new ResultVo();
        transactionRemark.setId(UUIDUtil.getUUID());
        transactionRemark.setCreateBy(user.getName());
        transactionRemark.setCreateTime(DateTimeUtil.getSysTime());
        transactionRemark.setOwner(user.getId());
        transactionRemark.setImg(user.getImg());
        int count = transactionRemarkMapper.insertSelective(transactionRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.TranRemark__add_add);
        }
        Transaction transaction = transactionMapper.selectByPrimaryKey(transactionRemark.getTranId());
        transactionRemark.setTranId(transaction.getName());
        resultVo.setOk(true);
        resultVo.setMessage("添加备注成功!");
        resultVo.setT(transactionRemark);

        return resultVo;
    }

    //修改备注
    @Override
    public ResultVo editRemark(TransactionRemark transactionRemark, User user) {
        int i = 1;
        ResultVo resultVo = new ResultVo();
        TransactionRemark transactionRemark1 = transactionRemarkMapper.selectByPrimaryKey(transactionRemark.getId());
        transactionRemark.setCreateBy(transactionRemark1.getCreateBy());
        transactionRemark.setCreateTime(transactionRemark1.getCreateTime());
        transactionRemark.setOwner(transactionRemark1.getOwner());
        transactionRemark.setTranId(transactionRemark1.getTranId());
        transactionRemark.setEditBy(user.getName());
        transactionRemark.setEditFlag(String.valueOf(i));
        transactionRemark.setEditTime(DateTimeUtil.getSysTime());
        transactionRemark.setImg(user.getImg());

        int count = transactionRemarkMapper.updateByPrimaryKey(transactionRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.TranRemark__update_edit);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改备注成功!");
        return resultVo;
    }

    //删除备注
    @Override
    public ResultVo deleteRemark(String id) {
        ResultVo resultVo = new ResultVo();
        int count = transactionRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.TranRemark__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功!");
        return resultVo;
    }

    //导出报表
    @Override
    public ExcelWriter exportExcel() {
        ExcelWriter writer = ExcelUtil.getWriter();
        List<Transaction> transactions = transactionMapper.selectAll();
        for (Transaction transaction : transactions) {
            //备注
            TransactionRemark transactionRemark = new TransactionRemark();
            transactionRemark.setTranId(transaction.getId());
            List<TransactionRemark> remarks = transactionRemarkMapper.select(transactionRemark);
            transaction.setTransactionRemarks(remarks);
            //所有者
            User user = userMapper.selectByPrimaryKey(transaction.getOwner());
            transaction.setOwner(user.getName());
            //市场活动
            Activity activity = activityMapper.selectByPrimaryKey(transaction.getActivityId());
            transaction.setActivityId(activity.getName());
            //客户
            Customer customer = customerMapper.selectByPrimaryKey(transaction.getCustomerId());
            transaction.setCustomerId(customer.getName());
            //联系人
            Contacts contacts = contactsMapper.selectByPrimaryKey(transaction.getContactsId());
            transaction.setContactsId(contacts.getFullname()+contacts.getAppellation());
        }
        writer.merge(Transaction.index - 1,"交易报表");
        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();
        //自定义标题别名
        writer.addHeaderAlias("transactionRemarks", "备注");
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("owner", "所有者");
        writer.addHeaderAlias("money", "金额");
        writer.addHeaderAlias("name", "名称");
        writer.addHeaderAlias("expectedDate", "预计成交日期");
        writer.addHeaderAlias("customerId", "客户名称");
        writer.addHeaderAlias("stage", "阶段");
        writer.addHeaderAlias("possibility", "可能性");
        writer.addHeaderAlias("type", "类型");
        writer.addHeaderAlias("source", "来源");
        writer.addHeaderAlias("activityId", "市场活动名称");
        writer.addHeaderAlias("contactsId", "联系人名称");
        writer.addHeaderAlias("createBy", "创建人");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("editBy", "修改人");
        writer.addHeaderAlias("editTime", "修改时间");
        writer.addHeaderAlias("description", "描述");
        writer.addHeaderAlias("contactSummary", "联系纪要");
        writer.addHeaderAlias("nextContactTime", "下次联系时间");

        writer.write(transactions, true);
        return writer;
    }
}
