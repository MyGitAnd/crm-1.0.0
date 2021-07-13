package com.bjpowernode.crm.workbench.service.impl;
import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
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
}
