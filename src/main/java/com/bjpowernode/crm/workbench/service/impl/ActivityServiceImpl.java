package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ActivityRemarkMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.List;

@Service
public class ActivityServiceImpl implements ActivityService {
    //注入mapper层对象
    @Autowired
    private ActivityMapper activityMapper;
    //注入mapper层对象
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ActivityRemarkMapper activityRemarkMapper;
    //查询所有信息
    @Override
    public PageInfo<Activity> selectAll(Integer page, Integer pageSize, Activity activity) {
        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();
        //名称不能为空和空字符串  模糊查询名称
        if (StrUtil.isNotEmpty(activity.getName())){
            criteria.andLike("name","%" + activity.getName() + "%");
        }

        //判断所有者不能为空 因为用户输入的是姓名，处理步骤如下
        //            1、根据用户输入的姓名，对用户表模糊查询，将查询出来的用户主键封装到集合中
        //            2、再查询市场活动表中的owner有哪些在1中的主键集合中
        if (StrUtil.isNotEmpty(activity.getOwner())){
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name","%" + activity.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }

        //查询开始时间
        if (StrUtil.isNotEmpty(activity.getStartDate())){
            criteria.andGreaterThanOrEqualTo("startDate",activity.getStartDate());
        }
        //查询结束时间
        if (StrUtil.isNotEmpty(activity.getEndDate())){
            criteria.andLessThanOrEqualTo("endDate",activity.getEndDate());
        }


        PageHelper.startPage(page,pageSize);
        List<Activity> activities = activityMapper.selectByExample(example);
        for (Activity activity1 : activities) {
            User user = userMapper.selectByPrimaryKey(activity1.getOwner());
            activity1.setOwner(user.getName());
        }
        PageInfo<Activity> pageInfo = new PageInfo(activities);


        return pageInfo;
    }
    //查询所有者信息
    @Override
    public List<User> selectUsers() {

        List<User> users = userMapper.selectAll();

        return users;
    }

    @Override
    public ResultVo addAndUpdate(Activity activity, User user) {
        ResultVo resultVo = new ResultVo();
        if (activity.getId() != null){
            //修改
            activity.setEditBy(user.getName());
            activity.setEditTime(DateTimeUtil.getSysTime());
            int count = activityMapper.updateByPrimaryKey(activity);
            if (count==0){
                throw new CrmException(CrmEnum.Activity_Update_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改市场活动成功!");

        }else {
            //添加
            activity.setId(UUIDUtil.getUUID());
            activity.setCreateBy(user.getName());
            activity.setCreateTime(DateTimeUtil.getSysTime());
            int account = activityMapper.insertSelective(activity);
            if (account == 0){
                throw new CrmException(CrmEnum.Activity_insert_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加市场活动成功!");
        }

        return resultVo;
    }


    //修改查询的方法
    @Override
    public Activity updateActivity(String id) {
        Activity activity = activityMapper.selectByPrimaryKey(id);

        return activity;
    }
        //删除的方法
    @Override
    public ResultVo deletesActivitys(String ids) {
        ResultVo resultVo = new ResultVo();
        String[] split = ids.split(",");
        List<String> list = new ArrayList<>();
        for (String id : split) {
            list.add(id);
        }
        Example example = new Example(Activity.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andIn("id",list);
        int count = activityMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Activity_Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功！【共删除"+count+"条记录】");

        return resultVo;
    }
    //发传单页面
    @Override
    public Activity selectActivity(String id) {
        Activity activity = updateActivity(id);
        User user = userMapper.selectByPrimaryKey(activity.getOwner());
        //设置所有者
        activity.setOwner(user.getName());

        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setActivityId(activity.getId());
        List<ActivityRemark> activityRemarks = activityRemarkMapper.select(activityRemark);
        for (ActivityRemark remark : activityRemarks) {
            remark.setActivityId(activity.getName());
            User user1 = userMapper.selectByPrimaryKey(remark.getOwner());
            remark.setImg(user1.getImg());
        }
        //把备注集合放到当前市场活动中
        activity.setActivityRemarks(activityRemarks);
        return activity;
    }
    //删除发传单
    @Override
    public ResultVo deleteActivity(String id) {
        ResultVo resultVo = new ResultVo();
        int count = activityMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.Activity_Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功!");

        return resultVo;

    }


    //添加备注信息
    @Override
    public ResultVo addRemark(ActivityRemark activityRemark,User user) {
        ResultVo resultVo = new ResultVo();
        activityRemark.setId(UUIDUtil.getUUID());
        activityRemark.setCreateTime(DateTimeUtil.getSysTime());
        activityRemark.setCreateBy(user.getName());
        activityRemark.setImg(user.getImg());
        activityRemark.setOwner(user.getId());
        int count = activityRemarkMapper.insertSelective(activityRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ActivityRemark_Insert_add);
        }
        //设置备注对应的市场活动

        Activity activity = updateActivity(activityRemark.getActivityId());
        activityRemark.setActivityId(activity.getName());

        resultVo.setT(activityRemark);
        resultVo.setOk(true);
        resultVo.setMessage("添加备注成功!");

        return resultVo;
    }

    //修改备注信息
    @Override
    public ResultVo updateRemark(ActivityRemark activityRemark, User user) {
        ResultVo resultVo = new ResultVo();
        activityRemark.setEditFlag("1");
        activityRemark.setEditBy(user.getName());
        activityRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = activityRemarkMapper.updateByPrimaryKeySelective(activityRemark);

        if (count==0){
            throw new CrmException(CrmEnum.ActivityRemark_update_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改备注信息成功!");

        return resultVo;
    }

    //删除备注信息
    @Override
    public ResultVo deleteRemark(String id) {
        ResultVo resultVo = new ResultVo();
        int count = activityRemarkMapper.deleteByPrimaryKey(id);
        if (count==0){
            throw new CrmException(CrmEnum.ActivityRemark_delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功");

        return resultVo;
    }
}
