<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>菜单管理</title>

<jsp:include page="../base/common.jsp" flush="true" />
<style type="text/css">
.left-panel {
	border: solid 2px #e0e0e0;
	width: 20%;
	padding: 5px;
	height: 600px;
	float: left;
}

.right-panel {
	border: solid 2px #e0e0e0;
	margin-left: 10px;
	float: left;
	height: 570px;
	width: 800px;
	padding: 20px;
}

.field-row {
	margin-top: 20px;
	margin-left: 20px;
}

.field-name {
	float: left;
	margin-top: 2px;
	margin-right: 20px;
}
</style>

<script type="text/javascript">
	$(function(){
		$('#tt').tree({  
		    checkbox: false,  
		    dnd:true,  
		    method:'get',
		    animate:true,
		    lines:true,
		    url: '<%=basePath%>system/loadMenu',  
		    onClick:function(node){//单击事件  
		        $(this).tree('toggle', node.target); 
		        /*if(node.attributes!=null && node.attributes.url!=null){
		        	loadMenuInfo(node.id, node.attributes.url);
		        }*/
		        loadMenuInfo(node.id);
		    },
		    onContextMenu: function(e, node){
				e.preventDefault();
				// 查找节点
				$('#tt').tree('select', node.target);
				// 显示快捷菜单
				if(node.attributes.level == 1){
					$('#mm').menu('show', {
						left: e.pageX,
						top: e.pageY
					});
				}else{
					$('#mm1').menu('show', {
						left: e.pageX,
						top: e.pageY
					});				
				}
			} 
		}); 
	});
	
	function loadMenuInfo(menuID){
		//console.log(menuID + ", " + url);
		$.ajax({  
            url:'<%=basePath%>/system/getMenuInfo?id='+menuID,  
            type:'get',  
           // data:"{'id':'"+ menuID +"'}",  
            dataType:'json',  
            success:function (data) {
            	console.log(data);
            	$('#menuName').textbox("setValue", data.name);
            	$('#menuLink').textbox("setValue", data.link);
            	$('#displayOrder').textbox("setValue", data.displayOrder);
            	$('#level').val(data.level);
            	$('#parentId').val(data.parentId);
            	/*var node = $('#tt').tree('getSelected');
            	if(node){
            		var newNode = {"id":-99,"text":'新节点', "attributes":{"parentID":menuID}};
            		$('#tt').tree('append', {
						parent:node.target,
						data:newNode
					});
					var node = $('#tt').tree('find', -99);
					console.log(node);
					$('#tt').tree('select', newNode.target);
            	}
            	*/
            	/*var node = $('#tt').tree('getSelected');
				if (node){
					var nodes = [{
						"id":13,
						"text":"Raspberry"
					},{
						"id":14,
						"text":"Cantaloupe"
					}];
					$('#tt').tree('append', {
						parent:node.target,
						data:nodes
					});
				}*/
            	
            	/*var node = $('#tt').tree('getSelected');
                $('#tt').tree('remove', node.target);*/
                
                /*var node = $('#tt').tree('find', 2);
				$('#tt').tree('select', node.target);*/
            }  
        });  
	}
	
	function menuHandler(item){
		if(item.id == "addSame" || item.id == "addSame1"){
			console.log('Add same');
			var node = $('#tt').tree('getSelected')
			var pnode = $('#tt').tree('getParent', node.target); 
			console.log(pnode.text);
		}
	}
		
	function submitForm(){
		//$('#form').form('submit');
		
		var jsonuserinfo = $('#form').serializeJson();
        console.log(jsonuserinfo);
        $.ajax( {
          	type : 'POST',
          	//contentType : 'application/json',
          	url : '<%=basePath%>system/saveMenu',
			data : jsonuserinfo,
			dataType : 'json',
			success : function(data) {
				//alert("新增成功！");
				console.log(data);
			},
			error : function(data) {
				alert("error");
			}
		});
	}

	$.fn.serializeJson = function() {
		var serializeObj = {};
		var array = this.serializeArray();
		var str = this.serialize();
		$(array).each(
				function() {
					if (serializeObj[this.name]) {
						if ($.isArray(serializeObj[this.name])) {
							serializeObj[this.name].push(this.value);
						} else {
							serializeObj[this.name] = [
									serializeObj[this.name], this.value ];
						}
					} else {
						serializeObj[this.name] = this.value;
					}
				});
		return serializeObj;
	}
</script>

</head>

<body>
	<div style="margin:10px 0;"></div>
	<div class="main-panel">
		<div class="left-panel" style="padding:5px">
			<ul id="tt"></ul>
		</div>
		<div class=right-panel>
			<div class="easyui-panel" title="菜单信息" style="width:400px">
				<form id="form" method="post" action="<%=basePath%>system/saveMenu">
					<div class="field-row">
						<div class="field-name">菜单名称</div>
						<div>
							<input type="text" class="easyui-textbox" id="menuName"
								name="name" data-options="required:true" />
						</div>
					</div>
					<div class="field-row">
						<div class="field-name">菜单链接</div>
						<div>
							<input type="text" class="easyui-textbox" id="menuLink"
								name="link" data-options="required:true" />
						</div>
					</div>
					<div class="field-row">
						<div class="field-name">显示顺序</div>
						<div>
							<input type="text" class="easyui-textbox" id="displayOrder"
								name="displayOrder" data-options="required:true" />
						</div>
					</div>
					<div>
						<input type="hidden" name="parentId" id="parentId" />
						<input type="hidden" name="level" id="level" />
					</div>
				</form>
				<div style="text-align:center;padding:5px">
					<a href="javascript:void(0)" class="easyui-linkbutton"
						onclick="submitForm()">Submit</a>
				</div>
			</div>
			<!-- <input type="text" id="url" name="url" /> -->
		</div>
	</div>
	<div id="mm" class="easyui-menu" data-options="onClick:menuHandler"
		style="width:120px;">
		<div id="addSame" data-options="iconCls:'icon-add'">添加同级菜单</div>
		<div id="addSub" data-options="iconCls:'icon-add'">添加下级菜单</div>
		<div id="del" data-options="iconCls:'icon-remove'">删除菜单</div>
	</div>
	<div id="mm1" class="easyui-menu" data-options="onClick:menuHandler"
		style="width:120px;">
		<div id="addSame1" data-options="iconCls:'icon-add'">添加同级菜单</div>
		<div id="del1" data-options="iconCls:'icon-remove'">删除菜单</div>
	</div>
</body>
</html>
