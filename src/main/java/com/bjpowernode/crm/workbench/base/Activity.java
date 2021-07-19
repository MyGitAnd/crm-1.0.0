package com.bjpowernode.crm.workbench.base;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "tbl_activity")
@NameStyle(Style.normal)
public class Activity {
     @Id
     private String  id;//主键
     private String  owner;//所有者，登录的用户
     private String  name;//市场活动名称
     private String  startDate;//开始时间  年月日
     private String  endDate;//结束时间
     private String  cost;//花费
     private String  description;//描述
     private String  createTime;
     private String  createBy;//当前登录的用户
     private String  editTime;
     private String  editBy;

    List<ActivityRemark> activityRemarks;//市场活动对应的备注集合

    //属性的个数
    @Transient
    public static final Integer index = 12;
}
