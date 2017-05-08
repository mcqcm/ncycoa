<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.common.*,com.entity.system.Staff" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<base target="_self">
<TITLE>南充市烟草公司</TITLE>
<link rel="stylesheet" type="text/css" href="../../css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
</HEAD>

<script language="javascript" type="text/javascript" src="../../js/MyDatePicker/WdatePicker.js">  </script>

<script language="javascript" src="../../js/public/check.js"></script>
<script language="javascript">
function F5()
{
	window.location.reload();
}
function F3()
{
	document.all("reset").click();
}
function F8()
{
	if (CkEmptyStr(document.all("staffname"),"员工姓名不能为空！") && CkEmptyStr(document.all("idcard"),"身份证号不能为空！"))
	{
		//alert ("aaa");
		document.all("Submit").click();
	}
}
</script>
<%
	request.setCharacterEncoding("gb2312");
	String positionname = Format.NullToBlank(request.getParameter("positionname"));
	String orgcode = Format.NullToBlank(request.getParameter("orgcode"));
	String orgname = Format.NullToBlank(request.getParameter("orgname"));
	String positioncode = Format.NullToBlank(request.getParameter("positioncode"));
	String staffcode=Format.NullToBlank(request.getParameter("staffcode"));
	
	Staff staff=new Staff(staffcode,positioncode);
	String othersex=null;
	if(staff.getGender().equals("男"))
        othersex="女";
    else if(staff.getGender().equals("女"))
        othersex = "男";
        
    String orgclass = request.getParameter("orgclass");
    String membid="";
   if(orgclass.equals("00080001"))
{
  
  membid = "工作证号";
}
else if(orgclass.equals("00080002"))
{
 
  membid = "党证号";
}
	
%>
<BODY class="mainbody" onLoad="document.all('staffcode').focus();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="form1" id="form1" method="post" action="../../servlet/PageHandler">

       
<!--  <tr>-->
<!--    <td colspan="3" valign="middle" class="table_td_jb">&nbsp;&nbsp;<a href="#" onClick="F8()">保存[F8]</a>　<a href="#" onClick="F3()">重填[F3]</a>　<a href="#" onClick="F5()">刷新[F5]</a></td>-->
<!--  </tr>-->
 <table cellpadding="5"  width="100%" align="left" >
  <tr>
    <td> <a id="F8" style="display:none" href="#" onClick="F8()">保存[F8]</a></td>
  </tr>
             <tr>
				<td><span>员工编号：</span></td>
				<td>
					<input name="staffcode" type="text" class="easyui-textbox" id="staffcode" onKeyDown="EnterKeyDo('')" value="<%=staff.getStaffcode()%>"   size="30" maxlength="30"  readonly="readonly">
				</td>
			</tr>
			 
			<tr>
				<td><span>员工姓名：</span></td>
				<td>
					<input name="staffname" type="text" class="easyui-textbox" id="staffname" onKeyDown="EnterKeyDo('')" value="<%=staff.getStaffname()%>" size="40" maxlength="40">
				</td>
			</tr>
			<tr>
				<td><span>性别：</span></td>
				<td>
					<input name="gender" type="radio" class="easyui-textbox" id="gender" onKeyDown="EnterKeyDo('')" value="<%=staff.getGender()%>" size="40" maxlength="40" checked ><%=staff.getGender() %></input>
        <input name="gender" type="radio" class="easyui-textbox" id="gender" onKeyDown="EnterKeyDo('')" value="<%=othersex%>" size="40" maxlength="40"  ><%=othersex %></input>
				</td>
			</tr>
			
			<tr>
				<td><span>身份证号：</span></td>
				<td>
					<input name="idcard" type="text" class="easyui-textbox" id="idcard" onKeyDown="EnterKeyDo('')" value="<%=staff.getIdcard() %>" size="40" maxlength="40">
				</td>
			</tr>
			<tr>
				<td><span>民族编码：</span></td>
				<td>
					<input name="nationalitycode" type="text" class="easyui-textbox" id="nationalitycode" onKeyDown="EnterKeyDo('')" size="40" maxlength="40">
				</td>
			</tr>
			<tr>
				<td><span>入职时间：</span></td>
				<td>
					<input name="positiontime" type="Wdate" class="easyui-textbox" id="positiontime" onfocus="new WdatePicker({lang:'zh-cn'})"  value="<%=staff.getPositiontime() %>" size="30"  maxlength="30">
				</td>
			</tr>
			<tr>
				<td><span>工作证号：</span></td>
        <td><input name="memberid" type="text" class="easyui-textbox" id="memberid" onKeyDown="EnterKeyDo('')" value="<%=staff.getMemberid()%>" size="40" maxlength="40"></td>
			</tr>
  </table>
  <tr>
    <td colspan="3" valign="top" class="main_table_centerbg" align="center"><table width="100%" border="1" cellspacing="0" cellpadding="0" class="table_list1">
     
      <tr>
        
        <input name="orgcode" type="hidden" id="orgcode" value="<%=orgcode %>">
        <input name="orgname" type="hidden" id="orgname" value="<%=orgname %>">
        <input name="positioncode" type="hidden" id="positioncode" value="<%=positioncode %>">
        <input name="positionname" type="hidden" id="positionname" value="<%=positionname %>">
          <input name="act" type="hidden" id="act" value="modify">
		  <input type="submit" name="Submit" value="提交" style="display:none">
           <input type="reset" name="reset" value="重置" style="display:none">
          <input name="action_class" type="hidden" id="action_class" value="com.action.system.StaffAction"></td>
      </tr>
      <input type="button" id="btn_ok" style="display: none" onclick="ret()">
   
    </table></td>
  </tr>
  <tr>
    <td height="5" class="main_table_bottombg"><img src="../../images/table_lb.jpg" width="10" height="5"></td>
    <td height="5" class="main_table_bottombg"></td>
    <td height="5" align="right" class="main_table_bottombg"><img src="../../images/table_rb.jpg" width="10" height="5"></td>
  </tr>
</form>
</table>
<script type="text/javascript">
function ret(){
	var api = frameElement.api;
 	document.all("Submit").click();
 	(api.data)({code:"refresh"});
}
</script>
</BODY>
</HTML>
