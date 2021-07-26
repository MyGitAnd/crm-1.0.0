package com.bjpowernode.crm.workbench.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.*;
import com.bjpowernode.crm.workbench.service.ContactsService;
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
public class ContactsController {
    //注入service层对象
    @Autowired
    private ContactsService contactsService;

    @RequestMapping("/workbench/contacts/list")
    @ResponseBody
    private PageInfo<Contacts> list( Integer currentPage, Integer rowsPerPage,Contacts contacts){

        PageInfo<Contacts> pageInfo = contactsService.selectContacts(currentPage,rowsPerPage,contacts);


        return pageInfo;
    }

    //查询自动补全的信息
    @RequestMapping("/workbench/contact/queryCustomerName")
    @ResponseBody
    public List<String> queryCustomerName(String customerName, HttpSession session){
        User user = (User) session.getAttribute("user");
        return contactsService.queryCustomerName(customerName,user);
    }

    //添加的方法
    @RequestMapping("/workbench/Contacts/addContactsAndUpdate")
    @ResponseBody
    public ResultVo addContactsAndUpdate(Contacts contacts,HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = null;
        try {
            resultVo = contactsService.addContactsAndUpdate(contacts, user);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //修改的查询方法
    @RequestMapping("/workbench/Contacts/selectContactsToOne")
    @ResponseBody
    public Contacts selectContactsToOne(String id){

        return contactsService.selectContactsToOne(id);
    }
    //删除的方法
    @RequestMapping("/workbench/contacts/deleteContacts")
    @ResponseBody
    public ResultVo deleteContacts(String ids){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.deleteContacts(ids);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //详情页查询的方法
    @RequestMapping("/workbench/Contacts/selectContactsAndRemark")
    @ResponseBody
    public Contacts selectContactsAndRemark(String id){

        return contactsService.selectContactsAndRemark(id);
    }

    //删除的方法
    @RequestMapping("/workbench/customer/deleteContactsById")
    @ResponseBody
    public ResultVo deleteContactsById(String id){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.deleteContactsById(id);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //添加备注的方法和修改
    @RequestMapping("/workbench/contactsRemark/addRemark")
    @ResponseBody
    public ResultVo addRemark(ContactsRemark contactsRemark,HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = null;
        try {
            resultVo = contactsService.addRemark(contactsRemark, user);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除备注的方法
    @RequestMapping("/workbench/contactsRemark/deleteRemark")
    @ResponseBody
    public ResultVo deleteRemark(String id){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.deleteRemark(id);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询交易
    @RequestMapping("/workbench/contacts/selectTranlist")
    @ResponseBody
    public List<Transaction> selectTranlist(){

        return contactsService.selectTranlist();
    }

    //删除交易
    @RequestMapping("/workbench/ContactsTran/deleteTran")
    @ResponseBody
    public ResultVo deleteTran(String id){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.deleteTran(id);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询市场活动
    @RequestMapping("/workbench/ContactsActivity/selectActivity")
    @ResponseBody
    public List<Activity> selectActivity(String id){

        return contactsService.selectActivity(id);
    }

    //查询所有没有关联的市场活动
    @RequestMapping("/workbench/ContactsActivity/selectContactsActivity")
    @ResponseBody
    public List<Activity> selectContactsActivity(String id,String name){

        return contactsService.selectContactsActivity(id,name);
    }
    //关联市场活动
    @RequestMapping("/workbench/ContactsActivity/addContactsActivity")
    @ResponseBody
    public ResultVo addContactsActivity(String contactsId,String ids){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.addContactsActivity(contactsId, ids);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //解除关联
    @RequestMapping("/workbench/contactsActivity/deleteContactsActivity")
    @ResponseBody
    public ResultVo deleteContactsActivity(ContactsActivity contactsActivity){

        ResultVo resultVo = null;
        try {
            resultVo = contactsService.deleteContactsActivity(contactsActivity);
        } catch (Exception e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    @RequestMapping("/workbench/Contacts/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response){
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try {
            excelWriter = contactsService.exportExcel();
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=Contacts.xls");
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
