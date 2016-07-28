<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
	$(function() {

		$('#roleAddForm').form({
			url : '${pageContext.request.contextPath}/role/add',
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
</script>
<div class="easyui-layout" data-options="fit:true,border:false" >
	<div data-options="region:'center',border:false" title="" style="overflow: hidden;padding: 3px;" >
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
	</div>
</div>
