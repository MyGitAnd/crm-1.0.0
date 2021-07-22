package com.bjpowernode.crm.settings.service.impl;

import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import cn.hutool.poi.excel.StyleSet;
import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.settings.service.DicTypeService;
import com.bjpowernode.crm.workbench.base.Visit;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
import java.util.List;

@Service
public class DicTypeServiceImpl implements DicTypeService {
    @Autowired
    private DicTypeMapper dicTypeMapper;
    //查询所有
    @Override
    public PageInfo<DicType> types(Integer page,Integer pageSize) {
        PageHelper.startPage(page,pageSize);
        //定义变量保存id
        int i = 1;
        List<DicType> dicTypes = dicTypeMapper.selectAll();
        for (DicType dicType : dicTypes) {
            dicType.setId(i++);
        }
        PageInfo<DicType> pageInfo = new PageInfo(dicTypes);
        return pageInfo;
    }
    //添加
    @Override
    public ResultVo save(DicType dicType) {
        ResultVo resultVo = new ResultVo();
        int count = dicTypeMapper.insertSelective(dicType);
        if (count == 0){
            throw new CrmException(CrmEnum.DicType__Insert_add);
        }
        resultVo.setOk(true);
        resultVo.setMessage("添加类型信息成功!");
        return resultVo;
    }
    //修改的查询的方法
    @Override
    public DicType updateType(String code) {
        return dicTypeMapper.selectByPrimaryKey(code);
    }
    //修改的方法
    @Override
    public ResultVo editType(DicType dicType) {
        ResultVo resultVo = new ResultVo();
        int count = dicTypeMapper.updateByPrimaryKey(dicType);
        if (count == 0){
            throw new CrmException(CrmEnum.DicType__Update_edit);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改成功!");

        return resultVo;
    }
    //删除的方法
    @Override
    public ResultVo deleteDicType(String ids) {
        String[] idss = ids.split(",");
        List<String> id = Arrays.asList(idss);
        Example example = new Example(DicType.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andIn("code",id);
        int count = dicTypeMapper.deleteByExample(example);
        if (count == 0){
                throw new CrmException(CrmEnum.USER_UPLOAD_SUFFIX);
            }
        ResultVo resultVo = new ResultVo();
        resultVo.setOk(true);
        resultVo.setMessage("删除信息成功!共删除【"+count+"】条记录!");
        return resultVo;
    }
    //导出报表
    @Override
    public ExcelWriter exportExcel() {
        // 通过工具类创建writer，默认创建xls格式
        ExcelWriter writer = ExcelUtil.getWriter();
        // 一次性写出内容，使用默认样式，强制输出标题
        List<DicType> dicTypes = dicTypeMapper.selectAll();

        writer.merge(DicType.index + 1,"数据字典报表");

        //设置字体颜色
        StyleSet styleSet = writer.getStyleSet();


        writer.write(dicTypes, true);
        return writer;
    }
}
