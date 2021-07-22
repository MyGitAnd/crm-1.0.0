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



	});
	
</script>
</head>
<body>

	<!-- 创建市场活动的模态窗口 -->
	<div class="modal fade" id="createActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel1">创建市场活动</h4>
				</div>
				<div class="modal-body">
				
					<form class="form-horizontal" id="addActivityForm" role="form">
					
						<div class="form-group">
							<label for="create-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="create-marketActivityOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
                            <label for="create-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="name" id="create-marketActivityName">
                            </div>
						</div>
						
						<div class="form-group">
							<label for="create-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="startDate" id="create-startTime">
							</div>
							<label for="create-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" class="form-control" name="endDate" id="create-endTime">
							</div>
						</div>
                        <div class="form-group">

                            <label for="create-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="cost" id="create-cost">
                            </div>
                        </div>
						<div class="form-group">
							<label for="create-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" rows="3" name="describe" id="create-describe"></textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary" onclick="addOrUpdate($(this).text())" data-dismiss="modal">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 修改市场活动的模态窗口 -->
	<div class="modal fade" id="editActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 85%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title" id="myModalLabel2">修改市场活动</h4>
				</div>
				<div class="modal-body">
					<form class="form-horizontal" id="editActivityForm" role="form">
                        <input type="hidden" name="id" id="id">
						<div class="form-group">
							<label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
							<div class="col-sm-10" style="width: 300px;">
								<select class="form-control" name="owner" id="edit-marketActivityOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
								</select>
							</div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" name="name" class="form-control" id="edit-marketActivityName" >
                            </div>
						</div>

						<div class="form-group">
							<label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" name="startDate" class="form-control" id="edit-startTime" >
							</div>
							<label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" name="endDate" class="form-control" id="edit-endTime" >
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-cost" class="col-sm-2 control-label">成本</label>
							<div class="col-sm-10" style="width: 300px;">
								<input type="text" name="cost" class="form-control" id="edit-cost">
							</div>
						</div>
						
						<div class="form-group">
							<label for="edit-describe" class="col-sm-2 control-label">描述</label>
							<div class="col-sm-10" style="width: 81%;">
								<textarea class="form-control" name="description" rows="3" id="edit-describe">
                                </textarea>
							</div>
						</div>
						
					</form>
					
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
					<button type="button" class="btn btn-primary"  onclick="addOrUpdate($(this).text())" data-dismiss="modal">更新</button>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>市场活动列表</h3>
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
				      <div class="input-group-addon">开始日期</div>
					  <input class="form-control" type="text" id="startTime" />
				    </div>
				  </div>
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">结束日期</div>
					  <input class="form-control" type="text" id="endTime">
				    </div>
				  </div>
				  
				  <button type="button" onclick="queryActivity()" class="btn btn-default">查询</button>

				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 5px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#createActivityModal"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" data-toggle="modal" onclick="openEditModal()"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deletes"><span class="glyphicon glyphicon-minus"></span> 删除</button>
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
							<td>开始日期</td>
							<td>结束日期</td>
						</tr>
					</thead>
					<tbody id="activityTbody">

					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 30px;">
				<div id="activityPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>

<script>
        //查询市场活动的信息
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

    //刷新的方法
    refresh(1,3);

    //分页查询
    function refresh (page,pageSize){
        $.ajax({
            url:"<%=basePath%>/workbench/activity/list",
            type:"get",
            dataType:"json",
            data:{
                'page':page,
                'pageSize':pageSize,
                'name':$("#name").val(),
                'owner':$("#owner").val(),
                'startDate':$("#startTime").val(),
                'endDate':$("#endTime").val()
            },
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $('#father').removeAttr('checked');
                $("#activityTbody").html("");
                var activitys = data.list;
                for (var i = 0; i < activitys.length; i++){
                    var activity = activitys[i];
                    $("#activityTbody").append("<tr class=\"active\">\n" +
                        "\t\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkedes()' class='sun' value='"+activity.id+"' /></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/activity/detail?id="+activity.id+"';\">"+activity.name+"</a></td>\n" +
                        "                            <td>"+activity.owner+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+activity.startDate+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+activity.endDate+"</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                $("#activityPage").bs_pagination({
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
        $("#endTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });

        $("#edit-startTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });
        $("#edit-endTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });

        $("#create-startTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });
        $("#create-endTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });

        //添加日历组件
        $("#startTime").datetimepicker({
            language:  "zh-CN",
            format: "yyyy-mm-dd",//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),//初始化当前日期
            autoclose: true,//选中自动关闭
            todayBtn: true, //显示今日按钮
            clearBtn : true,
            pickerPosition: "bottom-left"
        });

//    模糊查询
   function queryActivity() {
       refresh(1,3);
   }

   //查询所有者的信息
   function users(){
       <%--$.ajax({--%>
           <%--url:"<%=basePath%>/workbench/activity/users",--%>
           <%--type:"post",--%>
           <%--dataType:"json",--%>
           <%--success:function (data) {--%>
            <%--$("#create-marketActivityOwner").html("");--%>
            <%--for (var i = 0; i < data.length;i++){--%>
                <%--$("#create-marketActivityOwner").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");--%>
            <%--}--%>
           <%--}--%>
       <%--});--%>
   }


        users();
   //修改和添加功能的实现
       function addOrUpdate(content){
           if (content == "保存"){
               //保存
               $.ajax({
                   url:"<%=basePath%>/workbench/activity/addAndUpdate",
                   type:"post",
                   data: {
                       'owner':$("#create-marketActivityOwner").val(),
                       'name':$("#create-marketActivityName").val(),
                       'startDate':$("#create-startTime").val(),
                       'endDate':$("#create-endTime").val(),
                       'cost':$("#create-cost").val(),
                       'description':$("#create-describe").val()
                   },
               // $('#addActivityForm').serialize(),//可以使用这种方式要设置name值
                   dataType:"json",
                   success:function (data) {
                       //保存完毕后清空表单中的数据
                       $('#createActivityModal').on('hidden.bs.modal', function (){
                           document.getElementById("addActivityForm").reset();
                   });
                       if (data.ok){
                           layer.alert(data.message, {
                               icon: 6,
                               skin: 'layer-ext-demo'
                           });
                           refresh(1,3);

                       } else {
                           layer.alert(data.message, {
                               icon: 5,
                               skin: 'layer-ext-demo'
                           });
                       }
                   }
               });

         } else {
              //修改的
               $.ajax({
                   url:"<%=basePath%>/workbench/activity/addAndUpdate",
                   type:"post",
                   data: {
                       'owner':$("#edit-marketActivityOwner").val(),
                       'name':$("#edit-marketActivityName").val(),
                       'startDate':$("#edit-startTime").val(),
                       'endDate':$("#edit-endTime").val(),
                       'cost':$("#edit-cost").val(),
                       'description':$("#edit-describe").val(),
                       'id':$("#id").val()
                   },
                   // $("#editActivityForm").serialize()//可以使用这种方式要设置name值
                   dataType:"json",
                   success:function (data) {
                       $('#father').removeAttr('checked');
                       if (data.ok){
                           layer.alert(data.message, {
                               icon: 6,
                               skin: 'layer-ext-demo'
                           });
                           refresh(1,3);
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

       //全选和反选
       $("#father").click(function () {
          $(".sun").prop("checked",$(this).prop("checked"));
       });
        function checkedes() {
            //获取所有的sun的个数
            var length = $(".sun").length;
        //获取勾中的个数
            var checkedLength = $(".sun:checked").length;
            if (length == checkedLength){
                $("#father").prop("checked",true);
            } else {
                $("#father").prop("checked",false);
            }
        }

        //修改操作
        function openEditModal() {
            var checkedLength = $(".sun:checked").length;
            if (checkedLength < 1){
                layer.alert("请至少选择一条数据!", {
                    icon: 5});
            } else if (checkedLength > 1){
                layer.alert("选择操作的数据不能超过一条!", {
                    icon: 5});
            }else {
                //合法打开模态框
                $("#editActivityModal").modal("show");
                <%--$.ajax({--%>
                    <%--url:"<%=basePath%>/workbench/activity/users",--%>
                    <%--type:"post",--%>
                    <%--dataType:"json",--%>
                    <%--success:function (data) {--%>
                        <%--$("#edit-marketActivityOwner").html("");--%>
                        <%--for (var i = 0; i < data.length;i++){--%>
                            <%--$("#edit-marketActivityOwner").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>");--%>
                        <%--}--%>
                    <%--}--%>
                <%--});--%>
                var id = $(".sun:checked")[0].value;
                $.ajax({
                   url:"<%=basePath%>/workbench/activity/editActivity" ,
                    data:{
                       'id': id
                    },
                    dataType:"json",
                    type:"post",
                    success:function (data) {
                            $("#edit-marketActivityName").val(data.name);
                            $("#edit-startTime").val(data.startDate);
                            $("#edit-endTime").val(data.endDate);
                            $("#edit-cost").val(data.cost);
                            $("#edit-describe").val(data.description);
                            //将id放在隐藏域中
                            $("#id").val(data.id);
                            //将所有者显示当前对应的所有者
                            $("#edit-marketActivityOwner").val(data.owner);
                    }
                });

            }
        }

        //删除
    $("#deletes").click(function () {
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
                    url:"<%=basePath%>/workbench/activity/deletesActivity",
                    data:{
                    'ids':ids.join()
                    },
                    dataType:"json",
                    type:"get",
                    success:function (data) {
                        $('#father').removeAttr('checked');
                        if (data.ok){
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            refresh(1,3);
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

        window.location.href = "<%=basePath%>/workbench/Activity/exportExcel";

        //用不了
        <%--$.ajax({--%>
            <%--url:"<%=basePath%>/workbench/Activity/exportExcel",--%>
            <%--type:"get",--%>
            <%--dataType:"json",--%>
            <%--success:function (data) {--%>
                <%--if (data.ok){--%>
                    <%--layer.alert(data.message, {--%>
                        <%--icon: 6,--%>
                        <%--skin: 'layer-ext-demo'--%>
                    <%--});--%>
             <%--}--%>
            <%--}--%>
        <%--})--%>

    });


</script>