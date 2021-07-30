package com.bjpowernode.crm.settings.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.MD5Util;
import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.LockedState;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.DeptMapper;
import com.bjpowernode.crm.settings.mapper.LockedStateMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.UserService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

/**
 * 业务层
 */
@Service
public class UserServiceImpl implements UserService {
    //注入mapper层对象
    @Autowired
    private UserMapper userMapper;
    //注入mapper层对象
    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private LockedStateMapper lockedStateMapper;



    @Override
    public User login(User user)  {
        String ip = user.getAllowIps();
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        user.setAllowIps(null);
        List<User> users = userMapper.select(user);
        if (users.size() == 0){
            //说明密码错误是错误的
             throw new CrmException(CrmEnum.USER_LOGIN_ACCOUNT);
        }
        //验证账号是否失效
        user = users.get(0);
        //获取ip地址值
        String allowIps = user.getAllowIps();
        //获取数据库的有效日期
        String expireTime = user.getExpireTime();
        String sysTime = DateTimeUtil.getSysTime();

        if (expireTime.compareTo(sysTime)<0){
            throw new CrmException(CrmEnum.USER_LOGIN_expireTime);
        }

        //验证卡号是否被锁定
        if ("0".equals(user.getLockState())){
            throw new CrmException(CrmEnum.USER_LOGIN_LockState);
        }

        //验证ip地址
        if (!allowIps.contains(ip)){
            throw new CrmException(CrmEnum.USER_LOGIN_AllowIps);
        }

        return user;
    }
    //修改密码的方法
    @Override
    public void update(User user) {
        user.setLoginPwd(MD5Util.getMD5(user.getLoginPwd()));
        //修改的记录数
        int index = userMapper.updateByPrimaryKeySelective(user);

        if (index == 0){
            throw new CrmException(CrmEnum.USER_LOGIN_LoginPwd);
        }

    }

//    //查询员工系信息的方法
//    @Override
//    public Dept selectUser(User user) {
//
//        //用部门编号查询部门名称
//        Dept dept = deptMapper.selectByPrimaryKey(user.getDeptno());
//
//           return dept;
//    }

    //查询所有用户信息
    @Override
    public PageInfo<User> selectAllUser(User user, Integer currentPage, Integer rowsPerPage,String startTime) {
        Example example = new Example(User.class);
        Example.Criteria criteria = example.createCriteria();
        if (StrUtil.isNotEmpty(user.getName())){
            criteria.andLike("name","%" + user.getName() + "%");
        }
        if (StrUtil.isNotEmpty(user.getDeptno())){
           Example example1 = new Example(Dept.class);
           example1.createCriteria().andLike("name","%" + user.getDeptno() + "%");
            List<Dept> depts = deptMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (Dept dept : depts) {
                list.add(dept.getId());
            }
            criteria.andIn("deptno",list);
        }
        if (!("请选择").equals(user.getLockState())){

            Example example1 = new Example(LockedState.class);
            example1.createCriteria().andLike("name","%" + user.getLockState() + "%");
            List<LockedState> lockedStates = lockedStateMapper.selectByExample(example);
            List<String> list = new ArrayList<>();
            for (LockedState lockedState : lockedStates) {
                list.add(lockedState.getId());
            }
            criteria.andIn("lockState",list);
        }
        //当前时间
        user.setCreateTime(startTime);
        if (StrUtil.isNotEmpty(user.getCreateTime())){
            criteria.andGreaterThanOrEqualTo("createTime",user.getCreateTime());
        }
        //过期时间
        if (StrUtil.isNotEmpty(user.getExpireTime())){
            criteria.andLessThanOrEqualTo("expireTime",user.getExpireTime());
        }

        PageHelper.startPage(currentPage,rowsPerPage);
        List<User> users = userMapper.selectAll();
        for (User user1 : users) {
            Dept dept = deptMapper.selectByPrimaryKey(user1.getDeptno());
            user1.setDeptno(dept.getName());

            LockedState lockedState = lockedStateMapper.selectByPrimaryKey(user1.getLockState());
            user1.setLockState(lockedState.getName());
        }
        PageInfo<User> pageInfo = new PageInfo<>(users);

        return pageInfo;
    }
}
