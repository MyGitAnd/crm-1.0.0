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

<SCRIPT type="text/javascript">
	var setting = {
		data: {
			simpleData: {
				enable: true
			}
		}
	};

	
	$(document).ready(function(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	});
	
</SCRIPT>

</head>
<body>

	<!-- 分配许可的模态窗口 -->
	<div class="modal fade" id="assignRoleForUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 80%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">为<b>张三</b>分配角色</h4>
				</div>
				<div class="modal-body">
					<table width="90%" border="0" cellspacing="0" cellpadding="0" align="center">
						<tr>
							<td width="42%">
								<div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
									张三，未分配角色列表
								</div>
							</td>
							<td width="15%">
								&nbsp;
							</td>
							<td width="43%">
								<div class="list_tit" style="border: solid 1px #D5D5D5; background-color: #F4F4B5;">
									张三，已分配角色列表
								</div>
							</td>
						</tr>
						<tr>
							<td>
								<select size="15" name="srcList" id="srcList"
									style="width: 100%" multiple="multiple">
									<option>
										总裁
									</option>
									<option>
										市场部普通职员
									</option>
									<option>
										市场总监
									</option>
									<option>
										销售部销售员
									</option>
									<option>
										销售总监
									</option>
								</select>
							</td>
							<td>
								<p align="center">
									<a href="javascript:void(0);" title="分配角色"><span class="glyphicon glyphicon-chevron-right" style="font-size: 20px;"></span></a>
								</p>
								<br><br>
								<p align="center">
									<a href="javascript:void(0);" title="撤销角色"><span class="glyphicon glyphicon-chevron-left" style="font-size: 20px;"></span></a>
								</p>
							</td>
							<td>
								<select name="destList" size="15" multiple="multiple"
									id="destList" style="width: 100%">
									<option>
										副总裁
									</option>
								</select>
							</td>
						</tr>
					</table>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 编辑用户的模态窗口 -->
	<div class="modal fade" id="editUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">修改用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="userUpdateForm" role="form">
					    <input type="hidden" id="id" name="id">
						<div class="form-group">
							<label for="edit-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="loginAct" id="edit-loginActNo">
							</div>
							<label for="edit-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="name" id="edit-username">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" name="loginPwd" id="edit-loginPwd">
							</div>
							<label for="edit-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="edit-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="email" id="edit-email">
							</div>
							<label for="edit-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="expireTime" id="edit-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="edit-lockStatus" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="lockState" id="edit-lockStatus">
                                    <c:forEach var="lockedStates" items="${applicationScope.lockedStates}">
                                        <option value="${lockedStates.id}">${lockedStates.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label class="col-sm-2 control-label">部门名称<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="deptno" id="edit-dept">
                                    <c:forEach var="dept" items="${applicationScope.depts}">
                                        <option value="${dept.id}">${dept.name}</option>
                                    </c:forEach>
                                </select>
							</div>
						</div>
						<div class="form-group">
							<label for="edit-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="allowIps" id="edit-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="updateUser" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3 id="h3">用户明细 <small id="small"></small></h3>
			</div>
			<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 80%;">
				<button type="button" class="btn btn-default" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left"></span> 返回</button>
			</div>
		</div>
	</div>
	
	<div style="position: relative; left: 60px; top: -50px;">
		
		<div id="myTabContent" class="tab-content">
			<div class="tab-pane fade in active" id="role-info">
				<div style="position: relative; top: 20px; left: -30px;">
					<div style="position: relative; left: 40px; height: 30px; top: 20px;">
						<div style="width: 300px; color: gray;">登录帐号</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b1"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 40px;">
						<div style="width: 300px; color: gray;">用户姓名</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b2"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 60px;">
						<div style="width: 300px; color: gray;">邮箱</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b3"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 80px;">
						<div style="width: 300px; color: gray;">失效时间</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b4"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 100px;">
						<div style="width: 300px; color: gray;">允许访问IP</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b5"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 120px;">
						<div style="width: 300px; color: gray;">锁定状态</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b6"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
					</div>
					<div style="position: relative; left: 40px; height: 30px; top: 140px;">
						<div style="width: 300px; color: gray;">部门名称</div>
						<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b7"></b></div>
						<div style="height: 1px; width: 600px; background: #D5D5D5; position: relative; top: -20px;"></div>
						<button style="position: relative; left: 76%; top: -40px;" type="button" class="btn btn-default" data-toggle="modal" data-target="#editUserModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
					</div>
				</div>
			</div>
			<div class="tab-pane fade" id="permission-info">
				<div style="position: relative; top: 20px; left: 0px;">
					<ul id="treeDemo" class="ztree" style="position: relative; top: 15px; left: 15px;"></ul>
					<div style="position: relative;top: 30px; left: 76%;">
						<button type="button" class="btn btn-default" data-toggle="modal" data-target="#assignRoleForUserModal"><span class="glyphicon glyphicon-edit"></span> 分配角色</button>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
</body>
</html>


<script>
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
    $("#edit-expireTime").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition:"bottom-left"
    });


$.ajax({
    url:"<%=basePath%>/settings/user/selectUser",
    data:{
        'id':'${requestScope.id}'
    },
    type:"post",
    dataType:"json",
    success:function (data) {
        $("#small").append(data.name);
        $("#b1").text(data.loginAct);
        $("#b2").text(data.name);
        $("#b3").text(data.email);
        $("#b4").text(data.expireTime);
        $("#b5").text(data.allowIps);
        $("#b6").text(data.lockState);
        $("#b7").text(data.deptno);
    }
});

//修改的查询方法
$.ajax({
    url:"<%=basePath%>/settings/user/selectUser2",
    data:{
        'id':'${requestScope.id}'
    },
    type:"post",
    dataType:"json",
    success:function (data) {
        //登录账号
        $("#edit-loginActNo").val(data.loginAct);
        $("#edit-username").val(data.name);
        /*  $("#edit-loginPwd").val(data.loginPwd);
          $("#edit-confirmPwd").val(data.loginPwd);*/
        $("#edit-email").val(data.email);
        $("#edit-expireTime").val(data.expireTime);
        $("#edit-lockStatus").val(data.lockState);
        $("#edit-dept").val(data.deptno);
        $("#edit-allowIps").val(data.allowIps);
        $("#id").val(data.id);
    }
});

//修改的方法
    $("#updateUser").click(function () {
        if ($("#edit-loginActNo").val() == ""){
            layer.alert("账号不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-username").val() == ""){
            layer.alert("姓名不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-loginPwd").val() == ""){
            layer.alert("登录密码不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-confirmPwd").val() != $("#edit-loginPwd").val()){
            layer.alert("两次输入的密码不一致,请重新输入!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-email").val() == ""){
            layer.alert("邮箱不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#edit-allowIps").val() == ""){
            layer.alert("允许访问的IP不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            $.ajax({
                url: "<%=basePath%>/settings/user/updateUser",
                data: $("#userUpdateForm").serialize(),
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                    }
                    //延迟刷新本页面
                    window.setTimeout(function () {
                        window.location.reload();
                    },2000)
                }, error:function (data) {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            })
        }
    });


</script>