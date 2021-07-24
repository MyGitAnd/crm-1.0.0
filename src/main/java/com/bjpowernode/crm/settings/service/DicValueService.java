package com.bjpowernode.crm.settings.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.base.ResultVo;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface DicValueService {
    PageInfo<DicValue> selectDicValue(Integer page,Integer pageSize);

    ResultVo addDicValue(DicValue dicValue);

    ResultVo updateDicValue(DicValue dicValue);

    DicValue selectValue(String id);

    ResultVo deleteDicValue(String ids);

    ExcelWriter exportExcel();


    List<DicType> typeValues();

}
