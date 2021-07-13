package com.bjpowernode.crm.workbench.controller;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.service.TransactionService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class TransactionController {
    //注入service层对象
    @Autowired
    private TransactionService transactionService;


    @RequestMapping("/settings/transaction/list")
    @ResponseBody
    public PageInfo<Transaction> list(Integer currentPage, Integer rowsPerPage){

        PageInfo<Transaction> pageInfo = transactionService.selectTransaction(currentPage,rowsPerPage);


        return pageInfo;
    }
}
