<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>系统主页面</title>
<script>
	var sessionInfo_userId = '${sessionInfo.id}';
	if (sessionInfo_userId) {//如果没有登录,直接跳转到登录页面
		layout_west_tree_url = '${ctx}/resource/mainMenu';
	}else{
		window.location.href='${ctx}/admin/index';
	}
</script>
<jsp:include page="inc.jsp"></jsp:include>

<style type="text/css">
	.firstMenu{padding:10px;}
	.firstMenu div{margin-bottom:10px;}
	.menuDiv{font-family: '微软雅黑';
    border-bottom: dotted 2px #e0e0e0;
    height: 32px;
    line-height: 32px;
    padding-left: 25px;}
    .menuLink{font-size: 14px;
    text-decoration: none;
    color: #000000;}
</style>

<script type="text/javascript">
	$(function(){
		// 从后台返回一个生成二级菜单的json列表，要与easyui 的 tree结构一致的
		$.ajax({  
            url:layout_west_tree_url,  
            type:'get',  
            data:"{}",  
            dataType:'json',  
            success:function (data) {
            	var farr = data;                
                $.each(farr,function(i,n){
                	var sarr = n.children;
                	var scontent = '';
                	if(sarr != null){
                		$.each(sarr, function(idx, sn){                		
                			scontent += "<div class='menuDiv'>"
                				+"<a class='menuLink' href=\"javascript:addTab('tabId_"+ sn.id +"', '"+ sn.name +"', '${ctx}/"+ sn.url +"');\">"+ sn.name +"</a></div>";
                		});
                	}
                    $('#menu').accordion('add',{
                        title: n.name,
                        selected: true,
                        content: scontent,
                    });
                });
            }  
        });  
	});

	/**  
	 * 创建新选项卡  
	 * @param tabId    选项卡id  
	 * @param title    选项卡标题  
	 * @param url      选项卡远程调用路径  
	 */
	function addTab(tabId, title, url) {
		//如果当前id的tab不存在则创建一个tab  
		if ($("#" + tabId).html() == null) {
			var name = 'iframe_' + tabId;
			$('#centerTab').tabs('add',
				{
					title : title,
					closable : true,
					cache : false,
					content : '<iframe name="' + name + '"id="' + tabId + '"src="' + url
							+ '" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>'
				});
		} else {
			$('#centerTab').tabs('select', title);
		}
	}
	
	function logout(){
		$.messager.confirm('提示','确定要退出?',function(r){
			if (r){
				progressLoad();
				$.post( '${ctx}/admin/logout', function(result) {
					if(result.success){
						progressClose();
						window.location.href='${ctx}/admin/index';
					}
				}, 'json');
			}
		});
	}
</script>

</head>

<!-- 主界面的框架 -->
<body class="easyui-layout">
	<!-- 北边区域 -->
	<div data-options="region:'north',border:false"
		style="height:60px;background:#B3DFDA;padding:10px">
		<span style="font-size: 20px; display: block; margin-left: 20px; height: 24px; width: 180px;
    		float: left; margin-top: 5px;">UBT 运维系统</span>
    	<div style="float:right;margin-top:10px;">
    		欢迎 <b>${sessionInfo.name}</b>&nbsp;&nbsp; 
    		<a href="javascript:void(0)" onclick="editUserPwd()" style="color: #000">修改密码</a>
    		&nbsp;&nbsp;<a href="javascript:void(0)" onclick="logout()" style="color: #000">安全退出</a>
    	</div>	
	</div>
	<!-- 各个模块 -->
	<div data-options="region:'west',split:true,title:'系统菜单'"
		style="width:165px;">
		<!-- 子模块：模板管理 -->
		<div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
		</div>
	</div>
	<!-- 东部区域 -->
	<div data-options="region:'east',split:true"
		style="width:10px;padding:10px;"></div>
	<!-- 中央布局 -->
	<div data-options="region:'center'" fit="true" border="false">
		<div class="easyui-tabs" id="centerTab" fit="true" border="false">
			<div title="欢迎页" style="padding:20px;overflow:hidden;">
				<div style="margin-top:20px;">
					<h3>你好，欢迎来到系统</h3>
				</div>
			</div>
		</div>
	</div>
	<!-- 底部 -->
	<div data-options="region:'south',border:false" style="height: 30px;line-height:30px; overflow: hidden;text-align: center;background-color: #eee" >优必选科技有限公司 </div>
</body>

</html>