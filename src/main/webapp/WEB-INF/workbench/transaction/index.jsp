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
<%--交易页面--%>
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

	
	
	<div>
		<div style="position: relative; left: 10px; top: -10px;">
			<div class="page-header">
				<h3>交易列表</h3>
			</div>
		</div>
	</div>
	
	<div style="position: relative; top: -20px; left: 0px; width: 100%; height: 100%;">
	
		<div style="width: 100%; position: absolute;top: 5px; left: 10px;">
		
			<div class="btn-toolbar" role="toolbar" style="height: 80px;">
				<form class="form-inline" role="form" style="position: relative;top: 8%; left: 5px;">
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">所有者</div>
				      <input class="form-control" id="owner" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">名称</div>
				      <input class="form-control" name="name" type="text">
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">客户名称</div>
				      <input class="form-control" id="customerId" type="text">
				    </div>
				  </div>
				  
				  <br>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">阶段</div>
					  <select class="form-control" id="stage">
                          <option>请选择</option>
                          <c:forEach items="${applicationScope.dics['stage']}" var="stage">
                              <option value="${stage.value}">${stage.text}</option>
                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">类型</div>
					  <select class="form-control" id="transactionType">
					  	<option>请选择</option>
                          <c:forEach items="${applicationScope.dics['transactionType']}" var="transactionType">
                              <option value="${transactionType.value}">${transactionType.text}</option>
                          </c:forEach>
					  </select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">来源</div>
				      <select class="form-control" id="create-clueSource">
                          <option>请选择</option>
                          <c:forEach items="${applicationScope.dics['source']}" var="source">
                              <option value="${source.value}">${source.text}</option>
                          </c:forEach>
						</select>
				    </div>
				  </div>
				  
				  <div class="form-group">
				    <div class="input-group">
				      <div class="input-group-addon">联系人名称</div>
				      <input class="form-control" id="contactsId" type="text">
				    </div>
				  </div>
				  
				  <button type="button" id="select" class="btn btn-default">查询</button>
				  
				</form>
			</div>
			<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;top: 10px;">
				<div class="btn-group" style="position: relative; top: 18%;">
				  <button type="button" class="btn btn-primary" onclick="window.location.href='<%=basePath%>/toView/workbench/transaction/save';"><span class="glyphicon glyphicon-plus"></span> 创建</button>
				  <button type="button" class="btn btn-default" id="update"><span class="glyphicon glyphicon-pencil"></span> 修改</button>
				  <button type="button" class="btn btn-danger" id="deleteTran"><span class="glyphicon glyphicon-minus"></span> 删除</button>
                    <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>
				</div>
				
				
			</div>
			<div style="position: relative;top: 10px;">
				<table class="table table-hover">
					<thead>
						<tr style="color: #B3B3B3;">
							<td><input type="checkbox" id="father" /></td>
							<td>名称</td>
							<td>客户名称</td>
							<td>阶段</td>
							<td>类型</td>
							<td>所有者</td>
							<td>来源</td>
							<td>联系人名称</td>
						</tr>
					</thead>
					<tbody id="tbody">


					</tbody>
				</table>
			</div>
			
			<div style="height: 50px; position: relative;top: 20px;">
				<div id="transactionPage"></div>
			</div>
			
		</div>
		
	</div>
</body>
</html>

<script>
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

    function refresh (page,pageSize){
        $.ajax({
            url:"<%=basePath%>/settings/transaction/list",
            type:"get",
            dataType:"json",
            data:{
                'currentPage': page,
                'rowsPerPage': pageSize,
                'owner':$("#owner").val(),
                'name':$("#name").val(),
                'customerId':$("#customerId").val(),
                'stage':$("#stage").val(),
                'type':$("#transactionType").val(),
                'source':$("#create-clueSource").val(),
                'contactsId':$("#contactsId").val()
            },
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                // $('#father').removeAttr('checked');
                $("#tbody").html("");
                var transactions = data.list;
                for (var i = 0;i < transactions.length;i++){
                    var transaction = transactions[i];
                    $("#tbody").append("<tr>\n" +
                        "\t\t\t\t\t\t\t<td><input type=\"checkbox\" onclick='checkeds()' class='sun' value='"+transaction.id+"' /></td>\n" +
                        "\t\t\t\t\t\t\t<td><a style=\"text-decoration: none; cursor: pointer;\" onclick=\"window.location.href='<%=basePath%>/toView/workbench/transaction/detail?id="+transaction.id+"';\">"+transaction.name+"</a></td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.customerId+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.stage+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.activityId+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.owner+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.source+"</td>\n" +
                        "\t\t\t\t\t\t\t<td>"+transaction.contactsId+"</td>\n" +
                        "\t\t\t\t\t\t</tr>")
                }
                //分页
                //分页查询
                $("#transactionPage").bs_pagination({
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
        });

    }
//模糊查询
    $("#select").click(function () {
       refresh(1,3);
    });

    //复选框
    $("#father").click(function () {
        $(".sun").prop("checked",$(this).prop("checked"));
    });
    function checkeds() {
        //获取sun的个数
        var length = $(".sun").length;
        //获取勾中的个数
        var checkedLength = $(".sun:checked").length;
        if (length == checkedLength){
            $("#father").prop("checked",true);
        } else {
            $("#father").prop("checked",false);
        }

    }


    $("#update").click(function () {

        var checkedLenth = $(".sun:checked").length;
        if (checkedLenth > 1){
            layer.alert("选择操作的数据不能超过一条!", {
                icon: 5});
        } else if (checkedLenth < 1){
            layer.alert("请至少选择一条数据!", {
                icon: 5});
        } else {
            $("#editClueModal").modal("show");
            var id = $(".sun:checked")[0].value;

        window.location.href='<%=basePath%>/toView/workbench/transaction/edit?id='+id;
        }
    });

    $("#deleteTran").click(function () {
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
                    url:"<%=basePath%>/workbench/Tran/deletesTran",
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

        window.location.href = "<%=basePath%>/workbench/Tran/exportExcel";

        });

</script>