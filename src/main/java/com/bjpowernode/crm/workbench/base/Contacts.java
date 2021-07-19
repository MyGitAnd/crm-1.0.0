package com.bjpowernode.crm.workbench.base;
import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "tbl_contacts")
@NameStyle(Style.normal)
public class Contacts {
    @Id
    private String id;
    private String owner;//所有者
    private String source;//来源
    private String customerId;//客户名称
    private String fullname;//姓名
    private String appellation;//昵称
    private String email;//邮箱
    private String mphone;//联系人手机号
    private String job;//职位
    private String birth;//生日
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String description;//描述
    private String contactSummary;
    private String nextContactTime;
    private String address;

    private List<ContactsRemark> contactsRemarks;//备注集合

    //属性的个数
    @Transient
    public static final Integer index = 19;

}
