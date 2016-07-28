<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function() {

		$('#userAddForm').form({
			url : '${pageContext.request.contextPath}/user/save',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
					parent.$.messager.alert('提示', result.msg, 'info');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				}
			}
		});
	});
	
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
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
		<form id="userAddForm" method="post" novalidate>
			<table class="grid"> 
				<tr>
					<td>登录名</td>
					<td>
						<input type="hidden" name="id" />
						<input name="loginName" class="easyui-validatebox" required="true">
					</td>
					<td>密码</td>
					<td><input name="password" type="password" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td>姓名</td>
					<td><input name="userName" class="easyui-validatebox" required="true"></td>
					<td>性别</td>
					<td>
						<select name="gender" id="gender" class="easyui-combobox" data-options="width:150,height:24,editable:false,panelHeight:'auto'">
							<option value="M">男</option><option value="F">女</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>生日</td>
					<td><input class="easyui-datebox" name="birth" data-options="formatter:myformatter,parser:myparser"></input></td>
					<td>手机</td>
					<td><input name="mobile" class="easyui-validatebox" required="true"></td>
				</tr>
				<tr>
					<td>电子邮箱</td>
					<td><input name="email" class="easyui-validatebox" required="true"></td>
					<td></td>
					<td></td>
				</tr>
				<tr>
					<td>地址</td>
					<td colspan="3"><textarea name="address" rows="3" cols="58"></textarea></td>
				</tr>
			</table>		
		</form>
	</div>
</div>
