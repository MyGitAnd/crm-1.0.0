package com.bjpowernode.crm.workbench.service;

import com.bjpowernode.crm.workbench.base.Transaction;
import com.github.pagehelper.PageInfo;



public interface TransactionService {
    PageInfo<Transaction> selectTransaction(Integer currentPage,Integer rowsPerPage);

}
