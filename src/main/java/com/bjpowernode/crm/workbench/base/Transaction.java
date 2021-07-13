package com.bjpowernode.crm.workbench.base;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_tran")
@NameStyle(Style.normal)
public class Transaction {

    @Id
    private String id;
    private String owner;//所有者
    private String money;
    private String name;//名称
    private String expectedDate;
    private String customerId;//客户名称
    private String stage;//阶段
    private String possibility;
    private String type;
    private String source;
    private String activityId;//类型
    private String contactsId;//来源  //联系人名称
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;
    private String contactSummary;
    private String nextContactTime;

}
