<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<style>
	.s1{width:60px;height:30px;}
	#d1{width:450px;height:280px;background-color:#F5DEB3;margin:0 auto;}
	#d2{height:30px;font-size:24px;background-color:blue;color:white;}
	#d3{padding-left:30px;padding-right:30px;}
</style>
<script type="text/javascript">
	$(function(){
		LoadOptions();
		
		$('#selectOne').click(function(){
			$obj = $('select option:selected').clone(true);
			if($obj.size() == 0){
				alert("请至少选择一条!");
			}
			$('#selectedList').append($obj);
			$('select option:selected').remove();
		});
		
		$('#selectAll').click(function(){
			$('#selectedList').append($('#toSelectList option'));
		});
		
		$('#removeOne').click(function(){
			$obj = $('select option:selected').clone(true);
			if($obj.size() == 0){
				alert("请至少选择一条!");
			}
			$('#toSelectList').append($obj);
			$('select option:selected').remove();
		});
		
		$('#removeAll').click(function(){
			$('#toSelectList').append($('#selectedList option'));
		});
		
		$('option').dblclick(function(){
			var flag = $(this).parent().attr('id');
			if(flag == "toSelectList"){
				var $obj = $(this).clone(true);
				$('#selectedList').append($obj);
				$(this).remove();
			} else {
				var $obj = $(this).clone(true);
				$('#toSelectList').append($obj);
				$(this).remove();
			}
		});
		
		$('#userGrantForm').form({
			url : '${pageContext.request.contextPath}/user/grant',
			onSubmit : function() {
				progressLoad();
				var isValid = $(this).form('validate');
				if (!isValid) {
					progressClose();
				}
				var ids = [];
				$('#selectedList option').each(function(idx, obj){
					console.log(idx + " : " + obj.value);
					ids.push(obj.value);
				});
				$('#selectedRole').val(ids);
				
				return isValid;
			},
			success : function(result) {
				progressClose();
				result = $.parseJSON(result);
				
				parent.$.modalDialog.handler.dialog('close');
				parent.$.messager.alert('提示', result.msg, 'info');
				/* result = $.parseJSON(result);
				if (result.success) {
					parent.$.modalDialog.openner_dataGrid.datagrid('reload');//之所以能在这里调用到parent.$.modalDialog.openner_dataGrid这个对象，是因为user.jsp页面预定义好了
					parent.$.modalDialog.handler.dialog('close');
					parent.$.messager.alert('提示', result.msg, 'info');
				} else {
					parent.$.messager.alert('错误', result.msg, 'error');
				} */
			} 
		});
	});
	
	function LoadOptions(){
		$.post( '${ctx}/user/loadRole', {
			id : '5'
		}, function(result) {
			console.log(result.obj.OwnedRoles);
			console.log(result.obj.ToSelRoles);
			var ownedRoles = result.obj.OwnedRoles;
			var opt = "";
			$.each(ownedRoles, function(idx, obj){
			    opt+="<option value='"+obj.id+"'>"+obj.name+"</option>";		
			});
			$('#selectedList').append(opt);
			
			var toSelRoles = result.obj.ToSelRoles;
			opt="";
			$.each(toSelRoles, function(idx, obj){
			    opt+="<option value='"+obj.id+"'>"+obj.name+"</option>";		
			});
			$('#toSelectList').append(opt);
			
			/* var ids="";
			if (result.id != undefined&&result.resourceIds!= undefined) {
				ids = $.stringToList(result.resourceIds);
			}
			if (ids.length > 0) {
				for ( var i = 0; i < ids.length; i++) {
					if (resourceTree.tree('find', ids[i])) {
						resourceTree.tree('check', resourceTree.tree('find', ids[i]).target);
					}
				}
			} */
		}, 'json');
	}
</script>
<div id="roleGrantLayout" class="easyui-layout" data-options="fit:true,border:false">
	<div data-options="region:'center'" title="" style="overflow: hidden; padding: 10px;">
		<div id="d1">
			<div id="d3">
				<form id="userGrantForm" method="post" >
					<input type="hidden" id="selectedRole" name="selectedRole" />
					<table cellpadding="0" cellspacing="8">
						<tr>
							<td>可选角色</td>
							<td>&nbsp;</td>
							<td>已授权角色</td>
						</tr>
						<tr>
							<td>
								<select id="toSelectList" name="toSelectList" style="width:150px; height:220px;" multiple="multiple">
								</select>
							</td>
							<td>
								<p><input id="selectOne" type="button" class="s1" value="--&gt;" /></p>
								<p><input type="button" id="selectAll" class="s1" value="--&gt;&gt;" /></p>
								<p><input type="button" id="removeOne" class="s1" value="&lt;--" /></p>
								<p><input type="button" id="removeAll" class="s1" value="&lt;&lt;--" /></p>
							</td>
							<td><select id="selectedList" name="selectedList" style="width:150px;height:220px;" multiple="multiple"></select></td>
						</tr>
					</table>
				</form>	
			</div>
		</div>
	</div>
</div>