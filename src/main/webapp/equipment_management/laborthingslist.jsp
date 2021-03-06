<%@ page language="java" pageEncoding="gb2312"%>
<%@ taglib prefix="h" uri="/gem-tags"%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<link rel="stylesheet" type="text/css" href="jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jscomponent/easyui/themes/icon.css">
<script type="text/javascript" src="jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="jscomponent/tools/datagrid.js"></script>
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>
</head>
<body>
	<h:datagrid actionUrl="laborthings_management.htm?dgdata" fit="true" fitColumns="true" queryMode="group" name="elevatorlist">
		<h:dgColumn field="id" title="id" hidden="true"></h:dgColumn>
		<h:dgColumn field="type" title="劳动保护用品类别" query="true"></h:dgColumn>
     	<h:dgColumn field="performanceRequire" title="性能要求" query="true"></h:dgColumn>
		<h:dgColumn field="status" title="用品状态" ></h:dgColumn>
		<h:dgColumn field="givener" title="发放的人员" ></h:dgColumn>
		<h:dgColumn field="amount" title="每人发放的套数"></h:dgColumn>
		<h:dgColumn field="givenTime" title="发放时间" dateFormatter="yyyy-MM-dd hh:mm:ss" query="true" queryMode="scope"></h:dgColumn>
		<h:dgToolBar url="laborthings_management.htm?add" icon="icon-add" funname="add" title="新增"></h:dgToolBar>
		<h:dgToolBar url="laborthings_management.htm?del" icon="icon-remove" funname="del" title="删除"></h:dgToolBar>
		<h:dgToolBar url="laborthings_management.htm?update" icon="icon-reload" funname="myedit" title="更新"></h:dgToolBar>
	</h:datagrid>
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='givenTime_begin']").attr("class","easyui-datebox");
		$("input[name='givenTime_end']").attr("class","easyui-datebox");
	});
	
	
	function myedit(title, actionUrl, gname, width, height) {
		gridname=gname;
		var rows;
		try{rows=$('#'+gname).datagrid('getSelections');}catch(ex){}
		try{rows=$('#'+gname).treegrid('getSelections');}catch(ex){}
		
		if (!rows || rows.length==0) {
			tip('请先选择一条记录');
			return;
		}
		if (rows.length > 1) {
			tip('不能同时对多条记录编辑，请勾选一条记录');
			return;
		}
	
		if(actionUrl.indexOf("?") >= 0) {
			actionUrl += '&id='+ rows[0].id;
		} else {
			actionUrl += '?id='+ rows[0].id;
		}
		createwindow(title, actionUrl, width, height);
	}
</script>
<script type="text/javascript" src="jscomponent/easyui/jquery.easyui.min.js"></script>
</html>