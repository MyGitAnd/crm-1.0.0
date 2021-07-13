package com.bjpowernode.crm.workbench.base;
import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;
import javax.persistence.Id;
import javax.persistence.Table;

@Data
@Table(name = "tbl_contacts")
@NameStyle(Style.normal)
public class Contacts {
    @Id
    private String id;
    private String owner;//所有者
    private String source;//来源
    private String customerId;//姓名
    private String fullname;//客户名称
    private String appellation;
    private String email;
    private String mphone;
    private String job;
    private String birth;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;
    private String contactSummary;
    private String nextContactTime;

}
