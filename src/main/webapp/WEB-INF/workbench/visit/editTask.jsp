<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=basePath%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<link href="<%=basePath%>/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet" />

<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#reminderTime").click(function(){
			if(this.checked){
				$("#reminderTimeDiv").show("200");
			}else{
				$("#reminderTimeDiv").hide("200");
			}
		});
	});
</script>
</head>
<body>

	<!-- 查找联系人 -->
    <div class="modal fade" id="findContacts" role="dialog">
        <div class="modal-dialog" role="document" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">查找联系人</h4>
                </div>
                <div class="modal-body">
                    <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                        <div class="input-group">
                            <input class="form-control width100" id="name1" placeholder="请输入联系人名称，支持模糊查询">
                            <span class="input-group-btn">
                        <button class="btn btn-info" id="likeClue1">搜索</button>
                            </span>
                        </div>
                    </div>
                    <table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                        <thead>
                        <tr style="color: #B3B3B3;">
                            <td></td>
                            <td>名称</td>
                            <td>邮箱</td>
                            <td>手机</td>
                        </tr>
                        </thead>
                        <tbody id="tranTbody">


                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="addClueActivity1" data-dismiss="modal">关联</button>
                </div>
            </div>
        </div>
    </div>
	
	<div style="position:  relative; left: 30px;">
		<h3>修改任务</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="updateVisit" class="btn btn-primary">更新</button>
			<button type="button" onclick="javascript:history.back(-1);" class="btn btn-default">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" id="updateVisitForm" role="form">
        <%--隐藏域--%>
        <input id="id" name="id" type="hidden">
		<div class="form-group">
			<label for="create-taskOwner" class="col-sm-2 control-label">任务所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="owner" id="create-taskOwner">
                    <c:forEach var="user" items="${applicationScope.users}">
                        <option value="${user.id}">${user.name}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="create-subject" class="col-sm-2 control-label">主题<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-subject" name="subject">
			</div>
		</div>
		<div class="form-group">
			<label for="create-expiryDate" class="col-sm-2 control-label">到期日期</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-expiryDate" name="ExpiryDate">
			</div>
			<label for="create-contacts" class="col-sm-2 control-label">联系人&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-contacts" name="contactsId">
			</div>
		</div>
	
		<div class="form-group">
			<label for="create-state" class="col-sm-2 control-label">回访状态</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-state" name="returnState">
                    <c:forEach items="${applicationScope.dics['returnState']}" var="returnState">
                        <option value="${returnState.value}">${returnState.value}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="create-priority" class="col-sm-2 control-label">回访优先级</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-priority" name="returnPriority">
                    <c:forEach items="${applicationScope.dics['returnPriority']}" var="returnPriority">
                        <option value="${returnPriority.value}">${returnPriority.value}</option>
                    </c:forEach>
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" id="create-describe" name="description"></textarea>
			</div>
		</div>
		
		<div style="position: relative; left: 103px;">
			<span><b>提醒时间</b></span>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="checkbox" id="reminderTime" checked>
		</div>
		
		<div id="reminderTimeDiv" style="width: 500px; height: 180px; background-color: #EEEEEE; position: relative; left: 185px; top: 20px;">
			<div class="form-group" style="position: relative; top: 10px;">
				<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
				<div class="col-sm-10" style="width: 300px;">
					<input type="text" class="form-control" id="create-startTime" name="startTime">
				</div>
			</div>
			
			<div class="form-group" style="position: relative; top: 15px;">
				<label for="create-repeatType" class="col-sm-2 control-label">重复类型</label>
				<div class="col-sm-10" style="width: 300px;">
					<select class="form-control" id="create-repeatType" name="repeatType">
                        <c:forEach items="${applicationScope.dics['repeatType']}" var="repeatType">
                            <option value="${repeatType.value}">${repeatType.value}</option>
                        </c:forEach>
					</select>
				</div>
			</div>
			
			<div class="form-group" style="position: relative; top: 20px;">
				<label for="create-noticeType" class="col-sm-2 control-label">通知类型</label>
				<div class="col-sm-10" style="width: 300px;">
					<select class="form-control" id="create-noticeType" name="noticeType">
                        <c:forEach items="${applicationScope.dics['noticeType']}" var="noticeType">
                            <option value="${noticeType.value}">${noticeType.value}</option>
                        </c:forEach>
					</select>
				</div>
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>

<script>

//查询信息
$.ajax({
    url:"<%=basePath%>/workbench/Visit/selectVisit",
    data:{
        'id':'${requestScope.id}'
    },
    type:"get",
    dataType:"json",
    success:function (data) {
        console.log(data);
        $("#id").val(data.id);
        $("#create-taskOwner").val(data.owner);
        $("#create-subject").val(data.subject);
        $("#create-expiryDate").val(data.expiryDate);
        $("#create-contacts").val(data.contactsId);
        $("#create-state").val(data.returnState);
        $("#create-priority").val(data.returnPriority);
        $("#create-describe").val(data.description);
        $("#create-startTime").val(data.startTime);
        $("#create-repeatType").val(data.repeatType);
        $("#create-noticeType").val(data.noticeType);
    }
});

//修改的方法
$("#updateVisit").click(function () {

    $.ajax({
        url:"<%=basePath%>/workbench/Visit/addVisitAndUpdate",
        data:$("#updateVisitForm").serialize(),
        type:"get",
        dataType:"json",
        success:function (data) {
            if (data.ok) {
                layer.alert(data.message, {
                    icon: 6,
                    skin: 'layer-ext-demo'
                });
            } else {
                layer.alert(data.message, {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }
        }
    })
});



    //关联联系人
    $("#likeClue1").click(function () {
        $.ajax({
            url: "<%=basePath%>/workbench/VisitContacts/selectCon",
            data: {
                'fullname': $("#name1").val()
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                refresh1(data)
            }
        })
    });
    $("#name1").keypress(function (ele) {
        if (ele.keyCode == 13) {
            $.ajax({
                url: "<%=basePath%>/workbench/VisitContacts/selectCon",
                data: {
                    'fullname': $("#name1").val()
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    refresh1(data)
                }
            })
        }
    });
    //关联联系人
    $("#addClueActivity1").click(function () {
        var id = $($(".sun1:checked")[0]).val();
        //给单选按钮id赋给隐藏域
        $("#contactsId").val(id);
        //把选中的市场活动展现给用户看
        var text = $($(".sun1:checked")[0]).parent().next().text();
        $("#create-contacts").val(text);
    });

    //刷新的方法
    function refresh1(data) {
        $("#tranTbody").html("");
        for (var i = 0; i < data.length; i++) {
            $("#tranTbody").append("<tr>\n" +
                "\t\t\t\t\t\t\t\t<td><input type=\"radio\" class='sun1' name='activity' value='" + data[i].id + "'/></td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].fullname + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].email + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].mphone + "</td>\n" +
                "\t\t\t\t\t\t\t</tr>");
        }
    }


(function($){
    $.fn.datetimepicker.dates['zh-CN'] = {
        days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
        daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
        daysMin:  ["日", "一", "二", "三", "四", "五", "六", "日"],
        months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
        monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
        today: "今天",
        suffix: [],
        meridiem: ["上午", "下午"]
    };
}(jQuery));
//添加日历组件
$("#create-expiryDate").datetimepicker({
    language:  "zh-CN",
    format: "yyyy-mm-dd",//显示格式
    minView: "month",//设置只显示到月份
    initialDate: new Date(),//初始化当前日期
    autoclose: true,//选中自动关闭
    todayBtn: true, //显示今日按钮
    clearBtn : true,
    pickerPosition:"bottom-left"
});
$("#create-startTime").datetimepicker({
    language:  "zh-CN",
    format: "yyyy-mm-dd",//显示格式
    minView: "month",//设置只显示到月份
    initialDate: new Date(),//初始化当前日期
    autoclose: true,//选中自动关闭
    todayBtn: true, //显示今日按钮
    clearBtn : true,
    pickerPosition:"bottom-left"
});
</script>