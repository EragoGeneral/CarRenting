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
	<META HTTP-EQUIV="pragma" CONTENT="no-cache">
	<META HTTP-EQUIV="Cache-Control" CONTENT="no-cache, must-revalidate">
	<title>菜单管理</title>
	
	<jsp:include page="../base/common.jsp" flush="true" />
	
	<script type="text/javascript">
		$(function(){
			$("#dg").datagrid({
            url: "<%=basePath%>user/list", //指向一个一般处理程序或者一个控制器，返回数据要求是Json格式，直接赋值Json格式数据也可，我以demo中自带的Json数据为例，就不写后台代码了，但是我会说下后台返回的注意事项
            iconCls: "icon-add",
            fitColumns: false, //设置为true将自动使列适应表格宽度以防止出现水平滚动,false则自动匹配大小
            idField: 'id', //标识列，一般设为id，可能会区分大小写，大家注意一下
            loadMsg: "正在努力为您加载数据", //加载数据时向用户展示的语句
            pagination: true, //显示最下端的分页工具栏
            singleSelect: true,
            selectOnCheck:false,
            checkOnSelect:false,
            rownumbers: true, //显示行数 1，2，3，4...
            pageSize: 10, //读取分页条数，即向后台读取数据时传过去的值
            pageList: [1, 10, 20], //可以调整每页显示的数据，即调整pageSize每次向后台请求数据时的数据
            //由于datagrid的属性过多，我就不每个都介绍了，如有需要，可以看它的API
            sortName: "id", //初始化表格时依据的排序 字段 必须和数据库中的字段名称相同
            sortOrder: "asc", //正序
            columns: [[
           		{ field:'ck',checkbox:true,formatter:formatCK}, 
                { field: 'userName', title: '姓名', width: '100', sortable: true }, //sortable:true点击该列的时候可以改变升降序
                { field: 'gender', title: '性别', width: '100', formatter:function(value, row, index){if(value=="M"){return "男"} else { return "女"}}},
                { field: 'birth', title: '生日', width: '100', formatter:function(value, row, index){return formatDate(value);} },
                { field: 'email', title: '电邮', width: '100' },
                { field: 'address', title: '地址', width: '250'},
                { field: 'mobile', title: '移动电话', width: '120' }
            ]],//这里之所以有两个方括号，是因为可以做成水晶报表形式，具体可看demo            
            //toolbar设置表格顶部的工具栏，以数组形式设置
            toolbar: [{//在dategrid表单的头部添加按钮
                text: "添加",
                iconCls: "icon-add",
                handler: function () {
                	addUser();
                }
            }, '-', {//'-'就是在两个按钮的中间加一个竖线分割，看着舒服
                text: "删除",
                iconCls: "icon-remove",
                handler: function () {
                	removeUser();                	
                }
            }, '-', {
                text: "修改",
                iconCls: "icon-edit",
                handler: function () {
                	editUser();                	
                }
            }, '-']
        });
        
        
        /*var p = $('#dg').datagrid('getPager'); 
	    $(p).pagination({ 
	        pageSize: 10,//每页显示的记录条数，默认为10 
	        pageList: [1,10,15],//可以设置每页记录条数的列表 
	        beforePageText: '第',//页数文本框前显示的汉字 
	        afterPageText: '页    共 {total} 页', 
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录', 
	        onBeforeRefresh:function(){
	            $(this).pagination('loading');
	            alert('before refresh');
	            $(this).pagination('loaded');
	        } 
	    }); */
		
		});
		
		function formatCK(value,row){
			console.log(row);
	         if(row.loginName !="admin"){ //抓取失败的行返回 checkbox,成功了的什么都不返回
	               return '<input type="checkbox" class="ck" name="DataGridCheckbox"/>';
	        }
	    }
	
		function addUser(){
			$('#EditForm').form('clear'); 
			$('#w').window({title:'添加用户信息'});
			$('#w').window('open');
		}
		
		function formatDate(now) { 
			var d = new Date(now);
			var year=d.getFullYear(); 
			var month=d.getMonth()+1;  if(month<10) month='0'+month;
			var date=d.getDate();  if(date<10) date='0'+date;
			var hour=d.getHours(); 
			var minute=d.getMinutes(); 
			var second=d.getSeconds(); 
			return year+"-"+month+"-"+date; //+" "+hour+":"+minute+":"+second; 
		} 
		
		function doSearch(){ 
			$('#dg').datagrid('reload',{ userName: $('#userName').val(), addressd: $('#address').val() });
			//$("#dg").datagrid("load", sy.serializeObject($("#searchForm").form()));
		}
		
		function cancelForm(){
			$('#w').window('close');
		}
		
		function submitForm(){
			var jsonuserinfo = $('#EditForm').serializeJson();
	        console.log(jsonuserinfo);
	        $.ajax( {
	          	type : 'POST',
	          	//contentType : 'application/json',
	          	url : '<%=basePath%>user/save',
				data : jsonuserinfo,
				dataType : 'json',
				success : function(data) {				
					if(data.success == true){	                    
	                    alert("保存用户成功");
	                    $('#w').window('close');
	                    $('#dg').datagrid('reload',{});
					}else{
						alert("保存用户失败");
					}
				},
				error : function(data) {
					alert("error");
				}
			});
		}
		
		function editUser(){
			$('#w').window('open');
			var rec = $('#dg').datagrid('getSelected');
			console.log(rec.id);
			$("#EditForm #id").val(rec.id);
           	$.each(rec, function(i, j){           		
           		if(i=="loginName" || i == "userName" || i == "password" || i == "mobile" || i == "email" || i == "address"){
           			var obj = $("#EditForm #"+i);
           			obj.textbox("setValue", j);
           		}else if(i == "birth"){
           			console.log("birth" + j);
           			var result = formatDate(j);
           			console.log(result);
           			$("#EditForm #"+i).datebox("setValue", result);
           		}else if(i == "deptNo"){
					$("#EditForm #"+i).combobox("setValue", j);           			
           		}else if(i == "gender"){
           			var oo = $("#EditForm input[type=radio][name="+ i +"][value="+ j +"]");
           			oo.attr('checked', true);
           		}	
           		
           	});
		}
		
		function removeUser(){
			var checkedItems = $('#dg').datagrid('getChecked');
			var array = [];
			$.each(checkedItems, function(idx, obj){
				array.push(obj.id);
			});
			var param = array.toString();			
			$.ajax( {
	          	type : 'POST',
	          	url : '<%=basePath%>user/del',
				data : {selectedIDs: param},
				dataType : 'json',
				success : function(data) {				
					if(data.success == 1){	  
	                    $('#dg').datagrid('reload',{});          
					}else{
					}
				},
				error : function(data) {
					alert("error");
				}
			});
		}
		
	</script>
	<style type="text/css">
		.form-box{
		    margin-top: 30px;
		    margin-left: auto;
		    margin-right: auto;
		    width: 250px;
		}
	
		.form-item{
		    height: 40px;
		}
		
		.form-item label{
			font-size:18px;
			margin-right:30px;
		}
		
		.form-item label.len2{
    		padding-left:17px;
		}
		
	</style>
  </head>
  
  <body>
  	<div class="easyui-panel" title="Search" style="height:450px;" data-options="iconCls:'icon-search'">
  		<form id="searchForm">
  			<div id="tb" style="padding:3px; background-color:#efefef;"> 
	  			<span>用户名:</span> <input id="userName" style="line-height:26px;border:1px solid #ccc" /> 
	  			<span>地址:</span> <input id="address" style="line-height:26px;border:1px solid #ccc" /> 
	  			<a class="easyui-linkbutton" plain="true" onclick="doSearch()">Search</a> 
	  		</div>
  		</form>
    	<table id="dg"></table>
    </div>	
    <div id="w" class="easyui-window" title="User" data-options="modal:true,closed:true,iconCls:'icon-save'" 
    	style="width:500px;height:500px;padding:10px;">
		<div class="form-box">
			<form id="EditForm" action="<%=basePath %>user/save" method="post">
				<div class="form-item">
					<label for="loginName">登录名:</label>
					<input type="hidden" id="id" name="id" />
					<input type="text" class="easyui-textbox easyui-validatebox" name="loginName" id="loginName" data-options="required:true,validType:'length[3,10]'" />
				</div>
				<div class="form-item">
					<label for="userName">用户名:</label>
					<input type="text" class="easyui-textbox easyui-validatebox" name="userName" id="userName" data-options="required:true" />
				</div>
				<div class="form-item">
					<label for="password" class="len2">密码:</label>
					<input type="password" class="easyui-textbox easyui-validatebox" name="password" id="password" data-options="required:true" />
				</div>
				<div class="form-item">
					<label for="gender" class="len2">性别:</label>
					<input type="radio" name="gender" id="genderM" value="M" />男
					<input type="radio" name="gender" id="genderF" value="F" />女
				</div>
				<div class="form-item">
					<label for="birth" class="len2">生日:</label>
					<input class="easyui-datebox " name="birth" id="birth" ></input>
				</div>
				<div class="form-item">
					<label for="mobile" class="len2">手机:</label>
					<input type="text" class="easyui-textbox" name="mobile" id="mobile"/>
				</div>
				<div class="form-item">
					<label for="email" class="len2">邮箱:</label>
					<input type="text" class="easyui-textbox" name="email" id="email" data-options="validType:'email'"/>
				</div>
				<div class="form-item">
					<label for="address" class="len2">住址:</label>
					<input type="text" class="easyui-textbox easyui-validatebox" name="address" id="address"/>
				</div>
				<div class="form-item">
					<label for="deptNo" class="len2">部门:</label>
					<select class="easyui-combobox" name="deptNo" id="deptNo" style="width:150px;">
						<option value="-1">请选择</option>
						<option value="1">总经办</option>
						<option value="2">技术部</option>
						<option value="3">市场部</option>
						<option value="4">财务部</option>
					</select>
				</div>
				<div style="text-align:center;padding:5px">
					<a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;" onclick="submitForm()">提交</a>
            		<a href="javascript:void(0)" class="easyui-linkbutton" style="width:80px;" onclick="cancelForm()">取消</a>
				</div>
			</form>
		</div>	
	</div>
  </body>
</html>
