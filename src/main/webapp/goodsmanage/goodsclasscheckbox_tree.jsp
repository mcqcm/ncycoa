<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.common.*,com.entity.system.*,com.dao.system.*,com.db.*" errorPage="" %>
<%
request.setCharacterEncoding("gb2312");
String StoreEventNo=Format.NullToBlank(request.getParameter("StoreEventNo"));
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";

%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<base target=_self>
<HEAD>

<META http-equiv="Content-Type" content="text/html; charset=GB18030">
<META http-equiv="Content-Style-Type" content="text/css">
<link rel="stylesheet" href="../images/ztree/zTreeStyle.css" type="text/css">
<link rel="stylesheet" type="text/css" href="../css/style.css">
<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script type="text/javascript" src="<%=path%>/js/ztree/jquery-1.4.4.min.js"></script>
<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.core-3.5.js"></script>
<script type="text/javascript" src="<%=path%>/js/ztree/jquery.ztree.excheck-3.5.min.js"></script>
<SCRIPT type="text/javascript">
function setCheck() {
		var zTree = $.fn.zTree.getZTreeObj("treeDemo"),
		py = $("#py").attr("checked")? "p":"",
		sy = $("#sy").attr("checked")? "s":"",
		pn = $("#pn").attr("checked")? "p":"",
		sn = $("#sn").attr("checked")? "s":"",
		type = { "Y":py + sy, "N":pn + sn};
		zTree.setting.check.chkboxType = type;
	}
		var zNodes =<%=UnitTreecheckbox.getTreeNew("com_goodsclass","goodscode","goodsname","parentgoodscode","WF")%>;
var setting = {
				check: {
					enable: true
				},
				data: {
					simpleData: {
						enable: true
					}
				}
			};
		$(document).ready(function(){
		$.fn.zTree.init($("#treeDemo"), setting, zNodes);
		setCheck();
	});	
</SCRIPT>
<TITLE>这是一颗树</TITLE>
</HEAD>
<BODY bgcolor="#DBECFE" leftmargin="0" rightmargin="0" topmargin="0" bottommargin="0">
<form name="form1" id="form1" method="post" action="../servlet/PageHandler">
<div style="overflow-x: auto; overflow-y: auto; height: 480px;">
	<ul id="treeDemo" class="ztree"></ul>
</div>
<input type="hidden" id="entity" name="entity" value="COM_INSTOREITEM"/>
<input type="submit" name="Submit" value="提交" style="display:none">
<input type="hidden" id="btn_ok" onclick="ret()">
         <input type="txt" name="StoreEventNo" id="StoreEventNo" value="<%=StoreEventNo %>" style="display:none">
         <input type="txt" name="goodscode" id="goodscode" value="" style="display:none">
         <input name="act" type="hidden" id="act" value="addDul">
         <input name="action_class" type="hidden" id="action_class" value="com.action.system.SystemGoodsinformINAction">
</form>
<script type="text/javascript">
function ret(){
	
	var api = frameElement.api;
		
	var zTree = $.fn.zTree.getZTreeObj("treeDemo");
	 
    var nodes = zTree.getCheckedNodes(true);
		var orgname,orgcode="";
    for (var i = 0; i < nodes.length; i++) {
				orgcode+=nodes[i].id+";";
    }        
    document.getElementById("goodscode").value=orgcode;
    document.all("Submit").click();
    (api.data)({code:"refresh"});
}
</script>
</BODY>
</HTML>
