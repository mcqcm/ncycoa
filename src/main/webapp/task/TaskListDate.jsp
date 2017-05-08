<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.db.*,com.common.*,com.entity.system.UserInfo,com.entity.task.*,com.dao.system.*" errorPage="" %>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";



UserInfo uinfo=(UserInfo)request.getSession().getAttribute("UserInfo");
Role.sysmng.login.User u=(Role.sysmng.login.User)request.getSession().getAttribute("USER");

String date = Format.NullToBlank(request.getParameter("date"));
//System.out.println(date.equals(""));
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>南充市烟草公司</TITLE>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
<base target="_self">
</HEAD>
<%
	
    int page_no=Integer.parseInt(Format.NullToZero(request.getParameter("page_no")));
	int per_page=uinfo.getPerpage_third();
	//Log.Debug(per_page);
	DataTable dt=Task.getTaskListByDate(page_no,per_page,u.getYybdm(),date);
	int dtcount=Task.getTaskListCountByDate(u.getYybdm(),date);
	//System.out.println(dtcount);
	int pagecount=0;
	if(dtcount%per_page==0)
	    pagecount=dtcount/per_page;
	else
		pagecount=(dtcount/per_page)+1;
		
%>
<script language="javascript" src="../js/public/select.js"></script>
<script language="javascript">






function getmember(taskno)
{
    var rand=Math.floor(Math.random()*10000);
	var newmemberurl='ParticipantList.jsp?date=<%=date%>&taskno='+taskno ;
	window.open(newmemberurl,"participantList");
}


function mod(taskno)
{
  window.showModalDialog("task_mod.jsp?taskno="+taskno,window,"scroll=no;status=no;dialogWidth=700px;dialogHeight=400px;center=yes;help=no;");
  F5();
}

function del(taskno)
{

    if(confirm("是否确定删除任务号为："+taskno+"的任务？"))
    {
    var newmemberurl='../servlet/PageHandler?act=del&entity=MONTHTASK&action_class=com.action.task.TaskAction&TASKNO='+taskno;
    window.open(newmemberurl,"_self");
    }


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
function F3()
{
	window.showModalDialog("task_new.jsp",window,"scroll=no;status=no;dialogWidth=700px;dialogHeight=400px;center=yes;help=no;");	
}
</script>
<BODY class="mainbody" onLoad="this.focus()">
<table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
<tr>
<td class="table_td_jb_iframe">工作列表：&nbsp;&nbsp; 
<a href="#" onClick="F3()">增加[F3]</a>




</td>
</tr>
</table>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="form1" id="form1" method="post" action="../servlet/PageHandler">

  <tr>
    <td colspan="3" valign="top" class="main_table_centerbg" align="left"><table width="100%" border="1" cellpadding="0" cellspacing="0" class="table_list">

    </table>
   <%
		//out.print(dt.getRowsCount());
		if (dt!=null && dt.getRowsCount()>=0) {
		TableUtil tableutil=new TableUtil();
		tableutil.setDt(dt);
		tableutil.setHeadWidth("操作","10%");
		tableutil.setHeadWidth("计划名称","10%");
		tableutil.setHeadWidth("计划内容","40%");
		tableutil.setHeadWidth("参与人数目","10%");
		tableutil.setHeadWidth("备注","25%");
		tableutil.setHeadWidth("审核结果","5%");
		tableutil.setRowCode("审核结果","@审核结果@"+",taskaudit");
		tableutil.setDisplayCol("工作序号,rn");
		
		//tableutil.setLineAction("onclick=\"getmember('@工作序号@')\"");
		out.print(tableutil.DrawTable());
	%>
      
      <table width="100%" border="0" cellpadding="3" cellspacing="0">
        <tr>
          <td align="right">
          <%
          StringBuilder date0 = new StringBuilder();
          date0.append("date=").append(date);
        // System.out.println("date0.toString()="+date0.toString());
      	out.print(PageUtil.DividePage(page_no,pagecount,"TaskListDate.jsp",date0.toString()));
       %>
       </td>
          
        </tr>
        
      </table>
      <%}%>
 
  </tr>
  <tr>
    <td width="3%" height="5" class="main_table_bottombg"><img src="../images/table_lb.jpg" width="10" height="5"></td>
    <td width="94%" height="5" class="main_table_bottombg"></td>
    <td width="3%" height="5" align="right" class="main_table_bottombg"><img src="../images/table_rb.jpg" width="10" height="5"></td>
  </tr>
</form>
</table>
</BODY>
</HTML>