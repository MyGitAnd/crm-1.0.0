<%@ page import="com.bjpowernode.crm.workbench.base.Transaction" %>
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
<%--客户页面--%>
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

	<!-- 删除联系人的模态窗口 -->
	<div class="modal fade" id="removeContactsModal" role="dialog">
		<div class="modal-dialog" role="document" style="width: 30%;">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">
						<span aria-hidden="true">×</span>
					</button>
					<h4 class="modal-title">删除联系人</h4>
				</div>
				<div class="modal-body">
					<p>您确定要删除该联系人吗？</p>
				</div>
                <input id="Contactsid" name="id" type="hidden">
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" id="deleteContacts" data-dismiss="modal">删除</button>
				</div>
			</div>
		</div>
	</div>

    <!-- 删除交易的模态窗口 -->
    <div class="modal fade" id="removeTransactionModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 30%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title">删除交易</h4>
                </div>
                <div class="modal-body">
                    <p>您确定要删除该交易吗？</p>
                </div>
                <input id="Tranid" name="id" type="hidden">
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-danger" id="deleteTran" data-dismiss="modal">删除</button>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 创建联系人的模态窗口 -->
    <div class="modal fade" id="createContactsModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" onclick="$('#createContactsModal').modal('hide');">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabelx">创建联系人</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="ContactsFrom" role="form">

                        <div class="form-group">
                            <label for="create-contactsOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="create-contactsOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label for="create-clueSource" class="col-sm-2 control-label">来源</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="source" id="create-clueSource">
                                    <c:forEach items="${applicationScope.dics['source']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="create-surname" class="col-sm-2 control-label">姓名<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="fullname" id="create-surname">
                            </div>
                            <label for="create-call" class="col-sm-2 control-label">称呼</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="appellation" id="create-call">
                                    <c:forEach items="${applicationScope.dics['appellation']}" var="dicValue">
                                        <option value="${dicValue.value}">${dicValue.value}</option>
                                    </c:forEach>
                                </select>
                            </div>

                        </div>

                        <div class="form-group">
                            <label for="create-job" class="col-sm-2 control-label">职位</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="job" id="create-job">
                            </div>
                            <label for="create-mphone" class="col-sm-2 control-label">手机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="mphone" id="create-mphone">
                            </div>
                        </div>

                        <div class="form-group" style="position: relative;">
                            <label for="create-email" class="col-sm-2 control-label">邮箱</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="email" id="create-email">
                            </div>
                            <label for="create-birth" class="col-sm-2 control-label">生日</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="birth" id="create-birth">
                            </div>
                        </div>

                        <div class="form-group" style="position: relative;">
                            <label for="create-customerName" class="col-sm-2 control-label">客户名称</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="customerId" id="create-customerName" placeholder="支持自动补全，输入客户不存在则新建">
                            </div>
                        </div>

                        <div class="form-group" style="position: relative;">
                            <label for="create-describe" class="col-sm-2 control-label">描述</label>
                            <div class="col-sm-10" style="width: 81%;">
                                <textarea class="form-control" name="description" rows="3" id="create-describe"></textarea>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative;"></div>

                        <div style="position: relative;top: 15px;">
                            <div class="form-group">
                                <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" name="contactSummary" rows="3" id="create-contactSummary"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime1" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime1">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="create-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" name="address" rows="1" id="create-address"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="addContact" data-dismiss="modal">保存</button>
                </div>
            </div>
        </div>
    </div>
	
	<!-- 修改客户的模态窗口 -->
    <div class="modal fade" id="editCustomerModal" role="dialog">
        <div class="modal-dialog" role="document" style="width: 85%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel">修改客户</h4>
                </div>
                <div class="modal-body">
                    <form class="form-horizontal" id="UpdateEditForm" role="form">
                        <input id="id" name="id" type="hidden">
                        <div class="form-group">
                            <label for="edit-customerOwner" class="col-sm-2 control-label">所有者<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <select class="form-control" name="owner" id="edit-customerOwner">
                                    <c:forEach var="user" items="${applicationScope.users}">
                                        <option value="${user.id}">${user.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <label for="edit-customerName" class="col-sm-2 control-label">名称<span style="font-size: 15px; color: red;">*</span></label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="name" id="edit-customerName" >
                            </div>
                        </div>

                        <input type="hidden" name="createBy" id="createBy1">
                        <input type="hidden" name="createTime" id="createTime1">


                        <div class="form-group">
                            <label for="edit-website" class="col-sm-2 control-label">公司网站</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="website" id="edit-website">
                            </div>
                            <label for="edit-phone" class="col-sm-2 control-label">公司座机</label>
                            <div class="col-sm-10" style="width: 300px;">
                                <input type="text" class="form-control" name="phone" id="edit-phone" >
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
                                <label for="create-contactSummary1" class="col-sm-2 control-label">联系纪要</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" rows="3" name="contactSummary" id="create-contactSummary1"></textarea>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="create-nextContactTime2" class="col-sm-2 control-label">下次联系时间</label>
                                <div class="col-sm-10" style="width: 300px;">
                                    <input type="text" class="form-control" name="nextContactTime" id="create-nextContactTime2">
                                </div>
                            </div>
                        </div>

                        <div style="height: 1px; width: 103%; background-color: #D5D5D5; left: -13px; position: relative; top : 10px;"></div>

                        <div style="position: relative;top: 20px;">
                            <div class="form-group">
                                <label for="edit-address" class="col-sm-2 control-label">详细地址</label>
                                <div class="col-sm-10" style="width: 81%;">
                                    <textarea class="form-control" name="address" rows="1" id="edit-address"></textarea>
                                </div>
                            </div>
                        </div>
                    </form>

                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                    <button type="button" class="btn btn-primary" id="updateEdit" data-dismiss="modal">更新</button>
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
			<h3 id="name1"><small><a target="_blank" id="website1"></a></small></h3>
		</div>
		<div style="position: relative; height: 50px; width: 500px;  top: -72px; left: 700px;">
			<button type="button" class="btn btn-default" id="editCustomer" ><span class="glyphicon glyphicon-edit"></span> 编辑</button>
			<button type="button" class="btn btn-danger" id="deleteCustomer"><span class="glyphicon glyphicon-minus"></span> 删除</button>
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
			<div style="width: 300px; color: gray;">公司网站</div>
			<div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="website"></b></div>
			<div style="width: 300px;position: relative; left: 450px; top: -40px; color: gray;">公司座机</div>
			<div style="width: 300px;position: relative; left: 650px; top: -60px;"><b id="phone"></b></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px;"></div>
			<div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -60px; left: 450px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 20px;">
			<div style="width: 300px; color: gray;">创建者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="createBy"></b><small style="font-size: 10px; color: gray;" id="createTime"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
		<div style="position: relative; left: 40px; height: 30px; top: 30px;">
			<div style="width: 300px; color: gray;">修改者</div>
			<div style="width: 500px;position: relative; left: 200px; top: -20px;"><b id="editBy"></b><small style="font-size: 10px; color: gray;" id="editTime"></small></div>
			<div style="height: 1px; width: 550px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 40px;">
            <div style="width: 300px; color: gray;">联系纪要</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="contactSummary">

                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
        <div style="position: relative; left: 40px; height: 30px; top: 50px;">
            <div style="width: 300px; color: gray;">下次联系时间</div>
            <div style="width: 300px;position: relative; left: 200px; top: -20px;"><b id="nextContactTime"></b></div>
            <div style="height: 1px; width: 400px; background: #D5D5D5; position: relative; top: -20px; "></div>
        </div>
		<div style="position: relative; left: 40px; height: 30px; top: 60px;">
			<div style="width: 300px; color: gray;">描述</div>
			<div style="width: 630px;position: relative; left: 200px; top: -20px;">
				<b id="description">

				</b>
			</div>
			<div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
		</div>
        <div style="position: relative; left: 40px; height: 30px; top: 70px;">
            <div style="width: 300px; color: gray;">详细地址</div>
            <div style="width: 630px;position: relative; left: 200px; top: -20px;">
                <b id="address">

                </b>
            </div>
            <div style="height: 1px; width: 850px; background: #D5D5D5; position: relative; top: -20px;"></div>
        </div>
	</div>


    <!-- 修改联系人备注的模态窗口 -->
    <div class="modal fade" id="editRemarkModal" role="dialog">
        <%-- 备注的id --%>
        <input type="hidden" id="remarkId">
        <div class="modal-dialog" role="document" style="width: 40%;">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title" id="myModalLabel2">修改备注</h4>
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



	
	<!-- 备注 -->
	<div style="position: relative; top: 10px; left: 40px;">
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
					<button type="button" id="save" class="btn btn-primary">保存</button>
				</p>
			</form>
		</div>
	</div>
	
	<!-- 交易 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>交易</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable2" class="table table-hover" style="width: 900px;">
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
					<tbody id="tranTbody">
						<%--<tr>
							<td><a href="<%=basePath%>/toView/workbench/transaction/detail" style="text-decoration: none;">动力节点-交易01</a></td>
							<td>5,000</td>
							<td>谈判/复审</td>
							<td>90</td>
							<td>2017-02-07</td>
							<td>新业务</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeTransactionModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="<%=basePath%>/toView/workbench/transaction/save" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建交易</a>
			</div>
		</div>
	</div>
	
	<!-- 联系人 -->
	<div>
		<div style="position: relative; top: 20px; left: 40px;">
			<div class="page-header">
				<h4>联系人</h4>
			</div>
			<div style="position: relative;top: 0px;">
				<table id="activityTable" class="table table-hover" style="width: 900px;">
					<thead>
						<tr style="color: #B3B3B3;">
							<td>名称</td>
							<td>邮箱</td>
							<td>手机</td>
							<td></td>
						</tr>
					</thead>
					<tbody id="ContactsTbody">
						<%--<tr>
							<td><a href="<%=basePath%>/contacts/detail.jsp" style="text-decoration: none;">李四</a></td>
							<td>lisi@bjpowernode.com</td>
							<td>13543645364</td>
							<td><a href="javascript:void(0);" data-toggle="modal" data-target="#removeContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-remove"></span>删除</a></td>
						</tr>--%>
					</tbody>
				</table>
			</div>
			
			<div>
				<a href="javascript:void(0);" data-toggle="modal" data-target="#createContactsModal" style="text-decoration: none;"><span class="glyphicon glyphicon-plus"></span>新建联系人</a>
			</div>
		</div>
	</div>
	
	<div style="height: 200px;"></div>
</body>
</html>


<script>
    //获取表单数据
    $(function () {
        $.ajax({
            url:"<%=basePath%>/settings/customerRemark/lists",
            data:{
                'id':'${requestScope.id}'
            },
            dataType:"json",
            type:"post",
            success:function (data) {
                $("#owner").text(data.owner);
                $("#name").text(data.name);
                $("#name1").text(data.name);
                $("#website").text(data.website);
                $("#website1").text(data.website).attr("href",data.website);
                $("#phone").text(data.phone);
                $("#createBy").text(data.createBy);
                $("#createTime").text(data.createTime);
                $("#editBy").text(data.editBy);
                $("#editTime").text(data.editTime);
                $("#contactSummary").text(data.contactSummary);
                $("#nextContactTime").text(data.nextContactTime);
                $("#description").text(data.description);
                $("#address").text(data.address);

                var customerRemarks = data.customerRemarks;
                selectCustomerRemark(customerRemarks);

            }
        });
    });

    $("#editCustomer").click(function () {
        //修改的模态框
        $("#editCustomerModal").modal("show");
        <%--$.ajax({--%>
            <%--url:"<%=basePath%>/workbench/customer/users",--%>
            <%--type:"post",--%>
            <%--dataType:"json",--%>
            <%--success:function (data) {--%>
                <%--$("#edit-customerOwner").html("");--%>
                <%--for (var i = 0;i < data.length; i++ ){--%>
                    <%--$("#edit-customerOwner").append("<option value='"+data[i].id+"'>"+data[i].name+"</option>")--%>
                <%--}--%>
            <%--}--%>
        <%--});--%>
        //获取id
        $.ajax({
            url:"<%=basePath%>/workbench/customer/selectCustomerORId",
            data:{
                'id':'${requestScope.id}'
            },
            type:"post",
            dataType:"json",
            success:function (data) {
                $("#edit-customerOwner").val(data.owner);
                $("#edit-customerName").val(data.name);
                $("#edit-website").val(data.website);
                $("#edit-phone").val(data.phone);
                $("#edit-describe").val(data.description);
                $("#create-contactSummary1").val(data.contactSummary);
                $("#create-nextContactTime2").val(data.nextContactTime);
                $("#edit-address").val(data.address);
                $("#id").val(data.id);
                $("#createBy1").val(data.createBy);
                $("#createTime1").val(data.createTime);
            }
        });
    });

    $("#updateEdit").click(function () {
        if ($("#edit-customerName").val() == ""){
            layer.alert("名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#edit-website").val() == "") {
            layer.alert("公司网站不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#edit-phone").val() == "") {
            layer.alert("公司座机不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#edit-describe").val() == "") {
            layer.alert("描述不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#create-contactSummary1").val() == "") {
            layer.alert("联系纪要不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#create-nextContactTime2").val() == "") {
            layer.alert("下次联系时间不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#create-address").val() == "") {
            layer.alert("详细地址不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else {
            //修改的方法
            $.ajax({
                url: "<%=basePath%>/workbench/customer/addAndUpdateCustomer",
                data: $("#UpdateEditForm").serialize(),
                type: "post",
                dataType: "json",
                success: function (data) {
                    if (data.ok) {
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
            })
        }
    });
    //删除的方法
    $("#deleteCustomer").click(function () {
        layer.confirm('确定要删除这条记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
           //确定删除
            $.ajax({
                url:"<%=basePath%>/workbench/customer/deleteCustomer",
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
                        ayer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })
        });
    });
    //添加备注
    $("#save").click(function () {
        if ($("#remark").val() == ""){
            layer.alert("添加备注信息不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            $.ajax({
                url:"<%=basePath%>/settings/customerRemark/save",
                data:{
                    'noteContent':$("#remark").val(),
                    'customerId':'${requestScope.id}'
                } ,
                type:"post",
                dataType:"json",
                success:function (data) {
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //刷新当前页面
                        $("#remark").val("");
                        var customerRemark = data.t;
                        var  customerRemarks = [];
                        customerRemarks[0] = customerRemark;
                        selectCustomerRemark(customerRemarks)

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


    //修改备注的方法
    function openEditModal(noteContent,id) {
        $("#editRemarkModal").modal("show");

        $("#noteContent").val(noteContent);
        //隐藏域id
        $("#remarkId").val(id);

    }
    //更新
    $("#updateRemarkBtn").click(function () {
            if ($("#noteContent").val() == ""){
                layer.alert("修改备注信息不能为空!", {
                    icon: 5,
                    skin: 'layer-ext-demo'
                });
            } else {
                $.ajax({
                    url:"<%=basePath%>/settings/customerRemark/update",
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

    //删除备注信息
    function openDeleteModal(id) {
        // alert(id)
        layer.confirm('确定要删除这条记录吗？', {
            btn : ['确定', '取消']
            // 按钮
        }, function() {
           $.ajax({
               url:"<%=basePath%>/settings/customerRemark/delete",
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
           });
        });
    }


    //查询交易
    selectTran();
    //查询交易
    function selectTran() {
        $.ajax({
            url:"<%=basePath%>/workbench/CustomerTran/selectCustTran",
            type:"get",
            dataType:"json",
            success:function (data) {
                $("#tranTbody").html("");
                for (var i = 0;i < data.length;i++){
                    var transaction = data[i];

                $("#tranTbody").append("<tr>\n" +
                    "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/transaction/detail?id="+transaction.id+"';\" style=\"text-decoration: none;\">"+transaction.name+"</a></td>\n" +
                    "\t\t\t\t\t\t\t<td>"+transaction.money+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+transaction.stage+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+transaction.possibility+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+transaction.createTime+"</td>\n" +
                    "\t\t\t\t\t\t\t<td>"+transaction.type+"</td>\n" +
                    "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"deleteTran('"+transaction.id+"')\" data-toggle=\"modal\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
                    "\t\t\t\t\t\t</tr>")

             }
            }
        });
    }
    //删除交易
    function deleteTran(id) {
       $("#removeTransactionModal").modal("show");
       //加入隐藏域
        $("#Tranid").val(id);

    }

    $("#deleteTran").click(function () {
        $.ajax({
            url:"<%=basePath%>/workbench/contactsTran/deleteContactsTran",
            data:{
                'id':$("#Tranid").val()
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
                    selectTran();
                }else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }

            }
        })
    });

    //添加联系人
    //添加
    $("#addContact").click(function () {
        if ($("#create-surname").val() == ""){
            layer.alert("姓名不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-job").val() == ""){
            layer.alert("职位不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-mphone").val() == ""){
            layer.alert("手机不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-email").val() == ""){
            layer.alert("邮箱不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-birth").val() == ""){
            layer.alert("生日不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }  else if ($("#create-customerName").val() == ""){
            layer.alert("客户名称不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-describe").val() == ""){
            layer.alert("描述不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-contactSummary1").val() == ""){
            layer.alert("联系纪要不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-nextContactTime1").val() == ""){
            layer.alert("下次联系时间不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else if ($("#create-address").val() == ""){
            layer.alert("详细地址不能为空!", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            $.ajax({
                url: "<%=basePath%>/workbench/ContactsCustomer/addContactsCustomer",
                data: $("#ContactsFrom").serialize(),
                type: "post",
                dataType: "json",
                success: function (data) {
                    //添加成功清空表单数据
                    $('#createContactsModal').on('hidden.bs.modal', function () {
                        document.getElementById("ContactsFrom").reset();
                    });
                    if (data.ok) {
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //添加成功刷新当前页面
                        refresh();
                    } else {
                        layer.alert(data.message, {
                            icon: 5,
                            skin: 'layer-ext-demo'
                        });
                    }
                }
            })
        }
    });

    //自动补全的功能
    $("#create-customerName").typeahead({
        source: function (customerName, process) {
            $.post("<%=basePath%>/workbench/contact/queryCustomerName", {'customerName': customerName},
                function (data) {
                    process(data);

                }, "json");
        },
        //输入内容后延迟多长时间弹出提示内容
        delay: 0
    });

    //查询联系人
    refresh();
    function refresh() {
        $("#ContactsTbody").html("");
        $.ajax({
            url:"<%=basePath%>/workbench/ContactsCust/selectContactsCustomer",
            type:"get",
            dataType:"json",
            success:function (data) {
                for (var i = 0; i < data.length; i++) {
                    var contacts = data[i];
                    $("#ContactsTbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/contacts/detail?id="+contacts.id+"';\" style=\"text-decoration: none;\">"+contacts.fullname+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.email+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+contacts.mphone+"</td>\n" +
                        "\t\t\t\t\t\t\t<td><a href=\"javascript:void(0);\" data-toggle=\"modal\" onclick=\"deleteContacts('"+contacts.id+"')\" style=\"text-decoration: none;\"><span class=\"glyphicon glyphicon-remove\"></span>删除</a></td>\n" +
                        "\t\t\t\t\t\t</tr>")

                }
            }
        })
    }


    function deleteContacts(id) {

        $("#removeContactsModal").modal("show");

        //给隐藏域赋值
        $("#Contactsid").val(id);

    }

    $("#deleteContacts").click(function () {

        $.ajax({
            url:"<%=basePath%>/workbench/customerContacts/deleteContacts",
            data:{
                'id':$("#Contactsid").val()
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
                    refresh();
                }else {
                    layer.alert(data.message, {
                        icon: 5,
                        skin: 'layer-ext-demo'
                    });
                }

            }
        })
    });



    //查询发传单信息
    function selectCustomerRemark(customerRemarks) {
        for (var i = 0;i < customerRemarks.length;i++){
            var customerRemark = customerRemarks[i];

            $("#remarkDiv").before("<div class=\"remarkDiv\" style=\"height: 60px;\">\n" +
                "\t\t\t<img title=\"zhangsan\" src=\""+customerRemark.img+"\" style=\"width: 30px; height:30px;\">\n" +
                "\t\t\t<div style=\"position: relative; top: -40px; left: 40px;\" >\n" +
                "\t\t\t\t<h5 id ='h5"+customerRemark.id+"'>"+customerRemark.noteContent+"</h5>\n" +
                "\t\t\t\t<font color=\"gray\">联系人</font> <font color=\"gray\">-</font> <b>"+customerRemark.customerId+"</b> <small style=\"color: gray;\">"+customerRemark.createTime+" 由"+customerRemark.createBy+"</small>\n" +
                "\t\t\t\t<div style=\"position: relative; left: 500px; top: -30px; height: 30px; width: 100px; display: none;\">\n" +
                "\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\" onclick=\"openEditModal('"+customerRemark.noteContent+"','"+customerRemark.id+"')\"><span class=\"glyphicon glyphicon-edit\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
                "\t\t\t\t\t&nbsp;&nbsp;&nbsp;&nbsp;\n" +
                "\t\t\t\t\t<a class=\"myHref\" href=\"javascript:void(0);\" onclick=\"openDeleteModal('"+customerRemark.id+"');\"><span class=\"glyphicon glyphicon-remove\" style=\"font-size: 20px; color: #E6E6E6;\"></span></a>\n" +
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
    $("#create-nextContactTime2").datetimepicker({
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
    $("#create-birth").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: "bottom-left"
    });
    $("#create-nextContactTime1").datetimepicker({
        language:  "zh-CN",
        format: "yyyy-mm-dd",//显示格式
        minView: "month",//设置只显示到月份
        initialDate: new Date(),//初始化当前日期
        autoclose: true,//选中自动关闭
        todayBtn: true, //显示今日按钮
        clearBtn : true,
        pickerPosition: 'top-right'
    });




// $("#edit-phone").blur(function () {
//     var phone = document.getElementById('edit-phone').value;
//     if(!(/^1[3456789]d{9}$/.test(phone))){
//         layer.alert("手机号码有误，请重填");
//         return false;
//     }
// });
//
// $("#edit-website").blur(function () {
//     var phone = document.getElementById('edit-website').value;
//     if(!(/^([a-zA-Z]\:|\\\\[^\/\\:*?"<>|]+\\[^\/\\:*?"<>|]+)(\\[^\/\\:*?"<>|]+)+(\.[^\/\\:*?"<>|]+)$/.test(phone))){
//         layer.alert("公司网站有误，请重填");
//         return false;
//     }
// });




</script>