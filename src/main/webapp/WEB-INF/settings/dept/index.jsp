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
    <style>
        .a-upload{
            padding: 4px 10px;
            /*height: 34px;*/
            line-height: 28px;
            position: relative;
            cursor: pointer;
            color: #fff;
            background-color: #286090;
            border-color: #204d74;
            border-radius: 4px;
            overflow: hidden;
            display: inline-block;
            *display: inline;
            *zoom: 1;
        }
        .a-upload input{
            position: absolute;
            font-size: 100px;
            right: 0;
            top: 0;
            opacity: 0;
            filter: alpha(opacity=0);
            cursor: pointer
        }
        .a-upload:hover{
            color: #FFFFFF;
            background: #337ab7;
            border-color: #204d74;
            text-decoration: none;
        }
    </style>
</head>
<body>


    <!-- 我的资料 -->
    <div class="modal fade" id="myInformation" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">我的资料</h4>
                </div>
                <div class="modal-body">
                    <div style="position: relative; left: 40px;">
                        姓名：<b id="b1"></b><br><br>
                        登录帐号：<b id="b2"></b><br><br>
                        组织机构：<b id="b3"></b><br><br>
                        邮箱：<b id="b4"></b><br><br>
                        失效时间：<b id="b5"></b><br><br>
                        允许访问IP：<b id="b6"></b>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 修改密码的模态窗口 -->
    <div class="modal fade" id="editPwdModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 70%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <img id="photo" type="hidden"/>
                        <div class="form-group">
                            <label for="oldPwd" class="col-sm-2 control-label">原密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="oldPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="newPwd" style="width: 200%;">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="password" class="form-control" id="confirmPwd" style="width: 200%;">
                            </div>
                        </div>
                        <%--上传头像--%>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">上传头像</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <a href="javascript:;" class="a-upload mr10"><input type="file" name="img" id="img">点击这里上传文件</a>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="button" >更新</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 退出系统的模态窗口 -->
    <div class="modal fade" id="exitModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">离开</h4>
                </div>
                <div class="modal-body">
                    <p>您确定要退出系统吗？</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="window.location.href='<%=basePath%>/settings/user/logOut';">确定</button>
                </div>
            </div>
        </div>
    </div>

    <!-- 顶部 -->
    <div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
        <div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;动力节点</span></div>
        <div style="position: absolute; top: 15px; right: 15px;">
            <ul>
                <li class="dropdown user-dropdown">
                    <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                        <img id="userPhoto1"  style="display:none;border-radius: 100%;width: 30px;height: 30px" />
                    </a>
                    <c:choose>
                        <c:when test="${not empty sessionScope.user.img}">
                            <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                                <img id="userPhoto" src="${sessionScope.user.img}" style="border-radius: 100%;width: 30px;height: 30px" /> ${sessionScope.user.name} <span class="caret"></span>
                            </a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0)" style="text-decoration: none; color: white;" class="dropdown-toggle" data-toggle="dropdown">
                                <span class="glyphicon glyphicon-user" id="span"></span> ${sessionScope.user.name} <span class="caret"></span>
                            </a>
                        </c:otherwise>
                    </c:choose>

                    <ul class="dropdown-menu">
                        <li><a href="<%=basePath%>/toView/workbench/index"><span class="glyphicon glyphicon-home"></span> 工作台</a></li>
                        <li><a href="<%=basePath%>/toView/settings/index"><span class="glyphicon glyphicon-wrench"></span> 系统设置</a></li>
                        <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file" id="mydata"></span> 我的资料</a></li>
                        <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
                        <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
	
	<!-- 创建部门的模态窗口 -->
	<div class="modal fade" id="createDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel"><span class="glyphicon glyphicon-plus"></span> 新增部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="deptForm" role="form">
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-code" style="width: 200%;" placeholder="编号不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-name" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="create-clueOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="create-phone" style="width: 200%;">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="create-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addDept" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改部门的模态窗口 -->
	<div class="modal fade" id="editDeptModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1"><span class="glyphicon glyphicon-edit"></span> 编辑部门</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" role="form">
					
						<div class="form-group">
							<label for="create-code" class="col-sm-2 control-label">编号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-code" style="width: 200%;" placeholder="不能为空，具有唯一性">
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-name" class="col-sm-2 control-label">名称</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-name" style="width: 200%;" >
							</div>
						</div>
						
						<div class="form-group">
							<label class="col-sm-2 control-label">负责人</label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="edit-clueOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-phone" class="col-sm-2 control-label">电话</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" id="edit-phone" style="width: 200%;" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 55%;">
								<textarea class="form-control" rows="3" id="edit-describe"></textarea>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="updateDept()">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	<div style="width: 95%">
		<div>
			<div style="position: relative; left: 30px; top: -10px;">
				<div class="page-header">
					<h3>部门列表</h3>
				</div>
			</div>
		</div>
		<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; top:-30px;">
			<div class="btn-group" style="position: relative; top: 18%;">
			  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createDeptModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
			  <button type="button" class="btn btn-default" id="editDept"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			  <button type="button" class="btn btn-danger" id="deleteDept"><span class="glyphicon glyphicon-minus"></span> 删除</button>
              <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>

            </div>
		</div>
		<div style="position: relative; left: 30px; top: -10px;">
			<table class="table table-hover">
				<thead>
					<tr style="color: #B3B3B3;">
						<td><input type="checkbox" id="father"/></td>
						<td>编号</td>
						<td>名称</td>
						<td>负责人</td>
						<td>电话</td>
						<td>描述</td>
					</tr>
				</thead>
				<tbody id="tbody">
					<%--<tr class="active">
						<td><input type="checkbox" class="sun" /></td>
						<td>1110</td>
						<td>财务部</td>
						<td>张飞</td>
						<td>010-84846005</td>
						<td>description info</td>
					</tr>--%>
				</tbody>
			</table>
		</div>
		
		<div style="height: 50px; position: relative;top: 0px; left:30px;">
            <div id="DeptPage"></div>
		</div>
			
	</div>
	
</body>
</html>

<script>
    //判断原密码正确不正确
    $("#oldPwd").blur(function () {
        if ($("#oldPwd").val()==""){
            layer.alert("原密码不能为空！", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }

        $.ajax({
            url:"<%=basePath%>/settings/user/oldPassword",
            data:{
                'loginPwd': $("#oldPwd").val()
            },
            type: "post",
            dataType:"json",
            success: function (data) {

                if (!data.ok) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        });
    });

    //修改密码
    $("#button").click(function () {
        var confirmPwd = $("#confirmPwd").val();
        var newPwd = $("#newPwd").val();

        if (confirmPwd == "" || newPwd==""){

            layer.alert("密码不能为空!", {
                icon: 4,
                skin: 'layer-ext-demo'});
            $.ajax({
                url:"<%=basePath%>/setting/user/update",
                data:{
                    'img' : $('#photo').val()
                },
                type: "post",
                dataType:"json",
                success: function (data) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'});
                }
            });
            //    只能更改密码的时候才能修改头像
        } else if (confirmPwd != "" && newPwd !="" &&confirmPwd == newPwd){

            $.ajax({
                url:"<%=basePath%>/setting/user/update",
                data:{
                    'loginPwd': confirmPwd,
                    'img' : $('#photo').val(),
                    'id':'${sessionScope.user.id}'
                },
                type: "post",
                dataType:"json",
                success: function (data) {
                    if (!data.ok) {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'});

                        <%--window.location.href = "<%=basePath%>/toView/login";--%>
                        window.location.href = "<%=basePath%>/toView/login";
                    }
                }
            });
        }else {
            layer.alert("两次输入的密码不一致请重新输入！", {
                icon: 5,
                skin: 'layer-ext-demo'});
        }
    });

    //异步上传文件
    $("#img").change(function () {
        $.ajaxFileUpload({
            url:"<%=basePath%>/setting/user/FileUpload",
            dataType:"json",
            fileElementId:"img",
            success:function (data) {
                //状态错误走if
                if (!data.ok) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });

                }else {
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    $("#photo").val(data.t);

                    $("#userPhoto").css('display','none');
                    $("#userPhoto1").css('display','inline').prop('src',data.t);
                    $("#span").css('display','none');
                }
            }
        });
        return false;
    });
    //查询我的资料
    $(function() {
        $.ajax({
            url:"<%=basePath%>/setting/user/mydata",
            type:"get",
            dataType:"json",
            success:function (data) {
                $("#b1").html(data.name);
                $("#b2").html(data.loginAct);
                $("#b3").html(data.deptno);
                $("#b4").html(data.email);
                $("#b5").html(data.expireTime);
                $("#b6").html(data.allowIps);
            }
        });
    });

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
    //查询部门信息
    function refresh (page,pageSize){
        $.ajax({
            url:"<%=basePath%>/settings/dept/selectAll",
            type:"get",
            dataType:"json",
            data:{
                'page':page,
                'pageSize':pageSize
            },
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $('#father').removeAttr('checked');
                $("#tbody").html("");
                var depts = data.list;
                for (var i = 0; i < depts.length; i++){
                    var dept = depts[i];
                    $("#tbody").append("<tr class=\"active\">\n" +
                        "\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkedes()' class=\"sun\" value='"+dept.id+"' /></td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.id+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.name+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.owner+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.phone+"</td>\n" +
                        "\t\t\t\t\t\t<td>"+dept.description+"</td>\n" +
                        "\t\t\t\t\t</tr>")
                }
                $("#DeptPage").bs_pagination({
                    currentPage: data.pageNum, // 页码
                    rowsPerPage: data.pageSize, // 每页显示的记录条数
                    maxRowsPerPage: 20, // 每页最多显示的记录条数
                    totalPages:data.pages, // 总页数
                    totalRows:data.total, // 总记录条数
                    visiblePageLinks: 3, // 显示几个卡片
                    showGoToPage: true,
                    showRowsPerPage: true,
                    showRowsInfo: true,
                    showRowsDefaultInfo: true,
                    onChangePage: function (event, obj) {
                        //递归调用自己
                        refresh(obj.currentPage,obj.rowsPerPage);
                    }
                });
            }
        });
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


    //添加
    $("#addDept").click(function () {
        if ($("#create-code").val() == ""){
            layer.alert("编号不能为空!", {
                icon: 5});
        } else if ($("#create-name").val() == ""){
            layer.alert("部门名称不能为空!", {
                icon: 5});
        } else if ($("#create-manager").val() == ""){
            layer.alert("负责人不能为空!", {
                icon: 5});
        } else if ($("#create-phone").val() == ""){
            layer.alert("手机号不能为空!", {
                icon: 5});
        }else if ($("#create-describe").val() == ""){
            layer.alert("描述不能为空!", {
                icon: 5});
        }else {
            $.ajax({
                url:"<%=basePath%>/settings/dept/addDept",
                data:{
                    'id':$("#create-code").val(),
                    'name':$("#create-name").val(),
                    'owner':$("#create-clueOwner").val(),
                    'phone':$("#create-phone").val(),
                    'description':$("#create-describe").val()
                },
                dataType:"json",
                type:"post",
                success:function (data) {
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6});
                        //清除表单数据
                        $("#deptForm")[0].reset();
                        refresh(1,3);
                    } else {
                        layer.alert(data.message, {
                            icon: 5});
                    }

                }
            })
        }
    });

    //修改
    $("#editDept").click(function () {
        var checkedLenth = $(".sun:checked").length;
        if (checkedLenth > 1){
            layer.alert("选择操作的数据不能超过一条!", {
                icon: 5});
        } else if (checkedLenth < 1){
            layer.alert("请至少选择一条数据!", {
                icon: 5});
        } else {
            $("#editDeptModal").modal("show");
            var id = $(".sun:checked")[0].value;
           $.ajax({
               url:"<%=basePath%>/settings/dept/selectDept",
               data:{
                   'id':id
               },
               type:"post",
               dataType:"json",
               success:function (data) {
                   $("#edit-code").val(data.id);
                   $("#edit-name").val(data.name);
                   $("#edit-clueOwner").val(data.owner);
                   $("#edit-phone").val(data.phone);
                   $("#edit-describe").val(data.description);
               }
           });
       }
    });

    //修改的方法id="updateDept"
   function updateDept() {
       if ($("#edit-code").val() == ""){
           layer.alert("编号不能为空!", {
               icon: 5});
       } else if ($("#edit-name").val() == ""){
           layer.alert("部门名称不能为空!", {
               icon: 5});
       } else if ($("#edit-clueOwner").val() == ""){
           layer.alert("负责人不能为空!", {
               icon: 5});
       } else if ($("#edit-phone").val() == ""){
           layer.alert("手机号不能为空!", {
               icon: 5});
       }else if ($("#edit-describe").val() == ""){
           layer.alert("描述不能为空!", {
               icon: 5});
       }else {
           $.ajax({
               url: "<%=basePath%>/settings/dept/updateDept",
               data: {
                   'id': $("#edit-code").val(),
                   'name': $("#edit-name").val(),
                   'owner': $("#edit-clueOwner").val(),
                   'phone': $("#edit-phone").val(),
                   'description': $("#edit-describe").val()
               },
               type: "post",
               dataType: "json",
               success: function (data) {
                   if (data.ok) {
                       layer.alert(data.message, {
                           icon: 6
                       });
                       $("#editDeptModal").modal("hide");
                       //刷新页面
                       refresh(1, 3);
                   } else {
                       layer.alert(data.message, {
                           icon: 5
                       });
                   }
               }
           });
       }
   }

   //删除部门信息的方法
    $("#deleteDept").click(function () {
       var checkedLength = $(".sun:checked").length;
        if (checkedLength == 0) {
            layer.alert("请至少选择一条数据进行删除!", {
                icon: 5
            });
        }else {
            layer.confirm('确定要删除' + checkedLength + '条记录吗？', {
                btn: ['确定', '取消']
                // 按钮
            }, function () {
                var ids = [];
                $(".sun:checked").each(function () {
                    ids.push($(this).val());
                });
                $.ajax({
                  url:"<%=basePath%>/settings/dept/deleteDept",
                  data:{
                      'ids':ids.join()
                  },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data.ok) {
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
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

        window.location.href = "<%=basePath%>/workbench/Dept/exportExcel";
    });





</script>