package com.bjpowernode.crm.settings.controller;

import cn.hutool.core.io.IoUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.settings.service.DicTypeService;
import com.bjpowernode.crm.workbench.base.ClueActivity;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
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

        ResultVo resultVo = null;
        try {
            resultVo = dicTypeService.save(dicType);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
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

        ResultVo resultVo = null;
        try {
            resultVo = dicTypeService.editType(dicType);
        } catch (CrmException e) {
          resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }

    //删除的方法
    @RequestMapping("/settings/clueType/DeleteDicType")
    @ResponseBody
    public ResultVo deleteDicType(String ids){
        ResultVo resultVo = null;
        try {
            resultVo = dicTypeService.deleteDicType(ids);
        } catch (CrmException e) {
            resultVo.setMessage(e.getMessage());
        }
        return resultVo;
    }


    //导出报表
    @RequestMapping("/settings/Type/exportExcel")
    @ResponseBody
    public void exportExcel(HttpServletResponse response){
        ExcelWriter excelWriter = null;
        ServletOutputStream out = null;
        try {
            excelWriter = dicTypeService.exportExcel();
            //response为HttpServletResponse对象
            response.setContentType("application/vnd.ms-excel;charset=utf-8");
            //test.xls是弹出下载对话框的文件名，不能为中文，中文请自行编码
            response.setHeader("Content-Disposition","attachment;filename=DicType.xls");
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
