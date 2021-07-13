/*
package com.bjpowernode.crm.test;

import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.mapper.DeptMapper;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.math.BigInteger;
import java.util.List;

public class UserTest {
    ApplicationContext applicationContext  = new ClassPathXmlApplicationContext("spring/applicationContext.xml");
    DeptMapper deptMapper = (DeptMapper) applicationContext.getBean("deptMapper");
    //查询部门
    @Test
    public void Test1(){

//        System.out.println(deptMapper);
        List<Dept> depts = deptMapper.selectAll();
        for (Dept dept1 : depts) {
            System.out.println("dept1 = " + dept1);
        }

    }
    //增加
    @Test
    public void Test2(){

        Dept dept = new Dept();
        dept.setDept_id(5);
        dept.setDept_name("研发部");
        deptMapper.insertSelective(dept);

    }

    //修改
    @Test
    public void Test3(){
        Dept dept = new Dept();
        dept.setDept_id(5);
        dept.setDept_name("经理部");
        deptMapper.updateByPrimaryKey(dept);

    }

    //删除
    @Test
    public void Test4(){
        deptMapper.deleteByPrimaryKey("5");
    }



    @Test
    public void Test5(){
//        BigInteger
        double pi = Math.PI * 3;
        System.out.println("pi = " + pi);
        long round = Math.round(11.5);
        System.out.println("round = " + round);



    }



}
*/
