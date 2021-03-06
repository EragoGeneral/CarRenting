<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>User Management</title>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/easyui.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/icon.css">
	<link rel="stylesheet" type="text/css" href="<%=basePath%>resources/css/demo.css">
	<script type="text/javascript" src="<%=basePath%>resources/js/jquery.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>resources/js/jquery.easyui.min.js"></script>
	<style type="text/css">
		#fm{
			margin:0;
			padding:10px 30px;
		}
		.ftitle{
			font-size:14px;
			font-weight:bold;
			color:#666;
			padding:5px 0;
			margin-bottom:10px;
			border-bottom:1px solid #ccc;
		}
		.fitem{
			margin-bottom:5px;
		}
		.fitem label{
			display:inline-block;
			width:80px;
		}
	</style>
  </head>
  
  <body>
    <div style="margin:20px 0;"></div>
	
	<table id="dg" class="easyui-datagrid" title="Basic DataGrid" toolbar="#toolbar" style="width:80%;height:250px"
			data-options="singleSelect:true,collapsible:true,url:'<%=basePath%>/user/list',method:'get',
			pagination:true">
		<thead>
			<tr>
				<th data-options="field:'userName',width:'10%'">Name</th>
				<th data-options="field:'gender',width:'5%',formatter:function(val, rec){if(val=='M'){return '男'}else{return '女'}}">Gender</th>
				<th data-options="field:'birth',width:'10%',align:'left'">Birth</th>
				<th data-options="field:'email',width:'15%',align:'center'">Email</th>
				<th data-options="field:'mobile',width:'10%'">Mobile</th>
				<th data-options="field:'address',align:'center'">Address</th>
			</tr>
		</thead>
	</table>
	<div id="toolbar">
		<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">New User</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">Edit User</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="delUser()">Remove User</a>
	</div>
	<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;"
			closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>First Name:</label>
				<input type="hidden" name="user.id" />
				<input name="user.userName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Last Name:</label>
				<input name="user.gender" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>Phone:</label>
				<input name="phone">
			</div>
			<div class="fitem">
				<label>Email:</label>
				<input name="email" class="easyui-validatebox" validType="email">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
	</div>
<script>
	var url;
	$(function(){
			var pager = $('#dg').datagrid().datagrid('getPager');	// get the pager of datagrid
			pager.pagination({
				displayMsg:'',
				pageList:[10,20,30]
			});			
		});
		
	function newUser(){
		$('#dlg').dialog('open').dialog('setTitle','New User');
		$('#fm').form('clear');
			//url = 'save_user.php';
	}
	
	function editUser(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			$('#dlg').dialog('open').dialog('setTitle','Edit User');
			$('#fm').form('load',row);
			//url = 'update_user.php?id='+row.id;
		}
	}
	
	function delUser(){
		var row = $('#dg').datagrid('getSelected');
		if (row){
			$.messager.confirm('Confirm','Are you sure you want to remove this user?',function(r){
				if (r){
					$.post('remove_user.php',{id:row.id},function(result){
						if (result.success){
							$('#dg').datagrid('reload');	// reload the user data
						} else {
							$.messager.show({	// show error message
								title: 'Error',
								msg: result.msg
							});
						}
					},'json');
				}
			});
		}
	}
	
	function saveUser(){
		$('#fm').form('submit',{
			url: url,
			onSubmit: function(){
				return $(this).form('validate');
			},
			success: function(resp){
				var result = eval('('+resp+')');
				if (result.success){
					$('#dlg').dialog('close');		// close the dialog
					$('#dg').datagrid('reload');	// reload the user data
				} else {
					$.messager.show({
						title: 'Error',
						msg: result.msg
					});
				}
			}
		});
	}
</script>
</body>
</html>