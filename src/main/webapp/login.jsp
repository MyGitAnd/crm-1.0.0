<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort() + request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=basePath%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
</head>
<body id="body">
	<div style="position: absolute; top: 0px; left: 0px; width: 60%;">
		<img src="<%=basePath%>/image/IMG_7114.JPG" style="width: 100%; position: relative; top: 50px;">
	</div>
	<div id="top" style="height: 50px; background-color: #3C3C3C; width: 100%;">
		<div style="position: absolute; top: 5px; left: 0px; font-size: 30px; font-weight: 400; color: white; font-family: 'times new roman'">CRM &nbsp;<span style="font-size: 12px;">&copy;2021&nbsp;动力节点</span></div>
	</div>
	
	<div style="position: absolute; top: 120px; right: 100px;width:450px;height:400px;border:1px solid #D5D5D5">
		<div style="position: absolute; top: 0px; right: 60px;">
			<div class="page-header">
				<h1>登录</h1>
			</div>
			<form action="workbench/index.html" class="form-horizontal" role="form">
				<div class="form-group form-group-lg">
					<div style="width: 350px;">
						<input class="form-control" id="username" type="text" placeholder="用户名">
					</div>
					<div style="width: 350px; position: relative;top: 20px;">
						<input class="form-control" id="password" type="password" placeholder="密码">
					</div>
					<div class="checkbox"  style="position: relative;top: 30px; left: 10px;">
						
							<span id="msg"></span>
						
					</div>
					<button type="button" id="button" class="btn btn-primary btn-lg btn-block"  style="width: 350px; position: relative;top: 45px;">登录</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>

<script>


    $(function () {
        $("#username").focus();
    });

   $("#body").keypress(function (ele) {

       if (ele.keyCode == 13) {

           if($("#username").val()==""){
               layer.alert('账号不能为空!', {
                   icon: 5,
                   skin: 'layer-ext-demo'
               });
           }
           if($("#password").val()=="") {
               layer.alert('密码不能为空!', {
                   icon: 5,
                   skin: 'layer-ext-demo'
               });
            }else {
               $.ajax({
                   url: "<%=basePath%>/settings/user/login",
                   data: {
                       'loginAct': $("#username").val(),
                       'loginPwd': $("#password").val()
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
                           window.location.href = "<%=basePath%>/toView/workbench/index";
                       }
                   }
               });
       }
   }
   });

    $("#button").click(function () {

            if($("#username").val()==""){
                layer.alert('账号不能为空!', {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }
            if($("#password").val()==""){
                layer.alert('密码不能为空!', {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }else {
                    $.ajax({
                        url: "<%=basePath%>/settings/user/login",
                        data: {
                            'loginAct': $("#username").val(),
                            'loginPwd': $("#password").val()
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
                                window.location.href = "<%=basePath%>/toView/workbench/index";
                            }

                        }
                    });
                }
    });

</script>