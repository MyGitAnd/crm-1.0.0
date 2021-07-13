package com.bjpowernode.crm.workbench.controller;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.ActivityRemark;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.service.ActivityService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ActivityController {
    //注入service层
    @Autowired
    private ActivityService activityService;

    //查询所有信息
    @RequestMapping("/workbench/activity/list")
    @ResponseBody
    public PageInfo list(Integer page,Integer pageSize,Activity activity){

        PageInfo<Activity> pageInfo = activityService.selectAll(page,pageSize,activity);

        return pageInfo;
    }

    //查询所有用户信息
    @RequestMapping("/workbench/activity/users")
    @ResponseBody
    public List<User> users(){
      List<User>  userList = activityService.selectUsers();

        return userList;
    }

    //添加用户
    @RequestMapping("/workbench/activity/addAndUpdate")
    @ResponseBody
    public ResultVo addAndUpdate(Activity activity, HttpSession session){
        ResultVo resultVo = null;
        //
        try {
            User user = (User) session.getAttribute("user");
            resultVo = activityService.addAndUpdate(activity,user);
        } catch (CrmException e) {
           resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }

    //修改的方法
    @RequestMapping("/workbench/activity/editActivity")
    @ResponseBody
    public Activity editActivity(String id){

        return activityService.updateActivity(id);
    }

    //删除的方法
    @RequestMapping("/workbench/activity/deletesActivity")
    @ResponseBody
    public ResultVo deletesActivity(String ids){


        ResultVo resultVo = activityService.deletesActivitys(ids);

        return resultVo;
    }

    //发传单页面的元素和备注信息的方法
    @RequestMapping("/workbench/activity/detailActivity")
    @ResponseBody
    public Activity detailActivity(String id){
        Activity activity =  activityService.selectActivity(id);
      return activity;
    }

    //删除的方法
    @RequestMapping("/workbench/activity/deleteActivity")
    @ResponseBody
    public ResultVo deleteActivity(String id){


        ResultVo resultVo = activityService.deleteActivity(id);

        return resultVo;
    }

    //添加备注信息的方法
    @RequestMapping("/workbench/activity/addRemark")
    @ResponseBody
    public ResultVo addRemark(ActivityRemark activityRemark,HttpSession session){
     User user = (User)session.getAttribute("user");

    ResultVo resultVo =  activityService.addRemark(activityRemark,user);

    return resultVo;
    }

    //修改备注信息
    @RequestMapping("/workbench/activity/updateRemark")
    @ResponseBody
    public ResultVo updateRemark(ActivityRemark activityRemark,HttpSession session){

        User user = (User)session.getAttribute("user");

        ResultVo resultVo =  activityService.updateRemark(activityRemark,user);

        return resultVo;

    }


    //删除备注信息
    @RequestMapping("/workbench/activity/deleteRemark")
    @ResponseBody
    public ResultVo deleteRemark(String id){



        ResultVo resultVo =  activityService.deleteRemark(id);

        return resultVo;

    }
}
