package com.bjpowernode.crm.base.base;

import lombok.Data;

@Data
public class ResultVo<T> {
    //判断是成功还是失败
    private boolean isOk;
    private String message;
    private T t;


}
