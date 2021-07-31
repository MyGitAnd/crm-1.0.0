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

	<div>
		<div style="position: relative; left: 30px; top: -10px;">
			<div class="page-header">
				<h3>字典值列表</h3>
			</div>
		</div>
	</div>
	<div class="btn-toolbar" role="toolbar" style="background-color: #F7F7F7; height: 50px; position: relative;left: 30px;">
		<div class="btn-group" style="position: relative; top: 18%;">
		  <button type="button" class="btn btn-primary" onclick="window.location.href='<%=basePath%>/toView/settings/dictionary/value/save'"><span class="glyphicon glyphicon-plus"></span> 创建</button>
		  <button type="button" class="btn btn-default" id="editDicValue"><span class="glyphicon glyphicon-edit"></span> 编辑</button>
		  <button type="button" id="deleteValue" class="btn btn-danger"><span class="glyphicon glyphicon-minus"></span> 删除</button>
          <button type="button" class="btn btn-success" id="exportExcel"><span class="glyphicon glyphicon-circle-arrow-down"></span> 导出报表</button>
        </div>
	</div>
	<div style="position: relative; left: 30px; top: 20px;">
		<table class="table table-hover">
			<thead>
				<tr style="color: #B3B3B3;">
					<td><input type="checkbox" id="farther"/></td>
					<td>序号</td>
					<td>字典值</td>
					<td>文本</td>
					<td>排序号</td>
					<td>字典类型编码</td>
				</tr>
			</thead>
			<tbody id="dicValueTbody">
				<%--<tr class="active">--%>
					<%--<td><input type="checkbox" /></td>--%>
					<%--<td>1</td>--%>
					<%--<td>m</td>--%>
					<%--<td>男</td>--%>
					<%--<td>1</td>--%>
					<%--<td>sex</td>--%>
				<%--</tr>--%>

			</tbody>
		</table>
        <div style="height: 50px; position: relative;top: 30px;">
            <div id="DicValuePage"></div>
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
        go_last_text: '末页'};

    refresh(1,3);
    function refresh (page,pageSize){
        $.ajax({
            url:"<%=basePath%>/settings/DicValue/selectDicValue",
            type:"get",
            dataType:"json",
            data:{
                'page':page,
                'pageSize':pageSize
            },
            success:function (data) {
                //分页查询的时候选中的复选框要清除掉
                $('#farther').removeAttr('checked');
                $("#dicValueTbody").html("");
                var dicValues = data.list;
                for (var i = 0; i < dicValues.length; i++){
                    var dicValue = dicValues[i];
                            $("#dicValueTbody").append("<tr class=\"active\">\n" +
                                "\t\t\t\t\t<td><input type=\"checkbox\" class='sun' onclick='checkedes()' value='"+dicValue.id+"'/></td>\n" +
                                "\t\t\t\t\t<td>"+dicValue.id2+"</td>\n" +
                                "\t\t\t\t\t<td>"+dicValue.value+"</td>\n" +
                                "\t\t\t\t\t<td>"+dicValue.text+"</td>\n" +
                                "\t\t\t\t\t<td>"+dicValue.orderNo+"</td>\n" +
                                "\t\t\t\t\t<td>"+dicValue.typeCode+"</td>\n" +
                                "\t\t\t\t</tr>")
                        }
                $("#DicValuePage").bs_pagination({
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


    //查询表中数据
    <%--$(function () {--%>
       <%--$.ajax({--%>
           <%--url:"<%=basePath%>/settings/DicValue/selectDicValue",--%>
           <%--type:"get",--%>
           <%--dataType:"json",--%>
           <%--success:function (data) {--%>
               <%--for (var i = 0;i < data.length; i++){--%>
                   <%--$("#dicValueTbody").append("<tr class=\"active\">\n" +--%>
                       <%--"\t\t\t\t\t<td><input type=\"checkbox\" class='sun' value='"+data[i].id+"'/></td>\n" +--%>
                       <%--"\t\t\t\t\t<td>"+data[i].id2+"</td>\n" +--%>
                       <%--"\t\t\t\t\t<td>"+data[i].value+"</td>\n" +--%>
                       <%--"\t\t\t\t\t<td>"+data[i].text+"</td>\n" +--%>
                       <%--"\t\t\t\t\t<td>"+data[i].orderNo+"</td>\n" +--%>
                       <%--"\t\t\t\t\t<td>"+data[i].typeCode+"</td>\n" +--%>
                       <%--"\t\t\t\t</tr>")--%>
               <%--}--%>
           <%--}--%>
       <%--});--%>
    <%--});--%>

    //设置全选和全不选
    $("#farther").click(function () {
        $(".sun").prop("checked",$(this).prop("checked"));

    });
    function checkedes() {
        //获取子复选框的数量
        var length = $(".sun").length;
        //获取勾中的数量
        var checkedLength = $(".sun:checked").length;

        if (length == checkedLength){
            $("#farther").prop("checked",true);
        } else {
            $("#farther").prop("checked",false);
        }
    }

    $("#editDicValue").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength < 1){
            layer.alert("请至少选择一条数据!", {
                icon: 5});
        } else if (checkedLength > 1){
            layer.alert("选择操作的数据不能超过一条!", {
                icon: 5});
        }else {
            var id = $(".sun:checked")[0].value;
            window.location.href = '<%=basePath%>/toView/settings/dictionary/value/edit?id='+id
        }
    });

    //删除
    $("#deleteValue").click(function () {
        var checkedLength = $(".sun:checked").length;
        if (checkedLength != 0) {
            layer.confirm('确定要删除' + checkedLength + '条记录吗？', {
                btn: ['确定', '取消']
                // 按钮
            }, function () {
                var ids = [];
                $(".sun:checked").each(function () {
                    ids.push($(this).val());
                });
                $.ajax({
                    url:"<%=basePath%>/settings/DicValue/deleteDicValue",
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
                        }else {
                            layer.alert(data.message, {
                                icon: 5,
                                skin: 'layer-ext-demo'
                            });
                        }
                    }
                });
            })
        }else{
            layer.alert("请至少选择一条数据！", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }
    });

    //导出报表
    $("#exportExcel").click(function () {

        window.location.href = "<%=basePath%>/settings/Value/exportExcel";

    });


</script>