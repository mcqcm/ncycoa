<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.sql.*,com.db.*,com.common.*,com.entity.stdapply.*,com.entity.system.*" errorPage="" %>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="org.activiti.engine.*"%>

<%@page import="org.activiti.engine.task.Task"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%
//String path = request.getContextPath();
//String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String bm=Format.NullToBlank(request.getParameter("unitccm"));
//System.out.println(bm+"dvxvxvxcvx");
if (bm.equals("")) bm="NC";
%>
<HTML>
<HEAD>
<TITLE>四川省南充烟草公司</TITLE>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
</HEAD>
<%
	//System.out.println(bm);
		String taskId=request.getParameter("id");
	    ApplicationContext ctx = WebApplicationContextUtils.getWebApplicationContext(application);
		ProcessEngine processEngine = (ProcessEngine) ctx.getBean("processEngine");
		TaskService taskService = processEngine
				.getTaskService();
		String ApplyId=taskService.getVariable(taskId, "applyid").toString();
		int applyid=Integer.parseInt(ApplyId.toString());
		DocApplyPerson applyperson=new DocApplyPerson(applyid);
	String staffcode=applyperson.getApplystaffcode();
	String staffname=applyperson.getApplyperson();
	String applyapart=applyperson.getApplyapart();
	String applydate=(applyperson.getApplydate()).substring(0,10);
	String applyreason=applyperson.getApplyreason();
	OrgPosition orgPosition = new OrgPosition();
	DataTable dTable = orgPosition.getOrgPositionCode(staffcode);//返回该员工对应的机构编码和岗位编码（这个会返回两条及以上的记录）
	String orgcode = dTable.get(0).getString("orgcode");
%>

<script language=
                "javascript" type="text/javascript" src="<%=request.getContextPath()%>/js/MyDatePicker/WdatePicker.js">  </script>
<script language="javascript" src="<%=request.getContextPath()%>/js/public/select.js"></script> 
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tab/jquery.js"></script>
                <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jscomponent/easyui/themes/icon.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/jscomponent/easyui/jquery.easyui.min.js"></script>
 <script type="text/javascript" src="<%=request.getContextPath()%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jscomponent/tools/stdapplyoutwindow.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/tab/tab/tab.js"></script>
<style type="text/css">
@IMPORT url("<%=request.getContextPath()%>/js/tab/tab/tab.css");

h2 {
	background-color: #cccccc;
	padding: 4px;
	font-size: 18px;
	font-family: "黑体";
}
#tab_menu {
	padding: 0px;
	width: 100%;
	height: 30px;
	overflow: hidden;
}
#tab_menu2 {
	padding: 0px;
	width: 100%;
	height: 30px;
	overflow: hidden;
}
	#page {
	width: 100%;
	height: 32%;
	border: solid 1px #cccccc;
	}
		#page2 {
	width: 100%;
	height: 33%;
	border: solid 1px #cccccc;
	}
</style>
<script language="javascript">
var tab=null;
$( function() {
	  	tab = new TabView( {
		containerId :'tab_menu',
		pageid :'page',
		cid :'tab_po',
		position :"top"
	});
		  	tab2 = new TabView( {
		containerId :'tab_menu2',
		pageid :'page2',
		cid :'tab_po2',
		position :"top"
	});
});
function showModalDialogWin(url,wh,hg) {
        var obj = window.showModalDialog(url, window,"status:false;dialogWidth:"+wh+"px;dialogHeight:"+hg+"px;scrollbar=no;help: no;resizable:no;status:no;");
}

function F2()
{
	document.all("reset").click();
}
function F1()
{
	//if (CkEmptyStr(document.all("DocNo"),"层次码不能为空！"))
	//{
		//alert (document.all("act"));
		document.form1.result.value="1";
		document.all("form1").submit();
	//}
}

function F4()
{
	if (CheckSelect("form1"))
	{
		if (confirm("父级菜单的删除将级联删除子菜单，是否继续？"))
		{
			document.all("form1").submit();
		}
	}
	else
	{
		alert ("你没有选中要删除的内容！");
	}
}
function F5()
{
	window.location.reload();
}
var index1=1;
var index2=300;
function F8(positioncode,positionname,orgcode)
{
		while(index1>1)
		{
			tab.close(index1);
			index1=index1-5;
		}
		while(index2>300)
		{
			tab2.close(index2);
			index2=index2-5;
		}
        var newurl='std_list.jsp?positioncode='+positioncode+'&orgcode='+orgcode;
	    var id=index1+5;
		tab.add( {
		id :id,
		title :name==""?("标签页面"+(index1+1)):positionname,
		url :newurl,
		isClosed :true
	});
	index1=index1+5;
  //window.open(newurl,"attachposlist");
}
function page()
{
var url=document.form1.url.value;
var name=document.form1.name.value;
var id=index1+5;
		tab.add( {
		id :id,
		title :name==""?("标签页面"+(index1+1)):name,
		url :url,
		isClosed :true
	});
		index1=index1+5;
}
function page2()
{
var url=document.form1.url.value;
var name=document.form1.name.value;
var flag=document.form1.flag.value;
if(flag=='std')
{
		while(index2>300)
		{
			tab2.close(index2);
			index2=index2-5;
		}
}
var id=index2+5;
		tab2.add( {
		id :id,
		title :name==""?("标签页面"+(index2+1)):name,
		url :url,
		isClosed :true
	});
		index2=index2+5;
}
function checkradio()
{
	var applyid = document.getElementById('applyid').value;
	var check=document.all.radio;
	  for(var i=0;i<check.length;i++){
   		 if(check[i].checked==true){
     			if(check[i].value=='new')
				{
					while(index1>1)
					{
						tab.close(index1);
						index1=index1-5;
					}
					while(index2>300)
					{
						tab2.close(index2);
						index2=index2-5;
					}
					var orgcode=document.getElementById('orgcode').value;
        			var newurl='/ncycoa/stdapply/std_list.jsp?applyid='+applyid+'&orgcode='+orgcode;
	    			var id=index1+5;
					tab.add( {
						id :id,
						title :name==""?("标签页面"+(index1+1)):"标准",
						url :newurl,
						isClosed :true
					});
					index1=index1+5;
				}else if(check[i].value=='modify')
				{
					var applystaffcode = document.getElementById('applystaffcode').value;
					  var stdupnewurl='/ncycoa/stdapply/std_applymodmanage.jsp?applystaffcode='+applystaffcode+'&applyid='+applyid+'&type='+'修订';
		//			  createwindowNoButton('修订标准',stdupnewurl,'1000px','800px');
  		//			//window.open(stdupnewurl,"stdlist");
 // 						window.showModalDialog(stdupnewurl,window,"dialogWidth=1000px;dialogHeight=1000px");
  		createwindowIframe("修订标准", stdupnewurl, "1000px", "520px","stdlist","修订")
  						
  						

				}else if(check[i].value=='dele')
				{
					var applystaffcode = document.getElementById('applystaffcode').value;
					  var stdupnewurl='/ncycoa/stdapply/std_applymodmanage.jsp?applystaffcode='+applystaffcode+'&applyid='+applyid+'&type='+'废除';
		createwindowIframe("废除标准", stdupnewurl, "1000px", "520px","stdlist","废除")
  					//window.open(stdupnewurl,"stdlist");
  		//				window.showModalDialog(stdupnewurl,window,"dialogWidth=1000px;dialogHeight=1000px");
  		//				window.location.reload();
  						
  					
				}
     		}
		}


}
function createwindowIframe(title, url, width, height,siframe,buttonname) {
// 		width = width ? width : 700;
// 		height = height ? height : 400;
// 		if (width == "100%" || height == "100%") {
// 			width = document.body.offsetWidth;
// 			height = document.body.offsetHeight - 100;
// 		}
var api = frameElement.api, W = api.opener;
		var applyid = document.getElementById('applyid').value;
		var orgcode=document.getElementById('orgcode').value;
		if (typeof (windowapi) == 'undefined') {
			W.$.dialog({
				//data:returnValue,
				modal:true,
				content : 'url:' + url,
				lock : false, 
				width : width,
				height : height,
				title : title,
				opacity : 0.3,
				cache : false,
				button: [
        		{
            			name: buttonname,
            			callback: function(){
                			$('#F8', this.iframe.contentWindow.document.getElementById(siframe).contentWindow.document).click();
                   			disabled: false
                   			      setTimeout(function(){
                   	while(index1>1)
					{
						tab.close(index1);
						index1=index1-5;
					}
					while(index2>300)
					{
						tab2.close(index2);
						index2=index2-5;
					}
        			var newurl='/ncycoa/stdapply/std_list.jsp?applyid='+applyid+'&orgcode='+orgcode;
	    			var id=index1+5;
					tab.add( {
						id :id,
						title :name==""?("标签页面"+(index1+1)):"标准",
						url :newurl,
						isClosed :true
					});
					index1=index1+5;
					 return true;
                   			       },1000);
               				 return false;
            			},
            			focus:true	
        		}
        		],
				cancelVal : '关闭',

				cancel :function(){
				//window.location.reload();
				},
				close:function(){
				//window.location.reload();
				return true;
				}
				
			});
		}
	}
function appytablebutton()
{
var applyid=document.getElementById("applyid").value;
var applyorg=document.getElementById("applyapart").value;
var applydate=document.getElementById("applydate").value;
var applyreason=document.getElementById("applyreason").value;
var url='/ncycoa/stdapply/applytable2.jsp?applyid='+applyid+'&applyorg='+applyorg+'&applydate='+applydate+'&applyreason='+applyreason;
createwindowNoButton('企业标准修订申请表',url,'1000px','500px');
//window.open(url);
}
</script>
<BODY class="mainbody" onLoad="this.focus()" style="background-color:white" style="height:100%;" >

<form name="form1" id="form1" method="post" style="background-color:white" action="<%=request.getContextPath()%>/servlet/PageHandler">
<table width="100%" height="100%" border="0"  cellpadding="0" cellspacing="0">
<tr>
<td width="15%" height="80%"  class="main_table_centerbg">
<table width="100%" height="35%" border="0" cellpadding="0" cellspacing="0">
       <tr>
    <td colspan="3" valign="middle" class="table_td_jb">&nbsp;&nbsp;<a href="#" class="easyui-linkbutton"
				        data-options="iconCls:'icon-add',plain:true"  onClick="F1()">提交[F1]</a>　　<a href="#"  class="easyui-linkbutton"
				        data-options="iconCls:'icon-reload',plain:true" onClick="F5()">刷新[F5]</a></td>
       </tr>
<!--  <tr>   -->
<!--  <td colspan="2" valign="middle">-->
<!--      <table width="100%" border="0" cellpadding="3" cellspacing="0">-->

        <tr>
          <td width="40%" align="center"> 申 请 人</td>
		  <td width="60%" ><input type="text" name="applyperson" value="<%=staffname %>" id="applyperson" size="20" maxlength="30" readonly="readonly"><input type="hidden" name="applyid" value="<%=applyid%>" id="applyid"></td>
		  </tr>
		  		 <tr>
          <td width="40%" align="center"> 申请时间</td>
           <td width="60%"><input name="applydate" type="text" class="Wdate" id="applydate" onFocus="new WdatePicker(this,null,false,'whyGreen')"   value="<%=applydate %>"  readonly="readonly" size="20" maxlength="30"></td>
        </tr>
                <tr>
          <td width="40%" align="center"> 申请部门</td>
		  <td width="60%"><input type="text" name="applyapart" value="<%=applyapart %>" id="applyapart" size="20" maxlength="60"></td>
		  </tr>
		  </table>
		  <table width="100%" height="60%" border="0" cellpadding="0" cellspacing="0">
		  <tr>          <td width="40%" align="center"> 申请事项:</td>
		  </tr>
		  <tr>
		  <td width="100%" align="center"><input type="radio" name="radio" value="new" >新建
		         <input type="radio"  name="radio" value="modify">修订
		         <input type="radio"  name="radio" value="dele">废除
		    <input type="button" name="button0" value="选择" onClick="checkradio()" >		 </td>
        </tr>

		  <tr>
		            <td width="100%" align="center"> 申请理由:</td>
		            </tr><tr>
		  <td width="100%"  align="center">
		  <label>
		    <textarea name="applyreason" id="applyreason" value="<%=applyreason %>" style="width:150px;height:200px"><%=applyreason %></textarea>
		   </label></td>
        </tr>
        <tr>
		  <td width="100%" align="center">
				 <input type="button" name="button0" value="查看申请表" onClick="appytablebutton()" >
		 </td>
        </tr>
          <tr>
        <td><div align="right"><input name="act" type="hidden" id="act" value="appro">
          <input name="orgcode" type="hidden" id="orgcode" value="<%=orgcode%>">
          <input type='hidden' name='sugstaffcode'  value="<%=staffcode %>">
          <input name="taskId" type="hidden" id="taskid" value="<%=taskId %>">
          <input name="result" type="hidden" id="result" value="">
          <input name="url" type="hidden" id="url" value="">
          <input name="name" type="hidden" id="name" value="">
          <input name="flag" type="hidden" id="flag" value="">
          <input type='hidden' name='applystaffcode' id='applystaffcode'  value="<%=staffcode %>">
          <input name="hidbutton" type="button" id="hidbutton" value="" onClick="page();" style="display:none">
          <input name="hidbutton2" type="button" id="hidbutton2" value="" onClick="page2();" style="display:none"></div>
        <input name="action_class" type="hidden" id="action_class" value="com.action.stdapply.StdApplyAction"></td>
    </tr>
    <tr>
    <td width="49%" height="5" class="main_table_bottombg"><img src="<%=request.getContextPath()%>/images/table_lb.jpg" width="10" height="5"></td>
    <td width="48%" height="5" class="main_table_bottombg"></td>
    <td width="3%" height="5" align="right" class="main_table_bottombg"><img src="<%=request.getContextPath()%>/images/table_rb.jpg" width="10" height="5"></td>
  </tr>
      </table>
      </td>
  <td width="1%"></td>
  <td width="84%"  height="100%"  class="main_table_centerbg">
 	<div id="tab_menu" style="text-align: center;position: relative; border:1px "></div>
	<div id="page" style="text-align: center;position: relative;  height:45%; width:100%; border:1px "></div> 
	<div id="tab_menu2" style="text-align: center;position: relative; border:1px "></div>
	<div id="page2" style="text-align: center;position: relative;  height:45%; width:100%; border:1px "></div> 
	</td>
</tr>
</table>

</form>
</BODY>
</HTML>

