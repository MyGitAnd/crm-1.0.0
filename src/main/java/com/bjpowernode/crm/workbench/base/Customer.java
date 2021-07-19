package com.bjpowernode.crm.workbench.base;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "tbl_customer")
@NameStyle(Style.normal)
public class Customer {
    @Id
    private String id;
    private String owner;//所有者
    private String name;//名称
    private String website;//网站
    private String phone;//手机号
    private String createBy;//创建人
    private String createTime;//创建时间
    private String editBy;//修改人
    private String editTime;//修改时间
    private String contactSummary;//联系纪要
    private String nextContactTime;//下次联系时间
    private String description;//描述
    private String address;//地址

    private  List<CustomerRemark> customerRemarks;//客户对应的备注信息

    @Transient
    public static final Integer index = 14;
}
