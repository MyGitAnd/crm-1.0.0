package com.bjpowernode.crm.settings.bean;
import lombok.Data;
import tk.mybatis.mapper.annotation.NameStyle;
import tk.mybatis.mapper.code.Style;

import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

@Data
@Table(name = "tbl_user")
@NameStyle(Style.normal)//加入注解防止数据库和实体类不一样
public class User {

    @Id
   private String id;//主键
   private String loginAct;//登录账号
   private String name;//昵称
   private String loginPwd;//登录密码
   private String email;//邮箱
   private String expireTime;//失效时间
   private String lockState;//账号是否被锁定 0:锁定
   private String deptno;//部门编号
   private String allowIps;//允许登录的ip地址：必须是公司指定的哪些机器可以访问CRM项目
   private String createTime;//创建时间
   private String createBy;//创建者
   private String editTime;//编辑时间
   private String editBy;//编辑者
   private String img;

   @Transient
   private Integer index;
}
