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
<link href="<%=basePath%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>

<script type="text/javascript">
	$(function(){
		$("#isCreateTransaction").click(function(){
			if(this.checked){
				$("#create-transaction2").show(200);
			}else{
				$("#create-transaction2").hide(200);
			}
		});
	});
</script>

</head>
<body>
	
	<!-- 搜索市场活动的模态窗口 -->
	<div class="modal fade" id="searchActivityModal" role="dialog" >
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">搜索市场活动</h4>
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
					<table id="activityTable" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
						<thead>
							<tr style="color: #B3B3B3;">
								<td></td>
								<td>名称</td>
								<td>开始日期</td>
								<td>结束日期</td>
								<td>所有者</td>
								<td></td>
							</tr>
						</thead>
						<tbody id="ClueTbody">
							<%--<tr>
								<td><input type="radio" name="activity"/></td>
								<td>发传单</td>
								<td>2020-10-10</td>
								<td>2020-10-20</td>
								<td>zhangsan</td>
							</tr>--%>
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

	<div id="title" class="page-header" style="position: relative; left: 20px;">
		<h4>转换线索 <small id="small"></small></h4>
	</div>
	<div id="create-customer" style="position: relative; left: 40px; height: 35px;">
		<%--新建客户：动力节点--%>
	</div>
	<div id="create-contact" style="position: relative; left: 40px; height: 35px;">
		<%--新建联系人：李四先生--%>
	</div>
	<div id="create-transaction1" style="position: relative; left: 40px; height: 35px; top: 25px;">
		<input type="checkbox" id="isCreateTransaction" value="0"/>
		为客户创建交易
	</div>
	<div id="create-transaction2" style="position: relative; left: 40px; top: 20px; width: 80%; background-color: #F7F7F7; display: none;" >
	
		<form>
		  <div class="form-group" style="width: 400px; position: relative; left: 20px;">
		    <label for="amountOfMoney">金额</label>
		    <input type="text" class="form-control" id="amountOfMoney">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="tradeName">交易名称</label>
		    <input type="text" class="form-control" id="tradeName">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="expectedClosingDate">预计成交日期</label>
		    <input type="text" class="form-control" id="expectedClosingDate">
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="stage">阶段</label>
		    <select id="stage"  class="form-control">
                <c:forEach items="${applicationScope.dics['stage']}" var="dicValue">
                    <option value="${dicValue.value}">${dicValue.text}</option>
                </c:forEach>
		    </select>
		  </div>
		  <div class="form-group" style="width: 400px;position: relative; left: 20px;">
		    <label for="activity">市场活动源&nbsp;&nbsp;<a href="javascript:void(0);" data-toggle="modal" id="selectActivity" data-target="#searchActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-search"></span></a></label>
              <%--加入隐藏域--%>
              <input type="hidden" id="activityId" />
              <input type="text" class="form-control" id="activity" placeholder="点击上面搜索" readonly>
		  </div>
		</form>
		
	</div>
	
	<div id="owner" style="position: relative; left: 40px; height: 35px; top: 50px;">
		记录的所有者：<br>
		<b id="b1"></b>
	</div>
	<div id="operation" style="position: relative; left: 40px; height: 35px; top: 100px;">
		<input class="btn btn-primary" id="transfer" type="button" value="转换">
		&nbsp;&nbsp;&nbsp;&nbsp;
		<input class="btn btn-default" onclick="javascript:history.back(-1);" type="button" value="取消">
	</div>
</body>
</html>
<script>
    (function ($) {
        $.fn.datetimepicker.dates['zh-CN'] = {
            days: ["星期日", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"],
            daysShort: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
            daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
            months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
            today: "今天",
            suffix: [],
            meridiem: ["上午", "下午"]
        };
    }(jQuery));
    //添加日历组件
    $("#expectedClosingDate").datetimepicker({
        language: "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn: true,
        pickerPosition: 'top-right'
    });

    //查询单个对象
    select();
    function select() {

        $.ajax({
            url:"<%=basePath%>/workbench/clue/selectConvent",
            data:{
                'id':'${requestScope.id}'
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                $("#small").text(data.fullname+data.appellation);
                $("#create-customer").text("新建客户："+data.company);
                $("#create-contact").text("新建联系人："+data.fullname+data.appellation);
                $("#b1").text(data.owner);
            }
        });
    }

    //查询市场活动
    $("#selectActivity").click(function () {
        $("#ClueTbody").text("");
        $("#likeClue").click(function () {
            $.ajax({
                url: "<%=basePath%>/workbench/clueActivity/selectActivity01",
                data: {
                    'id': '${requestScope.id}',
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
                    url: "<%=basePath%>/workbench/clueActivity/selectActivity01",
                    data: {
                        'id': '${requestScope.id}',
                        'name': $("#name").val()
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        refresh(data);
                    }
                })
            }
        });
    });

    function refresh(data) {
        $("#ClueTbody").html("");
        for (var i = 0; i < data.length; i++) {
            $("#ClueTbody").append("<tr>\n" +
                "\t\t\t\t\t\t\t\t<td><input type=\"radio\" class='sun' value='" + data[i].id + "' name='activity'/></td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].name + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].startDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].endDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].owner + "</td>\n" +
                "\t\t\t\t\t\t\t</tr>");
        }
    }

    //转换
    $("#transfer").click(function () {
        $.ajax({
            url:"<%=basePath%>/workbench/clueActivity/transfer",
            data:{
                'id':'${requestScope.id}',
                'isTran':$("#isCreateTransaction").val(),
                'money':$("#amountOfMoney").val(),
                'name':$("#tradeName").val(),
                'expectedDate':$("#expectedClosingDate").val(),
                'stage':$("#stage").val(),
                'activityId':$("#activityId").val()
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                if (data.ok){
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

    //是否发生交易
    $("#isCreateTransaction").click(function () {
       if ($(this).prop("checked")){
           $(this).val("1");
       }
    });

    //点击关联按钮
    $("#addClueActivity").click(function () {

        var id = $($(".sun:checked")[0]).val();
        //给单选按钮id赋给隐藏域
        $("#activityId").val(id);
        //把选中的市场活动展现给用户看
        var text = $($(".sun:checked")[0]).parent().next().text();
        $("#activity").val(text);
    });


</script>
