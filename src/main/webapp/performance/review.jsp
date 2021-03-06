<%@page contentType="text/html;charset=gb2312" language="java" errorPage=""%>
<%@ page import="com.performance.Review"%>
<%@ page import="com.entity.system.UserInfo"%>
<%@ page import="com.performance.IndexDataHelper"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<title>南充烟草专卖局</title>
<link rel="stylesheet" type="text/css" href="../jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="../jscomponent/easyui/themes/icon.css">
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>
</head>
<body class="easyui-layout">
<%
	UserInfo user = (UserInfo) request.getSession().getAttribute("UserInfo");
	String type = request.getParameter("objType");
	Review review= new Review(user);
	if(!review.hasReviewTask(type)){
		out.write("您尚未具备该类考核的权限");
	} else {
%>
<!-- 上 width:223px;padding:0 3px-->
<div data-options="region:'north',border:false">
<table>
	<tr>
	<td>
	<div>
		<label for="yearsel">年度: </label>
		<input id='yearsel' class="easyui-combobox" style="width:80px;" data-options="data:<%=IndexDataHelper.getYearJson() %>,valueField:'value',textField:'text',onSelect:onYearChanged" />
		<script type="text/javascript">
		function onYearChanged(record){
			var period = $('#periodsel').combobox('getValue');
			var indexcode = $("#indexcode").val();
			if(period && indexcode){
				$("#indexdg").attr('src','index_datagrid.jsp?objType=${param.objType}&periodcode=' + period + '&indexcode=' + indexcode + '&relateyear=' + record.value);
			}
		}
		</script>
	</div>
	</td>
	
	<td>
	<div>
		<label for="periodsel">周期: </label>
		<input id='periodsel' class="easyui-combobox" style="width:80px;" data-options="data:<%=IndexDataHelper.getPeriodJson() %>,valueField:'value',textField:'text',onSelect:onPeriodChanged" />
		<script type="text/javascript">
		function onPeriodChanged(record){
			var year = $('#yearsel').combobox('getValue');
			var indexcode = $("#indexcode").val();
			if(year && indexcode){
				$("#indexdg").attr('src','index_datagrid.jsp?objType=${param.objType}&periodcode=' + record.value + '&indexcode=' + indexcode + '&relateyear=' + year);
			}
		}
		</script>
	</div>
	</td>
	
	<td>
	<div>
		<label for="indexname">指标: </label>
	   	<input id="indexcode" name="indexcode" type="hidden"></input>
		<input id="indexname" name="indexcode" type="text" style="width:150px;background-color:white;" readonly="readonly"></input>
		<a id="indexsel" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-search'">选择</a>
	</div> 
	</td>
	</tr>
</table>
</div>
<!-- 中 -->
<div data-options="region:'center',border:false">
<iframe id="indexdg" frameborder="0" scrolling="no" style="width:100%;height:99.5%;border:0px none;"></iframe>
</div>
<script type="text/javascript" src="../jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="../jscomponent/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="../jscomponent/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="../jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>

<script type="text/javascript">
(function($){
	function returnValue(result){
		if(result.code != $('#indexcode').val()){
			$("#indexcode").val(result.code);
			$("#indexname").val(result.name);
			
			var year = $('#yearsel').combobox('getValue');
			var period = $('#periodsel').combobox('getValue');
			if(year && period){
				$("#indexdg").attr('src','index_datagrid.jsp?objType=${param.objType}&periodcode=' + period + '&indexcode=' + result.code + '&relateyear=' + year);
			}
		}
	}
	
	function createwindow(title, url, width, height) {
		width = width ? width : 700;
		height = height ? height : 400;
		if (width == "100%" || height == "100%") {
			width = document.body.offsetWidth;
			height = document.body.offsetHeight - 100;
		}
		
		$.dialog({
			data:returnValue,
			content : 'url:' + url,
			lock : true,
			width : width,
			height : height,
			title : title,
			opacity : 0.3,
			cache : false,
			ok : function() {
				$('#btn_ok', this.iframe.contentWindow.document).click();
			},
			cancelVal : '关闭',
			cancel : true/* 为true等价于function(){} */
		});
	}
	
	$('#indexsel').click(function(){
		var year = $('#yearsel').combobox('getValue');
		var period = $('#periodsel').combobox('getValue');
		if(!year || !period){
			$.dialog.alert("请先选择年份和周期",null, window);
			return;
		}
		createwindow('指标体系', 'performance/selectindex.jsp?objType=${param.objType}&year='+year+'&period='+period, 600);
	});
})($);
</script>
<% }%>
</body>
</html>
