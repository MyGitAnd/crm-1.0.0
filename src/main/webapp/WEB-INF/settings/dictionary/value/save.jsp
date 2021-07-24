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
</head>
<body>

	<div style="position:  relative; left: 30px;">
		<h3>新增字典值</h3>
	  	<div style="position: relative; top: -40px; left: 70%;">
			<button type="button" id="addDicValue" class="btn btn-primary">保存</button>
			<button type="button" class="btn btn-default" onclick="window.history.back();">取消</button>
		</div>
		<hr style="position: relative; top: -40px;">
	</div>
	<form class="form-horizontal" role="form">
					
		<div class="form-group">
			<label for="create-dicTypeCode" class="col-sm-2 control-label">字典类型编码<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<select class="form-control" id="create-dicTypeCode" style="width: 200%;">
				</select>
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-dicValue" class="col-sm-2 control-label">字典值<span style="font-size: 15px; color: red;">*</span></label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-dicValue" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-text" class="col-sm-2 control-label">文本</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-text" style="width: 200%;">
			</div>
		</div>
		
		<div class="form-group">
			<label for="create-orderNo" class="col-sm-2 control-label">排序号</label>
			<div class="col-sm-10" style="width: 300px;">
				<input type="text" class="form-control" id="create-orderNo" style="width: 200%;">
			</div>
		</div>
	</form>
	
	<div style="height: 200px;"></div>
</body>
</html>
<script>

    //查询字典类型的编码

        $.ajax({
            url:"<%=basePath%>/settings/dictionary/typeValues",
            type:"get",
            dataType:"json",
            success:function (data) {
                for (var i = 0;i < data.length;i++){
                    $("#create-dicTypeCode").append("<option value='"+data[i].code+"'>"+data[i].name+"</option>");
                }
            }
        });

    $("#addDicValue").click(function () {
         if ($("#create-dicValue").val() == ""){
            layer.alert("字典值不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#create-text").val() == ""){
            layer.alert("文本不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        }else if ($("#create-orderNo").val() == ""){
            layer.alert("排序号不能为空", {
                icon: 5,
                skin: 'layer-ext-demo'
            });
        } else {
            $.ajax({
                url:"<%=basePath%>/settings/dicValue/addDicValue",
                data:{
                    'typeCode':$("#create-dicTypeCode").val(),
                    'value':$("#create-dicValue").val(),
                    'text':$("#create-text").val(),
                    'orderNo':$("#create-orderNo").val()
                },
                type:"post",
                dataType:"json",
                success:function (data) {
                    if (data.ok){
                        layer.alert(data.message, {
                            icon: 6,
                            skin: 'layer-ext-demo'
                        });
                        //刷新上页面
                        // window.opener.location.reload();
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
</script>