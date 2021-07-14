package com.bjpowernode.crm.workbench.controller;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.Clue;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.ClueRemark;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class ClueController {

    @Autowired
    private ClueService clueService;

    @RequestMapping("/settings/contacts/addAndUpdateClue")
    @ResponseBody
    public ResultVo addClue(Clue clue, HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = clueService.addAndUpdateClue(clue,user);
     return resultVo;
    }

    //查询
    @RequestMapping("/settings/clue/selectClues")
    @ResponseBody
    public PageInfo<Clue> selectClues(Integer page,Integer pageSize,Clue clue){

       PageInfo pageInfo  = clueService.selectClues(page,pageSize,clue);

       return pageInfo;
    }

    //修改的查询方法
    @RequestMapping("/settings/clue/editClue")
    @ResponseBody
    public Clue editClue(String id){

       Clue clue = clueService.editClue(id);

       return clue;
    }

    //删除的方法
    @RequestMapping("/settings/clue/deleteClue")
    @ResponseBody
    public ResultVo deleteClue(String ids){

       ResultVo resultVo = clueService.deleteClue(ids);
       return resultVo;
    }

    //查询副页面的表单数据
    @RequestMapping("/workbench/clue/selectClue")
    @ResponseBody
    public Clue selectClue(String id){

       return clueService.selectClue(id);
    }

    //删除表单
    @RequestMapping("/workbench/clue/delete")
    @ResponseBody
    public ResultVo delete(String id){

     return  clueService.delete(id);
    }
    //添加备注信息
    @RequestMapping("/workbench/clue/saveRemark")
    @ResponseBody
    public ResultVo saveRemark(ClueRemark clueRemark,HttpSession session){
        User user = (User) session.getAttribute("user");

      ResultVo resultVo = clueService.saveRemark(clueRemark,user);
      return resultVo;
    }
    //修改备注信息
    @RequestMapping("/workebench/clueRemark/updateClueRemark")
    @ResponseBody
    public ResultVo updateClueRemark(ClueRemark clueRemark,HttpSession session){
        User user = (User) session.getAttribute("user");
        ResultVo resultVo = clueService.updateClueRemark(clueRemark,user);
        return resultVo;
    }
    //删除备注信息
    @RequestMapping("/workbench/clueRemark/deleteClueRemark")
    @ResponseBody
    public ResultVo deleteClueRemark(String id){
      return   clueService.deleteClueRemark(id);
    }

    //查询关联的市场活动
    @RequestMapping("/workbench/clueActivity/selectClueActivity")
    @ResponseBody
    public List<Activity> selectClueActivity(String id){

    List<Activity> activityList = clueService.selectClueActivity(id);
    return activityList;
    }

    //查询市场活动
    @RequestMapping("/workbench/clueActivity/selectActivity")
    @ResponseBody
    public List<Activity> selectActivity(String id,String name){
       List<Activity> activityList = clueService.selectActivity(id,name);

       return activityList;
    }
//添加关联
    @RequestMapping("/workbench/clueActivity/addClueActivitys")
    @ResponseBody
    public ResultVo addClueActivitys(String id,String ids){

        ResultVo resultVo = clueService.addClueActivitys(id,ids);

        return resultVo;
    }

    //解除关联
    @RequestMapping("/workbench/clueActivity/deleteClueActivity")
    @ResponseBody
    public ResultVo deleteClueActivity(String activityId,String clueId){

        ResultVo resultVo = clueService.deleteClueActivity(activityId,clueId);
        return resultVo;
    }


}
