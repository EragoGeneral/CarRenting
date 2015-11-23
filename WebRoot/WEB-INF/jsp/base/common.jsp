<%@ page language="java" import="java.util.*" pageEncoding="ISO-8859-1"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css//icon.css">
<link rel="stylesheet" type="text/css" href="<%=basePath%>/static/css/demo.css">
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=basePath%>/static/js/jquery.easyui.min.js"></script>
