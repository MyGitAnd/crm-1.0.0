package com.bjpowernode.crm.workbench.controller;

import com.bjpowernode.crm.workbench.base.Contacts;
import com.bjpowernode.crm.workbench.service.ContactsService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;



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


}
