package com.bjpowernode.crm.settings.bean;

import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Data
@Table(name = "tbl_dept")
@NameStyle(Style.normal)
public class Dept {

    @Id
    private String id;
    private String name;
    private String owner;
    private String phone;
    private String description;

    @Transient
    public static final int index = 5;

}
