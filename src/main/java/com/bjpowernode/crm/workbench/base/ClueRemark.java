package com.bjpowernode.crm.workbench.base;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Data
@Table(name = "tbl_clue_remark")
@NameStyle(Style.normal)
public class ClueRemark {
    @Id
    private String id;
    private String noteContent;
    private String createBy;
    private String createTime;
    private String editBy;
    private String editTime;
    private String editFlag;
    private String clueId;
    private String owner;

    //设置备注头像
    @Transient
    private String img;

}
