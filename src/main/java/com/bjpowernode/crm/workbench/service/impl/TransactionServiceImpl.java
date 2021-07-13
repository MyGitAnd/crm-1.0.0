package com.bjpowernode.crm.workbench.service.impl;
import com.bjpowernode.crm.settings.bean.*;
import com.bjpowernode.crm.settings.mapper.*;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ContactsMapper;
import com.bjpowernode.crm.workbench.mapper.CustomerMapper;
import com.bjpowernode.crm.workbench.mapper.TransactionMapper;
import com.bjpowernode.crm.workbench.service.TransactionService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
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

    @Override
    public PageInfo<Transaction> selectTransaction(Integer currentPage, Integer rowsPerPage) {
        PageHelper.startPage(currentPage,rowsPerPage);

        List<Transaction> transactions = transactionMapper.selectAll();
        for (Transaction transaction : transactions) {
            User user = userMapper.selectByPrimaryKey(transaction.getOwner());
            transaction.setOwner(user.getName());
            //客户名称
            Customer customer = customerMapper.selectByPrimaryKey(transaction.getCustomerId());
            transaction.setContactsId(customer.getName());
            //类型
            Activity activity = activityMapper.selectByPrimaryKey(transaction.getActivityId());
            transaction.setActivityId(activity.getName());
            //来源
//            Contacts contacts = contactsMapper.selectByPrimaryKey(transaction.getContactsId());
//            transaction.setContactsId(contacts.getSource());
        }

        PageInfo<Transaction> pageInfo = new PageInfo(transactions);

        return pageInfo;
    }
}
