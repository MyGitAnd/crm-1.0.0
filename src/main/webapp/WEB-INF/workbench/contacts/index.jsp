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
<%--联系人页面--%>
<link href="<%=basePath%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
<script type="text/javascript">

	$(function(){
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		
	});
	
</script>
</head>
<body>

	
	<!-- 创建联系人的模态窗口 -->
	<div class="modal fade" id="createContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="ContactsFrom" role="form">

						<div class="form-group">
							<label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="create-contactsOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label for="create-clueSource" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="source" id="create-clueSource">
                                    <c:forEach items="${applicationScope.dics['source']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="fullname" id="create-surname">
							</div>
							<label for="create-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="appellation" id="create-call">
                                    <c:forEach items="${applicationScope.dics['appellation']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
								</select>
							</div>
							
						</div>
						
						<div class="form-group">
							<label for="create-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="job" id="create-job">
							</div>
							<label for="create-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="mphone" id="create-mphone">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="email" id="create-email">
							</div>
							<label for="create-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="birth" id="create-birth">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="customerId" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group" style="position: relative;">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" name="description" rows="3" id="create-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" name="contactSummary" rows="3" id="create-contactSummary1"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime1">
								</div>
							</div>
						</div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" name="address" rows="1" id="create-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addContact" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改联系人的模态窗口 -->
	<div class="modal fade" id="editContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="ContactsFromUpdate" role="form">
					<input id="id" type="hidden" name="id">
						<div class="form-group">
							<label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="edit-contactsOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="source" id="edit-clueSource1">
                                    <c:forEach items="${applicationScope.dics['source']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="fullname" id="edit-surname">
							</div>
							<label for="edit-call" class="col-sm-2 control-label">称呼</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="appellation" id="edit-call">
                                    <c:forEach items="${applicationScope.dics['appellation']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
								</select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-job" class="col-sm-2 control-label">职位</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="job" id="edit-job">
							</div>
							<label for="edit-mphone" class="col-sm-2 control-label">手机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="mphone" id="edit-mphone">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="email" id="edit-email">
							</div>
							<label for="edit-birth" class="col-sm-2 control-label">生日</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="birth" id="edit-birth">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="customerId" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" name="description" id="edit-describe"></textarea>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>
						
						<div style="position: relative;top: 15px;">
							<div class="form-group">
								<label for="create-contactSummary" class="col-sm-2 control-label">联系纪要</label>
								<div class="col-sm-10" style="width: 81%;">
									<textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary"></textarea>
								</div>
							</div>
							<div class="form-group">
								<label for="create-nextContactTime" class="col-sm-2 control-label">下次联系时间</label>
								<div class="col-sm-10" style="width: 300px;">
									<input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime">
								</div>
							</div>
						</div>
						
						<div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" name="address" id="edit-address2"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateContacts" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>联系人列表</h3>
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
				      <input class="form-control" id="owner" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">姓名</div>
				      <input class="form-control" id="customerId" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" id="fullname" type="text">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="edit-clueSource">
                              <option>请选择</option>
                              <c:forEach items="${applicationScope.dics['source']}" var="dicValue">
                                  <option value="${dicValue.value}">${dicValue.value}</option>
                              </c:forEach>
                          </select>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">生日</div>
				      <input class="form-control" id="birth" type="text">
				    </div>
				  </div>
				  
				  <button type="button" id="likeContacts" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createContactsModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" id="selectContacts"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteContacts"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                  <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>
                </div>
				
				
			</div>
			<div style="position: relative;top: 20px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="father" /></td>
							<td>姓名</td>
							<td>客户名称</td>
							<td>所有者</td>
							<td>来源</td>
							<td>生日</td>
						</tr>
					</thead>
					<tbody id="tbody">


					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 10px;">
                <div id="contactsPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>

<script>
    //添加日历插件
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
    $("#create-birth").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });
    $("#create-nextContactTime1").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: 'top-right'
    });
    $("#edit-birth").datetimepicker({
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

    $("#birth").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });

    //分页
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
        go_last_text: '末页'};

    refresh(1,3);
    function refresh(page,pageSize) {
        <%--获取联系人信息--%>
        $.ajax({
            url:"<%=basePath%>/workbench/contacts/list",
            type:"get",
            data:{
                'currentPage': page,
                'rowsPerPage': pageSize,
                'owner':$("#owner").val(),
                'customerId':$("#customerId").val(),
                'fullname':$("#fullname").val(),
                'source':$("#edit-clueSource").val(),
                'birth':$("#birth").val()
            },
            dataType:"json",
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $('#father').removeAttr('checked');
                $("#tbody").html("");
                var contactss = data.list;
                for (var i = 0; i < contactss.length; i++){
                    var contacts = contactss[i];
                    $("#tbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkedes()' class='sun' value='"+contacts.id+"'/></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/contacts/detail?id="+contacts.id+"';\">"+contacts.customerId+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.fullname+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.owner+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.source+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.birth+"</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                //分页查询
                $("#contactsPage").bs_pagination({
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
                    onChangePage: function (event, obj) {
                        refresh(obj.currentPage,obj.rowsPerPage);
                    }
                });
            }
        });
    }
    //模糊查询
    $("#likeContacts").click(function () {
       refresh(1,3);
    });

    //自动补全的功能
    $("#create-customerName").typeahead({
        source: function (customerName, process) {
            $.post("<%=basePath%>/workbench/contact/queryCustomerName", {'customerName': customerName},
                function (data) {
                    process(data);

                }, "json");
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 0
    });
    //自动补全的功能
    $("#edit-customerName").typeahead({
        source: function (customerName, process) {
            $.post("<%=basePath%>/workbench/contact/queryCustomerName", {'customerName': customerName},
                function (data) {
                    process(data);

                }, "json");
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 0
    });


    //添加
    $("#addContact").click(function () {
        if ($("#create-surname").val() == ""){
            layer.alert("姓名不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-job").val() == ""){
            layer.alert("职位不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-mphone").val() == ""){
            layer.alert("手机不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-email").val() == ""){
            layer.alert("邮箱不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-birth").val() == ""){
            layer.alert("生日不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-customerName").val() == ""){
            layer.alert("客户名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-describe").val() == ""){
            layer.alert("描述不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-contactSummary1").val() == ""){
            layer.alert("联系纪要不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-nextContactTime1").val() == ""){
            layer.alert("下次联系时间不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-address").val() == ""){
            layer.alert("详细地址不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            $.ajax({
                url:"<%=basePath%>/workbench/Contacts/addContacts",
                data:$("#ContactsFrom").serialize(),
                type:"post",
                dataType:"json",
                success:function (data) {
                    //添加成功清空表单数据
                    $('#createContactsModal').on('hidden.bs.modal', function (){
                        document.getElementById("ContactsFrom").reset();
                    });
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //添加成功刷新当前页面
                        refresh(1,3);
                    } else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })
        }
    });

    //设置全选和全不选
    $("#father").click(function () {
        $(".sun").prop("checked",$(this).prop("checked"));

    });
    function checkedes() {
        //获取子复选框的数量
        var length = $(".sun").length;
        //获取勾中的数量
        var checkedLength = $(".sun:checked").length;

        if (length == checkedLength){
            $("#father").prop("checked",true);
        } else {
            $("#father").prop("checked",false);
        }
    }


    //修改
    $("#selectContacts").click(function () {
        //获取勾中的数量
        var checkedLength = $(".sun:checked").length;
        if (checkedLength < 1){
            layer.alert("执行修改操作至少要选择一条记录!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if (checkedLength > 1){
            layer.alert("执行修改操作最多只能选择一条记录!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            //正确的
            $("#editContactsModal").modal("show");

            //获取id
            var id = $(".sun:checked")[0].value;
            $.ajax({
                url:"<%=basePath%>/workbench/Contacts/selectContactsToOne",
                data:{
                    'id':id
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    $("#edit-contactsOwner").val(data.owner);
                    $("#edit-clueSource1").val(data.source);
                    $("#edit-surname").val(data.fullname);
                    $("#edit-call").val(data.appellation);
                    $("#edit-job").val(data.job);
                    $("#edit-mphone").val(data.mphone);
                    $("#edit-email").val(data.email);
                    $("#edit-birth").val(data.birth);
                    $("#edit-customerName").val(data.customerId);
                    $("#edit-describe").val(data.description);
                    $("#create-contactSummary").val(data.contactSummary);
                    $("#create-nextContactTime").val(data.nextContactTime);
                    $("#edit-address2").val(data.address);
                    $("#id").val(data.id);
                }
            })
        }

    });

    //真正修改的方法
    $("#updateContacts").click(function () {
        if ($("#edit-surname").val() == ""){
            layer.alert("姓名不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-job").val() == ""){
            layer.alert("职位不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-mphone").val() == ""){
            layer.alert("手机不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-email").val() == ""){
            layer.alert("邮箱不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-birth").val() == ""){
            layer.alert("生日不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-customerName").val() == ""){
            layer.alert("客户名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }   else if ($("#edit-describe").val() == ""){
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
        } else if ($("#edit-address2").val() == ""){
            layer.alert("详细地址不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else {
            $.ajax({
                url:"<%=basePath%>/workbench/Contacts/addContactsAndUpdate",
                data:$("#ContactsFromUpdate").serialize(),
                type:"post",
                dataType:"json",
                success:function (data) {
                    //添加成功清空表单数据
                    $('#createContactsModal').on('hidden.bs.modal', function (){
                        document.getElementById("ContactsFrom").reset();
                    });
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //添加成功刷新当前页面
                        refresh(1,3);
                    } else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })
        }

    });


    //删除
    $("#deleteContacts").click(function () {
        //获取勾中的数量
        var checkedLength = $(".sun:checked").length;
            if (checkedLength < 1){
                layer.alert("至少选择一条记录进行删除!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            } else {
                //删除
                layer.confirm('确定要删除' + checkedLength + '条记录吗？', {
                    btn: ['确定', '取消']
                    // 按钮
                }, function () {
                    var ids = [];
                    $(".sun:checked").each(function () {
                        ids.push($(this).val());
                    });
                    $.ajax({
                        url:"<%=basePath%>/workbench/contacts/deleteContacts",
                        data:{
                            'ids':ids.join()
                        },
                        dataType:"json",
                        type:"post",
                        success:function (data) {
                            if (data.ok) {
                                layer.alert(data.message, {
                                    icon: 6,
                                    skin: 'layer-ext-demo'
                                });
                                //刷新的方法
                                refresh(1, 3);
                            } else {
                                layer.alert(data.message, {
                                    icon: 5,
                                    skin: 'layer-ext-demo'
                                });
                            }
                        }
                    })

                });
            }
    });

    //导出报表
    $("#exportExcel").click(function () {

        window.location.href = "<%=basePath%>/workbench/Contacts/exportExcel";

    });



</script>