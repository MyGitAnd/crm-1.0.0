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
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
<script type="text/javascript">

	$(function(){
		
		//以下日历插件在FF中存在兼容问题，在IE浏览器中可以正常使用。
		/*
		$("#startTime").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
	        autoclose: true,
	        todayBtn: true,
	        pickerPosition: "bottom-left"
		});
		
		$("#endTime").datetimepicker({
			minView: "month",
			language:  'zh-CN',
			format: 'yyyy-mm-dd',
	        autoclose: true,
	        todayBtn: true,
	        pickerPosition: "bottom-left"
		});
		*/
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		
	});
	
</script>
</head>
<body>

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>任务列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">

			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
            <form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
					  <select class="form-control" id="owner">
                          <option value="">请选择</option>
                          <c:forEach var="user" items="${applicationScope.users}">
                              <option value="${user.id}">${user.name}</option>
                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">主题</div>
				      <input class="form-control" type="text" id="subject">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">到期日期</div>
				      <input class="form-control" type="text" id="ExpiryDate">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人</div>
				      <input class="form-control" type="text" id="contactsId">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">回访状态</div>
					  <select class="form-control" id="returnState">
                          <option value="">请选择</option>
                          <c:forEach items="${applicationScope.dics['returnState']}" var="returnState">
                              <option value="${returnState.value}">${returnState.value}</option>
                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">回访优先级</div>
					  <select class="form-control" id="returnPriority">
					  	<option>请选择</option>
                          <c:forEach items="${applicationScope.dics['returnPriority']}" var="returnPriority">
                              <option value="${returnPriority.value}">${returnPriority.value}</option>
                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <button type="button" id="selectLike" class="btn btn-default">查询</button>

                </form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='<%=basePath%>/toView/workbench/visit/saveTask';"><span class="glyphicon glyphicon-plus"></span> 任务</button>
				  <button type="button" class="btn btn-default" onclick="layer.alert('正在联系管理员……');"><span class="glyphicon glyphicon-plus"></span> 通话</button>
				  <button type="button" class="btn btn-default" id="updateVisit" ><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteVisit"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                  <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>
                </div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="father"/></td>
							<td>主题</td>
							<td>到期日期</td>
							<td>联系人</td>
							<td>状态</td>
							<td>优先级</td>
							<td>所有者</td>
						</tr>
					</thead>
					<tbody id="tbody">
						<%--<tr>
							<td><input type="checkbox" /></td>
							<td><a style="text-decoration: none; cursor: pointer;" onclick="window.location.href='detail.jsp';">拜访客户</a></td>
							<td>2017-07-09</td>
							<td>李四先生</td>
							<td>未启动</td>
							<td>高</td>
							<td>zhangsan</td>
						</tr>--%>

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
                <div id="visitPage"></div>
			</div>

		</div>
		
	</div>
</body>
</html>

<script>
    var rsc_bs_pag = {
        go_to_page_title: 'Go to page',
        rows_per_page_title: 'Rows per page',
        current_page_label: 'Page',
        current_page_abbr_label: 'p.',
        total_pages_label: 'of',
        total_pages_abbr_label: '/',
        total_rows_label: 'of',
        rows_info_records: 'records',
        go_top_text: '首页',
        go_prev_text: '上一页',
        go_next_text: '下一页',
        go_last_text: '末页'
    };
    refresh(1,3);

    function refresh(page,pageSize) {

        $.ajax({
            url:"<%=basePath%>/workbench/visit/selectAllVisit",
            data:{
                'currentPage': page,
                'rowsPerPage': pageSize,
                'owner':$("#owner").val(),
                'subject':$("#subject").val(),
                'ExpiryDate':$("#ExpiryDate").val(),
                'contactsId':$("#contactsId").val(),
                'returnState':$("#returnState").val(),
                'returnPriority':$("#returnPriority").val()
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                $("#tbody").html("");
                var visits = data.list;
                for (var i = 0;i < visits.length;i++) {
                    var visit = visits[i];
                    $("#tbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkeds()' class='sun' value='"+visit.id+"'/></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/visit/detail?id="+visit.id+"';\">"+visit.subject+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+visit.startTime+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+visit.contactsId+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+visit.returnState+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+visit.returnPriority+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+visit.owner+"</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                //分页
                //分页查询
                $("#visitPage").bs_pagination({
                    currentPage: data.pageNum, // 页码
                    rowsPerPage: data.pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages: data.pages, // 总页数
                    totalRows: data.total, // 总记录条数
                    visiblePageLinks: 3, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    onChangePage : function(event, obj){

                        refresh(obj.currentPage,obj.rowsPerPage);

                    }
                });
            }
        })
    }
//模糊查询
    $("#selectLike").click(function () {

        refresh(1,3);
    });

//修改
    //复选框
    $("#father").click(function () {
        $(".sun").prop("checked",$(this).prop("checked"));
    });
    function checkeds() {
        //获取sun的个数
        var length = $(".sun").length;
        //获取勾中的个数
        var checkedLength = $(".sun:checked").length;
        if (length == checkedLength){
            $("#father").prop("checked",true);
        } else {
            $("#father").prop("checked",false);
        }

    }
//修改
$("#updateVisit").click(function () {
    var checkedLenth = $(".sun:checked").length;
    if (checkedLenth > 1){
        layer.alert("选择操作的数据不能超过一条!", {
            icon: 5});
    } else if (checkedLenth < 1){
        layer.alert("请至少选择一条数据!", {
            icon: 5});
    } else {
        $("#editClueModal").modal("show");
        var id = $(".sun:checked")[0].value;
        window.location.href = '<%=basePath%>/toView/workbench/visit/editTask?id='+id;
    }
});

    //删除
    $("#deleteVisit").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength != 0) {
            layer.confirm('确定要删除' + checkedLength + '条记录吗？', {
                btn: ['确定', '取消']
                // 按钮
            }, function () {
                var ids = [];
                $(".sun:checked").each(function () {
                    ids.push($(this).val());
                });
                $.ajax({
                    url:"<%=basePath%>/workbench/Visit/deleteVisit",
                    data:{
                        'ids':ids.join()
                    },
                    type:"get",
                    dataType:"json",
                    success:function (data) {
                        $('#father').removeAttr('checked');
                        if (data.ok){
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            refresh(1,3);
                        }else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }
                })
            });
        } else {
            layer.alert("请至少选择一条数据！", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }
    });


    //导出报表
    $("#exportExcel").click(function () {

        window.location.href = "<%=basePath%>/workbench/Visit/exportExcel";

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
    $("#ExpiryDate").datetimepicker({
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