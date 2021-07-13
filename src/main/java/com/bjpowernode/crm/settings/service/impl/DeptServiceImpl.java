package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.mapper.DeptMapper;
import com.bjpowernode.crm.settings.service.DeptService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;



@Service
public class DeptServiceImpl implements DeptService {
    //注入mapper层
    @Autowired
    private DeptMapper deptMapper;

    //查询所有部门信息
    @Override
    public Dept dept(String id){
        Dept dept = deptMapper.selectByPrimaryKey(id);

        return dept;
    }




}
