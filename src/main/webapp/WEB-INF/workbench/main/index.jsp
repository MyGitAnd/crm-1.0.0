<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" %>
<%
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+
            request.getServerPort()+request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="<%=basePath%>jquery/bootstrap_3.3.0/css/bootstrap.min.css" type="text/css" rel="stylesheet" />
<script type="text/javascript" src="<%=basePath%>jquery/jquery-1.11.1-min.js"></script>
<script type="text/javascript" src="<%=basePath%>jquery/bootstrap_3.3.0/js/bootstrap.min.js"></script>

</head>
<body>
	<img src="<%=basePath%>/image/home.png" style="position: relative;top: -10px; left: -10px;"/>
</body>
</html>