package com.bjpowernode.crm.settings.service.impl;

import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.base.ResultVo;
import com.bjpowernode.crm.base.exception.CrmEnum;
import com.bjpowernode.crm.base.exception.CrmException;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.base.utils.UUIDUtil;
import com.bjpowernode.crm.settings.service.DicValueService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import tk.mybatis.mapper.entity.Example;

import java.util.Arrays;
import java.util.List;

@Service
public class DicValueServiceImpl implements DicValueService {

    @Autowired
    private DicValueMapper dicValueMapper;
    //查询
    @Override
    public PageInfo<DicValue> selectDicValue(Integer page,Integer pageSize) {
        PageHelper.startPage(page,pageSize);

        Example example = new Example(DicValue.class);
        example.setOrderByClause("orderNo asc");
        List<DicValue> dicValues = dicValueMapper.selectByExample(example);
        int i = 1;
        for (DicValue dicValue : dicValues) {
            dicValue.setId2(i);
            i++;
        }
        PageInfo<DicValue> pageInfo = new PageInfo(dicValues);
        return pageInfo;
    }
    //添加
    @Override
    public ResultVo addDicValue(DicValue dicValue) {
        dicValue.setId(UUIDUtil.getUUID());
        int count = dicValueMapper.insertSelective(dicValue);
        if (count == 0){
            throw new CrmException(CrmEnum.DicValue__add_add);
        }
        ResultVo resultVo = new ResultVo();
        resultVo.setOk(true);
        resultVo.setMessage("添加成功!");
        return resultVo;
    }

    //修改
    @Override
    public ResultVo updateDicValue(DicValue dicValue) {
        ResultVo resultVo = new ResultVo();
        int count = dicValueMapper.updateByPrimaryKeySelective(dicValue);
        if (count == 0){
            throw new CrmException(CrmEnum.DicValue__update_update);
        }
        resultVo.setOk(true);
        resultVo.setMessage("修改成功!");

        return resultVo;
    }
//修改的查询方法
    @Override
    public DicValue selectValue(String id) {
        DicValue dicValue = dicValueMapper.selectByPrimaryKey(id);

        return dicValue;
    }
    //删除
    @Override
    public ResultVo deleteDicValue(String ids) {
        ResultVo resultVo = new ResultVo();
        String[] split = ids.split(",");
        List<String> list = Arrays.asList(split);
        Example example = new Example(DicValue.class);
        Example.Criteria criteria = example.createCriteria();
        criteria.andIn("id",list);
        int count = dicValueMapper.deleteByExample(example);
        if (count == 0){
            throw new CrmException(CrmEnum.DicValue__Delete_delete);
        }
        resultVo.setOk(true);
        resultVo.setMessage("删除成功!共删除【"+count+"】条数据!");

        return resultVo;
    }
}
