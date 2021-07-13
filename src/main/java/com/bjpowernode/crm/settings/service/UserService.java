package com.bjpowernode.crm.settings.service;

import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.User;


public interface UserService {


    User login(User user);

    void update(User user);

//    public Dept selectUser(User user);
}
