<%@ page language="java" pageEncoding="gb2312"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="h" uri="/gem-tags"%>

<!DOCTYPE html>
<html>
<head>
<title>计划管理</title>
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
<script type="text/javascript" src="jscomponent/ckeditor/ckeditor.js"></script>
<script type="text/javascript" src="js/MyDatePicker/WdatePicker.js"></script>
<script type="text/javascript">
$(function(){
	var description = $("#description_ctn").val();
	CKEDITOR.replace('description');
	CKEDITOR.instances.description.setData(description);
});
</script>
<style type="text/css">
*{font-size:12px; font-family:微软雅黑,新宋体}
</style>
</head>
<body style="overflow-x:hidden">
<form id="formobj" name="formobj" action="plan-management.htm?save"  method="post">
<input type="hidden" id="btn_sub" class="btn_sub" /> 
<input id="id" name="id" type="hidden" value="${plan.id}">
<table style="width:100%;border-spacing:1px;" class="formtable">
	<tr>
		<td align="right"><label class="Validform_label"> 计划名称 </label></td>
		<td class="value"><input class="inputxt" style="width:200px;" id="name" name="name" value="${plan.name}">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	<c:if test="${isAdmin}">
	<tr>
		<td align="right"><label class="Validform_label"> 计划类型 </label></td>
		<td class="value">
		<select class="inputxt" id="type" name="type" style="width:206px;">
		<c:if test="${plan.type == 0 || plan.type == null}">
			<option value="0" selected >岗位计划</option>
			<option value="1">部门计划</option>
		</c:if>
		<c:if test="${plan.type == 1}">
			<option value="0">岗位计划</option>
			<option value="1" selected>部门计划</option>
		</c:if>
		</select>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	</c:if>
	<tr>
		<td align="right"><label class="Validform_label"> 开始时间 </label></td>
		<td class="value">
		<input name="planBeginDate" type="Wdate" class="input1" id="planBeginDate" onfocus="new WdatePicker({dateFmt:'yyyy-MM-dd'})"  value="${plan.planBeginDate}" size="30"  maxlength="30">
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	<tr>
		<td align="right"><label class="Validform_label"> 计划描述 </label></td>
		<td class="value">
		<textarea class="inputxt" id="description" name="description" style="overflow-x:hidden;width:400px;height:100px"></textarea>
		<input id="description_ctn" type="hidden" value="${plan.description}"/>
		<span class="Validform_checktip"></span>
		</td>
	</tr>
	
		<tr>
		<td align="right"><label class="Validform_label"> 流程步骤类型 </label></td>
		<td class="value">
		<c:set var="stepType" value="0" />
		<c:if test="${plan.stepType == 1}">
		<c:set var="stepType" value="1" />
		</c:if>
		
		<c:if test="${stepType == 1}">
		<input type="radio" name="step_type" value="0">自定义流程
		<input type="radio" name="step_type" checked value="1">固定流程
		</c:if>
		<c:if test="${stepType == 0}">
		<input type="radio" name="step_type" checked value="0">自定义流程
		<input type="radio" name="step_type" value="1">固定流程
		</c:if>
		
		</td>
	</tr>
</table>
<div style="width: 690px; height: 1px;"></div>
<div id="tt" class="easyui-tabs" data-options="onSelect:function(t){$('#tt .panel-body').css('width','auto');}">
<div title="流程步骤">
<div style="padding: 3px; height: 25px; width: auto;" class="datagrid-toolbar">
	<a id="addBtn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-add'">添加</a>
	<a id="editBtn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-edit'">编辑</a> 
	<a id="delBtn" href="#" class="easyui-linkbutton" data-options="plain:true,iconCls:'icon-remove'">删除</a>
</div>
<table style="border-spacing:2px" id="participant_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE">序号</td>
		<td align="left" bgcolor="#EEEEEE">负责人</td>
		<td align="left" bgcolor="#EEEEEE">持续时间(天)</td>
		<td align="left" bgcolor="#EEEEEE">任务内容</td>
	</tr>
	<tbody id="add_steps_table" >
		<c:if test="${fn:length(taskList)  <= 0 }">
		<tr class="tpl">
			<td align="center">
			<input style="width: 20px;" type="radio" name="ck" />
			<input type="hidden" name="taskid" value="" />
			<input type="hidden" name="taskorder" value=""/>
			</td>
			<td align="left">
			<input name="taskparticipant" style="width: 200px;" disabled type="text" value=""/>
			<input name="taskParticipantValue" type="hidden" value=""/>
			</td>
			<td align="left">
			<input name="taskTimeConsuming" type="text" disabled value=""/>
			</td>
			<td align="left">
			<input name="tasksummary" style="width: 400px;" disabled type="text" value=""/>
			<input name="taskcontent" type="hidden" value=""/>
			</td>
		</tr>
		</c:if>
		<c:if test="${fn:length(taskList)  > 0 }">
			<c:forEach items="${taskList}" var="task" varStatus="stuts">
				<tr>
					<td align="center">
					<input style="width: 20px;" type="radio" name="ck" />
					<input type="hidden" name="taskid" value="${task.id }" />
					<input type="hidden" name="taskorder" value="${task.order }"/>
					</td>
					
					<td align="left">
					
					<c:set var="part_code" value=""/>
					<c:set var="part_name" value=""/>
					<c:forEach items="${task.participants}" var="aTaskPart" varStatus="part_status">
					<c:if test="${part_status.last }">
					<c:set var="part_code" value="${part_code}${aTaskPart.key}"/>
					<c:set var="part_name" value="${part_name}${aTaskPart.value}"/>
					</c:if>
					<c:if test="${!part_status.last }">
					<c:set var="part_code" value="${part_code}${aTaskPart.key},"/>
					<c:set var="part_name" value="${part_name}${aTaskPart.value},"/>
					</c:if>
					</c:forEach>
					
					<input name="taskparticipant" type="text" style="width: 200px;" disabled value="${part_name}"/>
					<input name="taskParticipantValue" type="hidden" value="${part_code }"/>
					</td>
					<td align="left">
					<input name="taskTimeConsuming" type="text" disabled value="${task.timeConsuming }"/>
					</td>
					<td align="left">
					<input name="tasksummary" style="width: 400px;" disabled type="text" value="${task.summary }"/>
					<input name="taskcontent" type="hidden" value="${task.content }"/>
					</td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</div>
</div>

<div id="fixflow" style="margin:60px 50px;display: none">
<table style="width:100%;border-spacing:1px;" class="formtable">

	<tr>
		<td align="right"><label class="Validform_label"> 选择系统流程 </label></td>
		<td class="value">
		<select class="inputxt" style="width:200px;" id="selFixflow" id="selFixflow" name="selFixflow">
		
		<c:forEach items="${fixFlows}" var="aFlow" varStatus="aflow_status">
		<c:set var="isselected" value="0" />
		<c:if test="${plan.fixFlowKey == aFlow.id}">
		<c:set var="isselected" value="1" />
		</c:if>
		
		<c:if test="${isselected == 1}">
		<option value="${aFlow.key}" selected="selected">${aFlow.name}</option>
		</c:if>
		<c:if test="${isselected == 0}">
		<option value="${aFlow.key}">${aFlow.name}</option>
		</c:if>
		</c:forEach>
		
		</select>
		</td>
	</tr>

</table>
</div>
</form>

<table style="display: none">
	<tbody id="add_steps_table_template">
		<tr>
			<td align="center">
			<input style="width: 20px;" type="radio" name="ck" />
			<input type="hidden" name="taskid" value="" />
			<input type="hidden" name="taskorder" value=""/>
			</td>
			<td align="left">
			<input name="taskparticipant" style="width: 200px;" disabled type="text" value=""/>
			<input name="taskParticipantValue" type="hidden" value=""/>
			</td>
			<td align="left">
			<input name="taskTimeConsuming" type="text" disabled value=""/>
			</td>
			<td align="left">
			<input name="tasksummary" style="width: 400px;" disabled type="text" value=""/>
			<input name="taskcontent" type="hidden" value=""/>
			</td>
		</tr>
	</tbody>
</table>


<script type="text/javascript">
	function resetTrNum(tableId) {
		$tbody = $("#" + tableId + "");
		$tbody.find('>tr').each(function(i){
			$('input[name=taskorder]', this).each(function() {
				$(this).val(i);
			});
		});
	}
	
	$(function() {
		
		if($("input[name='step_type']:checked").val() == 0){
	        	$('#tt').show();
	        	$("#fixflow").hide();
	    } else {
	        	$('#tt').hide();
	        	$("#fixflow").show();
	    }
		
		$("#btn_sub").bind('click', function(){
			
			if($("input[name='step_type']:checked").val() == 0 && ($('#add_steps_table > tr.tpl') != null && $('#add_steps_table > tr.tpl').length > 0)) {
				alert("自定义流程需要至少一个步骤节点")
				return;
			}
			
			var data = {};
			data.id = $("#id").val();
			data.name= $("#name").val();
			data.type= $("#type").val();
			data.description=CKEDITOR.instances.description.getData();
			data.summary=CKEDITOR.instances.description.document.getBody().getText();
	     	if(data.summary.length > 20) {
	     		data.summary = data.summary.slice(0, 20);
	     		data.summary += '...';
	     	}
	     	data.planBeginDate=$("#planBeginDate").val();
			data.participantList_id=$("#participantList_id").val();
			data.participantList=$("#participantList").val();
			
			data.taskparticipant="";
			data.taskParticipantValue="";
			data.taskTimeConsuming="";
			data.taskcontent="";
			data.tasksummary="";
			data.taskid="";
			data.taskorder="";
			
			if($("input[name='step_type']:checked").val() == 0){
				data.stepType = 0;
				if($('#add_steps_table > tr.tpl') == null || $('#add_steps_table > tr.tpl').length == 0){
					$('#add_steps_table > tr').each(function(i){
						data.taskparticipant += $("input[name=taskparticipant]", this).val() + ":;;:";
						data.taskParticipantValue += $("input[name=taskParticipantValue]", this).val() + ":;;:";
						data.taskTimeConsuming += $("input[name=taskTimeConsuming]", this).val()+":;;:";
						data.taskcontent += $("input[name=taskcontent]", this).val()+":;;:";
						data.tasksummary += $("input[name=tasksummary]", this).val()+":;;:";
						data.taskid += $("input[name=taskid]", this).val()+":;;:";
						data.taskorder += $("input[name=taskorder]", this).val()+":;;:";
					});
					
					if($('#add_steps_table > tr').length > 0){
						data.taskparticipant.substring(0, data.taskparticipant.length - 4);
						data.taskParticipantValue.substring(0, data.taskParticipantValue.length - 4);
						data.taskTimeConsuming.substring(0, data.taskTimeConsuming.length - 4);
						data.taskcontent.substring(0, data.taskcontent.length - 4);
						data.tasksummary.substring(0, data.tasksummary.length - 4);
						data.taskid.substring(0, data.taskid.length - 4);
						data.taskorder.substring(0, data.taskorder.length - 4);
					}
				
				}
			} else {
				data.stepType = 1;
				data.fixFlowKey = $("#selFixflow").val();
			}
			
			var url = $("#formobj").attr("action");
			$.post(url, data, function(data){
				var win = frameElement.api.opener;
				data = $.parseJSON(data);
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
			});
			
		});
		
		var ckid = 100;
		function returnObjValue(data){
			var tr;
			if(data.id){
				tr = $("#add_steps_table tr input:radio[name='ck'][value='" + data.id + "']").parent().parent();
			} else {
				tr =  $("#add_steps_table_template tr").clone();
				$("input[name=ck]", tr).val(ckid);
				$("input[name=taskid]", tr).val(" ");
				ckid += 100;
			}
	 		
	 		$("input[name=taskparticipant]", tr).val(data.participant);
	 		$("input[name=taskParticipantValue]", tr).val(data.participantValue);
	 		$("input[name=taskTimeConsuming]", tr).val(data.taskTimeConsuming);
	 		$("input[name=taskcontent]", tr).val(data.content);
	 		$("input[name=tasksummary]", tr).val(data.summary);
	 		
		 	if($("#add_steps_table").children(".tpl") && $("#add_steps_table").children(".tpl").length > 0) {
		 		$("#add_steps_table tr").remove();
		 	} 
		 	
		 	if(!data.id){
		 		$("#add_steps_table").append(tr);
			 	resetTrNum('add_steps_table');
		 	}
		}
		
		$('#addBtn').bind('click', function(){   
			$.dialog({
				content: 'url:plan-management.htm?planstep',
				data: {callback:returnObjValue},
				zIndex: 2000,
				lock : true,
				width: 800,
				height: 600,
				title: "添加流程步骤",
				parent: frameElement.api,
				opacity : 0.4,
			    button:[{name:'确认',focus:true,callback: function() {
					$('#btn_ok', this.iframe.contentWindow.document).click();
				}},{name:"取消",callback:function(){} }]
			});
	    });  
		
		$('#editBtn').bind('click', function(){   
			var tr = $("#add_steps_table tr input:radio[name=ck]:checked");
			if(!tr || tr.length != 1){
				$.dialog.alert("请先选中一个条目");
				return;
			}
			
			tr = tr.parent().parent();
			var data = {};
			data.participant = $("input[name='taskparticipant']", tr).val();
			data.participantValue = $("input[name='taskParticipantValue']", tr).val();
			data.taskTimeConsuming = $("input[name='taskTimeConsuming']", tr).val();
			data.content = $("input[name='taskcontent']", tr).val();
			data.id = $("input[name='ck']", tr).val();
			
			$.dialog({
				content: 'url:plan-management.htm?planstep',
				data: {data: data, callback:returnObjValue},
				zIndex: 2000,
				lock : true,
				width: 800,
				height: 600,
				title: "添加流程步骤",
				parent: frameElement.api,
				opacity : 0.4,
			    button:[{name:'确认',focus:true,callback: function() {
					$('#btn_ok', this.iframe.contentWindow.document).click();
				}},{name:"取消",callback:function(){} }]
			});
	    });  
		
		$('#delBtn').bind('click', function(){   
	       $("#add_steps_table").find("input:checked").parent().parent().remove(); 
	       if($("#add_steps_table > tr") == null || $("#add_steps_table > tr").length == 0) {
	    	   var tr =  $("#add_steps_table_template tr").clone();
	    	   $("#add_steps_table").append(tr);
		   } 
	       
	       resetTrNum('add_steps_table');
	    });
		
		// 流程步骤类型切换（自定义流程、固定流程）
		$("input[name='step_type']").on('click',function(e){
	        if($(this).val() == 0) {
	        	$('#tt').show();
	        	$("#fixflow").hide();
	        } else {
	        	$('#tt').hide();
	        	$("#fixflow").show();
	        }
	    });
	});
</script>
</body>