package com.bjpowernode.crm.workbench.service;


import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.*;
import com.github.pagehelper.PageInfo;

import java.util.List;


public interface ContactsService {
    PageInfo<Contacts> selectContacts(Integer currentPage,Integer rowsPerPage,Contacts contacts);

    List<String> queryCustomerName(String customerName, User user);

    ResultVo addContactsAndUpdate(Contacts contacts,User user);

    Contacts selectContactsToOne(String id);

    ResultVo deleteContacts(String ids);

    Contacts selectContactsAndRemark(String id);

    ResultVo deleteContactsById(String id);

    ResultVo addRemark(ContactsRemark contactsRemark,User user);

    ResultVo deleteRemark(String id);

    List<Transaction> selectTranlist();


    ResultVo deleteTran(String id);

    List<Activity> selectActivity(String id);

    List<Activity> selectContactsActivity(String id, String name);

    ResultVo addContactsActivity(String contactsId, String ids);

    ResultVo deleteContactsActivity(ContactsActivity contactsActivity);

    ExcelWriter exportExcel();

}
