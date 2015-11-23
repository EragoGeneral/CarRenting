<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath1 = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>	
<!-- 启用EL表达式 -->
<%@ page isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta charset="UTF-8">
<title>系统主页面</title>

<jsp:include page="../base/common.jsp" flush="true" />

<style type="text/css">
	.firstMenu{padding:10px;}
	.firstMenu div{margin-bottom:10px;}


	.menuDiv{font-family: '微软雅黑';
    border-bottom: dotted 2px #e0e0e0;
    height: 32px;
    line-height: 32px;
    padding-left: 25px;}
    .menuLink{font-size: 16px;
    text-decoration: none;
    width: 80px;}
</style>

<script type="text/javascript">
	$(function(){
		// 从后台返回一个生成二级菜单的json列表，要与easyui 的 tree结构一致的
		$.ajax({  
            url:'<%=basePath1%>/system/MainMenu',  
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
                			scontent += "<div class='menuDiv'><a class='menuLink' href=\"javascript:addTab('tabId_"+ sn.id +"', '"+ sn.name +"', '<%=basePath1%>"+ sn.link +"');\">"+ sn.name +"</a></div>";
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
			$('#centerTab')
					.tabs(
							'add',
							{
								title : title,
								closable : true,
								cache : false,
								content : '<iframe name="'
										+ name
										+ '"id="'
										+ tabId
										+ '"src="'
										+ url
										+ '" width="100%" height="100%" frameborder="0" scrolling="auto" ></iframe>'
							});
		} else {
			$('#centerTab').tabs('select', title);
		}
	}
</script>

</head>

<!-- 主界面的框架 -->
<body class="easyui-layout">
	<!-- 北边区域 -->
	<div data-options="region:'north',border:false"
		style="height:60px;background:#B3DFDA;padding:10px">考试系统</div>
	<!-- 各个模块 -->
	<div data-options="region:'west',split:true,title:'系统菜单'"
		style="width:220px;">
		<!-- 子模块：模板管理 -->
		<div id="menu" class="easyui-accordion" data-options="fit:true,border:false">
			<!--  
			<div title="客户管理" class="firstMenu">
				<div><a href="javascript:addTab('tabId_list','list','/FirstSSM/article/list');">list</a>
				</div>
				<div><a href="javascript:addTab('tabId_datagrid','datagrid','/FirstSSM/article/index');">datagrid</a>
				</div>
			</div>
			<div title="会员管理" class="firstMenu">
				<div><a href="javascript:addTab('tabId_tree','tree','/FirstSSM/article/hello');">Tree</a>
				</div>
				<div><a href="javascript:addTab('tabId_datagrid','datagrid模板','/FirstSSM/article/index');">datagrid</a>
				</div>
			</div>
			<div title="租车管理" class="firstMenu">
				<div><a href="javascript:addTab('tabId_templet','租车管理','/FirstSSM/article/hello');">租车管理</a>
				</div>
				<div><a href="javascript:addTab('tabId_datagrid','datagrid模板','/FirstSSM/article/index');">datagrid</a>
				</div>
			</div>
			<div title="系统管理" class="firstMenu">
				<div><a href="javascript:addTab('tabId_templet','系统管理','/FirstSSM/article/list');">系统管理</a>
				</div>
				<div><a	href="javascript:addTab('tabId_datagrid','datagrid模板','/FirstSSM/article/index');">datagrid</a>
				</div>
			</div>
			-->
		</div>
	</div>
	<!-- 东部区域 -->
	<div data-options="region:'east',split:true"
		style="width:10px;padding:10px;"></div>
	<!-- 底部 -->
	<div data-options="region:'south',border:false"
		style="height:50px;background:#A9FACD;padding:10px;">
		<div id="footer">Copyright &copy; 大潮阳棉小城租车系统</div>
	</div>
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
</body>

</html>