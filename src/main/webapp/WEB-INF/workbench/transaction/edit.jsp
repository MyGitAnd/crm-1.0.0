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
</head>
<body>

	<!-- 查找市场活动 -->	
	<div class="modal fade" id="findMarketActivity" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">查找市场活动</h4>
				</div>
				<div class="modal-body">
					<div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                        <div class="input-group">
                            <input class="form-control width100" id="name" placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="input-group-btn">
                        <button class="btn btn-info" id="likeClue">搜索</button>
                            </span>
                        </div>
					</div>
					<table id="activityTable4" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
							</tr>
						</thead>
                        <tbody id="saveTbody">

						</tbody>
					</table>
				</div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="addClueActivity" data-dismiss="modal">关联</button>
                </div>
			</div>
		</div>
	</div>

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
		<h3>更新交易</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="updateTran" class="btn btn-primary">更新</button>
			<button type="button" onclick="javascript:history.back(-1);" class="btn btn-default">返回</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form" id="updateFrom" style="position: relative; top: -30px;">

        <input type="hidden" id="id" name="id">
		<div class="form-group">
			<label for="edit-transactionOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="owner" id="edit-transactionOwner">
                    <c:forEach var="user" items="${applicationScope.users}">
                        <option value="${user.id}">${user.name}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="edit-amountOfMoney" class="col-sm-2 control-label">金额</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="money" id="edit-amountOfMoney">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-transactionName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="name" id="edit-transactionName">
			</div>
			<label for="edit-expectedClosingDate" class="col-sm-2 control-label">预计成交日期<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="expectedDate" id="edit-expectedClosingDate">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-accountName" class="col-sm-2 control-label">客户名称<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="customerId" id="edit-accountName" placeholder="支持自动补全，输入客户不存在则新建">
			</div>
			<label for="edit-transactionStage" class="col-sm-2 control-label">阶段<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
			  <select class="form-control" name="stage" id="edit-transactionStage">
                  <c:forEach items="${applicationScope.dics['stage']}" var="stage">
                      <option value="${stage.value}">${stage.text}</option>
                  </c:forEach>
			  </select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-transactionType" class="col-sm-2 control-label">类型</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="type" id="edit-transactionType">
                    <c:forEach items="${applicationScope.dics['transactionType']}" var="transactionType">
                        <option value="${transactionType.value}">${transactionType.text}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="edit-possibility" class="col-sm-2 control-label">可能性</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="possibility" id="edit-possibility">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-clueSource" class="col-sm-2 control-label">来源</label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" name="source" id="edit-clueSource">
                    <c:forEach items="${applicationScope.dics['source']}" var="source">
                        <option value="${source.value}">${source.text}</option>
                    </c:forEach>
				</select>
			</div>
			<label for="edit-activitySrc" class="col-sm-2 control-label">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findMarketActivity"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-activitySrc">
                <input type="hidden" name="activityId" id="activityId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="edit-contactsName" class="col-sm-2 control-label">联系人名称&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" data-target="#findContacts"><span class="glyphicon glyphicon-search"></span></a></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="edit-contactsName">
                <input type="hidden" name="contactsId" id="contactsId">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-describe" class="col-sm-2 control-label">描述</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
			<div class="col-sm-10" style="width: 70%;">
				<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary"></textarea>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime">
			</div>
		</div>
		
	</form>
</body>
</html>

<script>

    //查询数据信息
    $.ajax({
        url:"<%=basePath%>/workbench/tran/selectTran",
        data:{
            'id':'${requestScope.id}'
        },
        type:"get",
        dataType:"json",
        success:function (data) {
            $("#edit-transactionOwner").val(data.owner);
            $("#edit-amountOfMoney").val(data.money);
            $("#edit-expectedClosingDate").val(data.expectedDate);
            $("#edit-transactionName").val(data.name);
            $("#edit-transactionStage").val(data.stage);
            $("#edit-transactionType").val(data.type);
            $("#edit-possibility").val(data.possibility);
            $("#edit-clueSource").val(data.source);
            $("#edit-activitySrc").val(data.activityId);
            $("#activityId").val(data.activityId);
            $("#contactsId").val(data.contactsId);
            $("#edit-contactsName").val(data.contactsId);
            $("#create-describe").val(data.description);
            $("#edit-accountName").val(data.customerId);
            $("#create-contactSummary").val(data.contactSummary);
            $("#create-nextContactTime").val(data.nextContactTime);
            $("#id").val(data.id);
        }
    });


    //自动补全
    $("#edit-accountName").typeahead({
        source: function (customerName, process) {
            $.post("<%=basePath%>/workbench/transaction/queryCustomerName", {'customerName': customerName},
                function (data) {
                    process(data);

                }, "json");
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 0
    });

    //查询可能性
    $("#edit-possibility").change(function () {
        $.ajax({
            url:"<%=basePath%>/workbench/transaction/getPossibility",
            data:{
                'stage':$(this).val()
            },
            type:"get",
            dataType:"json",
            success:function (data) {
                $("#edit-possibility").val(data);
            }
        })
    });
    //查询所有的市场活动
    $("#likeClue").click(function () {
        $.ajax({
            url: "<%=basePath%>/workbench/clueActivity/selectAc",
            data: {
                'name': $("#name").val()
            },
            type: "post",
            dataType: "json",
            success: function (data) {
                refresh(data)
            }
        })
    });
    $("#name").keypress(function (ele) {
        if (ele.keyCode == 13) {
            $.ajax({
                url: "<%=basePath%>/workbench/clueActivity/selectAc",
                data: {
                    'name': $("#name").val()
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    refresh(data)
                }
            })
        }
    });
    //关联市场活动
    $("#addClueActivity").click(function () {
        var id = $($(".sun:checked")[0]).val();
        //给单选按钮id赋给隐藏域
         $("#activityId").val(id);
        //把选中的市场活动展现给用户看
        var text = $($(".sun:checked")[0]).parent().next().text();
        $("#edit-activitySrc").val(text);
    });

    $("#likeClue1").click(function () {
        $.ajax({
            url: "<%=basePath%>/workbench/clueActivity/selectAc1",
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
                url: "<%=basePath%>/workbench/clueActivity/selectAc1",
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
        $("#edit-contactsName").val(text);
    });
    function refresh(data) {
        $("#saveTbody").html("");
        for (var i = 0; i < data.length; i++) {
            $("#saveTbody").append("<tr>\n" +
                "\t\t\t\t\t\t\t\t<td><input type=\"radio\" class='sun' name='activity' value='" + data[i].id + "'/></td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].name + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].startDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].endDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].owner + "</td>\n" +
                "\t\t\t\t\t\t\t</tr>");
        }
    }
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

    //真正修改的方法
    $("#updateTran").click(function () {
        if ($("#edit-amountOfMoney").val() == ""){
            layer.alert("金额不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-transactionName").val() == ""){
            layer.alert("名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-expectedClosingDate").val() == ""){
            layer.alert("预计成交日期不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-accountName").val() == ""){
            layer.alert("客户名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-possibility").val() == ""){
            layer.alert("可能性不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-activitySrc").val() == ""){
            layer.alert("市场活动源不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-contactsName").val() == ""){
            layer.alert("联系人名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-describe").val() == ""){
            layer.alert("描述不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-contactSummary").val() == ""){
            layer.alert("联系纪要不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-nextContactTime").val() == ""){
            layer.alert("下次联系时间不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else {
            $.ajax({
                url:"<%=basePath%>/workbench/transaction/addTranUpdate",
                data:$("#updateFrom").serialize(),
                type:"post",
                dataType:"json",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });

                        //延迟跳转页面
                        window.setTimeout("window.location='<%=basePath%>/toView/workbench/transaction/index'",2000);
                    } else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            });
        }
    });


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
    $("#edit-expectedClosingDate").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });
    $("#create-nextContactTime").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: 'top-right'
    });

</script>
