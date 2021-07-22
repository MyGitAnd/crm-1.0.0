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
	
	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3 id="h3"></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="updateVisit"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteVisit"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">主题</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b1"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">到期日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b2"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">联系人</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b3"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">回访状态</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b4"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">回访优先级</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b5"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">任务所有者</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b6"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">提醒时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b7"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b8"></b><small style="font-size: 10px; color: gray;" id="b9"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b10"></b><small style="font-size: 10px; color: gray;" id="b11"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b12"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>


    <!-- 修改备注的模态窗口 -->
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
                            <label for="edit-describe" id="edit-describe" class="col-sm-2 control-label">内容</label>
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


	
	<!-- 备注 -->
	<div style="position: relative; top: -20px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="<%=basePath%>/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>呵呵！</h5>
				<font color="gray">任务</font> <font color="gray">-</font> <b>拜访客户</b> <small style="color: gray;"> 2017-01-22 10:10:10 星期二由zhangsan</small>
				<div style="position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;">
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-edit" style="font-size: 20px; color: #E6E6E6;"></span></a>
					&nbsp;&nbsp;&nbsp;&nbsp;
					<a class="myHref" href="javascript:void(0);"><span class="glyphicon glyphicon-remove" style="font-size: 20px; color: #E6E6E6;"></span></a>
				</div>
			</div>
		</div>--%>

		
		<div id="remarkDiv" style="background-color: #E6E6E6; width: 870px; height: 90px;">
			<form role="form" style="position: relative;top: 10px; left: 10px;">
				<textarea id="remark" class="form-control" style="width: 850px; resize : none;" rows="2"  placeholder="添加备注..."></textarea>
				<p id="cancelAndSaveBtn" style="position: relative;left: 737px; top: 10px; display: none;">
					<button id="cancelBtn" type="button" class="btn btn-default">取消</button>
					<button type="button" id="saveRemark" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	<div style="height: 200px;"></div>
</body>
</html>
<script>

    //查询详情页信息
    $.ajax({
        url:"<%=basePath%>/workbench/visit/selectVisitAndRemark",
        data:{
            'id':'${requestScope.id}'
        },
        dataType:"json",
        type:"post",
        success:function (data) {
            $("#h3").text(data.subject);
            $("#b1").text(data.subject);
            $("#b2").text(data.expiryDate);
            $("#b3").text(data.contactsId);
            $("#b4").text(data.returnState);
            $("#b5").text(data.returnPriority);
            $("#b6").text(data.owner);
            $("#b7").text(data.startTime+"("+data.repeatType+"发"+data.noticeType+")");
            $("#b8").text(data.createBy);
            $("#b9").text(data.createTime);
            $("#b10").text(data.editBy);
            $("#b11").text(data.editTime);
            $("#b12").text(data.description);

            var visitRemarks = data.visitRemarks;
            selectRemark(visitRemarks);
        }
    });

    //编辑
    $("#updateVisit").click(function () {

        window.location.href='<%=basePath%>/toView/workbench/visit/editTask?id='+'${requestScope.id}';
    });

    //删除
    $("#deleteVisit").click(function () {
        layer.confirm('确定要删除记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
         $.ajax({
             url:"<%=basePath%>/workbench/visit/deleteVisitAndRemark",
             data:{
                 'id':'${requestScope.id}'
             },
             type:"get",
             dataType:"json",
             success:function (data) {
                 if (data.ok) {
                     layer.alert(data.message, {
                         icon: 6,
                         skin: 'layer-ext-demo'
                     });
                 }else {
                     layer.alert(data.message, {
                         icon: 5,
                         skin: 'layer-ext-demo'
                     });
                 }
             }
         });

        })
    });


    //添加备注
    $("#saveRemark").click(function () {

        $.ajax({
            url:"<%=basePath%>/workbench/visitRemark/addVisitRemark",
            data:{
                'noteContent':$("#remark").val(),
                'visitId':'${requestScope.id}'
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                if (data.ok) {
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //刷新页面
                    $("#remark").val("");
                    var visitRemark = data.t;
                    var visitRemarks = [];
                    visitRemarks[0] = visitRemark;
                    selectRemark(visitRemarks);
                }else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        })
    });

    //修改备注
function updateVisitRemark(noteContent,id) {
    $("#editRemarkModal").modal("show");

    $("#noteContent").val(noteContent);

    $("#remarkId").val(id);

}

$("#updateRemarkBtn").click(function () {

    $.ajax({
        url:"<%=basePath%>/workbench/visitRemark/updateVisitRemark",
        data:{
            'noteContent':$("#noteContent").val(),
            'id':$("#remarkId").val()
        },
        type:"get",
        dataType:"json",
        success:function (data) {
            if (data.ok) {
                layer.alert(data.message, {
                    icon: 6,
                    skin: 'layer-ext-demo'
                });
                //关闭模态框
                $("#editRemarkModal").modal("hide");
                //刷新页面
                $('#h5' + $('#remarkId').val()).text($('#noteContent').val());
            }else {
                layer.alert(data.message, {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            }
        }
    })
});

//删除备注
    function deleteVisitRemark(id) {
        layer.confirm('确定要删除这条记录吗？', {
            btn: ['确定', '取消']
            // 按钮
        }, function () {
            $.ajax({
                url:"<%=basePath%>/workbench/visitRemark/deleteVisitRemark",
                data:{
                    'id':id
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //刷新页面
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

    //查询备注的方法
    function selectRemark(visitRemarks) {
        for (var i = 0;i < visitRemarks.length;i++ ) {
            var visitRemark = visitRemarks[i];
            $("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
                "\t\t\t<img title=\"zhangsan\" src='"+visitRemark.img+"' style=\"width: 30px; height:30px;\">\n" +
                "\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
                "\t\t\t\t<h5 id ='h5" + visitRemark.id + "'>"+visitRemark.noteContent+"</h5>\n" +
                "\t\t\t\t<font color=\"gray\">任务</font> <font color=\"gray\">-</font> <b>"+visitRemark.visitId+"</b> <small style=\"color: gray;\">"+visitRemark.createTime+" 由"+visitRemark.createBy+"</small>\n" +
                "\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                "\t\t\t\t\t<a class=\"myHref\" onclick=\"updateVisitRemark('"+visitRemark.noteContent+"','"+visitRemark.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                "\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                "\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteVisitRemark('"+visitRemark.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                "\t\t\t\t</div>\n" +
                "\t\t\t</div>\n" +
                "\t\t</div>");
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

</script>