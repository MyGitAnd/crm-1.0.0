package com.bjpowernode.crm.settings.controller;

import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
public class DicValueController {

    @Autowired
    private DicValueService dicValueService;

    @RequestMapping("/settings/DicValue/selectDicValue")
    @ResponseBody
    public PageInfo<DicValue> selectDicValue(Integer page, Integer pageSize){

        return dicValueService.selectDicValue(page,pageSize);
    }

    //添加
    @RequestMapping("/settings/dicValue/addDicValue")
    @ResponseBody
    public ResultVo addDicValue(DicValue dicValue){
        return dicValueService.addDicValue(dicValue);
    }
    //修改的查询的方法
    @RequestMapping("/settings/DicValue/selectValue")
    @ResponseBody
    public DicValue selectValue(String id){
        return dicValueService.selectValue(id);
    }

    //修改的方法
    @RequestMapping("/settings/dicValue/updateDicValue")
    @ResponseBody
    public ResultVo updateDicValue(DicValue dicValue){

        return dicValueService.updateDicValue(dicValue);
    }

    //删除的方法
    @RequestMapping("/settings/DicValue/deleteDicValue")
    @ResponseBody
    public ResultVo deleteDicValue(String ids){
        return dicValueService.deleteDicValue(ids);
    }
}
