<%@ page contentType="text/html; charset=gb2312" pageEncoding="gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="h" uri="/gem-tags"%>
<!DOCTYPE html>
<html>
<head>
<%
String base_path=request.getContextPath();
request.setAttribute("request_path", base_path);
%>
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<title>合同管理</title>
<link rel="stylesheet" type="text/css" href="${request_path }/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="${request_path }/jscomponent/easyui/themes/icon.css">
<link rel="stylesheet" href="${request_path }/jscomponent/validform/css/style.css" type="text/css" />
<link rel="stylesheet" href="${request_path }/jscomponent/validform/css/tableform.css" type="text/css" />
<script type="text/javascript" src="${request_path }/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="${request_path }/jscomponent/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="${request_path }/jscomponent/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="${request_path }/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="${request_path }/jscomponent/tools/datagrid.js"></script>
<script type="text/javascript" src="${request_path }/jscomponent/validform/js/Validform_v5.3.1_ncr_min.js"></script>
<script type="text/javascript" src="${request_path }/jscomponent/validform/js/Validform_Datatype.js"></script>

<script type="text/javascript" src="${request_path }/js/MyDatePicker/WdatePicker.js"></script></HEAD>
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>

</head>
<body style="overflow-x:hidden">
<label><span style="font-size:12px; font-family:微软雅黑,新宋体">合同类型:</span></label>
<select id="type" name="type" >
 <option value="1">买卖合同</option>
		  <option value="2">租赁合同</option>
		  <option value="3">仓储合同</option>
		  <option value="4">技术合同</option>
		  <option value="5">建设施工(维修)合同</option>
		  <option value="6">承揽合同</option>
		  <option value="7">委托合同</option>
		  <option value="8">赠与合同</option>
		  <option value="9">运输合同</option>
		  <option value="0">其他合同</option>
</select>
<br>
<br>
<label><span style="font-size:12px; font-family:微软雅黑,新宋体">起始日期:</span></label>
<input class="easyui-datebox" id="sDate" name="sDate">
<br>
<br>
<label><span style="font-size:12px; font-family:微软雅黑,新宋体">终止日期:</span></label>
<input class="easyui-datebox" id="eDate" name="eDate">
<br>
<br>

<input id="btn_ok" type="hidden" onclick="ret()">
<script type="text/javascript">
function ret(){
	 var api = frameElement.api;
     (api.data)({sDate:$('#sDate').datebox('getValue'),eDate:$('#eDate').datebox('getValue')});
     window.close();
}
</script>
</body>