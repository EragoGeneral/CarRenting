<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
	    <jsp:include page="../inc.jsp"></jsp:include>
        <title>用户管理</title>
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
        <c:if test="${fn:contains(sessionInfo.resourceList, '/user/edit')}">
			<script type="text/javascript">
				$.canEdit = true;
			</script>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/user/delete')}">
			<script type="text/javascript">
				$.canDelete = true;
			</script>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/user/grant')}">
			<script type="text/javascript">
				$.canGrant = true;
			</script>
		</c:if>
		<script type="text/javascript">
			var url;
		
			$(function(){
				loadGrid();
			
				var pager = $('#dg').datagrid().datagrid('getPager');	// get the pager of datagrid
				pager.pagination({
					displayMsg:'当前显示 {from} - {to} 条记录   共 {total} 条记录',
					beforePageText: '第',//页数文本框前显示的汉字 
	        		afterPageText: '页    共 {pages} 页'
				});	
				
				$("#submit_search").click(function () {
					var queryParams = $('#dg').datagrid('options').queryParams;
					//queryParams.mobile = '189';  
					var array = $("#searchform").serializeArray(); 
					for(var i = 0; i < array.length; i++){
						var p = "queryParams."+array[i].name+" = '"+array[i].value+"';";
						eval(p);
					} 
					
					$('#dg').datagrid('options').queryParams=queryParams;      
					$('#dg').datagrid('reload');
	            });	 	
			});
				
			function loadGrid(){
				$('#dg').datagrid({
				    title:'用户管理',
				    //fit:true,
	              	//nowrap: false,
	              	//striped:false,
	              	url:'/CarRenting/user/list',
	              	queryParams:{},
	              	singleSelect : true,
	              	//sortName: 'id',
	              	//sortOrder: 'asc',
		            remoteSort: false,
		            idField:'id',
	              	/* frozenColumns:[[
	                    {field:'ck',checkbox:true}
	              	]], */
	              columns:[[
	                  {field:'loginName',title:'登录名',width:'10%',sortable:true},
	                  {field:'userName',title:'姓名',width:'10%',sortable:true},
	              	  {field:'gender',title:'性别',width:'5%',formatter:function(val,rec){if(val=='M'){return '男';}else{return '女';}}},
	              	  {field:'birth',title:'生日',width:'10%'},
	                  {field:'email',title:'电子邮箱',width:'15%'},
	                  {field:'mobile',title:'手机',width:'10%'},
	                  {field:'address',title:'地址'}
	              ]],
	              pagination:true,
	              pageNumber:1,
	              pageSize:5,
	              pageList:[5,10],      
	              displayMsg:'当前显示 {from} - {to} 条记录   共 {total} 条记录',
				  beforePageText: '第',//页数文本框前显示的汉字 
	       		  afterPageText: '页    共 {pages} 页',       
	              //singleSelect:true,
	              rownumbers:true,
	              toolbar:[
	                  {
	                      iconCls:'icon-add',
	                      text:'新增',
	                      handler: function(){newUser();}
	              	  }, '-',
	              	  {
	              	  	  iconCls:'icon-edit',
	              	  	  text:'修改',
	              	  	  handler: function(){editUser();}
	              	  }, '-',
	              	  {
	              	      iconCls:'icon-remove',
	              	      text:'删除',
	              	      handler: function(){delUser();}
	              	  }, '-',
	              	  {
	              	      iconCls:'icon-ok',
	              	      text:'授权',
	              	      handler: function(){grantUser();}
	              	  }
	              ]               
				});
			}
				
			function newUser(){
				$('#dlg').dialog('open').dialog('setTitle','New User');
				$('#fm').form('clear');
			}
			
			function editUser(){
				var row = $('#dg').datagrid('getSelected');
				if (row){
					$('#dlg').dialog('open').dialog('setTitle','Edit User');
					$('#fm').form('load',row);
				}
			}
			
			function delUser(){
				var row = $('#dg').datagrid('getSelected');
				if (row){
					$.messager.confirm('Confirm','Are you sure you want to remove this user?',function(r){
						if (r){
							$.post('/CarRenting/user/del',{selectedIDs:row.id},function(result){
								if (result.success){
									$.messager.show({	// show error message
										title: 'info',
										style:{
											right:'',
											top:document.body.scrollTop+document.documentElement.scrollTop,
											bottom:''
										},
										msg: result.msg
									});
									$('#dg').datagrid('reload');	// reload the user data
								} else {
									$.messager.show({	// show error message
										title: 'Error',
										style:{
											right:'',
											top:document.body.scrollTop+document.documentElement.scrollTop,
											bottom:''
										},
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
					url: '/CarRenting/user/save',
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
			
			function grantUser(){
			    var row = $('#dg').datagrid('getSelected');
				if (row){
					parent.$.modalDialog({
						title : '授权',
						width : 500,
						height : 380,
						href : '${ctx}/user/grantPage?id=' + row.id,
						buttons : [ {
							text : '授权',
							handler : function() {
								console.log('111');
								//parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
								var f = parent.$.modalDialog.handler.find('#userGrantForm');
								f.submit();
							}
						} ]
					});
				}
			}
			
			function myformatter(date){
				var y = date.getFullYear();
				var m = date.getMonth()+1;
				var d = date.getDate();
				return y+'-'+(m<10?('0'+m):m)+'-'+(d<10?('0'+d):d);
			}
			function myparser(s){
				if (!s) return new Date();
				var ss = (s.split('-'));
				var y = parseInt(ss[0],10);
				var m = parseInt(ss[1],10);
				var d = parseInt(ss[2],10);
				if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
					return new Date(y,m-1,d);
				} else {
					return new Date();
				}
			}
			
			function cleanFun() {
				$('#searchform input').val('');
				$('#dg').datagrid('load', {});
			}
		</script>
    </head>
  
    <body>
	    <h2>User Management</h2>
	<div style="margin:20px 0;"></div>
	<form name="searchform" method="post" action="" id ="searchform">
	    <table>
	    	<tr>
	    		<td width="40" height="30">姓名：</td>
			    <td width="150" height="30">
			        <input type="text" name="userName" id="userName" size=20 >
			    </td>
			    <td width="40" height="30" style="padding-left:10px;">性别：</td>
			    <td width="100" height="30">
			    	<select name="gender" id="gender" style="width:80px;">
			            <option value="-1">全部</option>
			            <option value="M">男</option>
			            <option value="F">女</option>
			        </select>
			    </td>
			    <td width="40" height="30">手机：</td>
			    <td width="150" height="30">
			        <input type="text" name="mobile" id="mobile" size=20 >
			    </td>
			    <td>
			    	<!-- <a class="easyui-linkbutton l-btn l-btn-small l-btn-plain" id="submit_search">搜索</a> -->
			    	<a id="submit_search" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true">查询</a>
			    	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
			    </td>	
	    	</tr>
	    </table>
	  </form>
	<table id="dg"></table> 
	<div id="dlg" class="easyui-dialog" style="width:400px;height:320px;" closed="true" buttons="#dlg-buttons">
		<div class="ftitle">User Information</div>
		<form id="fm" method="post" novalidate>
			<div class="fitem">
				<label>登录名:</label>
				<input type="hidden" name="id" />
				<input name="loginName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>密码:</label>
				<input name="password" type="password" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>姓名:</label>
				<input name="userName" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>性别:</label>
				<select name="gender" id="gender" class="easyui-combobox" data-options="width:150,height:24,editable:false,panelHeight:'auto'">
					<option value="M">男</option><option value="F">女</option>
				</select>
			</div>
			<div class="fitem">
				<label>生日:</label>
				<input class="easyui-datebox" name="birth" data-options="formatter:myformatter,parser:myparser"></input>
			</div>
			<div class="fitem">
				<label>手机:</label>
				<input name="mobile" class="easyui-validatebox" required="true">
			</div>
			<div class="fitem">
				<label>电子邮箱:</label>
				<input name="email" class="easyui-validatebox" required="true">
			</div>
		</form>
	</div>
	<div id="dlg-buttons">
		<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">Save</a>
		<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">Cancel</a>
	</div>
  	</body>
</html>
