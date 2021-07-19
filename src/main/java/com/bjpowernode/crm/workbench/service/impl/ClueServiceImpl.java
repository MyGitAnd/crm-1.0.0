package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.StyleSet;
import com.alibaba.fastjson.support.odps.udf.CodecCheck;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.base.*;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    @Autowired
    private ClueActivityMapper clueActivityMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ContactsActivityMapper contactsActivityMapper;

    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    @Autowired
    private TransactionMapper transactionMapper;

    @Autowired
    private TransactionRemarkMapper transactionRemarkMapper;

    @Autowired
    private TransactionHistoryMapper transactionHistoryMapper;

    @Autowired
    private ContactsMapper contactsMapper;

    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private CustomerRemarkMapper customerRemarkMapper;

    //添加和修改的方法
    @Override
    public ResultVo addAndUpdateClue(Clue clue, User user) {
        ResultVo resultVo = new ResultVo();

        if (clue.getId() != null) {
            //修改的方法
            clue.setEditBy(user.getName());
            clue.setEditTime(DateTimeUtil.getSysTime());
            int count = clueMapper.updateByPrimaryKeySelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.Clue__update_update);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改线索成功！");
        } else {
            //添加的
            clue.setId(UUIDUtil.getUUID());
            clue.setCreateBy(user.getName());
            clue.setCreateTime(DateTimeUtil.getSysTime());

            int count = clueMapper.insertSelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.Clue__insert_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加线索成功!");
        }
            return resultVo;
    }
    //查询的方法
    @Override
    public PageInfo selectClues(Integer page, Integer pageSize, Clue clue) {
        Example example = new Example(Clue.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(clue.getFullname())) {
            criteria.andLike("fullname", "%" + clue.getFullname() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getCompany())) {
            criteria.andLike("company", "%" + clue.getCompany() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getPhone())) {
            criteria.andLike("phone", "%" + clue.getPhone() + "%");
        }
        if (!"请选择".equals(clue.getSource())) {
            criteria.andLike("source", "%" + clue.getSource() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getOwner())) {
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + clue.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                    list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }
        if (StrUtil.isNotEmpty(clue.getMphone())) {
            criteria.andLike("mphone", "%" + clue.getMphone() + "%");
        }
        if (!"请选择".equals(clue.getState())) {
            criteria.andLike("state", "%" + clue.getState() + "%");
        }

        PageHelper.startPage(page, pageSize);
        List<Clue> clues = clueMapper.selectByExample(example);
        for (Clue clue1 : clues) {
            User user = userMapper.selectByPrimaryKey(clue1.getOwner());
            clue1.setFullname(clue1.getFullname() + clue1.getAppellation());
            clue1.setOwner(user.getName());
        }
        PageInfo<Clue> pageInfo = new PageInfo(clues);

        return pageInfo;
    }
//  修改的查询方法
    @Override
    public Clue editClue(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);
//        User user = userMapper.selectByPrimaryKey(clue.getOwner());
//        clue.setOwner(user.getName());
        return clue;
    }
    //删除的方法
    @Override
    public ResultVo deleteClue(String ids) {
        ResultVo resultVo = new ResultVo();
        String[] Cids = ids.split(",");
        List<String> list = Arrays.asList(Cids);
        Example example = new Example(Clue.class);
        example.createCriteria().andIn("id",list);
        int count = clueMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Clue__Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功! 共删除【"+count+"】条数据!");
        return resultVo;
    }
    //查询副页面的表单数据
    @Override
    public Clue selectClue(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //所有者
        User user = userMapper.selectByPrimaryKey(clue.getOwner());
        clue.setOwner(user.getName());
        ClueRemark clueRemark = new ClueRemark();
        clueRemark.setClueId(clue.getId());
        List<ClueRemark> clueRemarks = clueRemarkMapper.select(clueRemark);
        for (ClueRemark remark : clueRemarks) {
            remark.setClueId(clue.getFullname() + clue.getAppellation());
            User user1 = userMapper.selectByPrimaryKey(remark.getOwner());
            remark.setImg(user1.getImg());
        }
        //把集合放到对象中
        clue.setClueRemarks(clueRemarks);

        return clue;
    }
    //删除表单
    @Override
    public ResultVo delete(String id) {
        ResultVo resultVo = new ResultVo();
        int count = clueMapper.deleteByPrimaryKey(id);
        if (count==0){
            throw new CrmException(CrmEnum.Clue__Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功！");

        return resultVo;
    }
//添加备注信息
    @Override
    public ResultVo saveRemark(ClueRemark clueRemark, User user) {
        ResultVo resultVo = new ResultVo();
        clueRemark.setId(UUIDUtil.getUUID());
        clueRemark.setCreateBy(user.getName());
        clueRemark.setOwner(user.getId());
        clueRemark.setImg(user.getImg());
        clueRemark.setCreateTime(DateTimeUtil.getSysTime());
        int count = clueRemarkMapper.insertSelective(clueRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__add_insert);
        }

        Clue clue = editClue(clueRemark.getClueId());
        clueRemark.setClueId(clue.getFullname()+clue.getAppellation());

        resultVo.setOk(true);
        resultVo.setMessage("添加备注信息成功!");
        resultVo.setT(clueRemark);
        return resultVo;
    }
    //修改备注信息
    @Override
    public ResultVo updateClueRemark(ClueRemark clueRemark, User user) {
        ResultVo resultVo = new ResultVo();
        clueRemark.setEditBy(user.getName());
        clueRemark.setEditFlag("1");
        clueRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = clueRemarkMapper.updateByPrimaryKeySelective(clueRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__Edit_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改备注信息成功!");
        return resultVo;
    }
    //删除备注信息
    @Override
    public ResultVo deleteClueRemark(String id) {
        ResultVo resultVo = new ResultVo();
        int count = clueRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__Delete_Delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功!");
        return resultVo;
    }

    //查询关联的市场活动
    @Override
    public List<Activity> selectClueActivity(String id) {
        ClueActivity clueActivity = new ClueActivity();
        clueActivity.setClueId(id);
        List<ClueActivity> activities = clueActivityMapper.select(clueActivity);
        //创建集合保存数据
        List<Activity> activityList = new ArrayList<>();
        for (ClueActivity activity : activities) {
            //根据外键查询市场活动信息
            Activity activity1 = activityMapper.selectByPrimaryKey(activity.getActivityId());
            //查询所有者信息
            User user = userMapper.selectByPrimaryKey(activity1.getOwner());
            activity1.setOwner(user.getName());
            activityList.add(activity1);
        }
        return activityList;
    }

    //查询市场活动
    @Override
    public List<Activity> selectActivity(String id, String name) {
            ClueActivity clueActivity = new ClueActivity();
            clueActivity.setClueId(id);
            List<ClueActivity> clueActivities = clueActivityMapper.select(clueActivity);
            List<Activity> activities1 = null;
            //保存数据
            if (clueActivities.size() > 0){
                List<String> ids = new ArrayList<>();
                for (ClueActivity activity : clueActivities) {
                    ids.add(activity.getActivityId());
                }
                Example example = new Example(Activity.class);
                Example.Criteria criteria = example.createCriteria();
                criteria.andLike("name","%" + name + "%");
                criteria.andNotIn("id",ids);
                activities1 = activityMapper.selectByExample(example);
            } else {
                Example example = new Example(Activity.class);
                Example.Criteria criteria = example.createCriteria();
                criteria.andLike("name","%" + name + "%");
                activities1 = activityMapper.selectByExample(example);
            }
            for (Activity activity : activities1) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
            }
            return activities1;
    }
    //关联市场活动
    @Override
    public ResultVo addClueActivitys(String id, String ids) {
        String[] idss = ids.split(",");
        List<String> asList = Arrays.asList(idss);
        for (String s : asList) {
            ClueActivity clueActivity = new ClueActivity();
            clueActivity.setId(UUIDUtil.getUUID());
            clueActivity.setClueId(id);
            clueActivity.setActivityId(s);
            int count = clueActivityMapper.insertSelective(clueActivity);
            if (count==0){
                throw new CrmException(CrmEnum.ClueActivity__add_insert);
            }
        }
        //查询已经关联的市场活动
//        List<Activity> activityList = selectClueActivity(id);
        ResultVo resultVo = new ResultVo();
        resultVo.setOk(true);
        resultVo.setMessage("关联市场活动成功!");
        //resultVo.setT(activityList);
        return resultVo;
    }

    //解除关联市场活动
    @Override
    public ResultVo deleteClueActivity(String activityId,String clueId) {
        ResultVo resultVo = new ResultVo();
        ClueActivity clueActivity = new ClueActivity();
        clueActivity.setActivityId(activityId);
        clueActivity.setClueId(clueId);
        List<ClueActivity> select = clueActivityMapper.select(clueActivity);
        for (ClueActivity activity : select) {
            int count = clueActivityMapper.deleteByPrimaryKey(activity.getId());
            if (count == 0){
                throw new CrmException(CrmEnum.ClueActivity__delete_delete);
            }
        }
        resultVo.setOk(true);
        resultVo.setMessage("解除关联市场活动成功!");
        return resultVo;
    }

    //转换页面的查询的方法
    @Override
    public Clue selectConvent(String id) {

        Clue clue = clueMapper.selectByPrimaryKey(id);
        User user = userMapper.selectByPrimaryKey(clue.getOwner());
        clue.setOwner(user.getName());
        return clue;
    }

//查询关联的市场活动
    @Override
    public List<Activity> selectActivity01(String id, String name) {
        ClueActivity clueActivity = new ClueActivity();
        clueActivity.setClueId(id);
        List<ClueActivity> clueActivities = clueActivityMapper.select(clueActivity);
        List<String> ids = new ArrayList<>();
        for (ClueActivity activity : clueActivities) {
            ids.add(activity.getActivityId());
        }
        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andLike("name","%" + name +"%").andIn("id",ids);
        List<Activity> activityList = activityMapper.selectByExample(example);
        for (Activity activity : activityList) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
        }
        return activityList;
    }
//转换
    @Override
    public ResultVo transfer(User user, String isTran, Transaction transaction, String id) {
        int count = 0;
        //根据线索的主键查询线索的信息(线索包含自身的信息，包含客户的信息，包含联系人信息)
        Clue clue = clueMapper.selectByPrimaryKey(id);
        //2、先将线索中的客户信息取出来保存在客户表中，当该客户不存在的时候，新建客户(按公司名称
            Customer customer = new Customer();
            customer.setName(clue.getCompany());
        List<Customer> customers = customerMapper.select(customer);
        if (customers.size() == 0){
            //创建
            customer.setId(UUIDUtil.getUUID());
            customer.setName(clue.getCompany());
            customer.setOwner(clue.getOwner());
            customer.setCreateBy(user.getName());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setAddress(clue.getAddress());
            customer.setContactSummary(clue.getContactSummary());
            customer.setDescription(clue.getDescription());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setPhone(clue.getPhone());
            customer.setWebsite(clue.getWebsite());
            count = customerMapper.insertSelective(customer);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__Customer_add);
            }
        }else {
            //有客户存在
            customer = customers.get(0);
        }
        //3、将线索中联系人信息取出来保存在联系人表中
            Contacts contacts = new Contacts();
            contacts.setId(UUIDUtil.getUUID());
            contacts.setOwner(clue.getOwner());
            contacts.setCreateBy(user.getName());
            contacts.setCreateTime(DateTimeUtil.getSysTime());
            contacts.setCustomerId(customer.getId());
            contacts.setAppellation(clue.getAppellation());
            contacts.setContactSummary(clue.getContactSummary());
            contacts.setDescription(clue.getDescription());
            contacts.setEmail(clue.getEmail());
            contacts.setFullname(clue.getFullname());
            contacts.setJob(clue.getJob());
            contacts.setMphone(clue.getMphone());
            contacts.setNextContactTime(clue.getNextContactTime());
            contacts.setSource(clue.getSource());
            count = contactsMapper.insertSelective(contacts);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__Contacts_add);
            }
        //4、线索中的备注信息取出来保存在客户备注和联系人备注中
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setImg(user.getImg());
            customerRemark.setCreateBy(clue.getCreateBy());
            customerRemark.setCreateTime(clue.getCreateTime());
            customerRemark.setOwner(clue.getOwner());
            count = customerRemarkMapper.insertSelective(customerRemark);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__CustomerRemark_add);
            }
            //保存联系人的备注信息
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setCreateBy(clue.getCreateBy());
            contactsRemark.setCreateTime(clue.getCreateTime());
            count = contactsRemarkMapper.insertSelective(contactsRemark);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__ContactsRemark_add);
            }
        //5、将"线索和市场活动的关系"转换到"联系人和市场活动的关系中"
            ClueActivity clueActivity = new ClueActivity();
            clueActivity.setClueId(id);
            List<ClueActivity> clueActivities = clueActivityMapper.select(clueActivity);
            for (ClueActivity activity : clueActivities) {
                ContactsActivity contactsActivity = new ContactsActivity();
                contactsActivity.setId(UUIDUtil.getUUID());
                contactsActivity.setContactsId(activity.getId());
                contactsActivity.setActivityId(activity.getActivityId());
                count = contactsActivityMapper.insertSelective(contactsActivity);
                if (count == 0){
                    throw new CrmException(CrmEnum.Clue__ContactsActivity_add);
                }
            }
        //6、如果转换过程中发生了交易，创建一条新的交易，交易信息不全，后面可以通过修改交易来完善交易信息
            if ("1".equals(isTran)){
                //发生了交易保存交易对象
                transaction.setId(UUIDUtil.getUUID());
                transaction.setOwner(clue.getOwner());
                transaction.setContactsId(contacts.getId());
                transaction.setCreateBy(user.getName());
                transaction.setCreateTime(clue.getCreateTime());
                transaction.setDescription(clue.getDescription());
                count = transactionMapper.insertSelective(transaction);
                if (count == 0){
                    throw new CrmException(CrmEnum.Clue__tran_add);
                }
                //7、创建该条交易对应的交易历史以及备注
                //保存交易备注
                TransactionRemark transactionRemark = new TransactionRemark();
                transactionRemark.setId(UUIDUtil.getUUID());
                transactionRemark.setCreateBy(user.getName());
                transactionRemark.setCreateTime(DateTimeUtil.getSysTime());
                transactionRemark.setTranId(transaction.getId());
                count = transactionRemarkMapper.insertSelective(transactionRemark);
                if (count == 0){
                    throw new CrmException(CrmEnum.Clue__tranRemark_add);
                }
                //保存交易历史
                TransactionHistory transactionHistory = new TransactionHistory();
                transactionHistory.setId(UUIDUtil.getUUID());
                transactionHistory.setCreateBy(user.getName());
                transactionHistory.setCreateTime(DateTimeUtil.getSysTime());
                transactionHistory.setTranId(transaction.getId());
                transactionHistory.setExpectedDate(transaction.getExpectedDate());
                transactionHistory.setPossibility(transaction.getPossibility());
                transactionHistory.setStage(transaction.getStage());
                transactionHistory.setMoney(transaction.getMoney());
                count = transactionHistoryMapper.insertSelective(transactionHistory);
                if (count == 0){
                    throw new CrmException(CrmEnum.Clue__tranhistory_add);
                }
            }
        //8、删除线索的备注信息
            ClueRemark clueRemark = new ClueRemark();
            clueRemark.setClueId(id);
            List<ClueRemark> clueRemarks = clueRemarkMapper.select(clueRemark);
            if (clueActivities.size() > 0){

            }
             List<ClueRemark> remarks = clueRemarkMapper.selectAll();
            if (remarks.size() > 0){
                count = clueRemarkMapper.delete(clueRemark);
                if (count == 0){
                    throw new CrmException(CrmEnum.Clue__clueRemark_delete);
                }
            }

        //9、删除线索和市场活动的关联关系(tbl_clue_activity_relation)
            ClueActivity clueActivity1 = new ClueActivity();
            clueActivity1.setClueId(id);
            count = clueActivityMapper.delete(clueActivity1);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__clueActivity_delete);
            }
        //10、删除线索
             count = clueMapper.deleteByPrimaryKey(id);
            if (count == 0){
                throw new CrmException(CrmEnum.Clue__clue_delete);
            }
            ResultVo resultVo = new ResultVo();
            resultVo.setOk(true);
            resultVo.setMessage("转换成功!");

        return resultVo;
    }


    //导出报表
    @Override
    public ExcelWriter exportExcel() {
        // 通过工具类创建writer，默认创建xls格式
        ExcelWriter writer = ExcelUtil.getWriter();
        // 一次性写出内容，使用默认样式，强制输出标题
        List<Clue> clues = clueMapper.selectAll();
        for (Clue clue : clues) {
           //备注
            ClueRemark clueRemark = new ClueRemark();
            clueRemark.setClueId(clue.getId());
            List<ClueRemark> remarks = clueRemarkMapper.select(clueRemark);
            clue.setClueRemarks(remarks);

            //所有者
            User user = userMapper.selectByPrimaryKey(clue.getOwner());
            clue.setOwner(user.getName());
        }
        writer.merge(Clue.index - 1,"线索活动报表");
        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();
        //自定义标题别名
        writer.addHeaderAlias("clueRemarks", "备注");
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("owner", "所有者");
        writer.addHeaderAlias("fullname", "联系人全名");
        writer.addHeaderAlias("appellation", "联系人称呼");
        writer.addHeaderAlias("company", "客户名称");
        writer.addHeaderAlias("job", "职位");
        writer.addHeaderAlias("email", "邮箱");
        writer.addHeaderAlias("phone", "公司座机");
        writer.addHeaderAlias("website", "网站");
        writer.addHeaderAlias("mphone", "联系人手机号");
        writer.addHeaderAlias("state", "状态");
        writer.addHeaderAlias("source", "来源");
        writer.addHeaderAlias("description", "描述");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("createBy", "创建人");
        writer.addHeaderAlias("editTime", "修改时间");
        writer.addHeaderAlias("editBy", "修改人");
        writer.addHeaderAlias("contactSummary", "联系纪要");
        writer.addHeaderAlias("nextContactTime", "下次联系时间");
        writer.addHeaderAlias("address", "公司地址");

        writer.write(clues, true);
        return writer;
    }
}
