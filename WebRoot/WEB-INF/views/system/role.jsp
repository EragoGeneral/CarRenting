<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
    <head>
	    <jsp:include page="../inc.jsp"></jsp:include>
        <title>角色管理</title>
        <style type="text/css">
        	#searchform{
        		margin-left: 10px;
    			margin-top: 6px;
        	}
        </style>
        <c:if test="${fn:contains(sessionInfo.resourceList, '/role/edit')}">
			<script type="text/javascript">
				$.canEdit = true;
			</script>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/role/delete')}">
			<script type="text/javascript">
				$.canDelete = true;
			</script>
		</c:if>
		<c:if test="${fn:contains(sessionInfo.resourceList, '/role/grant')}">
			<script type="text/javascript">
				$.canGrant = true;
			</script>
		</c:if>
		<script type="text/javascript">
			var dataGrid;
			$(function() {
				dataGrid = $('#roleGrid').datagrid({
					url : '${ctx}' + '/role/list',
					striped : true,
					rownumbers : true,
					pagination : true,
					singleSelect : true,
					idField : 'id',
					sortName : 'id',
					sortOrder : 'asc',
					pageSize : 10,
					pageList : [ 10, 20, 30],
					frozenColumns : [ [ {
						width : '100',
						title : 'id',
						field : 'id',
						sortable : true,
						hidden:true
					}, {
						width : '120',
						title : '编码',
						field : 'code',
						sortable : true
					} , {
						width : '150',
						title : '名称',
						field : 'name',
						sortable : true
					}, {
						width : '400',
						title : '描述',
						field : 'description'
					} , {
						field : 'action',
						title : '操作',
						width : 150,
						formatter : function(value, row, index) {
							var str = '&nbsp;';
								if ($.canGrant) {
									str += $.formatString('<a href="javascript:void(0)" onclick="grantFun(\'{0}\');" >授权</a>', row.id);
								}
							if(row.isdefault!=0){
								//str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
								if ($.canEdit) {
									str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
									str += $.formatString('<a href="javascript:void(0)" onclick="editFun(\'{0}\');" >编辑</a>', row.id);
								}
								//str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
								if ($.canDelete) {
									str += '&nbsp;&nbsp;|&nbsp;&nbsp;';
									str += $.formatString('<a href="javascript:void(0)" onclick="deleteFun(\'{0}\');" >删除</a>', row.id);
								}
							}
							return str;
						}
					} ] ],
					onSortColumn: function (sort, order) {
		                
		            },
					toolbar : '#toolbar'
				});
			});
			
			function addFun() {
				parent.$.modalDialog({
					title : '添加',
					width : 500,
					height : 300,
					href : '${ctx}/role/addPage',
					buttons : [ {
						text : '添加',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个treeGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#roleAddForm');
							f.submit();
						}
					} ]
				});
			}
			
			function deleteFun(id) {
				if (id == undefined) {//点击右键菜单才会触发这个
					var rows = dataGrid.datagrid('getSelections');
					id = rows[0].id;
				} else {//点击操作里面的删除图标会触发这个
					dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
				}
				parent.$.messager.confirm('询问', '您是否要删除当前角色？', function(b) {
					if (b) {
						progressLoad();
						$.post('${ctx}/role/delete', {
							id : id
						}, function(result) {
							if (result.success) {
								parent.$.messager.alert('提示', result.msg, 'info');
								dataGrid.datagrid('reload');
							}
							progressClose();
						}, 'JSON');
					}
				});
			}
			
			function editFun(id) {
				if (id == undefined) {
					var rows = dataGrid.datagrid('getSelections');
					id = rows[0].id;
				} else {
					dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
				}
				parent.$.modalDialog({
					title : '编辑',
					width : 500,
					height : 300,
					href : '${ctx}/role/editPage?id=' + id,
					buttons : [ {
						text : '编辑',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#roleEditForm');
							f.submit();
						}
					} ]
				});
			}
			
			function grantFun(id) {
				if (id == undefined) {
					var rows = dataGrid.datagrid('getSelections');
					id = rows[0].id;
				} else {
					dataGrid.datagrid('unselectAll').datagrid('uncheckAll');
				}
				
				parent.$.modalDialog({
					title : '授权',
					width : 500,
					height : 500,
					href : '${ctx}/role/grantPage?id=' + id,
					buttons : [ {
						text : '授权',
						handler : function() {
							parent.$.modalDialog.openner_dataGrid = dataGrid;//因为添加成功之后，需要刷新这个dataGrid，所以先预定义好
							var f = parent.$.modalDialog.handler.find('#roleGrantForm');
							f.submit();
						}
					} ]
				});
			}
			
			function searchFun() {
				var queryParams = $('#roleGrid').datagrid('options').queryParams;
				//queryParams.mobile = '189';  
				var array = $("#searchform").serializeArray(); 
				for(var i = 0; i < array.length; i++){
					var p = "queryParams."+array[i].name+" = '"+array[i].value+"';";
					eval(p);
				} 
				
				$('#roleGrid').datagrid('options').queryParams=queryParams;      
				$('#roleGrid').datagrid('reload');
            }	
            
            function cleanFun() {
				$('#searchform input').val('');
				$('#roleGrid').datagrid('load', {});
			}
			</script>
    </head>
  
    <body>
	    <div class="easyui-layout" style="width:'98%';height:350px;" data-options="region:'center',fit:true,border:false">
			<div data-options="region:'north'" style="height:50px">
				<form name="searchform" method="post" action="" id ="searchform">
			    	<table>
				    	<tr>
				    		<td width="40" height="30">编号：</td>
						    <td width="150" height="30">
						        <input type="text" name="code" id="code" size=20 >
						    </td>
						    <td width="40" height="30">名称：</td>
						    <td width="150" height="30">
						        <input type="text" name="name" id="name" size=20 >
						    </td>
						    <td width="40" height="30">描述：</td>
						    <td width="150" height="30">
						        <input type="text" name="description" id="description" size=20 >
						    </td>
						    <td>
						    	<a id="submit_search" href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-search',plain:true, " onclick="searchFun();">查询</a>
						    	<a href="javascript:void(0);" class="easyui-linkbutton" data-options="iconCls:'icon-cancel',plain:true" onclick="cleanFun();">清空</a>
						    </td>	
				    	</tr>
				    </table>
				  </form>
			</div>
			<div data-options="region:'center',title:'角色管理', fit:true,border:false,iconCls:'icon-ok'">
				<table id="roleGrid" data-options="fit:true,border:false"></table>
			</div>
			<div id="toolbar" style="display: none;">
				<c:if test="${fn:contains(sessionInfo.resourceList, '/role/add')}">
					<a onclick="addFun();" href="javascript:void(0);" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
				</c:if>
			</div>
		</div>
  	</body>
</html>
