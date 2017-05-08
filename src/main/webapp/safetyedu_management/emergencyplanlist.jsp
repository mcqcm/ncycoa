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
*{font-size:12px; font-family:΢���ź�,������}
</style>
</head>
<body>
	<h:datagrid actionUrl="emergencyplan_management.htm?dgdata" fit="true" fitColumns="true" queryMode="group" name="checkplanlist">
		<h:dgColumn field="id" title="id" hidden="true"></h:dgColumn>
		<h:dgColumn field="no" title="���" query="true"></h:dgColumn>
		<h:dgColumn field="name" title="Ԥ������"></h:dgColumn>
		<h:dgColumn field="type" title="Ԥ�����" replace="�ۺ�Ԥ��_0,ר��Ԥ��_1,�ֳ�����Ԥ��_2" query="true"></h:dgColumn>
		<h:dgColumn field="manageDepart" title="�ܼ쵥λ/����" query="true"  dictionary="base_org,orgcode,orgname"></h:dgColumn>
		<h:dgColumn field="makeTime" title="�����޶�ʱ��" dateFormatter="yyyy-MM-dd" query="true" queryMode="scope"></h:dgColumn>	
		<h:dgColumn field="filePath" title="����"></h:dgColumn>
		<h:dgColumn title="����" field="opt"></h:dgColumn>
		<h:dgFunOpt funname="fileload({filePath})" title="��������"></h:dgFunOpt>
		<h:dgColumn field="memo" title="��ע" ></h:dgColumn>
		<h:dgToolBar url="emergencyplan_management.htm?add" icon="icon-add" funname="add" title="����"></h:dgToolBar>
		<h:dgToolBar url="emergencyplan_management.htm?del" icon="icon-remove" funname="del" title="ɾ��"></h:dgToolBar>
		<h:dgToolBar url="emergencyplan_management.htm?update" icon="icon-reload" funname="myedit" title="����"></h:dgToolBar>
	</h:datagrid>
</body>

<script type="text/javascript">
function fileload(fileName){
	   window.open("fileupload/downweb.jsp?filename="+fileName);
}

	$(document).ready(function(){
		$("input[name='makeTime_begin']").attr("class","easyui-datebox");
		$("input[name='makeTime_end']").attr("class","easyui-datebox");
	});
	
	
	function myedit(title, actionUrl, gname, width, height) {
		gridname=gname;
		var rows;
		try{rows=$('#'+gname).datagrid('getSelections');}catch(ex){}
		try{rows=$('#'+gname).treegrid('getSelections');}catch(ex){}
		
		if (!rows || rows.length==0) {
			tip('����ѡ��һ����¼');
			return;
		}
		if (rows.length > 1) {
			tip('����ͬʱ�Զ�����¼�༭���빴ѡһ����¼');
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