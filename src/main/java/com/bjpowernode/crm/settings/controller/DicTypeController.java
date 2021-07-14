package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.service.DicTypeService;
import com.bjpowernode.crm.workbench.base.ClueActivity;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DicTypeController {

    @Autowired
    private DicTypeService dicTypeService;
    //查询所有
    @RequestMapping("/settings/dictionary/types")
    @ResponseBody
    public PageInfo<DicType> types(Integer page,Integer pageSize){

        return dicTypeService.types(page,pageSize);
    }

    //添加
    @RequestMapping("/settings/dictionary/type/save")
    @ResponseBody
    public ResultVo save(DicType dicType){

    return  dicTypeService.save(dicType);
    }
    //修改的查询的方法
    @RequestMapping("/settings/editType/updateType")
    @ResponseBody
    public DicType updateType(String code){

        return dicTypeService.updateType(code);
    }

    @RequestMapping("/settings/editType/editType")
    @ResponseBody
    public ResultVo editType(DicType dicType){

        return dicTypeService.editType(dicType);
    }

    //删除的方法
    @RequestMapping("/settings/clueType/DeleteDicType")
    @ResponseBody
    public ResultVo deleteDicType(String ids){

        return dicTypeService.deleteDicType(ids);
    }

}
