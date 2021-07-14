package com.bjpowernode.crm.base.base;
import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import java.util.List;

@Data
@Table(name = "tbl_dic_type")
@NameStyle(Style.normal)
public class DicType {

    @Id
    private String code;
    @Transient//数据库没有这个字段
    private int id;
    private String name;
    private String description;


    private List<DicValue> dicValues;

}
