<%@page import="com.entity.system.UserInfo"%>
<%@ page language="java" import="java.util.*" pageEncoding="gb2312"%>
<%@page import="com.entity.system.TbmSumlog"%>
<%@taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+
                  request.getServerName()+":"+
		          request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<title>�Ĵ��ϳ��̲�ר��</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/icon.css">
<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="<%=path%>/js/public/select.js"></script>
</head>
<%
UserInfo u=(UserInfo)request.getSession().getAttribute("UserInfo");
String year=request.getParameter("year");
String month=request.getParameter("month");
String dataurl="meritjson.jsp?class=c&year="+year+"&month="+month;
%>
<body>
   <div style="width: 100%">
    <table id="dg" class="easyui-datagrid" style="height:700px"
    data-options="url:'<%=dataurl %>',fitColumns:true,singleSelect:true,collapsible:true">
    <thead>
    <tr>
	    <th data-options="field:'company',width:100">��λ</th>
	    <th data-options="field:'keyindexscore',width:100">�ؼ���Ч�÷�</th>
	    <th data-options="field:'baseindexscore',width:100">��������/�����÷�</th>
	    <th data-options="field:'commindexscore',width:100">ͨ��ָ��</th>
	    <th data-options="field:'otherindexscore',width:100">����</th>
	    <th data-options="field:'addscore',width:100">ֱ�ӼӼ���</th>
	    <th data-options="field:'staffallmerit',width:100">�ۺϵ÷�</th>
    </tr>
    </thead>
    </table>
   
    </div>
     <div align="right">
   <input id="btnPrint" type="button" value="��ӡ" onclick="javascript:window.print();"/>
  </div>
 <script type="text/javascript">
   
 </script>
</body>
</html>