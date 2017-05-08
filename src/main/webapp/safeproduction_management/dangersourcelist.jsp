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
	<h:datagrid actionUrl="dangersource_management.htm?dgdata" fit="true" fitColumns="true" queryMode="group" name="dangersourcelist">
		<h:dgColumn field="id" title="id" hidden="true"></h:dgColumn>
		<h:dgColumn field="activityType" title="����ͳ���" query="true"></h:dgColumn>
		<h:dgColumn field="jobActivity" title="��ҵ�"></h:dgColumn>
     	<h:dgColumn field="mainDangerSource" title="Σ��Դ"></h:dgColumn>
		<h:dgColumn field="danger" title="���ܵ��µ��¹�"></h:dgColumn>
		<h:dgColumn field="dangerLevel" title="���ռ���" replace="�ش�_0,һ��_1" query="true" ></h:dgColumn>
		<h:dgColumn field="measureA" title="���ƴ�ʩA"></h:dgColumn>
		<h:dgColumn field="memo" title="��ע"></h:dgColumn>
		<h:dgToolBar url="dangersource_management.htm?add" icon="icon-add" funname="add" title="����"></h:dgToolBar>
		<h:dgToolBar url="dangersource_management.htm?del" icon="icon-remove" funname="del" title="ɾ��"></h:dgToolBar>
		<h:dgToolBar url="dangersource_management.htm?update" icon="icon-reload" funname="myedit" title="����"></h:dgToolBar>
		<h:dgToolBar onclick="success()" url="dangersource_management.htm?import" icon="icon-reload" title="��Excel����"></h:dgToolBar>
	</h:datagrid>
	<div>����ʱ�ڴ�ѡ���ļ���<input type="file" name="f" id="f" /></div> 
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='checkTime_begin']").attr("class","easyui-datebox");
		$("input[name='checkTime_end']").attr("class","easyui-datebox");
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
	
	function success(){
		alert("����ɹ�");
		//alert(document.getElementById("f").value);
		//alert(getPath(document.getElementById("f"));
		self.location.href="dangersource_management.htm?import&path="+document.getElementById("f").value ;
	}
	
	//���������޸��������ȫ���õ�javascript���룬����ie�� firefoxȫϵ��

	function getPath(obj)  
	{  
	  if(obj)  
	    {  
	 
	    if (window.navigator.userAgent.indexOf("MSIE")>=1)  
	      {  
	        obj.select();  
	 
	      return document.selection.createRange().text;  
	      }  
	 
	    else if(window.navigator.userAgent.indexOf("Firefox")>=1)  
	      {  
	      if(obj.files)  
	        {  
	 
	        return obj.files.item(0).getAsDataURL();  
	        }  
	      return obj.value;  
	      }  
	    return obj.value;  
	    }  
	}  
	//����objΪinput file����
</script>
<script type="text/javascript" src="jscomponent/easyui/jquery.easyui.min.js"></script>
</html>