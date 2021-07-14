package com.bjpowernode.crm.base.exception;

public enum CrmEnum {

    USER_LOGIN_ACCOUNT("001,001","账号或密码错误"),
    USER_LOGIN_expireTime("001,002","账号已失效！请呼叫管理员...."),
    USER_LOGIN_LockState("001,003","账号已被锁定！请呼叫管理员...."),
    USER_LOGIN_AllowIps("001,004","IP地址不合法！请呼叫管理员后重试...."),
    USER_LOGIN_LoginPwd("001,005","更新用户信息失败!"),
    USER_UPLOAD_MAXSIZE("001-006","上传文件不能超过2M"),
    USER_UPLOAD_SUFFIX("001-007","只能上传png,jpg,bmp,gif图片"),
    Activity_insert_add("002-001","添加市场活动失败!"),
    Activity_Update_add("002-002","修改市场活动失败!"),
    Activity_Delete_delete("002-003","删除市场活动失败!"),
    ActivityRemark_Insert_add("002-004","添加备注信息失败!"),
    ActivityRemark_update_update("002-005","修改备注信息失败!"),
    ActivityRemark_delete_delete("002-006","删除备注信息失败!"),
    Customer_insert_add("003-001","添加用户信息失败!"),
    Customer_update_edit("003-002","修改用户信息失败!"),
    Customer_delete_delete("003-002","删除用户信息失败!"),
    CustomerRemark__Insert_add("003-003","添加备注信息失败!"),
    CustomerRemark__update_update("003-004","修改备注信息失败!"),
    CustomerRemark__delete_delete("003-005","删除备注信息失败!"),
    Clue__insert_add("004-001","添加线索失败!"),
    Clue__update_update("004-002","修改线索失败!"),
    Clue__Delete_delete("004-003","删除线索失败!"),
    ClueRemark__add_insert("004-004","添加备注信息失败!"),
    ClueRemark__Edit_update("004-005","修改备注信息失败!"),
    ClueRemark__Delete_Delete("004-006","删除备注信息失败!"),
    ClueActivity__add_insert("004-007","关联市场活动失败!"),
    ClueActivity__delete_delete("004-008","解除关联市场活动失败!"),
    DicType__Insert_add("005-001","添加类型失败!"),
    DicType__Update_edit("005-002","修改类型失败!"),
    DicValue__add_add("005-003","添加类型失败!"),
    DicValue__update_update("005-004","修改类型失败!"),
    DicValue__Delete_delete("005-005","删除类型失败!");


    private String type;
    private String message;


    CrmEnum(String type, String message) {
        this.type = type;
        this.message = message;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
