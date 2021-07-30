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
    DicValue__Delete_delete("005-005","删除类型失败!"),
    Clue__Customer_add("006-001","创建客户失败!"),
    Clue__Contacts_add("006-002","创建联系人失败!"),
    Clue__CustomerRemark_add("006-003","创建客户备注失败!"),
    Clue__ContactsRemark_add("006-004","创建联系人备注失败!"),
    Clue__ContactsActivity_add("006-005","创建联系人市场活动备注失败!"),
    Clue__tran_add("006-006","创建交易失败!"),
    Clue__tranRemark_add("006-007","创建交易失败!"),
    Clue__tranhistory_add("006-008","创建交易失败!"),
    Clue__clueRemark_delete("006-009","删除备注失败!"),
    Clue__clueActivity_delete("006-010","删除关联市场活动失败!"),
    Clue__clue_delete("006-011","删除关联市场活动失败!"),
    Tran__add_add("007-001","添加交易失败!"),
    Tran__update_edit("007-002","修改交易失败!"),
    Tran__delete_delete("007-002","删除交易失败!"),
    TranHistory__add_add("007-003","添加阶段历史失败!"),
    TranHistory__update_edit("007-004","修改可能性失败!"),
    TranRemark__update_edit("007-005","修改备注失败!"),
    TranRemark__add_add("007-005","添加备注失败!"),
    TranRemark__delete_delete("007-006","添加备注失败!"),
    Contacts__add_add("008-001","添加联系人失败!"),
    Contacts__update_update("008-002","修改联系人失败!"),
    Contacts__delete_delete("008-003","删除联系人失败!"),
    ContactsAndById__delete_delete("008-004","删除联系人失败!"),
    ContactsRemark__add_add("008-005","添加备注失败!"),
    ContactsRemark__update_update("008-006","修改备注失败!"),
    ContactsRemark__delete_delete("008-007","删除备注失败!"),
    ContactsTran__delete_delete("008-008","删除交易失败!"),
    ContactsActivity__add_add("008-009","关联市场活动失败!"),
    ContactsActivity__delete_delete("008-009","解除关联市场活动失败!"),
    CustomerTran__delete_delete("009-001","解除关联市场活动失败!"),
    CustomerContacts__delete_delete("009-002","删除联系人失败!"),
    CustomerContacts__add_add("009-003","删除联系人失败!"),
    Visit__Add_add("010-001","添加回访失败!"),
    Visit__Update_Update("010-002","修改回访失败!"),
    Visit__delete_delete("010-003","删除回访失败!"),
    Visit__delete1_delete1("010-004","添加回访失败!"),
    VisitRemark__add_add("010-005","添加备注失败!"),
    VisitRemark__update_update("010-006","修改备注失败!"),
    VisitRemark__delete_delete("010-007","修改备注失败!"),
    Dept_Add_Add("011-001","添加部门失败!"),
    Dept_update_update("011-001","修改部门失败!"),
    Dept_delete_delete("011-001","删除部门失败!");



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
