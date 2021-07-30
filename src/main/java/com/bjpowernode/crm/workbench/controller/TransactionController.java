package com.bjpowernode.crm.workbench.controller;
import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.base.TransactionRemark;
import com.bjpowernode.crm.workbench.service.TransactionService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
public class TransactionController {
    //注入service层对象
    @Autowired
    private TransactionService transactionService;


    @RequestMapping("/settings/transaction/list")
    @ResponseBody
    public PageInfo<Transaction> list(Integer currentPage, Integer rowsPerPage,Transaction transaction){

        PageInfo<Transaction> pageInfo = transactionService.selectTransaction(currentPage,rowsPerPage,transaction);

        return pageInfo;
    }

    //查询客户名称
    @RequestMapping("/workbench/transaction/queryCustomerName")
    @ResponseBody
    public List<String> queryCustomerName(String customerName,HttpSession session){
        User user = (User) session.getAttribute("user");
        return transactionService.queryCustomerName(customerName,user);
    }

    //查询可能性
    @RequestMapping("/workbench/transaction/getPossibility")
    @ResponseBody
    public String getPossibility(String stage, HttpSession session){
        Map<String,String> map = (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");

        return map.get(stage) ;
    }

    //查询所有市场活动
    @RequestMapping("/workbench/clueActivity/selectAc")
    @ResponseBody
    public List<Activity> selectAc(String name){

        return transactionService.selectAc(name);
    }
    //查询联系人
    @RequestMapping("/workbench/clueActivity/selectAc1")
    @ResponseBody
    public List<Contacts> selectAc1(String fullname){

        return transactionService.selectAc1(fullname);
    }

    //添加
    @RequestMapping("/workbench/transaction/addTranUpdate")
    @ResponseBody
    public ResultVo addTranUpdate(Transaction transaction,HttpSession session){
        User user = (User) session.getAttribute("user");

        ResultVo resultVo = null;
        try {
            resultVo = transactionService.addTranUpdate(transaction, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //修改的查询方法
    @RequestMapping("/workbench/tran/selectTran")
    @ResponseBody
    public Transaction selectTran(String id){

        return transactionService.selectTran(id);
    }

    //删除的方法
    @RequestMapping("/workbench/Tran/deletesTran")
    @ResponseBody
    public ResultVo deletesTran(String ids){

        ResultVo resultVo = null;
        try {
            resultVo = transactionService.deletesTran(ids);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //详情页删除的方法
    @RequestMapping("/workbench/Tran/deleteTran")
    @ResponseBody
    public ResultVo deleteTran(String id){
        ResultVo resultVo = null;
        try {
            resultVo = transactionService.deleteTran(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询的方法
    @RequestMapping("/workbench/tran/queryTransaction")
    @ResponseBody
    public Transaction queryTransaction(String id){

        return transactionService.queryTransaction(id);
    }

   //查询所处的状态
   @RequestMapping("/workbench/tranHistory/queryStages")
   @ResponseBody
   public Map<String,Object> queryStages(HttpSession session,String id,Integer index){
       User user = (User) session.getAttribute("user");
       Map<String,String> map = (Map<String, String>) session.getServletContext().getAttribute("stage2Possibility");

         return   transactionService.queryStages(id,map,index,user);
    }
    //添加备注
    @RequestMapping("/workbench/tranRemark/addRemark")
    @ResponseBody
    public ResultVo addRemark(TransactionRemark transactionRemark,HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = null;
        try {
            resultVo = transactionService.addRemark(transactionRemark, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //修改备注
    @RequestMapping("/workbench/tranRemark/editRemark")
    @ResponseBody
    public ResultVo editRemark(TransactionRemark transactionRemark,HttpSession session){
        User user = (User) session.getAttribute("user");

        ResultVo resultVo = null;
        try {
            resultVo = transactionService.editRemark(transactionRemark, user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除备注
    @RequestMapping("/workbench/tranRemark/deleteRemark")
    @ResponseBody
    public ResultVo deleteRemark(String id){

        ResultVo resultVo = null;
        try {
            resultVo = transactionService.deleteRemark(id);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    @RequestMapping("/workbench/Tran/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response) {
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try {
            excelWriter = transactionService.exportExcel();
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=Tran.xls");
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
