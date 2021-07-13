package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.workbench.base.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface CustomerService {
    //分页加模糊查询
    PageInfo<Customer> selectCustomer(Integer page, Integer pageSize,Customer customer);
    //查询所有所有者信息
    List<User> users();


    ResultVo insertAndUpdateCustomer(Customer customer,User user);

    Customer selectCustomerORId(String id);

    ResultVo deleteCustomers(String ids);

    Customer lists(String id);

    ResultVo deleteCustomer(String id);

    ResultVo save(CustomerRemark customerRemark, User user);

    ResultVo update(CustomerRemark customerRemark, User user);

    ResultVo delete(String id);

}
