<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+request.getContextPath();
%>
<%--客户页面--%>
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
		
		//定制字段
		$("#definedColumns > li").click(function(e) {
			//防止下拉菜单消失
	        e.stopPropagation();
	    });
		
	});
	
</script>
</head>
<body>

	<!-- 创建客户的模态窗口 -->
	<div class="modal fade" id="createCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="CustomerForm" role="form">
					
						<div class="form-group">
							<label for="create-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="create-customerOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label for="create-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="name" id="create-customerName">
							</div>
						</div>
						
						<div class="form-group">
                            <label for="create-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="website" id="create-website">
                            </div>
							<label for="create-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="phone" id="create-phone">
							</div>
						</div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" name="description" id="create-describe"></textarea>
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
                                <label for="create-address1" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" name="address" id="create-address1"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addAndUpdateCustomer($(this).text())" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改客户的模态窗口 -->
	<div class="modal fade" id="editCustomerModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">修改客户</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="edit-CustomerForm" role="form">
                        <input type="hidden" id="id" name="id">
						<div class="form-group">
							<label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="edit-customerOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="name" id="edit-customerName" >
							</div>
						</div>
						
						<div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="website" id="edit-website" >
                            </div>
							<label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="phone" id="edit-phone" >
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
                                <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary1"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime2">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" name="address" id="create-address"></textarea>
                                </div>
                            </div>
                        </div>
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addAndUpdateCustomer($(this).text())" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>

	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>客户列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" id="name" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" id="owner" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司座机</div>
				      <input class="form-control" id="phone" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">公司网站</div>
				      <input class="form-control" id="website" type="text">
				    </div>
				  </div>
				  
				  <button type="button" id="selectAll" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createCustomerModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="editCustomer"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteCustomer"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                  <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>
                </div>
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="father" /></td>
							<td>名称</td>
							<td>所有者</td>
							<td>公司座机</td>
							<td>公司网站</td>
						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>
			</div>
            <%--分页--%>
            <div style="height: 50px; position: relative;top: 30px;">
                <div id="customerPage"></div>
		    </div>
		</div>
	</div>
</body>
</html>

<script>

    //分页查询
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


    //刷新页面的方法
    refresh(1,3);
    <%--查询用户信息--%>
    function refresh(page,pageSize){
        $.ajax({
            url:"<%=basePath%>/workbench/customer/list",
            type:"get",
            dataType:"json",
            data:{
                'page': page,
                'pageSize':pageSize,
                'name':$("#name").val(),
                'owner':$("#owner").val(),
                'phone':$("#phone").val(),
                'website':$("#website").val()
            },
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $('#father').removeAttr('checked');
                $("#tbody").html("");
                var customers = data.list;
                for (var i = 0; i < customers.length; i++){
                    var customer = customers[i];
                    $("#tbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkedes()' class='sun' value='"+customer.id+"' /></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/customer/detail?id="+customer.id+"';\">"+customer.name+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+customer.owner+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+customer.phone+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+customer.website+"</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                //分页查询
                $("#customerPage").bs_pagination({
                    currentPage:data.pageNum , // 页码
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
                        // 刷新页面的方法
                        refresh(obj.currentPage,obj.rowsPerPage);
                    }
                });

            }
        });
    }
//模糊查询
    $("#selectAll").click(function () {
      refresh(1,3);
    });
    //查询所有者信息
    <%--users();--%>
    <%--function users(){--%>
        <%--$.ajax({--%>
            <%--url:"<%=basePath%>/workbench/customer/users",--%>
            <%--type:"post",--%>
            <%--dataType:"json",--%>
            <%--success:function (data) {--%>
                <%--$("#create-customerOwner").html("");--%>
                <%--for (var i = 0;i < data.length; i++ ){--%>
                    <%--$("#create-customerOwner").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>")--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
    <%--}--%>
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
    $("#create-nextContactTime").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });
    $("#create-nextContactTime2").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });

    //添加和修改
    function addAndUpdateCustomer(name){
        if (name == "保存"){

            if ($("#create-customerName").val() == ""){
                layer.alert("名称不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            } else if ($("#create-website").val() == "") {
                layer.alert("公司网站不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-phone").val() == "") {
                layer.alert("公司座机不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-describe").val() == "") {
                layer.alert("描述不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-contactSummary").val() == "") {
                layer.alert("联系纪要不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-nextContactTime").val() == "") {
                layer.alert("下次联系时间不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-address1").val() == "") {
                layer.alert("详细地址不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else {
                //添加的方法
                $.ajax({
                    url:"<%=basePath%>/workbench/customer/addAndUpdateCustomer",
                    data:$("#CustomerForm").serialize(),
                    dataType:"json",
                    type:"post",
                    success:function (data) {
                        //添加成功清空表单数据
                        $('#createCustomerModal').on('hidden.bs.modal', function (){
                            document.getElementById("CustomerForm").reset();
                        });
                        if (data.ok){
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            //添加成功刷新当前页面
                            refresh(1,3);
                            //清空表单数据
                            $("#CustomerForm")[0].reset();
                        } else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }

                });
            }
        } else {
            if ($("#edit-customerName").val() == ""){
                layer.alert("名称不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            } else if ($("#edit-website").val() == "") {
                layer.alert("公司网站不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#edit-phone").val() == "") {
                layer.alert("公司座机不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#edit-describe").val() == "") {
                layer.alert("描述不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-contactSummary1").val() == "") {
                layer.alert("联系纪要不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-nextContactTime2").val() == "") {
                layer.alert("下次联系时间不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else if ($("#create-address").val() == "") {
                layer.alert("详细地址不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else {
                //修改的
                $.ajax({
                    url: "<%=basePath%>/workbench/customer/addAndUpdateCustomer",
                    data: $("#edit-CustomerForm").serialize(),
                    dataType: "json",
                    type: "post",
                    success: function (data) {
                        //修改成功后把复选框选中的去掉
                        $('#father').removeAttr('checked');
                        //添加成功清空表单数据
                        $('#createCustomerModal').on('hidden.bs.modal', function () {
                            document.getElementById("CustomerForm").reset();
                        });
                        if (data.ok) {
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            //修改成功刷新当前页面
                            refresh(1, 3);
                        } else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }
                });
            }
        }
}

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
        //修改的查询方法
    $("#editCustomer").click(function () {
        //获取勾中的数量
        var checkedLength = $(".sun:checked").length;
        if (checkedLength > 1){
            layer.alert("最多一次只能选择一条数据进行修改!", {
                icon: 5});
        } else if (checkedLength < 1){
            layer.alert("请至少选择一条数据!", {
                icon: 5});
        } else {
            //可以修改
            $("#editCustomerModal").modal("show");
            //查询所有者信息的方法
            <%--$.ajax({--%>
                <%--url:"<%=basePath%>/workbench/customer/users",--%>
                <%--type:"post",--%>
                <%--dataType:"json",--%>
                <%--success:function (data) {--%>
                    <%--$("#edit-customerOwner").html("");--%>
                    <%--for (var i = 0;i < data.length; i++ ){--%>
                        <%--$("#edit-customerOwner").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>")--%>
                    <%--}--%>
                <%--}--%>
            <%--});--%>

            //获取id
            var id = $(".sun:checked")[0].value;

            $.ajax({
                url:"<%=basePath%>/workbench/customer/selectCustomerORId",
                data:{
                    'id':id
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    $("#edit-customerOwner").val(data.owner);
                    $("#edit-customerName").val(data.name);
                    $("#edit-website").val(data.website);
                    $("#edit-phone").val(data.phone);
                    $("#edit-describe").val(data.description);
                    $("#create-contactSummary1").val(data.contactSummary);
                    $("#create-nextContactTime2").val(data.nextContactTime);
                    $("#create-address").val(data.address);
                    $("#id").val(data.id);
                }
            })
        }
    });

        //删除
    $("#deleteCustomer").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength != 0){
            layer.confirm('确定要删除'+checkedLength+'条记录吗？', {
                btn : ['确定', '取消']
                // 按钮
            }, function() {
                var ids = [];
                $(".sun:checked").each(function () {
                    ids.push($(this).val());
                });
                $.ajax({
                    url:"<%=basePath%>/workbench/customer/deleteCustomers",
                    data:{
                        'ids':ids.join()
                    },
                    dataType:"json",
                    type:'post',
                    success:function (data) {
                        layer.alert(data.message, {
                            icon: 6});
                        refresh(1,3);
                    }
                });
            });
        }else {
            layer.alert("请至少选择一条记录!", {
                icon: 5});
        }
    });

    //导出报表
    $("#exportExcel").click(function () {

        window.location.href = "<%=basePath%>/workbench/Customer/exportExcel";

    });






    // $("#create-phone").blur(function () {
    //     var phone = document.getElementById('create-phone').value;
    //     if(!(/^1[3456789]d{9}$/.test(phone))){
    //         layer.alert("手机号码有误，请重填");
    //         return false;
    //     }
    // });
    // $("#create-website").blur(function () {
    //     var phone = document.getElementById('create-website').value;
    //     if(!(/^([a-zA-Z]\:|\\\\[^\/\\:*?"<>|]+\\[^\/\\:*?"<>|]+)(\\[^\/\\:*?"<>|]+)+(\.[^\/\\:*?"<>|]+)$/.test(phone))){
    //         layer.alert("公司网站有误，请重填");
    //         return false;
    //     }
    // });
    // $("#edit-website").blur(function () {
    //     var phone = document.getElementById('edit-website').value;
    //     if(!(/^([a-zA-Z]\:|\\\\[^\/\\:*?"<>|]+\\[^\/\\:*?"<>|]+)(\\[^\/\\:*?"<>|]+)+(\.[^\/\\:*?"<>|]+)$/.test(phone))){
    //         layer.alert("公司网站有误，请重填");
    //         return false;
    //     }
    // });
    //
    // $("#edit-phone").blur(function () {
    //     var phone = document.getElementById('edit-phone').value;
    //     if(!(/^1[3456789]d{9}$/.test(phone))){
    //         layer.alert("手机号码有误，请重填");
    //         return false;
    //     }
    // });



    // var reg = /\S/;
    //
    // reg.test($("value").val());
    //
    //
    // $("#create-customerName").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("名称不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-website").blur(function () {
    //
    //     if (reg.test($("value").val())){
    //         layer.alert("公司网址不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-phone").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("手机号不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-describe").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("描述不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-contactSummary").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("联系纪要不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-nextContactTime").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("下次联系时间不能为空！", {icon: 5});
    //     }
    // });
    // $("#create-address1").blur(function () {
    //     if (reg.test($("value").val())){
    //         layer.alert("详细地址不能为空！", {icon: 5});
    //     }
    // });










</script>