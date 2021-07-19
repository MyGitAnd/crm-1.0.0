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
<%--联系人的发传单页面--%>
<link href="<%=basePath%>/jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet"/>
<link href="<%=basePath%>/jquery/bootstrap-datetimepicker-master/css/bootstrap-datetimepicker.min.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="<%=basePath%>/jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bootstrap-datetimepicker-master/locale/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/en.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_pagination/jquery.bs_pagination.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/layui/layui.js"></script>
<script type="text/javascript" src="<%=basePath%>/jquery/bs_typeahead/bootstrap3-typeahead.min.js"></script>
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

	<!-- 解除联系人和市场活动关联的模态窗口 -->
	<div class="modal fade" id="unbundActivityModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">解除关联</h4>
				</div>
				<div class="modal-body">
					<p>您确定要解除该关联关系吗？</p>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" data-dismiss="modal">解除</button>
				</div>
			</div>
		</div>
	</div>


	
	<!-- 联系人和市场活动关联的模态窗口 -->
    <div class="modal fade" id="bundActivityModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 80%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">关联市场活动</h4>
                </div>
                <div class="modal-body">
                    <div class="btn-group" style="position: relative; top: 18%; left: 8px;">
                        <%--<div class="form-group has-feedback ">--%>
                        <%--<input type="text" id="name" class="form-control" style="width: 300px;"--%>
                        <%--placeholder="请输入市场活动名称，支持模糊查询">--%>
                        <%--<input type="button" id="likeClue" class="btn btn-default" value="查询">--%>
                        <%--<span class="glyphicon glyphicon-search form-control-feedback"></span>--%>
                        <%--</div>--%>


                        <div class="input-group">
                            <input class="form-control width100" id="name" placeholder="请输入市场活动名称，支持模糊查询">
                            <span class="input-group-btn">
                        <button class="btn btn-info" id="likeClue">搜索</button>
                    </span>
                        </div>

                    </div>
                    <table id="activityTable1" class="table table-hover" style="width: 900px; position: relative;top: 10px;">
                        <thead>
                        <tr style="color: #B3B3B3;">
                            <td><input type="checkbox" id="father"/></td>
                            <td>名称</td>
                            <td>开始日期</td>
                            <td>结束日期</td>
                            <td>所有者</td>
                            <td></td>
                        </tr>
                        </thead>
                        <tbody id="ClueActivity">

                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="addClueActivity" data-dismiss="modal">关联</button>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 修改联系人的模态窗口 -->
    <div class="modal fade" id="editContactsModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel1">修改联系人</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="ContactsFromUpdate" role="form">
                        <input id="id" type="hidden" name="id">
                        <div class="form-group">
                            <label for="edit-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="edit-contactsOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label for="edit-clueSource1" class="col-sm-2 control-label">来源</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="source" id="edit-clueSource1">
                                    <c:forEach items="${applicationScope.dics['source']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="fullname" id="edit-surname">
                            </div>
                            <label for="edit-call" class="col-sm-2 control-label">称呼</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="appellation" id="edit-call">
                                    <c:forEach items="${applicationScope.dics['appellation']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-job" class="col-sm-2 control-label">职位</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="job" id="edit-job">
                            </div>
                            <label for="edit-mphone" class="col-sm-2 control-label">手机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="mphone" id="edit-mphone">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="email" id="edit-email">
                            </div>
                            <label for="edit-birth" class="col-sm-2 control-label">生日</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="birth" id="edit-birth">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="edit-customerName" class="col-sm-2 control-label">客户名称</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="customerId" id="edit-customerName" placeholder="支持自动补全，输入客户不存在则新建">
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
                                <label for="edit-address2" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="1" name="address" id="edit-address2"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateContacts" data-dismiss="modal">更新</button>
                </div>
            </div>
        </div>
    </div>

	<!-- 返回按钮 -->
	<div style="position: relative; top: 35px; left: 10px;">
		<a href="javascript:void(0);" onclick="window.history.back();"><span class="glyphicon glyphicon-arrow-left" style="font-size: 20px; color: #DDDDDD"></span></a>
	</div>
	
	<!-- 大标题 -->
	<div style="position: relative; left: 40px; top: -30px;">
		<div class="page-header">
			<h3 id="h3"><small id="small"></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" data-toggle="modal" id="selectContacts"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteContacts"><span class="glyphicon glyphicon-minus"></span> 删除</button>
		</div>
	</div>
	
	<!-- 详细信息 -->
	<div style="position: relative; top: -70px;">
		<div style="position: relative; left: 40px; height: 30px;">
			<div style="width: 300px; color: gray;">所有者</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b1"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">来源</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b2"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 10px;">
			<div style="width: 300px; color: gray;">客户名称</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b3"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">姓名</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b4"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">邮箱</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b5"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">手机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b6"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">职位</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b7"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">生日</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="b8">&nbsp;</b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 40px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b9"></b><small style="font-size: 10px; color: gray;" id="b10"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 50px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="b11"></b><small style="font-size: 10px; color: gray;" id="b12"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="b13">
				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 70px;">
			<div style="width: 300px; color: gray;">联系纪要</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="b14">

				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 80px;">
			<div style="width: 300px; color: gray;">下次联系时间</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="b15"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 90px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="b16">

                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>
	<!-- 备注 -->
	<div style="position: relative; top: 20px; left: 40px;">
		<div class="page-header">
			<h4>备注</h4>
		</div>
		
		<!-- 备注1 -->
		<%--<div class="remarkDiv" style="height: 60px;">
			<img title="zhangsan" src="<%=basePath%>/image/user-thumbnail.png" style="width: 30px; height:30px;">
			<div style="position: relative; top: -40px; left: 40px;" >
				<h5>哎呦！</h5>
				<font color="gray">联系人</font> <font color="gray">-</font> <b>李四先生-北京动力节点</b> <small style="color: gray;"> 2017-01-22 10:10:10 由zhangsan</small>
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
					<button type="button" id="addRemark" class="btn btn-primary">保存</button>
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
                    <h4 class="modal-title" id="myModalLabel">修改备注</h4>
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

	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable3" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>金额</td>
							<td>阶段</td>
							<td>可能性</td>
							<td>预计成交日期</td>
							<td>类型</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="tbody">
						<%--<tr>
							<td><a href="<%=basePath%>/transaction/detail.jsp" style="text-decoration: none;">动力节点-交易01</a></td>
							<td>5,000</td>
							<td>谈判/复审</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>新业务</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="<%=basePath%>/toView/workbench/transaction/save" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	
	<!-- 市场活动 -->
	<div>
		<div style="position: relative; top: 60px; left: 40px;">
			<div class="page-header">
				<h4>市场活动</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>开始日期</td>
							<td>结束日期</td>
							<td>所有者</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="clueTbody">
						<%--<tr>
							<td><a href="<%=basePath%>/activity/detail.jsp" style="text-decoration: none;">发传单</a></td>
							<td>2020-10-10</td>
							<td>2020-10-20</td>
							<td>zhangsan</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#unbundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>解除关联</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" data-toggle="modal" data-target="#bundActivityModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>关联市场活动</a>
			</div>
		</div>
	</div>
	
	
	<div style="height: 200px;"></div>
</body>
</html>

<script>
    //查询信息
   $.ajax({
       url:"<%=basePath%>/workbench/Contacts/selectContactsAndRemark",
       data:{
           'id':'${requestScope.id}'
       },
       type:"post",
       dataType:"json",
       success:function (data) {
           $("#b1").text(data.owner);
           $("#b2").text(data.source);
           $("#b3").text(data.customerId);
           $("#b4").text(data.fullname+data.appellation);
           $("#b5").text(data.email);
           $("#b6").text(data.mphone);
           $("#b7").text(data.job);
           $("#b8").text(data.birth);
           $("#b9").text(data.createBy);
           $("#b10").text(data.createTime);
           $("#b11").text(data.editBy);
           $("#b12").text(data.editTime);
           $("#b13").text(data.description);
           $("#b14").text(data.contactSummary);
           $("#b15").text(data.nextContactTime);
           $("#b16").text(data.address);
           $("#h3").text(data.customerId).append("--------------------"+data.fullname+data.appellation);
            //查询备注
           var contacts = data.contactsRemarks;
           selectContactsRemark(contacts);

           //查询交易
           refresh();

           //查看市场活动
           select()
       }
   });
   //修改的方法
    $("#selectContacts").click(function () {
        //正确的
        $("#editContactsModal").modal("show");
        $.ajax({
            url: "<%=basePath%>/workbench/Contacts/selectContactsToOne",
            data: {
                'id': '${requestScope.id}'
            },
            type: "get",
            dataType: "json",
            success: function (data) {
                $("#edit-contactsOwner").val(data.owner);
                $("#edit-clueSource1").val(data.source);
                $("#edit-surname").val(data.fullname);
                $("#edit-call").val(data.appellation);
                $("#edit-job").val(data.job);
                $("#edit-mphone").val(data.mphone);
                $("#edit-email").val(data.email);
                $("#edit-birth").val(data.birth);
                $("#edit-customerName").val(data.customerId);
                $("#edit-describe").val(data.description);
                $("#create-contactSummary").val(data.contactSummary);
                $("#create-nextContactTime").val(data.nextContactTime);
                $("#edit-address2").val(data.address);
                $("#id").val(data.id);



            }
        });
    });

    //真正修改的方法
    $("#updateContacts").click(function () {
        $.ajax({
            url:"<%=basePath%>/workbench/Contacts/addContactsAndUpdate",
            data:$("#ContactsFromUpdate").serialize(),
            type:"post",
            dataType:"json",
            success:function (data) {
                //添加成功清空表单数据
                $('#createContactsModal').on('hidden.bs.modal', function (){
                    document.getElementById("ContactsFrom").reset();
                });
                if (data.ok){
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //添加成功刷新当前页面
                    location.reload();
                } else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }
            }
        })
    });

    //添加备注的方法
    $("#addRemark").click(function () {

        $.ajax({
            url:"<%=basePath%>/workbench/contactsRemark/addRemark",
            data:{
               'noteContent':$("#remark").val(),
                'contactsId':'${requestScope.id}'
            },
            dataType:"json",
            type:"post",
            success:function (data) {
                if (data.ok){
                    layer.alert(data.message, {
                        icon: 6,
                        skin: 'layer-ext-demo'
                    });
                    //添加成功刷新当前页面
                    $("#remark").val("");
                    //刷新页面
                    var contacts = data.t;
                    var contact = [];
                    contact[0] = contacts;
                    selectContactsRemark(contact)
                } else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }

            }
        })
    });

    //修改备注
    function openEditModal(noteContent,id){

        $("#editRemarkModal").modal("show");
        //给隐藏域添加id
        $("#remarkId").val(id);
        //内容
        $("#noteContent").val(noteContent);
    }

    //修改备注信息
    $("#updateRemarkBtn").click(function () {

            $.ajax({
                url:"<%=basePath%>/workbench/contactsRemark/addRemark",
                data:{
                    'noteContent':$("#noteContent").val(),
                    'contactsId':'${requestScope.id}',
                    'id':$("#remarkId").val()
                },
                dataType:"json",
                type:"post",
                success:function (data) {
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //修改成功刷新当前页面
                        //关闭模态框
                        $("#editRemarkModal").modal("hide");
                        //刷新页面
                        $('#h5' + $('#remarkId').val()).text($('#noteContent').val());
                    } else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })

    });
    //删除的方法
    function openDeleteModal(id){
        layer.confirm('确定要删除这条记录吗？', {
            btn: ['确定', '取消']
            // 按钮
        }, function () {
           $.ajax({
               url:"<%=basePath%>/workbench/contactsRemark/deleteRemark",
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
                       $("#h5" + id).parent().parent().remove();
               }else {
                       layer.alert(data.message, {
                           icon: 5,
                           skin: 'layer-ext-demo'
                       });
                   }
               }
           });

        });
    }




    //删除的方法
    $("#deleteContacts").click(function () {
        layer.confirm('确定要删除这条记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
           $.ajax({
               url:"<%=basePath%>/workbench/customer/deleteContactsById",
               data:{
                   'id':'${requestScope.id}'
               },
               type:"post",
               dataType:"json",
               success:function (data) {
                   if (data.ok) {
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
           })
        });
    });


    //查询交易
    function refresh(){
        $.ajax({
            url:"<%=basePath%>/workbench/contacts/selectTranlist",
            type:"get",
            dataType:"json",
            data:{},
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $("#tbody").html("");
                for (var i = 0; i < data.length; i++) {
                    var transaction = data[i];
                    $("#tbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/transaction/detail?id="+transaction.id+"';\" style=\"text-decoration: none;\">"+transaction.name+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.money+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.stage+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.possibility+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.createTime+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.type+"</td>\n" +
                        "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"deleteTran('"+transaction.id+"')\" data-toggle=\"modal\" data-target=\"#unbundModal\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
            }
        });
    }


  function deleteTran(id){
      layer.confirm('确定要删除这一条记录吗？', {
          btn : ['确定', '取消']
          // 按钮
      }, function() {
          $.ajax({
              url:"<%=basePath%>/workbench/ContactsTran/deleteTran",
              data:{
                  'id':id
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
                      refresh();
                  }
              }
          })
        })
  }


  //关联市场活动
    //查询关联的市场活动
    function select(){
        $("#clueTbody").text("");
        $.ajax({
            url: "<%=basePath%>/workbench/ContactsActivity/selectActivity",
            type: "post",
            data: {
                'id': '${requestScope.id}'
            },
            dataType: "json",

            success: function (data) {
            for (var i = 0; i < data.length; i++) {
                $("#clueTbody").append(" <tr>\n" +
                    "                    <td><a href=\"javascript:void(0);\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/activity/detail?id="+data[i].id+"';\" style=\"text-decoration: none;\">" + data[i].name + "</td>\n" +
                    "                    <td>" + data[i].startDate + "</td>\n" +
                    "                    <td>" + data[i].endDate + "</td>\n" +
                    "                    <td>" + data[i].owner + "</td>\n" +
                    "                    <td><a href=\"javascript:void(0);\" onclick=\"deleteClueActivity('" + data[i].id + "')\" style=\"text-decoration: none;\"><span\n" +
                    "                           class=\"glyphicon glyphicon-remove\"></span>解除关联</a></td>\n" +
                    "                </tr>")
            }
        }
    });
    }
    //关联市场活动信息
        $("#likeClue").click(function () {
            $.ajax({
                url: "<%=basePath%>/workbench/ContactsActivity/selectContactsActivity",
                data: {
                    'id': '${requestScope.id}',
                    'name': $("#name").val()
                },
                type: "post",
                dataType: "json",
                success: function (data) {
                    refresh1(data)
                }
            })
        });
        $("#name").keypress(function (ele) {
            if (ele.keyCode == 13) {
                $.ajax({
                    url: "<%=basePath%>/workbench/ContactsActivity/selectContactsActivity",
                    data: {
                        'id': '${requestScope.id}',
                        'name': $("#name").val()
                    },
                    type: "post",
                    dataType: "json",
                    success: function (data) {
                        refresh1(data)
                    }
                })
            }
        });


    function refresh1(data) {
        $("#ClueActivity").html("");
        for (var i = 0; i < data.length; i++) {
            $("#ClueActivity").append("<tr>\n" +
                "\t\t\t\t\t\t\t\t<td><input type=\"checkbox\" class='sun' value='" + data[i].id + "'/></td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].name + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].startDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].endDate + "</td>\n" +
                "\t\t\t\t\t\t\t\t<td>" + data[i].owner + "</td>\n" +
                "\t\t\t\t\t\t\t</tr>");
        }

    }

    //复选框
    $("#father").click(function () {
        $(".sun").prop("checked", $(this).prop("checked"));
    });

    function checkeds() {
        //获取sun的个数
        var length = $(".sun").length;
        //获取勾中的个数
        var checkedLength = $(".sun:checked").length;
        if (length == checkedLength) {
            $("#father").prop("checked", true);
        } else {
            $("#father").prop("checked", false);
        }

    }
    //关联市场活动
    $("#addClueActivity").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength == 0) {
            layer.alert("至少选择一个进行关联!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {

           var ids = [];
           $(".sun:checked").each(function () {
              ids.push($(this).val())
           });

           $.ajax({
               url:"<%=basePath%>/workbench/ContactsActivity/addContactsActivity",
               data:{
                   'contactsId':'${requestScope.id}',
                   'ids':ids.join()
               },
               dataType:"json",
               type:"get",
               success:function (data) {
                   if (data.ok) {
                       layer.alert(data.message, {
                           icon: 6,
                           skin: 'layer-ext-demo'
                       });
                       //刷新当前页面
                       select();
                   } else {
                       layer.alert(data.message, {
                           icon: 5,
                           skin: 'layer-ext-demo'
                       });
               }
               }
           });
        }
    });



    //解除关联
    function deleteClueActivity(id) {
        layer.confirm('确定要解除关联吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
            $.ajax({
                url:"<%=basePath%>/workbench/contactsActivity/deleteContactsActivity",
                data:{
                    'activityId':id,
                    'contactsId':'${requestScope.id}'
                },
                type:"get",
                dataType:"json",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //刷新当前页面
                        select();
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




    //刷新备注的方法
    function selectContactsRemark(contacts) {
        for (var i = 0;i < contacts.length;i++) {
            var contacts1 = contacts[i];
            $("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
                "\t\t\t<img title=\"zhangsan\" src=\""+contacts1.img+"\" style=\"width: 30px; height:30px;\">\n" +
                "\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
                "\t\t\t\t<h5 id ='h5"+contacts1.id+"'>"+contacts1.noteContent+"</h5>\n" +
                "\t\t\t\t<font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b>"+contacts1.contactsId+"</b> <small style=\"color: gray;\">"+contacts1.createTime+" 由"+contacts1.createBy+"</small>\n" +
                "\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                "\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\" onclick=\"openEditModal('"+contacts1.noteContent+"','"+contacts1.id+"')\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                "\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                "\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\" onclick=\"openDeleteModal('"+contacts1.id+"');\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
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



</script>