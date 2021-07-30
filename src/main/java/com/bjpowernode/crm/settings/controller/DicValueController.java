package com.bjpowernode.crm.settings.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
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
        ResultVo resultVo = null;
        try {
            resultVo = dicValueService.addDicValue(dicValue);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
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

        ResultVo resultVo = null;
        try {
            resultVo = dicValueService.updateDicValue(dicValue);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //查询的方法
    @RequestMapping("/settings/dictionary/typeValues")
    @ResponseBody
    public List<DicType> typeValues(){

        return dicValueService.typeValues();
    }

    //删除的方法
    @RequestMapping("/settings/DicValue/deleteDicValue")
    @ResponseBody
    public ResultVo deleteDicValue(String ids){
        ResultVo resultVo = null;
        try {
            resultVo = dicValueService.deleteDicValue(ids);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //导出报表
    @RequestMapping("/settings/Value/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response){
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try {
            excelWriter = dicValueService.exportExcel();
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=DicValue.xls");
            out = response.getOutputStream();
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            excelWriter.flush(out, true);
            // 关闭writer，释放内存
            excelWriter.close();
            //此处记得关闭输出Servlet流
            IoUtil.close(out);
        }
    }
}
