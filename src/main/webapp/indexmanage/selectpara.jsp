<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<title>四川南充烟草专卖</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/icon.css">
<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/easyui/jquery.easyui.min.js"></script>
</head>
 
<body>
	<table id="dg" class="easyui-datagrid" style="width:400px;height:250px"
                             data-options="url:'parajson.jsp',fitColumns:true,singleSelect:true">
	<thead>
			<tr>

				<th data-options="field:'paracode',width:100">参数编码</th>
				<th data-options="field:'paraname',width:100">参数名称</th>
			</tr>
		</thead>
	</table>
	<script type="text/javascript">
	
    function ret(){
    	var api = frameElement.api;
    	var row = $('#dg').datagrid('getSelected');
    	(api.data)({code:(row.paracode), name:(row.paraname)});
    	
    }
	</script>
	<input type="button" id="btn_ok" style="display: none" onclick="ret()">
</body>
</html>
