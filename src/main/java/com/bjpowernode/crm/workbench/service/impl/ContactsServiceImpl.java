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
import com.bjpowernode.crm.workbench.base.*;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.mapper.*;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ContactsServiceImpl implements ContactsService {
    //注入mapper层对象
    @Autowired
    private ContactsMapper contactsMapper;
    //注入用户mapper层对象
    @Autowired
    private UserMapper userMapper;
    //注入customer层mapper对象
    @Autowired
    private CustomerMapper customerMapper;

    @Autowired
    private ContactsRemarkMapper contactsRemarkMapper;

    @Autowired
    private TransactionMapper transactionMapper;

    @Autowired
    private ActivityMapper activityMapper;

    @Autowired
    private ContactsActivityMapper contactsActivityMapper;

    @Override
    public PageInfo<Contacts> selectContacts(Integer currentPage,Integer rowsPerPage,Contacts contacts) {
        Example example = new Example(Contacts.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(contacts.getOwner())){
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name","%" + contacts.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }
        if (StrUtil.isNotEmpty(contacts.getCustomerId())){
            Example example1 = new Example(Customer.class);
            example1.createCriteria().andLike("name","%" + contacts.getCustomerId() + "%");
            List<Customer> customers = customerMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (Customer customer : customers) {
                list.add(customer.getId());
            }
            criteria.andIn("customerId",list);
        }
        if (StrUtil.isNotEmpty(contacts.getFullname())){
            criteria.andLike("fullname","%" + contacts.getFullname() + "%");
        }
        if (!"请选择".equals(contacts.getSource())){
            criteria.andLike("source", "%" + contacts.getSource() + "%");
        }
        if (StrUtil.isNotEmpty(contacts.getBirth())){
            criteria.andLike("birth","%" + contacts.getBirth() + "%");
        }


        PageHelper.startPage(currentPage,rowsPerPage);
        List<Contacts> contacts1 = contactsMapper.selectByExample(example);
        for (Contacts contact : contacts1) {
            User user = userMapper.selectByPrimaryKey(contact.getOwner());
            Customer customer = customerMapper.selectByPrimaryKey(contact.getCustomerId());
            contact.setOwner(user.getName());
            contact.setCustomerId(customer.getName());
        }
        PageInfo<Contacts> pageInfo = new PageInfo(contacts1);

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

    //添加和修改的方法
    @Override
    public ResultVo addContactsAndUpdate(Contacts contacts,User user) {
        ResultVo resultVo = new ResultVo();
        if (contacts.getId() == null || contacts.getId().equals("")){
            contacts.setId(UUIDUtil.getUUID());
            contacts.setCreateBy(user.getName());
            contacts.setCreateTime(DateTimeUtil.getSysTime());
            //因为前端传过来的是名字，所以需要转换
            Customer customer = new Customer();
            customer.setName(contacts.getCustomerId());
            List<Customer> select = customerMapper.select(customer);
            for (Customer customer1 : select) {
                contacts.setCustomerId(customer1.getId());
            }
            int count = contactsMapper.insertSelective(contacts);
            if (count == 0){
                throw new CrmException(CrmEnum.Contacts__add_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加联系人成功!");
        }else {
            //修改的
            contacts.setEditBy(user.getName());
            contacts.setEditTime(DateTimeUtil.getSysTime());
            //因为前端传过来的是名字，所以需要转换
            Customer customer = new Customer();
            customer.setName(contacts.getCustomerId());
            List<Customer> select = customerMapper.select(customer);
            for (Customer customer1 : select) {
                contacts.setCustomerId(customer1.getId());
            }
            int count = contactsMapper.updateByPrimaryKeySelective(contacts);
            if (count == 0){
                throw new CrmException(CrmEnum.Contacts__update_update);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改联系人成功!");
        }

        return resultVo;
    }

    //修改的查询方法
    @Override
    public Contacts selectContactsToOne(String id) {
        Contacts contacts = contactsMapper.selectByPrimaryKey(id);
        Customer customer = customerMapper.selectByPrimaryKey(contacts.getCustomerId());
        contacts.setCustomerId(customer.getName());
        return contacts;
    }
    //删除的方法
    @Override
    public ResultVo deleteContacts(String ids) {
        ResultVo resultVo = new ResultVo();
        String[] split = ids.split(",");
        List<String> id = Arrays.asList(split);
        Example example = new Example(Contacts.class);
        example.createCriteria().andIn("id",id);
        int count = contactsMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Contacts__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除联系人成功!共删除【"+count+"】条记录!");
        return resultVo;
    }

    //详情页查询的方法
    @Override
    public Contacts selectContactsAndRemark(String id) {
        Contacts contacts = contactsMapper.selectByPrimaryKey(id);
        User user = userMapper.selectByPrimaryKey(contacts.getOwner());
        contacts.setOwner(user.getName());
        Customer customer = customerMapper.selectByPrimaryKey(contacts.getCustomerId());
        contacts.setCustomerId(customer.getName());
        //查询备注
        ContactsRemark contactsRemark = new ContactsRemark();
        contactsRemark.setContactsId(contacts.getId());
        List<ContactsRemark> select = contactsRemarkMapper.select(contactsRemark);
        for (ContactsRemark remark : select) {
            remark.setContactsId(contacts.getFullname()+contacts.getAppellation());
            User user1 = userMapper.selectByPrimaryKey(remark.getOwner());
            remark.setImg(user1.getImg());
        }
        contacts.setContactsRemarks(select);
        return contacts;
    }
    //删除的方法
    @Override
    public ResultVo deleteContactsById(String id) {
        ResultVo resultVo = new ResultVo();
        int count = contactsMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.ContactsAndById__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除联系人成功!");
        return resultVo;
    }
    //添加备注和修改备注
    @Override
    public ResultVo addRemark(ContactsRemark contactsRemark,User user) {
        ResultVo resultVo = new ResultVo();
        if (contactsRemark.getId()  == null || contactsRemark.equals("")){
            //添加备注
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(user.getName());
            contactsRemark.setCreateTime(DateTimeUtil.getSysTime());
            contactsRemark.setOwner(user.getId());
            contactsRemark.setImg(user.getImg());
            int count = contactsRemarkMapper.insertSelective(contactsRemark);
            if (count == 0){
                throw new CrmException(CrmEnum.ContactsRemark__add_add);
            }
            Contacts contacts = contactsMapper.selectByPrimaryKey(contactsRemark.getContactsId());
            contactsRemark.setContactsId(contacts.getFullname()+contacts.getAppellation());
            resultVo.setOk(true);
            resultVo.setMessage("添加备注成功!");
            resultVo.setT(contactsRemark);
        }else {
            int i = 1;
            //修改
            contactsRemark.setEditBy(user.getName());
            contactsRemark.setEditTime(DateTimeUtil.getSysTime());
            contactsRemark.setEditFlag(String.valueOf(i));
            contactsRemark.setImg(user.getImg());
            int count = contactsRemarkMapper.updateByPrimaryKeySelective(contactsRemark);
            if (count == 0){
                throw new CrmException(CrmEnum.ContactsRemark__update_update);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改备注信息成功!");
        }

        return resultVo;
    }

    //删除备注信息
    @Override
    public ResultVo deleteRemark(String id) {
        ResultVo resultVo = new ResultVo();
        int count = contactsRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.ContactsRemark__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功!");
        return resultVo;
    }

        //查询交易
    @Override
    public List<Transaction> selectTranlist() {
        List<Transaction> transactions = transactionMapper.selectAll();
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
        return transactions;
    }

    //删除交易
    @Override
    public ResultVo deleteTran(String id) {
        ResultVo resultVo = new ResultVo();
        int count = transactionMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.ContactsTran__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除交易成功");
        return resultVo;
    }

    //查询市场活动
    @Override
    public List<Activity> selectActivity(String id) {
        ContactsActivity contactsActivity = new ContactsActivity();
        contactsActivity.setContactsId(id);
        List<ContactsActivity> select = contactsActivityMapper.select(contactsActivity);
        //创建集合保存数据
        List<Activity> list = new ArrayList<>();
        for (ContactsActivity activity : select) {
            Activity activity1 = activityMapper.selectByPrimaryKey(activity.getActivityId());
            User user = userMapper.selectByPrimaryKey(activity1.getOwner());
            activity1.setOwner(user.getName());
            list.add(activity1);
        }

        return list;
    }

    //查询没有关联的市场活动
    @Override
    public List<Activity> selectContactsActivity(String id, String name) {
        ContactsActivity contactsActivity = new ContactsActivity();
        contactsActivity.setContactsId(id);
        List<ContactsActivity> contactsActivities = contactsActivityMapper.select(contactsActivity);
        List<Activity> list = null;
        if (contactsActivities.size() > 0){
            List<String> ids = new ArrayList<>();
            for (ContactsActivity activity : contactsActivities) {
                ids.add(activity.getActivityId());
            }
            Example example = new Example(Activity.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andLike("name","%" + name + "%");
            criteria.andNotIn("id",ids);
            list = activityMapper.selectByExample(example);
        }else {
            Example example= new Example(Activity.class);
            Example.Criteria criteria = example.createCriteria();
            criteria.andLike("name","%" + name + "%");
            list = activityMapper.selectByExample(example);
        }
        for (Activity activity : list) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());

        }

        return list;
    }

    //关联市场活动
    @Override
    public ResultVo addContactsActivity(String contactsId, String ids) {
        ResultVo resultVo = new ResultVo();
        String[] idss = ids.split(",");
        List<String> id = Arrays.asList(idss);
        for (String s : id) {
            ContactsActivity contactsActivity = new ContactsActivity();
            contactsActivity.setId(UUIDUtil.getUUID());
            contactsActivity.setContactsId(contactsId);
            contactsActivity.setActivityId(s);
            int count = contactsActivityMapper.insertSelective(contactsActivity);
            if (count == 0){
                throw new CrmException(CrmEnum.ContactsActivity__add_add);
            }
        }
        resultVo.setOk(true);
        resultVo.setMessage("关联市场活动成功!");

        return resultVo;
    }

    //解除市场活动
    @Override
    public ResultVo deleteContactsActivity(ContactsActivity contactsActivity) {
        ResultVo resultVo = new ResultVo();
        int count = contactsActivityMapper.delete(contactsActivity);
        if (count == 0){
            throw new CrmException(CrmEnum.ContactsActivity__delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("解除关联成功!");
        return resultVo;
    }

    //导出报表
    @Override
    public ExcelWriter exportExcel() {
        ExcelWriter writer = ExcelUtil.getWriter();
        List<Contacts> contacts = contactsMapper.selectAll();
        for (Contacts contacts1 : contacts) {
            //备注
            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setContactsId(contacts1.getId());
            List<ContactsRemark> remarks = contactsRemarkMapper.select(contactsRemark);
            contacts1.setContactsRemarks(remarks);
            //所有者
            User user = userMapper.selectByPrimaryKey(contacts1.getOwner());
            contacts1.setOwner(user.getName());
            Customer customer = customerMapper.selectByPrimaryKey(contacts1.getCustomerId());
            contacts1.setCustomerId(customer.getName());
        }
        //属性的个数
        writer.merge(Contacts.index - 1,"联系人报表");
        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();
        //自定义标题别名
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("owner", "所有者");
        writer.addHeaderAlias("source", "来源");
        writer.addHeaderAlias("customerId", "客户名称");
        writer.addHeaderAlias("fullname", "姓名");
        writer.addHeaderAlias("appellation", "昵称");
        writer.addHeaderAlias("email", "邮箱");
        writer.addHeaderAlias("mphone", "联系人手机号");
        writer.addHeaderAlias("job", "职位");
        writer.addHeaderAlias("birth", "生日");
        writer.addHeaderAlias("createBy", "创建人");
        writer.addHeaderAlias("createTime", "创建时间");
        writer.addHeaderAlias("editBy", "修改人");
        writer.addHeaderAlias("editTime", "修改时间");
        writer.addHeaderAlias("description", "描述");
        writer.addHeaderAlias("contactSummary", "联系纪要");
        writer.addHeaderAlias("nextContactTime", "下次联系时间");
        writer.addHeaderAlias("address", "地址");
        writer.addHeaderAlias("contactsRemarks", "备注列表");

        writer.write(contacts, true);
        return writer;
    }
}
