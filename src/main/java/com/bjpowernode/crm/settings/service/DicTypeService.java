package com.bjpowernode.crm.settings.service;

import cn.hutool.poi.excel.ExcelWriter;
import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.ResultVo;
import com.github.pagehelper.PageInfo;


import java.util.List;

public interface DicTypeService {
    PageInfo<DicType> types(Integer page,Integer pageSize);

    ResultVo save(DicType dicType);

    DicType updateType(String code);

    ResultVo editType(DicType dicType);

    ResultVo deleteDicType(String ids);

    ExcelWriter exportExcel();

}
