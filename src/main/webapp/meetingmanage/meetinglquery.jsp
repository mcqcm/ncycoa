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
	<h:datagrid actionUrl="meeting_management.htm?dgdata&flag=all" fit="true" fitColumns="true" queryMode="group" name="meetinglist">
		<h:dgColumn field="id" title="id" hidden="true"></h:dgColumn>
		<h:dgColumn field="meetingName" title="��������"></h:dgColumn>
		<h:dgColumn field="meetingTopics" title="��������"></h:dgColumn>
		<h:dgColumn field="meetingBeginDate" title="��ʼʱ��"  dateFormatter="yyyy-MM-dd hh:mm:ss" query="true"></h:dgColumn>
		<h:dgColumn field="meetingEndDate" title="����ʱ��" dateFormatter="yyyy-MM-dd hh:mm:ss" query="true"></h:dgColumn>
		<h:dgColumn field="meetingRoom" title="����ص�"    dictionary="ncycoa_meetingroom,room_no,room_name"  ></h:dgColumn>
		<h:dgColumn field="numAttendee" title="��������"></h:dgColumn>
		<h:dgColumn field="eatType" title="�Ͳ�����"  replace="���_0,����_1"></h:dgColumn>
		<h:dgColumn field="eatpnum" title="�Ͳ�����"  ></h:dgColumn>
		<h:dgColumn field="accommodationnum" title="ס������"  ></h:dgColumn>
		<h:dgColumn field="meetingFlag" title="����״̬" replace="���_11,ȡ��_10,δ����_0" style="color:green_10,color:red_0,color:blue_11" query="true"></h:dgColumn>
		
		<h:dgColumn field="auditDate" title="�������"  dateFormatter="yyyy-MM-dd hh:mm:ss" ></h:dgColumn>
		
		<h:dgColumn field="auditFlag" title="���״̬" replace="ͨ��_11,δ���_0,δͨ��_10" style="color:red_10,color:blue_11,color:green_0" query="true"></h:dgColumn>
		</h:datagrid>
</body>

<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='meetingBeginDate']").attr("class","easyui-datebox");
		$("input[name='meetingEndDate']").attr("class","easyui-datebox");
	});
</script>
<script type="text/javascript" src="jscomponent/easyui/jquery.easyui.min.js"></script>
</html>