package com.bjpowernode.crm.base.cache;

import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.annotation.PostConstruct;
import javax.servlet.ServletContext;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

        //Map的方式
        List<DicType> dicTypes = dicTypeMapper.selectAll();
        Map<String,List<DicValue>> dics = new HashMap<>();
        for (DicType dicType : dicTypes) {
            String code = dicType.getCode();

            DicValue dicValue = new DicValue();
            dicValue.setTypeCode(code);
            List<DicValue> select = dicValueMapper.select(dicValue);
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
