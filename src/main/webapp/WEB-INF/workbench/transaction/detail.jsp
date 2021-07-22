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

<style type="text/css">
.mystage{
	font-size: 20px;
	vertical-align: middle;
	cursor: pointer;
}
.closingDate{
	font-size : 15px;
	cursor: pointer;
	vertical-align: middle;
}
</style>
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
		

		
		//阶段提示框
		$(".mystage").popover({
            trigger:'manual',
            placement : 'bottom',
            html: 'true',
            animation: false
        }).on("mouseenter", function () {
                    var _this = this;
                    $(this).popover("show");
                    $(this).siblings(".popover").on("mouseleave", function () {
                        $(_this).popover('hide');
                    });
                }).on("mouseleave", function () {
                    var _this = this;
                    setTimeout(function () {
                        if (!$(".popover:hover").length) {
                            $(_this).popover("hide")
                        }
                    }, 100);
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
			<h3 id="h3"><small id="small"></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 250px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="update"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" id="deleteTran" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>

	<!-- 阶段状态 -->
	<div id="stageDiv" style="position: relative; left: 40px; top: -50px;">
		<%--阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--%>
		<%--<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="资质审查" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="需求分析" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="价值建议" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-ok-circle mystage" data-toggle="popover" data-placement="bottom" data-content="确定决策者" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-map-marker mystage" data-toggle="popover" data-placement="bottom" data-content="提案/报价" style="color: #90F790;"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="谈判/复审"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="成交"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="丢失的线索"></span>
		-----------
		<span class="glyphicon glyphicon-record mystage" data-toggle="popover" data-placement="bottom" data-content="因竞争丢失关闭"></span>
		-----------
		<span class="closingDate">2010-10-10</span>--%>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: 0px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b1"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">金额</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b2"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b3"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">预计成交日期</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b4"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b5"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">阶段</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b6"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">类型</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b7"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">可能性</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b8"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b9"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">市场活动源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b10"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">联系人名称</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b11"></b></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b12">&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="b13"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b14">&nbsp;&nbsp;</b><small style="font-size: 10px; color: gray;" id="b15"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="b16">

				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 90px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="b17">
					&nbsp;
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 100px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b18">&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
	</div>
	
	<!-- 备注 -->
	<div style="position: relative; top: 100px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="<%=basePath%>/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">交易</font> <font color="gray">-</font> <b>动力节点-交易01</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
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


	
	<!-- 阶段历史 -->
	<div>
		<div style="position: relative; top: 100px; left: 40px;">
			<div class="page-header">
				<h4>阶段历史</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>阶段</td>
							<td>金额</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>创建时间</td>
							<td>创建人</td>
						</tr>
					</thead>
					<tbody id="tranHistory">
						<%--<tr>
							<td>资质审查</td>
							<td>5,000</td>
							<td>10</td>
							<td>2017-02-07</td>
							<td>2016-10-10 10:10:10</td>
							<td>zhangsan</td>
						</tr>--%>


					</tbody>
				</table>
			</div>
			
		</div>
	</div>
	
	<div style="height: 200px;"></div>
	
</body>
</html>

<script>
    //修改
    $("#update").click(function () {
            window.location.href='<%=basePath%>/toView/workbench/transaction/edit?id='+'${requestScope.id}';
    });

    $("#deleteTran").click(function () {
        layer.confirm('确定要删除记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
            $.ajax({
                url:"<%=basePath%>/workbench/Tran/deleteTran",
                data:{
                    'id':'${requestScope.id}'
                },
                dataType:"json",
                type:"get",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            });
        });
    });

    //查询的方法
    $.ajax({
        url:"<%=basePath%>/workbench/tran/queryTransaction",
        data:{
            'id':'${requestScope.id}'
        },
        type:"post",
        dataType:"json",
        success:function (data) {
            $("#h3").text(data.name)
                .append('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;'+"金额:￥"+data.money);
            $("#b1").text(data.owner);
            $("#b2").text(data.money);
            $("#b3").text(data.name);
            $("#b4").text(data.expectedDate);
            $("#b5").text(data.customerId);
            $("#b6").text(data.stage);
            $("#b7").text(data.type);
            $("#b8").text(data.possibility);
            $("#b9").text(data.source);
            $("#b10").text(data.activityId);
            $("#b11").text(data.contactsId);
            $("#b12").text(data.createBy);
            $("#b13").text(data.createTime);
            $("#b14").text(data.editBy);
            $("#b15").text(data.editTime);
            $("#b16").text(data.description);
            $("#b17").text(data.contactSummary);
            $("#b18").text(data.nextContactTime);

            //查询备注
            var tranRemarks = data.transactionRemarks;
            selectRemark(tranRemarks);

            var tranHistorys = data.transactionHistories;
            $("#tranHistory").html("");
            for (var i = 0; i < tranHistorys.length; i++) {
                var tranHistory = tranHistorys[i];
                //查询阶段历史
                $("#tranHistory").append("<tr>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.stage+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.money+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.possibility+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.expectedDate+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.createTime+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+tranHistory.createBy+"</td>\n" +
                    "\t\t\t\t\t\t</tr>")
            }
        }
    });

    //转换交易状态
    //查询当前交易图表
    $.ajax({
        url:"<%=basePath%>/workbench/tranHistory/queryStages",
        data:{
            'id':'${requestScope.id}'
        },
        type:"get",
        dataType:"json",
        success:function (data) {
            refresh(data.tranStageIcons)
        }
    });

    $("#stageDiv").on("click",".mystage",function () {

        $.ajax({
            url:"<%=basePath%>/workbench/tranHistory/queryStages",
            data:{
                'id':'${requestScope.id}',
                'index':$(this).attr("index")
            },
            dataType:"json",
            type:"post",
            success:function (data) {
                refresh(data.tranStageIcons);

                //修改页面的阶段和可能性
                $("#b6").text(data.transaction.stage);
                $("#b8").text(data.transaction.possibility);


                var tranHistory = data.transactionHistory;
                    //查询阶段历史
                    $("#tranHistory").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.stage + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.money + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.possibility + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.expectedDate + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.createTime + "</td>\n" +
                        "\t\t\t\t\t\t\t<td>" + tranHistory.createBy + "</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
        })
    });


    //刷新的方法
    function refresh(data) {
        $("#stageDiv").html("");
        $("#stageDiv").append("阶段&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");
        for (var i = 0; i < data.length;i++){
            var stage = data[i];
            if (stage.type == "绿圈"){
                $("#stageDiv").append("<span class=\"glyphicon glyphicon-ok-circle mystage\" " +
                    "data-toggle=\"popover\" index="+stage.index+"  data-placement=\"bottom\" " +
                    "data-content=\""+stage.title+"\" style=\"color: #90F790;\"></span>");
            } else if (stage.type == "锚点") {
                $("#stageDiv").append("<span class=\"glyphicon glyphicon-map-marker mystage\" " +
                    "data-toggle=\"popover\"" + " index="+stage.index+" data-placement=\"bottom\" " +
                    "data-content=\""+stage.title+"\" style=\"color: #90F790;\"></span>");

            } else if (stage.type == "黑圈"){
                $("#stageDiv").append("<span class=\"glyphicon glyphicon-record mystage\" " +
                    "data-toggle=\"popover\" " +
                    "data-placement=\"bottom\" index="+stage.index+" data-content=\""+stage.title+"\"></span>");

            } else if (stage.type == "黑X"){
                $("#stageDiv").append("<span class=\"glyphicon glyphicon-remove mystage\" " +
                    "data-toggle=\"popover\" " +
                    "data-placement=\"bottom\" index="+stage.index+" data-content=\""+stage.title+"\"></span>");

            } else if (stage.type == "红X"){
                $("#stageDiv").append("<span class=\"glyphicon glyphicon-remove mystage\" " +
                    "data-toggle=\"popover\" " +
                    "data-placement=\"bottom\" style='color: red;' index="+stage.index+" data-content=\""+stage.title+"\"></span>");

            }
        $("#stageDiv").append("-----------");
        }
        $("#stageDiv").append(new Date().toLocaleDateString());
    }





    //添加备注
    $("#saveRemark").click(function () {
       $.ajax({
           url:"<%=basePath%>/workbench/tranRemark/addRemark",
           data:{
               'noteContent':$("#remark").val(),
               'tranId':'${requestScope.id}'
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
                  var tranRemark = data.t;
                  var tranRemarks = [];
                   tranRemarks[0] = tranRemark;
                   selectRemark(tranRemarks);
               }else {
                   layer.alert(data.message, {
                       icon: 5,
                       skin: 'layer-ext-demo'
                   });
               }

           }
       });
    });

    //修改备注
        function updateTranRemark(noteContent,id) {
            $("#editRemarkModal").modal("show");
            //输入的内容
            $("#noteContent").val(noteContent);
            //把id给隐藏域
            $("#remarkId").val(id);
        }

        $("#updateRemarkBtn").click(function () {
           $.ajax({
               url:"<%=basePath%>/workbench/tranRemark/editRemark",
               data:{
                   'noteContent':$("#noteContent").val(),
                   'id':$("#remarkId").val()
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
    function deleteTranRemark(id) {
        layer.confirm('确定要删除这条记录吗？', {
            btn: ['确定', '取消']
            // 按钮
        }, function () {

            $.ajax({
                url:"<%=basePath%>/workbench/tranRemark/deleteRemark",
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

        })
    }







    //查询备注信息的方法
    function selectRemark(tranRemarks) {
        for (var i = 0;i < tranRemarks.length;i++ ){
            var tranRemark = tranRemarks[i];
            $("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
                "\t\t\t<img title=\"zhangsan\" src='"+tranRemark.img+"' style=\"width: 30px; height:30px;\">\n" +
                "\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
                "\t\t\t\t<h5 id ='h5" + tranRemark.id + "'>"+tranRemark.noteContent+"</h5>\n" +
                "\t\t\t\t<font color=\"gray\">交易</font> <font color=\"gray\">-</font> <b>"+tranRemark.tranId+"</b> <small style=\"color: gray;\"> "+tranRemark.createTime+" 由"+tranRemark.createBy+"</small>\n" +
                "\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                "\t\t\t\t\t<a class=\"myHref\" onclick=\"updateTranRemark('"+tranRemark.noteContent+"','"+tranRemark.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                "\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                "\t\t\t\t\t<a class=\"myHref\" onclick=\"deleteTranRemark('"+tranRemark.id+"')\" href=\"javascript:void(0);\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
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

//校验非空
//     function notnull() {
//         onclick="notnull()"
//         var remark = document.getElementById("remark");   //通过id名 找到 元素并重新 赋值
//         if(remark =="" || "null")                //判断条件
//         {
//             alert("输入的不能为空");           //输出不满足条件的提示内容
//             return false;
//         }
//         else {
//             return true;       //满足条件时将执行表单的action
//         }
//     }





</script>