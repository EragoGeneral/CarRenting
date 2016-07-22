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
},

/**
 * 
 * @requires jQuery
 * 
 * 页面加载加载进度条启用
 * **/
$.fn.progressLoad = function(){  
    $("<div class=\"datagrid-mask\" style=\"position:absolute;z-index: 9999;\"></div>").css({display:"block",width:"100%",height:$(window).height()}).appendTo("body");  
    $("<div class=\"datagrid-mask-msg\" style=\"position:absolute;z-index: 9999;\"></div>").html("正在处理，请稍候。。。").appendTo("body").css({display:"block",left:($(document.body).outerWidth(true) - 190) / 2,top:($(window).height() - 45) / 2});  
},

$.fn.progressClose = function(){
	$(".datagrid-mask").remove();  
	$(".datagrid-mask-msg").remove();
}