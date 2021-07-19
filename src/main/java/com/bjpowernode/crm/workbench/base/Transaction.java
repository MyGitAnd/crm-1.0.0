package com.bjpowernode.crm.workbench.base;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "tbl_tran")
@NameStyle(Style.normal)
public class Transaction {

    @Id
    private String id;
    private String owner;//所有者
    private String money;
    private String name;//名称
    private String expectedDate;//预计成交日期
    private String customerId;//客户名称
    private String stage;//阶段
    private String possibility;//可能性
    private String type;//类型
    private String source;//来源
    private String activityId;//市场活动名称
    private String contactsId; //联系人名称
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;
    private String contactSummary;
    private String nextContactTime;

    @Transient
    private String img;

    //加入交易历史
    private List<TransactionHistory> transactionHistories;

    //加入备注
    private List<TransactionRemark> transactionRemarks;

    @Transient
    public static final Integer index = 21;

}
