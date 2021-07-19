package com.bjpowernode.crm.workbench.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.base.Transaction;
import com.bjpowernode.crm.workbench.base.TransactionRemark;
import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;


public interface TransactionService {
    PageInfo<Transaction> selectTransaction(Integer currentPage,Integer rowsPerPage,Transaction transaction);

    List<String> queryCustomerName(String customerName,User user);

    List<Activity> selectAc(String name);


    List<Contacts> selectAc1(String fullname);

    ResultVo addTranUpdate(Transaction transaction, User user);

    Transaction selectTran(String id);

    ResultVo deletesTran(String ids);

    ResultVo deleteTran(String id);

    Transaction queryTransaction(String id);

    Map<String, Object> queryStages(String id, Map<String, String> map, Integer index,User user);

    ResultVo addRemark(TransactionRemark transactionRemark,User user);

    ResultVo editRemark(TransactionRemark transactionRemark, User user);

    ResultVo deleteRemark(String id);

    ExcelWriter exportExcel();

}
