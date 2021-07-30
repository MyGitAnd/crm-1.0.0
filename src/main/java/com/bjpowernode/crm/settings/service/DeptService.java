package com.bjpowernode.crm.settings.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.settings.bean.Dept;

import java.util.List;

public interface DeptService {

    List<Dept> selectAll();

    ResultVo addDept(Dept dept);

    Dept selectDept(String id);

    ResultVo updateDept(Dept dept);

    ResultVo deleteDept(String ids);

    ExcelWriter exportExcel();

}
