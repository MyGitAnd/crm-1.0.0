package com.bjpowernode.crm.workbench.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.base.Customer;
import com.bjpowernode.crm.workbench.base.CustomerRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.service.CustomerService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
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
        ResultVo resultVo = null;
        try {
            resultVo = customerService.insertAndUpdateCustomer(customer,user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }

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
        ResultVo resultVo = null;
        try {
            resultVo = customerService.deleteCustomers(ids);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }

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

        ResultVo resultVo = null;
        try {
            resultVo = customerService.deleteCustomer(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

//添加备注
    @RequestMapping("/settings/customerRemark/save")
    @ResponseBody
    public ResultVo save(CustomerRemark customerRemark,HttpSession session){

        User user = (User) session.getAttribute("user");
        ResultVo resultVo = null;
        try {
            resultVo = customerService.save(customerRemark,user);
        } catch (CrmException e) {
            try {
                resultVo.setMessage(e.getMessage());
            } catch (Exception e1) {
                resultVo.setMessage(e.getMessage());
            }
        }


        return resultVo;
    }

    //修改备注信息
    @RequestMapping("/settings/customerRemark/update")
    @ResponseBody
    public ResultVo update(CustomerRemark customerRemark,HttpSession session){
        User user = (User) session.getAttribute("user");

        ResultVo resultVo = null;
        try {
            resultVo = customerService.update(customerRemark,user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }


//删除备注信息
    @RequestMapping("/settings/customerRemark/delete")
    @ResponseBody
    public ResultVo delete(String id){

        ResultVo resultVo = null;
        try {
            resultVo = customerService.delete(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //查询交易
    @RequestMapping("/workbench/CustomerTran/selectCustTran")
    @ResponseBody
    public List<Transaction> selectCustTran(){

        return customerService.selectCustTran();
    }

    //删除交易
    @RequestMapping("/workbench/contactsTran/deleteContactsTran")
    @ResponseBody
    public ResultVo deleteContactsTran(String id){

        ResultVo resultVo = null;
        try {
            resultVo = customerService.deleteContactsTran(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询联系人
    @RequestMapping("/workbench/ContactsCust/selectContactsCustomer")
    @ResponseBody
    public List<Contacts> selectContactsCustomer(){

        return customerService.selectContactsCustomer();
    }

    //删除联系人
    @RequestMapping("/workbench/customerContacts/deleteContacts")
    @ResponseBody
    public ResultVo deleteContacts(String id){

        ResultVo resultVo = null;
        try {
            resultVo = customerService.deleteContacts(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //添加联系人
    @RequestMapping("/workbench/ContactsCustomer/addContactsCustomer")
    @ResponseBody
    public ResultVo addContactsCustomer(Contacts contacts,HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = null;
        try {
            resultVo = customerService.addContactsCustomer(contacts, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //导出报表
    @RequestMapping("/workbench/Customer/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response){
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try {
            excelWriter = customerService.exportExcel();
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=Customer.xls");
            out = response.getOutputStream();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            excelWriter.flush(out, true);
            // 关闭writer，释放内存
            excelWriter.close();
            //此处记得关闭输出Servlet流
            IoUtil.close(out);
        }

    }


}
