<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.db.*,com.common.*,com.entity.system.UserInfo,com.entity.task.*,com.dao.system.*" errorPage="" %>
<%
	String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";



UserInfo uinfo=(UserInfo)request.getSession().getAttribute("UserInfo");
Role.sysmng.login.User u=(Role.sysmng.login.User)request.getSession().getAttribute("USER");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<HTML>
<HEAD>
<TITLE>�ϳ����̲ݹ�˾</TITLE>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
<base target="_self">
</HEAD>
<%
	
    int page_no=Integer.parseInt(Format.NullToZero(request.getParameter("page_no")));
    String date =Format.NullToBlank(request.getParameter("date"));
	int per_page=uinfo.getPerpage_third();
	//Log.Debug(per_page);
	DataTable dt=Task.getTaskList(page_no,per_page,u.getYybdm(),date);
	
	int dtcount=Task.getTaskListCount(u.getYybdm(),date);
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
	var newmemberurl='TaskAudit.jsp?taskno='+taskno ;
	window.open(newmemberurl,"participantList");
	
}


function mod(taskno)
{
  window.showModalDialog("task_mod.jsp?taskno="+taskno,window,"scroll=no;status=no;dialogWidth=700px;dialogHeight=400px;center=yes;help=no;");
}

function del(taskno)
{

    if(confirm("�Ƿ�ȷ��ɾ�������Ϊ��"+taskno+"������"))
    {
    var newmemberurl='../servlet/PageHandler?act=del&entity=MONTHTASK&action_class=com.action.task.TaskAction&TASKNO='+taskno;
    window.open(newmemberurl,"_self");
    }


}

function F4()
{
	if (CheckSelect("form1"))
	{
		if (confirm("�����˵���ɾ��������ɾ���Ӳ˵����Ƿ������"))
		{
			document.all("form1").submit();
		}
	}
	else
	{
		alert ("��û��ѡ��Ҫɾ�������ݣ�");
	}
}
function F5()
{
	window.location.reload();
}

</script>
<BODY class="mainbody" onLoad="this.focus()">
<table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
<tr>
<td class="table_td_jb_iframe">�����б�&nbsp;&nbsp; 





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
		
		tableutil.setHeadWidth("�ƻ�����","15%");
		tableutil.setHeadWidth("�ƻ�����","50%");
		tableutil.setHeadWidth("��������Ŀ","10%");
		tableutil.setHeadWidth("��ע","25%");
		tableutil.setDisplayCol("rn,�������,��˱�ʶ,����");
		
		tableutil.setLineAction("onclick=\"getmember('@�������@')\"");
		out.print(tableutil.DrawTable());
	%>
      
      <table width="100%" border="0" cellpadding="3" cellspacing="0">
        <tr>
        
          <td align="right">
          <%
         
      	out.print(PageUtil.DividePage(page_no,pagecount,"TaskList.jsp",""));
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