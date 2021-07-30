package com.bjpowernode.crm.settings.service.impl;

import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.StyleSet;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.DeptMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import com.bjpowernode.crm.settings.service.DeptService;
import com.bjpowernode.crm.workbench.base.Clue;
import com.bjpowernode.crm.workbench.base.ClueRemark;
import org.apache.poi.ss.formula.functions.Count;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
import java.util.List;


@Service
public class DeptServiceImpl implements DeptService {
    //注入mapper层
    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private UserMapper userMapper;

    //查询所有部门信息
    @Override
    public List<Dept> selectAll(){

        List<Dept> depts = deptMapper.selectAll();
        for (Dept dept : depts) {
            User user = userMapper.selectByPrimaryKey(dept.getOwner());
            dept.setOwner(user.getName());
        }
        return depts;
    }

    //添加
    @Override
    public ResultVo addDept(Dept dept) {
        ResultVo resultVo = new ResultVo();
        int count = deptMapper.insertSelective(dept);
        if (count == 0){
            throw new CrmException(CrmEnum.Dept_Add_Add);
        }
        resultVo.setOk(true);
        resultVo.setMessage("添加部门成功!");
        return resultVo;
    }

    //修改的查询方法
    @Override
    public Dept selectDept(String id) {
        Dept dept = deptMapper.selectByPrimaryKey(id);

        return dept;
    }

    //修改的方法
    @Override
    public ResultVo updateDept(Dept dept) {
        ResultVo resultVo = new ResultVo();

        int count = deptMapper.updateByPrimaryKeySelective(dept);
        if (count == 0){
            throw new CrmException(CrmEnum.Dept_update_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改部门信息成功!");
        return resultVo;
    }

    //删除的方法
    @Override
    public ResultVo deleteDept(String ids) {
        ResultVo resultVo = new ResultVo();
        List<String> list = Arrays.asList(ids.split(","));
        Example example = new Example(Dept.class);
        example.createCriteria().andIn("id",list);
        int count = deptMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.Dept_delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功!共删除【"+ count+"】条数据!");
        return resultVo;
    }

    //导出报表
    @Override
    public ExcelWriter exportExcel() {


        // 通过工具类创建writer，默认创建xls格式
        ExcelWriter writer = ExcelUtil.getWriter();
        // 一次性写出内容，使用默认样式，强制输出标题
        List<Dept> depts = deptMapper.selectAll();
        for (Dept dept : depts) {
            User user = userMapper.selectByPrimaryKey(dept.getOwner());
            dept.setOwner(user.getName());
        }
        writer.merge(Dept.index - 1,"部门信息报表");
        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();
        //自定义标题别名
        writer.addHeaderAlias("id", "编号");
        writer.addHeaderAlias("name", "名称");
        writer.addHeaderAlias("owner", "负责人");
        writer.addHeaderAlias("phone", "电话");
        writer.addHeaderAlias("description", "描述");

        writer.write(depts, true);
        return writer;

    }
}
