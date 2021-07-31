package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.FileUploadUtil;
import com.bjpowernode.crm.base.utils.MD5Util;
import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.service.DeptService;
import com.bjpowernode.crm.settings.service.UserService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;


@Controller
public class UserController {
    //注入service层对象
    @Autowired
    private UserService userService;

    @Autowired
    private DeptService deptService;

    @RequestMapping("/settings/user/login")
    @ResponseBody
    public ResultVo login(User user, HttpServletRequest request, HttpSession session){
        ResultVo resultVo = new ResultVo();
        try {
            String remoteAddr = request.getRemoteAddr();
            user.setAllowIps(remoteAddr);
            user = userService.login(user);
            resultVo.setOk(true);
            session.setAttribute("user", user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }
        //登出
    @RequestMapping("/settings/user/logOut")
    public String logOut(HttpSession session){

        session.removeAttribute("user");


        return "redirect:../../login.jsp";
    }
    //校验原密码
    @RequestMapping("/settings/user/oldPassword")
    @ResponseBody
    public ResultVo oldPassword(String loginPwd, HttpSession session){
        ResultVo resultVo = new ResultVo();
        User user1 = (User) session.getAttribute("user");
                //获取session中的对象的密码
            if (!user1.getLoginPwd().equals(MD5Util.getMD5(loginPwd))){
                resultVo.setMessage("原密码不正确！请核对后重试....");
            }else {
                resultVo.setOk(true);
            }
        return resultVo;
    }
    //修改密码
    @RequestMapping("/setting/user/update")
    @ResponseBody
    public ResultVo update(User user){
        ResultVo resultVo = new ResultVo();
        try {
           userService.update(user);
            resultVo.setOk(true);
            resultVo.setMessage("更新密码成功!");
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //上传文件
    @RequestMapping("/setting/user/FileUpload")
    @ResponseBody
    public ResultVo FileUpload(MultipartFile img,HttpServletRequest request){
        //调用工具类
        ResultVo resultVo = null;
        try {
            resultVo = FileUploadUtil.FileUpload(img, request);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }

        return resultVo;
    }


    //查询我的资料
    @RequestMapping("/setting/user/mydata")
    @ResponseBody
    public User mydata(HttpSession session){
    //获取部门信息
        User user = (User) session.getAttribute("user");

        return user;
    }


    //查询所有用户信息
    @RequestMapping("/settings/user/selectAllUser")
    @ResponseBody
    public PageInfo<User> selectAllUser(User user,Integer currentPage,Integer rowsPerPage,String startTime){

        return userService.selectAllUser(user,currentPage,rowsPerPage,startTime);
    }

    //添加用户
    @RequestMapping("/settings/user/addUser")
    @ResponseBody
    public ResultVo addUser(User user){

        ResultVo resultVo = null;
        try {
            resultVo = userService.addUser(user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除用户
    @RequestMapping("/settings/user/deleteUser")
    @ResponseBody
    public ResultVo deleteUser(String ids){

        ResultVo resultVo = null;
        try {
            resultVo = userService.deleteUser(ids);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询用户
    @RequestMapping("/settings/user/selectUser")
    @ResponseBody
    public User selectUser(String id){

        return userService.selectUser(id);
    }
    //修改的查询
    @RequestMapping("/settings/user/selectUser2")
    @ResponseBody
    public User selectUser2(String id){

        return userService.selectUser2(id);
    }
    //修改
    @RequestMapping("/settings/user/updateUser")
    @ResponseBody
    public ResultVo updateUser(User user){

        ResultVo resultVo = null;
        try {
            resultVo = userService.updateUser(user);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }


}
