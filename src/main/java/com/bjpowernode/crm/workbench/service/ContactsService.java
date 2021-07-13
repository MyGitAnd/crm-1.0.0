package com.bjpowernode.crm.workbench.service;


import com.bjpowernode.crm.workbench.base.Contacts;
import com.github.pagehelper.PageInfo;


public interface ContactsService {
    PageInfo<Contacts> selectContacts(Integer currentPage,Integer rowsPerPage,Contacts contacts);
}
