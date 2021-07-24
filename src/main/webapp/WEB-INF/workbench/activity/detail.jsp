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
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript">

	//默认情况下取消和保存按钮是隐藏的
	var cancelAndSaveBtnDefault = true;
	
	$(function(){
		$("#remark").focus(function(){
			if(cancelAndSaveBtnDefault){
				//设置remarkDiv的高度为130px
				$("#remarkDiv").css("height","130px");
				//显示
				$("#cancelAndSaveBtn").show("2000");
				cancelAndSaveBtnDefault = false;
			}
		});
		
		$("#cancelBtn").click(function(){
			//显示
			$("#cancelAndSaveBtn").hide();
			//设置remarkDiv的高度为130px
			$("#remarkDiv").css("height","90px");
			cancelAndSaveBtnDefault = true;
		});

	});
	
</script>

</head>
<body>
	
	<!-- 修改市场活动备注的模态窗口 -->
	<div class="modal fade" id="editRemarkModal" role="dialog">
		<%-- 备注的id --%>
		<input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">修改备注</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" role="form">
                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="noteContent"></textarea>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateRemarkBtn">更新</button>
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
                    <h4 class="modal-title" id="myModalLabel">修改市场活动</h4>
                </div>
                <div class="modal-body">

                    <form class="form-horizontal" role="form">
                        <input id="id" name="id" type="hidden">
                        <div class="form-group">
                            <label for="edit-marketActivityOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" id="edit-marketActivityOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label for="edit-marketActivityName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-marketActivityName" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-startTime" class="col-sm-2 control-label">开始日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-startTime" >
                            </div>
                            <label for="edit-endTime" class="col-sm-2 control-label">结束日期</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-endTime" >
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-cost" class="col-sm-2 control-label">成本</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" id="edit-cost" >
                            </div>
                        </div>

                            <%--创建者--%>
                            <input type="hidden" name="createBy" id="createBy1"><input type="hidden" name="createByDate" id="createByDate1">

                            <%--修改者--%>
                            <input type="hidden" name="editBy" id="editBy1"><input type="hidden" name="editByDate" id="editByDate1">



                        <div class="form-group">
                            <label for="edit-describe" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" rows="3" id="edit-describe">

                                </textarea>
                            </div>
                        </div>

                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="update" data-dismiss="modal">更新</button>
                </div>
            </div>
        </div>
    </div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" id="div" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3 id="b1"><small id="startDateAndendDate"></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#editActivityModal"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteActivity"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="owner"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="name"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>

		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">开始日期</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="startDate"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">结束日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="endDate"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">成本</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="cost"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy"></b><small style="font-size: 10px; color: gray;" id="createByDate"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy"></b><small style="font-size: 10px; color: gray;" id="editByDate"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="description">

				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 30px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">--%>
			<%--<img title="zhangsan" src="<%=basePath%>/image/user-thumbnail.png" style="width: 30px; height:30px;">--%>
			<%--<div style="position: relative; top: -40px; left: 40px;" >--%>
				<%--<h5>哎呦！</h5>--%>
				<%--<font color="gray">市场活动</font> <font color="gray">-</font> <b>发传单</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>--%>
				<%--<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
					<%--&nbsp;&nbsp;&nbsp;&nbsp;--%>
					<%--<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>--%>
				<%--</div>--%>
			<%--</div>--%>
		<%--</div>--%>

		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" id="save" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>

<script>
    //查询市场活动和备注
    $(function () {
       $.ajax({
           url:"<%=basePath%>/workbench/activity/detailActivity",
           data:{
               'id':'${requestScope.id}'
           },
           type:"post",
           dataType:"json",
           success:function (data) {
            $("#owner").text(data.owner);
            $("#name").text(data.name);
            $("#b1").text(data.name);
            $("#startDate").text(data.startDate);
            $("#endDate").text(data.endDate);
            $("#cost").text(data.cost);
            $("#createBy").text(data.createBy);
            $("#editBy").text(data.editBy);
            $("#description").text(data.description);
            $("#createByDate").text(data.createTime);
            $("#editByDate").text(data.editTime);
            $("#startDateAndendDate").text(data.startDate+" ~ "+data.endDate);

               var  activityRemarks = data.activityRemarks;
               selectRemark(activityRemarks);

           }
       });
    });
    //修改的查询下拉框
    $(function () {
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
        $.ajax({
            url:"<%=basePath%>/workbench/activity/editActivity" ,
            data:{
                'id': '${requestScope.id}'
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
                $("#createBy1").val(data.createBy);
                $("#createByDate1").val(data.createTime);
                $("#editBy1").val(data.editBy);
                $("#editByDate1").val(data.editTime);
                //将所有者显示当前对应的所有者
                $("#edit-marketActivityOwner").val(data.owner);
            }
        });
    });


    $("#update").click(function () {
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
                'id':$("#id").val(),
                'createBy':$("#createBy1").val(),
                'createTime':$("#createByDate1").val(),
                'editBy':$("#editBy1").val(),
                'editTime':$("#editByDate1").val()
            },
            // $("#editActivityForm").serialize()//可以使用这种方式要设置name值
            dataType:"json",
            success:function (data) {
                if (data.ok){
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //刷新当前页面
                    location.reload();
                } else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        });
    });
    //点击返回的时候如果修改了刷新页面
    // $("#div").click(function () {
    //     //刷新上一级页面
    //     window.opener.location.reload();
    // });

    //删除
    $("#deleteActivity").click(function () {
        layer.confirm('确定要删除这条记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
        $.ajax({
            url:"<%=basePath%>/workbench/activity/deleteActivity",
            data:{
            'id':'${requestScope.id}'
            },
            type:"get",
            dataType:"json",
            success:function (data) {
                if (data.ok){
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //刷新上一级页面
                    window.opener.location.reload();
                }else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        });
    });
    });


    //添加备注信息
    $("#save").click(function () {
        if ($("#remark").val() == ""){
            layer.alert("添加备注信息不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });

        } else {
            $.ajax({
                url:"<%=basePath%>/workbench/activity/addRemark",
                data:{
                    'noteContent':$("#remark").val(),
                    'activityId':'${requestScope.id}'
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        $("#remark").val("");
                        //刷新当前页面
                        var activityRemark  = data.t;
                        var activityRemarks = [] ;
                        activityRemarks[0] = activityRemark;
                        selectRemark(activityRemarks);

                    }else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })
        }

    });




    //修改备注信息
    function openEditModal(noteContent,id) {
        //打开模态框
        $("#editRemarkModal").modal("show");

        $("#noteContent").val(noteContent);
        //把id给隐藏域
        $("#remarkId").val(id);

    }

    $("#updateRemarkBtn").click(function () {
            if ($("#noteContent").val() == ""){
                layer.alert("修改的备注不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            } else {
                $.ajax({
                    url:"<%=basePath%>/workbench/activity/updateRemark",
                    data:{
                        'id':$("#remarkId").val(),
                        'noteContent':$("#noteContent").val()
                    },
                    type:"post",
                    dataType:"json",
                    success:function (data) {
                        if (data.ok) {
                            layer.alert(data.message, {
                                icon: 6,
                                skin: 'layer-ext-demo'
                            });
                            //关闭模态框
                            $("#editRemarkModal").modal("hide");
                            //刷新备注列表
                            $('#h5'+ $('#remarkId').val()).text($('#noteContent').val());

                        }else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }

                });
            }
    });

    //删除
    function deleteRemark(id) {
        layer.confirm('确定要删除这条记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
           $.ajax({
               url:"<%=basePath%>/workbench/activity/deleteRemark",
               data:{
                   'id':id
               },
               type:"post",
               dataType:"json",
               success:function (data) {
                   if (data.ok) {
                       layer.alert(data.message, {
                           icon: 6,
                           skin: 'layer-ext-demo'
                       });
                       //刷新当前页面
                       $("#h5"+id).parent().parent().remove();
                   }else {
                       layer.alert(data.message, {
                           icon: 5,
                           skin: 'layer-ext-demo'
                       });
                   }
               }
           })
        });
    }


function selectRemark(activityRemarks) {
    for (var i = 0; i < activityRemarks.length; i++){
        var activityRemark =activityRemarks[i];
        $("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
            "\t\t\t<img title=\"zhangsan\" src=\""+activityRemark.img+"\" style=\"width: 30px; height:30px;\">\n" +
            "\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
            "\t\t\t\t<h5 id ='h5"+activityRemark.id+"'>"+activityRemark.noteContent+"</h5>\n" +
            "\t\t\t\t<font color=\"gray\">市场活动</font> <font color=\"gray\">-</font> <b>"+activityRemark.activityId+"</b> <small style=\"color: gray;\"> "+activityRemark.createTime+" 由"+activityRemark.createBy+"</small>\n" +
            "\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
            "\t\t\t\t\t<a class=\"myHref\" onclick=\"openEditModal('"+activityRemark.noteContent+"','"+activityRemark.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
            "\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
            "\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteRemark('"+activityRemark.id+"') \" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
            "\t\t\t\t</div>\n" +
            "\t\t\t</div>\n" +
            "\t\t</div>")
    }

    $(".remarkDiv").mouseover(function(){
        $(this).children("div").children("div").show();
    });

    $(".remarkDiv").mouseout(function(){
        $(this).children("div").children("div").hide();
    });

    $(".myHref").mouseover(function(){
        $(this).children("span").css("color","red");
    });

    $(".myHref").mouseout(function(){
        $(this).children("span").css("color","#E6E6E6");
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




</script>