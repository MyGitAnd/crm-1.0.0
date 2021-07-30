package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.User;
import com.github.pagehelper.PageInfo;


public interface UserService {


    User login(User user);

    void update(User user);

    PageInfo<User> selectAllUser(User user, Integer currentPage, Integer rowsPerPage,String startTime);


//    public Dept selectUser(User user);
}
