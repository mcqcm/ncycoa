<%@ page contentType="text/html; charset=gb2312" pageEncoding="gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="h" uri="/gem-tags"%>
<!DOCTYPE html>
<html>
<head>

<META http-equiv=Content-Type content="text/html; charset=gb2312">
<title>合同管理</title>
<link rel="stylesheet" type="text/css" href="jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="jscomponent/easyui/themes/icon.css">
<link rel="stylesheet" href="jscomponent/validform/css/style.css" type="text/css" />
<link rel="stylesheet" href="jscomponent/validform/css/tableform.css" type="text/css" />
<script type="text/javascript" src="jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="jscomponent/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="jscomponent/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="jscomponent/tools/datagrid.js"></script>
<script type="text/javascript" src="jscomponent/validform/js/Validform_v5.3.1_ncr_min.js"></script>
<script type="text/javascript" src="jscomponent/validform/js/Validform_Datatype.js"></script>

<script type="text/javascript" src="js/MyDatePicker/WdatePicker.js"></script></HEAD>
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>
<script type="text/javascript">
$(function() {
	$("#formobj").Validform({
		tiptype : 1,
		btnSubmit : "#btn_sub",
		btnReset : "#btn_reset",
		ajaxPost : true,
		callback : function(data) {
			var win = frameElement.api.opener;
			if (data.success == true) {
				frameElement.api.close();
				win.tip(data.msg);
				
			} else {
				if (data.responseText == ''|| data.responseText == undefined){
					$("#formobj").html(data.msg);
				}else{
					$("#formobj").html(data.responseText);
				}
				return false;
			}
			win.reloadTable();
		}
	});
});
	
</script>
</head>
<body style="overflow-x:hidden">



<div style="width: 90%;padding: 10px">
			<div style="width: 90%;padding: 20px">
				<div id="p" class="easyui-panel" title="合同表单"
					style="width:700px;height:300px;padding:10px;">
					<table style="width:100%;border-spacing:1px;" class="formtable">
	
	<tr>
		<td align="right"><label class="Validform_label"> 合同名称 </label></td>
		<td class="value">
		<label>${contract.name}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 归口部门 </label></td>
		<td class="value">
		<label>${relevantDepartment_disp}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 合同类别 </label></td>
		<td class="value">
		<c:if test="${contract.type == 0 || contract.type == null}">
		<label>工程合同</label>
		</c:if>
		<c:if test="${contract.type == 1}">
		<label>采购合同</label>
			
		</c:if>
		<c:if test="${contract.type == 2}">
		<label>维修合同</label>
		</c:if>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 甲方 </label></td>
		<td class="value">
		<label>${contract.partyA}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 乙方 </label></td>
		
		<td class="value">
		<label>${contract.partyB}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 合同金额 </label></td>
		<td class="value">
		<label>${contract.contractValue}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 合同标的 </label></td>
		<td class="value">
		<label>${contract.contractObject}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 签订日期 </label></td>
		<td class="value">
		<label>${contract.signingDate}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 执行情况 </label></td>
		<td class="value">
		<label>${contract.implementationStage}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 完成日期 </label></td>
		<td class="value">
		<label>${contract.finishingDate}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 续签情况 </label></td>
		<td class="value">
		<label>${contract.renewal}</label>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
	<tr>
		<td align="right"><label class="Validform_label"> 审核合同 </label></td>
		<td class="value">
		<a href="#" onclick="openoffice('${contract.contractFilePath}')">合同</a>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
</table>
	</div>
	</div>
	</div>
	<form  id="formobj" name="formobj"  action="contract-management.htm?exetask"  method="post">
	<input  type="hidden" id="id" name="id" value="${contract.id}">
	<input  type="hidden" id="taskId" name="taskId" value="${taskId}">
			<div style="width: 100%;padding: 20px">
				<div id="p" class="easyui-panel" title="批注"
					style="width:700px;height:300px;padding:10px;">
					<table style="border-spacing:1px;" >
					   <tr>
					     <td><textarea name="comment" id="comment" style="width: 400px;height: 100px">同意</textarea></td>
					   </tr>
					    <tr>
		                 <td align="left"><label class="Validform_label"> 承办部门分管领导 </label>
		                                  <input class="inputxt" id="chengbanleadername" name="chengbanleadername">
		                                  <input type="hidden" id="chengbanleader" name="chengbanleader">
		                                  <a id="btn_selectobject1" href="#">选择</a>
		                 </td>
		                   
	                   </tr>
	                    <tr>
		                 <td align="left"><label class="Validform_label"> 采购部门分管领导 </label>
		                                  <input class="inputxt" id="caigouleadername" name="caigouleadername" >
		                                  <input type="hidden" id="caigouleader" name="caigouleader">
		                                  
		                                  <a id="btn_selectobject2" href="#">选择</a>
		                 </td>
		                    
	                   </tr>
					   <tr>
					   <td>
					  
					   <input type="button"   value="批准"  onclick="sub('true')">
					    <input type="button"   value="回退"  onclick="sub('false')">
				
	                    </td>
	                   </tr>
					</table>
					<table style="width:600px;border-spacing:1px;">
					 <tr bgcolor="#E6E6E6">
		                <td align="center" bgcolor="#EEEEEE">时间</td>
		                <td align="left" bgcolor="#EEEEEE">审批人</td>
		                <td align="left" bgcolor="#EEEEEE">批准信息</td>
	                 </tr>
	                 <tbody >
                      <c:forEach items="${comments }" var="item">
	                   <tr>
	                   <td>${item.time }</td><td>${item.username }</td><td> ${item.msg }</td>
	                   </tr>
	                   </c:forEach>
	                  </tbody>
                      </table>
					</div>
			</div>
<input id="outcome" name="outcome" type="hidden" value="">
<input id="btn_ok" type="hidden" onclick="ret()">
</form>
<script type="text/javascript">
function sub(val){
	if(val=="true"){
		var chengbanleadername = $('#chengbanleadername').val();
		var caigouleadername = $('#caigouleadername').val();
		if(chengbanleadername==""){
			alert('请选择分管领导');
		}else{
			$('#outcome').val(val);
			$('#formobj').submit();
			ret();
		}
	}else{
		$('#outcome').val(val);
		$('#formobj').submit();
		ret();
	}
	
	
}
function ret(){
	 var api = frameElement.api;
	 (api.data)({code:"refresh"});
}
function openoffice(path){
	if(path==''||typeof(path)=='undefined'){
		$.dialog.alert('合同文件不存在');
	}else{
		var url = "officeonline/officeopen.jsp?filename="+path;
		$.dialog({
			id:'CLLHG1976D',
			content : 'url:' + url,
			lock : true,
			width : 1000,
			height : 600,
			title : '文档编辑',
			zIndex :3000,
			opacity : 0.3,
			cache : false,
			ok : function() {
				return true;
			},
			cancelVal : '关闭',
			cancel : true/* 为true等价于function(){} */
		});
	}
		
	
}

$("#btn_selectobject1").click(function(){
	
	createwindow('选择人员','indexmanage/selectstaff.jsp',500,500,returnobjValue1 );
    });
$("#btn_selectobject2").click(function(){
	
	createwindow('选择人员','indexmanage/selectstaff.jsp',500,500,returnobjValue2 );
    });
function returnobjValue1(data){

	var array = data.code;
	var staffcodes=array[0].staffcode;
	var staffnames=array[0].staffname;
	
	$('#chengbanleader').val(staffcodes);
	$('#chengbanleadername').val(staffnames);
	
}
function returnobjValue2(data){

	var array = data.code;
	var staffcodes=array[0].staffcode;
	var staffnames=array[0].staffname;
	
	$('#caigouleader').val(staffcodes);
	$('#caigouleadername').val(staffnames);
	
}
function createwindow(title, url, width, height,func) {
	
	$.dialog({
			id:'CLHG1976D',
			data:func,
			content : 'url:' + url,
			lock : true,
			width : width,
			height : height,
			title : title,
			zIndex :2000,
			opacity : 0.3,
			cache : false,
			ok : function() {
				$('#btn_ok', this.iframe.contentWindow.document).click();
				return true;
			},
			cancelVal : '关闭',
			cancel : true/* 为true等价于function(){} */
		});
}   
</script>
</body>