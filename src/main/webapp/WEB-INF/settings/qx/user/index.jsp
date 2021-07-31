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
</head>
<body>

	<!-- 创建用户的模态窗口 -->
	<div class="modal fade" id="createUserModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 90%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel">新增用户</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="userForm" role="form">
					
						<div class="form-group">
							<label for="create-loginActNo" class="col-sm-2 control-label">登录帐号<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="loginAct" id="create-loginActNo">
							</div>
							<label for="create-username" class="col-sm-2 control-label">用户姓名</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="name" id="create-username">
							</div>
						</div>
						<div class="form-group">
							<label for="create-loginPwd" class="col-sm-2 control-label">登录密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" name="loginPwd" id="create-loginPwd">
							</div>
							<label for="create-confirmPwd" class="col-sm-2 control-label">确认密码<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="password" class="form-control" id="create-confirmPwd">
							</div>
						</div>
						<div class="form-group">
							<label for="create-email" class="col-sm-2 control-label">邮箱</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="email" id="create-email">
							</div>
							<label for="create-expireTime" class="col-sm-2 control-label">失效时间</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="expireTime" id="create-expireTime">
							</div>
						</div>
						<div class="form-group">
							<label for="create-lockStatus" class="col-sm-2 control-label">锁定状态</label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="lockState" id="create-lockStatus">
                                    <c:forEach var="lockedStates" items="${applicationScope.lockedStates}">
                                        <option value="${lockedStates.id}">${lockedStates.name}</option>
                                    </c:forEach>
								</select>
							</div>
							<label class="col-sm-2 control-label">部门<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="deptno" id="create-dept">
                                    <c:forEach var="dept" items="${applicationScope.depts}">
                                        <option value="${dept.id}">${dept.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
						</div>
						<div class="form-group">
							<label for="create-allowIps" class="col-sm-2 control-label">允许访问的IP</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="allowIps" id="create-allowIps" style="width: 280%" placeholder="多个用逗号隔开">
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" id="addUser" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	
	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>用户列表</h3>
			</div>
		</div>
	</div>
	
	<div class="btn-toolbar" role="toolbar" style="position: relative; height: 80px; left: 30px; top: -10px;">
		<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">

		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">用户姓名</div>
		      <input class="form-control" id="name" type="text">
		    </div>
		  </div>

		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">部门名称</div>
		      <input class="form-control" id="deptno" type="text">
		    </div>
		  </div>

		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">锁定状态</div>
                <select class="form-control" id="lockedStates">
                    <option value="">请选择</option>
                    <c:forEach var="lockedStates" items="${applicationScope.lockedStates}">
                        <option value="${lockedStates.id}">${lockedStates.name}</option>
                    </c:forEach>
                </select>
		    </div>
		  </div>
		  <br><br>
		  
		  <div class="form-group">
		    <div class="input-group">
		      <div class="input-group-addon">失效时间</div>
			  <input class="form-control" type="text" id="startTime" />
		    </div>
		  </div>

		  ~

		  <div class="form-group">
		    <div class="input-group">
			  <input class="form-control" type="text" id="expireTime" />
		    </div>
		  </div>

		  <button type="button" id="likeSelect" class="btn btn-default">查询</button>
		</form>
	</div>
	
	
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px; width: 110%; top: 20px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createUserModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-danger" id="deleteUser"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
		
	</div>
	
	<div style="position: relative; left: 30px; top: 40px; width: 110%">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="father"/></td>
					<td>序号</td>
					<td>登录帐号</td>
					<td>用户姓名</td>
					<td>部门名称</td>
					<td>邮箱</td>
					<td>失效时间</td>
					<td>允许访问IP</td>
					<td>锁定状态</td>
					<td>创建者</td>
					<td>创建时间</td>
					<td>修改者</td>
					<td>修改时间</td>
				</tr>
			</thead>
			<tbody id="userTbody">
				<%--<tr class="active">
					<td><input type="checkbox" id="sun" value="" /></td>
					<td>1</td>
					<td><a onclick="location.href='<%=basePath%>/toView/settings/qx/user/detail?id='" href="javascript:void 0;">zhangsan</a></td>
					<td>张三</td>
					<td>市场部</td>
					<td>zhangsan@bjpowernode.com</td>
					<td>2017-02-14 10:10:10</td>
					<td>127.0.0.1,192.168.100.2</td>
					<td>启用</td>
					<td>admin</td>
					<td>2017-02-10 10:10:10</td>
					<td>admin</td>
					<td>2017-02-10 20:10:10</td>
				</tr>--%>

			</tbody>
		</table>
	</div>
	
	<div style="height: 50px; position: relative;top: 30px; left: 30px;">
        <div id="userPage"></div>
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
    $("#startTime").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition:"bottom-left"
    });
    $("#expireTime").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition:"bottom-left"
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
        go_last_text: '末页'
    };
    refresh(1,3);

    function refresh(page,pageSize) {
        $.ajax({
            url:"<%=basePath%>/settings/user/selectAllUser",
            data:{
                'currentPage': page,
                'rowsPerPage': pageSize,
                'name':$("#name").val(),
                'deptno':$("#deptno").val(),
                'lockState':$("#lockedStates").val(),
                'expireTime':$("#expireTime").val(),
                'startTime':$("#startTime").val()
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                $("#userTbody").html("");
                var users = data.list;
                for (var i = 0;i < users.length;i++) {
                    var user = users[i];
                    $("#userTbody").append("<tr class=\"active\">\n" +
                        "\t\t\t\t\t<td><input type=\"checkbox\" class='sun'  onclick='checkedes()' value="+user.id+" /></td>\n" +
                        "\t\t\t\t\t<td>"+user.index+"</td>\n" +
                        "\t\t\t\t\t<td><a onclick=\"location.href='<%=basePath%>/toView/settings/qx/user/detail?id="+user.id+"'\" href=\"javascript:void 0;\">"+user.loginAct+"</a></td>\n" +
                        "\t\t\t\t\t<td>"+user.name+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.deptno+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.email+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.expireTime+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.allowIps+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.lockState+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.createBy+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.createTime+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.editBy+"</td>\n" +
                        "\t\t\t\t\t<td>"+user.editTime+"</td>\n" +
                        "\t\t\t\t</tr>")
                }
                //分页
                //分页查询
                $("#userPage").bs_pagination({
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
    $("#likeSelect").click(function () {
        refresh(1,3);
    });

    //添加
    $("#addUser").click(function () {
       if ($("#create-loginActNo").val() == ""){
           layer.alert("账号不能为空!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       } else if ($("#create-username").val() == ""){
           layer.alert("姓名不能为空!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       }  else if ($("#create-loginPwd").val() == ""){
           layer.alert("登录密码不能为空!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       }  else if ($("#create-confirmPwd").val() != $("#create-loginPwd").val()){
           layer.alert("两次输入的密码不一致,请重新输入!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       }  else if ($("#create-email").val() == ""){
           layer.alert("邮箱不能为空!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       }  else if ($("#create-allowIps").val() == ""){
           layer.alert("允许访问的IP不能为空!", {
               icon: 5,
               skin: 'layer-ext-demo'
           });
       } else {

           $.ajax({
               url:"<%=basePath%>/settings/user/addUser",
               data:$("#userForm").serialize(),
               type:"get",
               dataType:"json",
               success:function (data) {
                   if (data.ok){
                       layer.alert(data.message, {
                           icon: 6,
                           skin: 'layer-ext-demo'
                       });
                   }
                   //清空表单数据
                   $("#userForm")[0].reset();
                   refresh(1,3);
               }, error:function (data) {
                   layer.alert(data.message, {
                       icon: 5,
                       skin: 'layer-ext-demo'
                   });
               }
           });
       }
    });

    //全选和全不选
    $("#father").click(function () {
       $(".sun") .prop("checked",$(this).prop("checked"));
    });

    function checkedes(){
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


    //删除
    $("#deleteUser").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength < 0) {
            layer.alert("请至少选择一条数据！", {
                icon: 5,
                skin: 'layer-ext-demo'
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
                    url:"<%=basePath%>/settings/user/deleteUser",
                    data:{
                        'ids':ids.join()
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data.ok){
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            //刷新当前页面
                            refresh(1,3);
                        }
                    },error:function (data) {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                })

            })
        }
    })


</script>