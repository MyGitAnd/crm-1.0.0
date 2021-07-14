package com.bjpowernode.crm.workbench.service.impl;

import cn.hutool.core.util.StrUtil;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.utils.DateTimeUtil;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.workbench.base.Activity;
import com.bjpowernode.crm.workbench.base.Clue;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.workbench.base.ClueActivity;
import com.bjpowernode.crm.workbench.base.ClueRemark;
import com.bjpowernode.crm.workbench.mapper.ActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ClueActivityMapper;
import com.bjpowernode.crm.workbench.mapper.ClueMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.workbench.mapper.ClueRemarkMapper;
import com.bjpowernode.crm.workbench.service.ClueService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

@Service
public class ClueServiceImpl implements ClueService {
    @Autowired
    private ClueMapper clueMapper;

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ClueRemarkMapper clueRemarkMapper;

    @Autowired
    private ClueActivityMapper clueActivityMapper;

    @Autowired
    private ActivityMapper activityMapper;
    //添加和修改的方法
    @Override
    public ResultVo addAndUpdateClue(Clue clue, User user) {
        ResultVo resultVo = new ResultVo();

        if (clue.getId() != null) {
            //修改的方法
            clue.setEditBy(user.getName());
            clue.setEditTime(DateTimeUtil.getSysTime());
            int count = clueMapper.updateByPrimaryKeySelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.Clue__update_update);
            }
            resultVo.setOk(true);
            resultVo.setMessage("修改线索成功！");
        } else {
            //添加的
            clue.setId(UUIDUtil.getUUID());
            clue.setCreateBy(user.getName());
            clue.setCreateTime(DateTimeUtil.getSysTime());

            int count = clueMapper.insertSelective(clue);
            if (count == 0) {
                throw new CrmException(CrmEnum.Clue__insert_add);
            }
            resultVo.setOk(true);
            resultVo.setMessage("添加线索成功!");
        }
            return resultVo;
    }
    //查询的方法
    @Override
    public PageInfo selectClues(Integer page, Integer pageSize, Clue clue) {
        Example example = new Example(Clue.class);
        Example.Criteria criteria = example.createCriteria();

        if (StrUtil.isNotEmpty(clue.getFullname())) {
            criteria.andLike("fullname", "%" + clue.getFullname() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getCompany())) {
            criteria.andLike("company", "%" + clue.getCompany() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getPhone())) {
            criteria.andLike("phone", "%" + clue.getPhone() + "%");
        }
        if (!"请选择".equals(clue.getSource())) {
            criteria.andLike("source", "%" + clue.getSource() + "%");
        }
        if (StrUtil.isNotEmpty(clue.getOwner())) {
            Example example1 = new Example(User.class);
            example1.createCriteria().andLike("name", "%" + clue.getOwner() + "%");
            List<User> users = userMapper.selectByExample(example1);
            List<String> list = new ArrayList<>();
            for (User user : users) {
                    list.add(user.getId());
            }
            criteria.andIn("owner",list);
        }
        if (StrUtil.isNotEmpty(clue.getMphone())) {
            criteria.andLike("mphone", "%" + clue.getMphone() + "%");
        }
        if (!"请选择".equals(clue.getState())) {
            criteria.andLike("state", "%" + clue.getState() + "%");
        }

        PageHelper.startPage(page, pageSize);
        List<Clue> clues = clueMapper.selectByExample(example);
        for (Clue clue1 : clues) {
            User user = userMapper.selectByPrimaryKey(clue1.getOwner());
            clue1.setFullname(clue1.getFullname() + clue1.getAppellation());
            clue1.setOwner(user.getName());
        }
        PageInfo<Clue> pageInfo = new PageInfo(clues);

        return pageInfo;
    }
//  修改的查询方法
    @Override
    public Clue editClue(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);
//        User user = userMapper.selectByPrimaryKey(clue.getOwner());
//        clue.setOwner(user.getName());
        return clue;
    }
    //删除的方法
    @Override
    public ResultVo deleteClue(String ids) {
        ResultVo resultVo = new ResultVo();
        String[] Cids = ids.split(",");
        List<String> list = Arrays.asList(Cids);
        Example example = new Example(Clue.class);
        example.createCriteria().andIn("id",list);
        int count = clueMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Clue__Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功! 共删除【"+count+"】条数据!");
        return resultVo;
    }
    //查询副页面的表单数据
    @Override
    public Clue selectClue(String id) {
        Clue clue = clueMapper.selectByPrimaryKey(id);

        //所有者
        User user = userMapper.selectByPrimaryKey(clue.getOwner());
        clue.setOwner(user.getName());
        ClueRemark clueRemark = new ClueRemark();
        clueRemark.setClueId(clue.getId());
        List<ClueRemark> clueRemarks = clueRemarkMapper.select(clueRemark);
        for (ClueRemark remark : clueRemarks) {
            remark.setClueId(clue.getFullname() + clue.getAppellation());
            User user1 = userMapper.selectByPrimaryKey(remark.getOwner());
            remark.setImg(user1.getImg());
        }
        //把集合放到对象中
        clue.setClueRemarks(clueRemarks);

        return clue;
    }
    //删除表单
    @Override
    public ResultVo delete(String id) {
        ResultVo resultVo = new ResultVo();
        int count = clueMapper.deleteByPrimaryKey(id);
        if (count==0){
            throw new CrmException(CrmEnum.Clue__Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功！");

        return resultVo;
    }
//添加备注信息
    @Override
    public ResultVo saveRemark(ClueRemark clueRemark, User user) {
        ResultVo resultVo = new ResultVo();
        clueRemark.setId(UUIDUtil.getUUID());
        clueRemark.setCreateBy(user.getName());
        clueRemark.setOwner(user.getId());
        clueRemark.setImg(user.getImg());
        clueRemark.setCreateTime(DateTimeUtil.getSysTime());
        int count = clueRemarkMapper.insertSelective(clueRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__add_insert);
        }

        Clue clue = editClue(clueRemark.getClueId());
        clueRemark.setClueId(clue.getFullname()+clue.getAppellation());

        resultVo.setOk(true);
        resultVo.setMessage("添加备注信息成功!");
        resultVo.setT(clueRemark);
        return resultVo;
    }
    //修改备注信息
    @Override
    public ResultVo updateClueRemark(ClueRemark clueRemark, User user) {
        ResultVo resultVo = new ResultVo();
        clueRemark.setEditBy(user.getName());
        clueRemark.setEditFlag("1");
        clueRemark.setEditTime(DateTimeUtil.getSysTime());
        int count = clueRemarkMapper.updateByPrimaryKeySelective(clueRemark);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__Edit_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改备注信息成功!");
        return resultVo;
    }
    //删除备注信息
    @Override
    public ResultVo deleteClueRemark(String id) {
        ResultVo resultVo = new ResultVo();
        int count = clueRemarkMapper.deleteByPrimaryKey(id);
        if (count == 0){
            throw new CrmException(CrmEnum.ClueRemark__Delete_Delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除备注信息成功!");
        return resultVo;
    }

    //查询关联的市场活动
    @Override
    public List<Activity> selectClueActivity(String id) {
        ClueActivity clueActivity = new ClueActivity();
        clueActivity.setClueId(id);
        List<ClueActivity> activities = clueActivityMapper.select(clueActivity);
        //创建集合保存数据
        List<Activity> activityList = new ArrayList<>();
        for (ClueActivity activity : activities) {
            //根据外键查询市场活动信息
            Activity activity1 = activityMapper.selectByPrimaryKey(activity.getActivityId());
            //查询所有者信息
            User user = userMapper.selectByPrimaryKey(activity1.getOwner());
            activity1.setOwner(user.getName());
            activityList.add(activity1);
        }
        return activityList;
    }

    //查询市场活动
    @Override
    public List<Activity> selectActivity(String id, String name) {
            ClueActivity clueActivity = new ClueActivity();
            clueActivity.setClueId(id);
            List<ClueActivity> clueActivities = clueActivityMapper.select(clueActivity);
            //保存数据
            List<String> activities = new ArrayList<>();
            for (ClueActivity activity : clueActivities) {
                activities.add(activity.getActivityId());
            }
            Example example = new Example(Activity.class);
            Example.Criteria criteria = example.createCriteria();
            if (StrUtil.isNotEmpty(name)){
                criteria.andLike("name","%" + name + "%");
            }
            criteria.andNotIn("id",activities);
            List<Activity> activities1 = activityMapper.selectByExample(example);
            for (Activity activity : activities1) {
            User user = userMapper.selectByPrimaryKey(activity.getOwner());
            activity.setOwner(user.getName());
            }
            return activities1;
    }
    //关联市场活动
    @Override
    public ResultVo addClueActivitys(String id, String ids) {
        String[] idss = ids.split(",");
        List<String> asList = Arrays.asList(idss);
        for (String s : asList) {
            ClueActivity clueActivity = new ClueActivity();
            clueActivity.setId(UUIDUtil.getUUID());
            clueActivity.setClueId(id);
            clueActivity.setActivityId(s);
            int count = clueActivityMapper.insertSelective(clueActivity);
            if (count==0){
                throw new CrmException(CrmEnum.ClueActivity__add_insert);
            }
        }
        //查询已经关联的市场活动
//        List<Activity> activityList = selectClueActivity(id);
        ResultVo resultVo = new ResultVo();
        resultVo.setOk(true);
        resultVo.setMessage("关联市场活动成功!");
        //resultVo.setT(activityList);
        return resultVo;
    }

    //解除关联市场活动
    @Override
    public ResultVo deleteClueActivity(String activityId,String clueId) {
        ResultVo resultVo = new ResultVo();
        ClueActivity clueActivity = new ClueActivity();
        clueActivity.setActivityId(activityId);
        clueActivity.setClueId(clueId);
        List<ClueActivity> select = clueActivityMapper.select(clueActivity);
        for (ClueActivity activity : select) {
            int count = clueActivityMapper.deleteByPrimaryKey(activity.getId());
            if (count == 0){
                throw new CrmException(CrmEnum.ClueActivity__delete_delete);
            }
        }
        resultVo.setOk(true);
        resultVo.setMessage("解除关联市场活动成功!");
        return resultVo;
    }
}
