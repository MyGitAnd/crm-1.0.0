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
<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript">

	//页面加载完毕
	$(function(){
		
		//导航中所有文本颜色为黑色
		$(".liClass > a").css("color" , "black");
		
		//默认选中导航菜单中的第一个菜单项
		$(".liClass:first").addClass("active");
		
		//第一个菜单项的文字变成白色
		$(".liClass:first > a").css("color" , "white");
		
		//给所有的菜单项注册鼠标单击事件
		$(".liClass").click(function(){
			//移除所有菜单项的激活状态
			$(".liClass").removeClass("active");
			//导航中所有文本颜色为黑色
			$(".liClass > a").css("color" , "black");
			//当前项目被选中
			$(this).addClass("active");
			//当前项目颜色变成白色
			$(this).children("a").css("color","white");
		});
		
		//展示市场活动页面
		window.open("<%=basePath%>/toView/settings/qx/user/index","workareaFrame");
		
	});
	
</script>
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
                            <input type="text" class="form-control" id="oldPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="newPwd" class="col-sm-2 control-label">新密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="newPwd" style="width: 200%;">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="confirmPwd" class="col-sm-2 control-label">确认密码</label>
                        <div class="col-sm-10" style="width: 300px;">
                            <input type="text" class="form-control" id="confirmPwd" style="width: 200%;">
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
                <button type="button" class="btn btn-primary" data-dismiss="modal" id="button">更新</button>
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
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#myInformation"><span class="glyphicon glyphicon-file"></span> 我的资料</a></li>
                    <li><a href="javascript:void(0)" data-toggle="modal" data-target="#editPwdModal"><span class="glyphicon glyphicon-edit"></span> 修改密码</a></li>
                    <li><a href="javascript:void(0);" data-toggle="modal" data-target="#exitModal"><span class="glyphicon glyphicon-off"></span> 退出</a></li>
                </ul>
            </li>
        </ul>
    </div>
</div>
	
	<!-- 中间 -->
	<div id="center" style="position: absolute;top: 50px; bottom: 30px; left: 0px; right: 0px;">
	
		<!-- 导航 -->
		<div id="navigation" style="left: 0px; width: 18%; position: relative; height: 100%; overflow:auto;">
		
			<ul id="no1" class="nav nav-pills nav-stacked">
				<li class="liClass"><a href="<%=basePath%>/toView/settings/qx/user/index" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 用户维护</a></li>
				<%--<li class="liClass"><a href="<%=basePath%>/toView/settings/qx/role/index" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 角色维护</a></li>--%>
				<%--<li class="liClass"><a href="<%=basePath%>/toView/settings/qx/permission/index" target="workareaFrame"><span class="glyphicon glyphicon-user"></span> 许可维护</a></li>--%>
			</ul>
			
			<!-- 分割线 -->
			<div id="divider1" style="position: absolute; top : 0px; right: 0px; width: 1px; height: 100% ; background-color: #B3B3B3;"></div>
		</div>
		
		<!-- 工作区 -->
		<div id="workarea" style="position: absolute; top : 0px; left: 18%; width: 82%; height: 100%;">
			<iframe style="border-width: 0px; width: 100%; height: 100%;" name="workareaFrame"></iframe>
		</div>
		
	</div>
	
	<div id="divider2" style="height: 1px; width: 100%; position: absolute;bottom: 30px; background-color: #B3B3B3;"></div>
	
	<!-- 底部 -->
	<div id="down" style="height: 30px; width: 100%; position: absolute;bottom: 0px;"></div>
	
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

        if (confirmPwd == "" && newPwd==""){

            layer.alert("保存失败!", {
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
        } else if (confirmPwd == newPwd){

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






</script>