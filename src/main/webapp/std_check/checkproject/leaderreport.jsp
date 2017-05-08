<%@ page language="java" pageEncoding="UTF-8" import="java.util.*,com.entity.system.*"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.activiti.engine.*"%>
<%@page import="org.activiti.engine.repository.ProcessDefinition"%>

<%@page import="org.activiti.engine.task.Task"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="h" uri="/gem-tags"%>

<!DOCTYPE html>
<%
String path = request.getContextPath();
 String taskId=request.getParameter("id");
 ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
	ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");
	TaskService taskService = processEngine
			.getTaskService();
%>
<html>
<head>
<title>南充烟草专卖局</title>
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/icon.css">
<link rel="stylesheet" href="<%=path%>/jscomponent/validform/css/style.css" type="text/css" />
<link rel="stylesheet" href="<%=path%>/jscomponent/validform/css/tableform.css" type="text/css" />
<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/tools/datagrid.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/validform/js/Validform_v5.3.1_ncr_min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/validform/js/Validform_Datatype.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/tools/ajaxfileupload.js"></script>
<script language=
                "javascript" type="text/javascript" src="<%=path%>/js/MyDatePicker/WdatePicker.js">  </script>
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>
<script type="text/javascript">

function officeopen(filepath){
		filepath='\\checkproject\\'+filepath;
	  var url='/ncycoa/std_check/std_officeopen.jsp?filename='+filepath;
	     window.open(url);
}
function F1()
{
	//if (CkEmptyStr(document.all("DocNo"),"层次码不能为空！"))
	//{
		//alert (document.all("act"));
		document.formobj.result.value="1";
		document.all("formobj").submit();
	//}
}

var count = 2;  
/** 
* 生成多附件上传框 
*/  
function createInput(parentId){  
    count++;  
    var str = '<div name="div" ><font style="font-size:12px;">附件</font>'+  
    '   '+ '<input type="file" contentEditable="false" id="uploads' + count + '' +  
    '" name="uploads'+ count +'" value="" style="width: 220px"/><input type="button"  value="删除" onclick="removeInput(event)" />'+'</div>';  
    document.getElementById(parentId).insertAdjacentHTML("beforeEnd",str);  
}  
/** 
* 删除多附件删除框 
*/  
function removeInput(evt, parentId){  
   var el = evt.target == null ? evt.srcElement : evt.target;  
   var div = el.parentNode;  
   var cont = document.getElementById('more');         
   if(cont.removeChild(div) == null){  
    return false;  
   }  
   return true;  
} 
function addOldFile(data){  
    var str = '<div name="div' + data.name + '" ><a href="#" style="text-decoration:none;font-size:12px;color:red;" onclick="removeOldFile(event,' + data.id + ')">删除</a>'+  
    '   ' + data.name +   
    '</div>';  
    document.getElementById('oldImg').innerHTML += str;  
}  
  
function removeOldFile(evt, id){  
    //前端隐藏域，用来确定哪些file被删除，这里需要前端有个隐藏域  
    $("#imgIds").val($("#imgIds").val()=="" ? id :($("#imgIds").val() + "," + id));  
    var el = evt.target == null ? evt.srcElement : evt.target;  
    var div = el.parentNode;  
    var cont = document.getElementById('oldImg');      
    if(cont.removeChild(div) == null){  
        return false;  
    }  
    return true;  
} 
function ajaxFileUploadImg(){  
    //获取file的全部id  
    var uplist = $("input[name^=uploads]");  
var arrId = [];  
for (var i=0; i< uplist.length; i++){  
    if(uplist[i].value){  
        arrId[i] = uplist[i].id;  
    }  
    }  
    ////////////////
    var taskid=document.getElementById("taskid").value;
    ////////////////
$.ajaxFileUpload({  
    url:'/ncycoa/checkproject.htm?upreport',  
    secureuri:false,  
    fileElementId: arrId,  //这里不在是以前的id了，要写成数组的形式哦！  
    dataType: 'plain',  
    data: {  
                 //需要传输的数据  
    	taskid:taskid,
            },  
    success: function (data){  
    	document.all("formobj").submit();
    },  
    error: function(data){  
    }  
});  
}
</script>
</head>
<body style="overflow-x:hidden">
<form id="formobj" name="formobj" action="/ncycoa/std_check/havedo.jsp" enctype="multipart/form-data" method="post">
&nbsp;&nbsp;<a href="#" class="easyui-linkbutton"
				        data-options="iconCls:'icon-add',plain:true" 
				        onclick="ajaxFileUploadImg()">提交</a>&nbsp;&nbsp;<a href="/ncycoa/std_check/checkproject/deleteinstance.jsp?id=<%=taskId %>" class="easyui-linkbutton"
				        data-options="iconCls:'icon-remove',plain:true" >结束流程</a>
<input id="taskid" name="taskid" type="hidden" value="<%=taskId%>">
<input id="result" name="result" type="hidden">
<table style="width:100%;border-spacing:1px;"  class="formtable">
	<tr>
		<td align="right" width="30%"><label class="Validform_label"> 发起人</label></td>
		<td class="value"  width="70%"><input class="inputxt" style="width:200px;" id="staffName" name="staffName" value="<%=taskService.getVariable(taskId, "staffName") %>">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
			<tr>
		<td align="right"><label class="Validform_label"> 评审方案编码</label></td>
		<td class="value"><input class="inputxt" style="width:200px;" id="checkCode" name="checkCode" value="<%=taskService.getVariable(taskId, "checkCode") %>">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
		<tr>
		<td align="right"><label class="Validform_label"> 评审方案名称</label></td>
		<td class="value"><input class="inputxt" style="width:200px;" id="checkName" name="checkName" value="<%=taskService.getVariable(taskId, "checkName") %>">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	<% String startdate=taskService.getVariable(taskId, "startdate").toString();
	System.out.println(startdate);
	%>
		<tr>
		<td align="right"><label class="Validform_label"> 发起时间 </label></td>
		<td class="value"><input class="inputxt" style="width:200px;" class="Wdate" type="Wdate" id="startTime" onfocus="new WdatePicker({lang:'zh-cn'})" name="startTime" value="<%=taskService.getVariable(taskId, "startdate") %>">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
			<%
			Object filepathObject=taskService.getVariable(taskId, "filepath");
			if(filepathObject!=null){
				String filepath=filepathObject.toString();
	String[] filepaths=filepath.split(";");
	%>
	<tr>
		<td align="right"><label class="Validform_label"> 评审方案 </label></td>
		<td class="value"><input type="button"  value=" 评审方案内容   " onclick="officeopen('<%=filepaths[0]%>')" />
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	<%} %>
	<tr>
		<td align="right"><label class="Validform_label"> 上传初评报告</label></td>
		<td class="value"><input type="file" id="uploads1" name="uploads1" style="width:205px;">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
</table>

</form>


</body>