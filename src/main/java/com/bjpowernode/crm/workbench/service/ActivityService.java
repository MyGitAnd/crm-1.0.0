package com.bjpowernode.crm.workbench.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface ActivityService {

    PageInfo<Activity> selectAll(Integer page, Integer pageSize, Activity activity);

    List<User> selectUsers();

    ResultVo addAndUpdate(Activity activity, User user);

    Activity updateActivity(String id);

    ResultVo deletesActivitys(String ids);

    Activity selectActivity(String id);

    ResultVo deleteActivity(String id);

    ResultVo addRemark(ActivityRemark activityRemarkm,User user);

    ResultVo updateRemark(ActivityRemark activityRemark, User user);

    ResultVo deleteRemark(String id);

    ExcelWriter exportExcel();
}
