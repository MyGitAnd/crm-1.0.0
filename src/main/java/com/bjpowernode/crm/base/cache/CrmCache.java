package com.bjpowernode.crm.base.cache;

import com.bjpowernode.crm.base.base.DicType;
import com.bjpowernode.crm.base.base.DicValue;
import com.bjpowernode.crm.base.mapper.DicTypeMapper;
import com.bjpowernode.crm.base.mapper.DicValueMapper;
import com.bjpowernode.crm.base.utils.RedisUtils;
import com.bjpowernode.crm.settings.bean.Dept;
import com.bjpowernode.crm.settings.bean.LockedState;
import com.bjpowernode.crm.settings.bean.User;
import com.bjpowernode.crm.settings.mapper.DeptMapper;
import com.bjpowernode.crm.settings.mapper.LockedStateMapper;
import com.bjpowernode.crm.settings.mapper.UserMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import redis.clients.jedis.Jedis;
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

    @Autowired
    private DeptMapper deptMapper;

    @Autowired
    private LockedStateMapper lockedStateMapper;


    //该方法在服务器启动的时候要调用
    @PostConstruct
    public void init(){

        //注入Redis工具类
        Jedis jedis = RedisUtils.getJedis();
        //使用redis
        jedis.select(7);
        Set<String> keys1 = jedis.keys("user:*");
        List<User> users = null;
        if (keys1.size() > 0){
            //从redis中取出数据
             users = RedisUtils.redisToJava(User.class, jedis, "user:*", 7);
        }else {
         users = userMapper.selectAll();
            //向Redis中存储用户信息
         RedisUtils.dbToRedis(users, jedis, "user:", 7,"userKey");
        }
        servletContext.setAttribute("users",users);

        //缓存到redis中
        Set<String> keys2 = jedis.keys("dept:*");
        List<Dept> depts = null;
        if (keys2.size() > 0){
            //从redis中取出数据
             depts = RedisUtils.redisToJava(Dept.class, jedis, "dept:*", 7);

        }else {
            //向Redis中存储用户信息
            depts = deptMapper.selectAll();
            RedisUtils.dbToRedis(depts,jedis,"dept:",7,"deptKey");
        }
        servletContext.setAttribute("depts",depts);

        //缓存到redis中
        Set<String> keys3 = jedis.keys("lockedState:*");
        List<LockedState> lockedStates = null;
        if (keys3.size() > 0){
           lockedStates = RedisUtils.redisToJava(LockedState.class,jedis,"lockedState:*",7);
        }else {
            //向Redis中存储用户信息
            lockedStates = lockedStateMapper.selectAll();
            RedisUtils.dbToRedis(lockedStates,jedis,"lockedState:",7,"lockKey");
        }
        servletContext.setAttribute("lockedStates",lockedStates);

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
        //保存到redis中
        Set<String> keys4 = jedis.keys("dicType:*");
        Map<String,List<DicValue>> dics = new HashMap<>();
        if (keys4.size() > 0){
            //有数据，从头Redis查询
            //先取dicType
            List<DicType> dicTypes = RedisUtils.redisToJava(DicType.class, jedis, "dicType:*", 7);
            //取出所有dicValue
            List<DicValue> dicValues = RedisUtils.redisToJava(DicValue.class, jedis, "dicValue:*", 7);
            for(DicType dicType : dicTypes){
                //当前的type对应的value集合
                List<DicValue> list = new ArrayList<>();
                for(DicValue dicValue : dicValues){
                    if(dicType.getCode().equals(dicValue.getTypeCode())){
                        list.add(dicValue);
                    }
                }
                dics.put(dicType.getCode(), list);
            }
        }else {
            //从数据库查询
            List<DicType> dicTypes = dicTypeMapper.selectAll();
            //保存到Redis中
            RedisUtils.dbToRedis(dicTypes, jedis, "dicType:", 7,"TypeKey");
            for (DicType dicType : dicTypes) {
                String code = dicType.getCode();

                Example example = new Example(DicValue.class);
                example.setOrderByClause("orderNo");
                example.createCriteria().andEqualTo("typeCode",code);
                List<DicValue> select = dicValueMapper.selectByExample(example);
                //保存到redis中
                RedisUtils.dbToRedis(select,jedis,"dicValue:",7,"ValueKey");
                dics.put(code,select);
            }
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
