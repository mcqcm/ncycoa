<%@ page contentType="text/html; charset=gb2312" language="java" import="java.sql.*,com.db.*,com.common.*,com.entity.system.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<TITLE>�Ĵ�ʡ�ϳ��̲ݹ�˾</TITLE>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
</HEAD>
<base target="_self">

<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>
<script language="javascript" type="text/javascript" src="<%=path%>/js/My97DatePicker/WdatePicker.js"></script>
<script language="javascript" src="<%=path%>/js/public/key.js"></script>
<script language="javascript" src="<%=path%>/js/public/check.js"></script>
<script language="javascript" src="<%=path%>/js/public/Calendar1.js"></script>
<%

	request.setCharacterEncoding("gb2312");
	String goodscode=Format.NullToBlank(request.getParameter("goodscode"));
  	Goods goods=new Goods(goodscode);
  	ComponentUtil cu=new ComponentUtil();
%>


<BODY class="mainbody" onLoad="this.focus();">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="form1" id="form1" method="post" action="../servlet/PageHandler">

  <tr>
    <td colspan="3" valign="top" class="main_table_centerbg" align="center">
    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="table_list1">
      <tr>
        <td width="20%"><div align="right">���ʱ��룺</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","GOODSCODE",goodscode,"readonly")); %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">�������ƣ�</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","GOODSNAME",goods.getGOODSNAME())); %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">˵����</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","GOODSDESC",goods.getGOODSDESC())); %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">��ڲ��ţ�</div></td>
        <td width="80%">
        
        <%out.print(cu.print("COM_GOODSCLASS","AUDITORGCODE",goods.getAUDITORGCODE())); %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">�ϲ����ʱ��룺</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","PARENTGOODSCODE",goods.getPARENTGOODSCODE(),"readonly")); %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">��Ч��־��</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","VALIDFLAG",goods.getVALIDFLAG()));  %>
        </td>
      </tr>
      <tr>
        <td width="20%"><div align="right">��ע��</div></td>
        <td width="80%">
        <%out.print(cu.print("COM_GOODSCLASS","MEMO",goods.getMEMO())); %>
       </td>
       <input id="btn_ok" style="display:none" onclick="ret()">
       <input type="submit" name="Submit" value="�ύ" style="display:none">
        <input type="reset" name="reset" value="����" style="display:none">
 		<input name="act" type="hidden" id="act" value="modify">
 		<input type="hidden" name="entity" id="entity" value="COM_GOODSCLASS"/>
 		<input name="old_GOODSCODE" type="hidden" id="old_GOODSCODE" value="<%=goodscode%>">
 		<input name="Com_GoodsClass.ISPARENT" type="hidden" id="Com_GoodsClass.ISPARENT" value="<%=goods.getISPARENT()%>">
 		<input name="action_class" type="hidden" id="action_class" value="com.action.system.SystemGoodsAction">
      </tr> 
    </table></td>
  </tr>
  <tr>
    <td height="5" class="main_table_bottombg"><img src="../images/table_lb.jpg" width="10" height="5"></td>
    <td height="5" class="main_table_bottombg"></td>
    <td height="5" align="right" class="main_table_bottombg"><img src="../images/table_rb.jpg" width="10" height="5"></td>
  </tr>
</form>
</table>
<script language="javascript">
function ret(){
	var api = frameElement.api;
	if (sumbit_check())
	{
		document.all("Submit").click();
		(api.data)({code:"refresh"});
	}
}
function select()
{
alert("hello");
alert(mo.getPositionCount ());
	var newtreeurl='unitcheckbox_tree.jsp';
	var str=showModalDialog(newtreeurl);
	var strs= new Array(); //����һ���� 
	strs=str.split(";"); //�ַ��ָ� 
	 
	document.getElementById("BlongAdminOrgName").value=strs[0];
	document.getElementById("BlongAdminOrgCode").value=strs[1];
	//window.open (newtreeurl,"Sample","toolbar=no,location=no,directories=no,status=no,menubar=no,resizable=no,scrollbars=yes, copyhistory=no,width=350,height=540,left=200,top=300");
}
</script>
</BODY>
</HTML>
<% out.print(cu.getCheckstr());%>