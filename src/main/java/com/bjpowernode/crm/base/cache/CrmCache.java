package com.bjpowernode.crm.base.cache;

import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import tk.mybatis.mapper.entity.Example;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.*;

@Component
public class CrmCache {

    //注入User mapper层对象
    @Autowired
    private UserMapper userMapper;

    @Autowired
    private ServletContext servletContext;

    @Autowired
    private DicTypeMapper dicTypeMapper;

    @Autowired
    private DicValueMapper dicValueMapper;

    //该方法在服务器启动的时候要调用
    @PostConstruct
    public void init(){
        List<User> users = userMapper.selectAll();
        servletContext.setAttribute("users",users);


        //缓冲阶段和可能性 Map<String,String>
        /**
         * 1、包分隔使用.
         * 2、文件后缀名不用加，特指只读.properties文件
         */
        ResourceBundle bundle = ResourceBundle.getBundle("mybatis.Stage2Possibility");
        Enumeration<String> bundleKeys = bundle.getKeys();
        Map<String,String> keys = new TreeMap<>();
        while (bundleKeys.hasMoreElements()){
            String key = bundleKeys.nextElement();
            String value = bundle.getString(key);
            keys.put(key,value);
        }
        servletContext.setAttribute("stage2Possibility",keys);


        //Map的方式
        List<DicType> dicTypes = dicTypeMapper.selectAll();
        Map<String,List<DicValue>> dics = new HashMap<>();
        for (DicType dicType : dicTypes) {
            String code = dicType.getCode();

            DicValue dicValue = new DicValue();
            Example example = new Example(DicValue.class);
            example.setOrderByClause("orderNo");
            example.createCriteria().andEqualTo("typeCode",code);
            List<DicValue> select = dicValueMapper.selectByExample(example);
            dics.put(code,select);
        }
        servletContext.setAttribute("dics",dics);

        //list 的方式
     /*   List<DicType> dicTypes1 = dicTypeMapper.selectAll();
        for (DicType dicType : dicTypes1) {
            String code = dicType.getCode();

            DicValue dicValue = new DicValue();
            dicValue.setTypeCode(code);
            List<DicValue> dicValues = dicValueMapper.select(dicValue);
            dicType.setDicValues(dicValues);
        }
        servletContext.setAttribute("dicTypes",dicTypes1);*/

    }

}
