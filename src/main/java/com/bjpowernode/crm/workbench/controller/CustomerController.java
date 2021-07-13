package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.workbench.base.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class CustomerController {
    //注入service层对象
    @Autowired
    private CustomerService customerService;


    //查询所有信息
    @RequestMapping("/workbench/customer/list")
    @ResponseBody
    public PageInfo<Customer> list(Integer page,Integer pageSize,Customer customer){

        PageInfo pageInfo = customerService.selectCustomer(page,pageSize,customer);

        return pageInfo;
    }

    //查询所有者信息
    @RequestMapping("/workbench/customer/users")
    @ResponseBody
    public List<User> users(){

       List<User> users = customerService.users();

        return users;
    }

    //添加和修改
    @RequestMapping("/workbench/customer/addAndUpdateCustomer")
    @ResponseBody
    public ResultVo insertCustomer(Customer customer, HttpSession session){
       User user = (User) session.getAttribute("user");
       ResultVo resultVo = customerService.insertAndUpdateCustomer(customer,user);

       return resultVo;
    }


    //修改查询的方法
    @RequestMapping("/workbench/customer/selectCustomerORId")
    @ResponseBody
    public Customer selectCustomerORId(String id){
      Customer customer  = customerService.selectCustomerORId(id);

      return customer;
    }
    //删除
    @RequestMapping("/workbench/customer/deleteCustomers")
    @ResponseBody
    public ResultVo deleteCustomers(String ids){
        ResultVo resultVo = customerService.deleteCustomers(ids);

        return resultVo;
    }

    //查询表单数据
    @RequestMapping("/settings/customerRemark/lists")
    @ResponseBody
    public Customer lists(String id){

        Customer customer = customerService.lists(id);

        return customer;
    }
    //删除
    @RequestMapping("/workbench/customer/deleteCustomer")
    @ResponseBody
    public ResultVo deleteCustomer(String id){

      ResultVo resultVo = customerService.deleteCustomer(id);
        return resultVo;
    }

//添加备注
    @RequestMapping("/settings/customerRemark/save")
    @ResponseBody
    public ResultVo save(CustomerRemark customerRemark,HttpSession session){

        User user = (User) session.getAttribute("user");
       ResultVo resultVo = customerService.save(customerRemark,user);


        return resultVo;
    }

    //修改备注信息
    @RequestMapping("/settings/customerRemark/update")
    @ResponseBody
    public ResultVo update(CustomerRemark customerRemark,HttpSession session){
        User user = (User) session.getAttribute("user");

       ResultVo resultVo = customerService.update(customerRemark,user);

       return resultVo;
    }


//删除备注信息
    @RequestMapping("/settings/customerRemark/delete")
    @ResponseBody
    public ResultVo delete(String id){

        ResultVo resultVo = customerService.delete(id);

        return resultVo;
    }



}
