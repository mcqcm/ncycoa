<%@ page contentType="text/html; charset=gb2312" language="java" import="java.util.*,java.sql.*,com.db.*,com.common.*,com.entity.std.*,com.entity.system.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML>
<HEAD>
<base target="_self">
<TITLE>�ϳ��̲�ר����</TITLE>
<link rel="stylesheet" type="text/css" href="../css/style.css">
<META http-equiv=Content-Type content="text/html; charset=gb2312">
<META content="MSHTML 6.00.2900.2873" name=GENERATOR>
</HEAD>
<script language=
                "javascript" type="text/javascript" src="../js/MyDatePicker/WdatePicker.js">  </script>

<script language="javascript" src="../js/public/check.js"></script>
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
	//if (CkEmptyStr(document.all("DocNo"),"����벻��Ϊ�գ�"))
	//{
		//alert (document.all("act"));
		document.all("Submit").click();
	//}
}
function fun(DocClassName)
{
    if(DocClassName=="������׼.����˵����")
    {
    	document.form1.DocClassCode.value="001.001";
    }else if(DocClassName=="������׼.��λ˵����")
    {
    	document.form1.DocClassCode.value="001.002";
    }else if(DocClassName=="������׼.����ҵ����")
    {
    	document.form1.DocClassCode.value="002.001";
    }else if(DocClassName=="������׼.����ҵ����")
    {
    	document.form1.DocClassCode.value="003.001";
    }
}
</script>
<%         Calendar c = Calendar.getInstance();
   		 String year = "" + c.get(c.YEAR);
		 String month = "" + (c.get(c.MONTH) + 1);
		 String day = "" + c.get(c.DATE);
		 String date=year+"-"+month+"-"+day;

	request.setCharacterEncoding("gb2312");
	String docNo=Format.NullToBlank(request.getParameter("docno"));
	DocMetaVersionInfo docMetaVersionInfo = new DocMetaVersionInfo();
    DataTable dtname=docMetaVersionInfo.getByDocNo(docNo);
	String name=dtname.get(0).get(2).toString();
  	DocStorePath docStorePath = new DocStorePath();
  	DataTable dt = docStorePath.getAllDocClass();
  
%>
<BODY class="mainbody" onLoad="document.all('newbm').focus();" scroll="no">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<form name="form1" id="form1" method="post" action="../servlet/PageHandler">
    <tr>
    <td> <a id="F8" style="display:none" href="#" onClick="F8()">����[F8]</a></td>
  </tr>
<!--  <tr>-->
<!--    <td colspan="3" valign="middle" class="table_td_jb">&nbsp;&nbsp;<a href="#" onClick="F8()">����[F8]</a>��<a href="#" onClick="F3()">����[F3]</a>��<a href="#" onClick="F5()">ˢ��[F5]</a></td>-->
<!--  </tr>-->
  <tr>
    <td colspan="3" valign="top" class="main_table_centerbg" align="center">
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0" class="table_list1">
      <tr>
        <td width="20%"><div align="right">������ţ�</div></td>
        <td width="80%"><input name="DocCode" type="text" class="input1" id="DocCode" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="30" ></td>
      </tr>
      <tr>
        <td><div align="right">�������ƣ�</div></td>
        <td><input name="DocVersionName" type="text" class="input1" id="DocVersionName" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="50"></td>
      </tr>
<!--      <tr>-->
<!--        <td><div align="right">�ĵ��汾��</div></td>-->
<!--        <td><input name="DocVersion" type="text" class="input1" id="DocVersion" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="30"></td>-->
<!--      </tr>-->
      <tr>
      	  <td width="20%"><div align="right">�����汾��</div></td>
        <td width="80%">
        <select name="UpdateFlag"  id="UpdateFlag" style="width:192px">
             <option value="A/0">A/0</option>
             <option value="A/1">A/1</option>
          </select>
          </td>     
      </tr>
<!--            <tr>-->
<!--      	  <td width="20%"><div align="right">���������ƣ�</div></td>-->
<!--        <td width="80%">-->
<!--        <select name="DocClassName" onChange="fun(this.value)" id="DocClassName" style="width:192px">-->
<!--             <option value="������׼.����˵����">������׼.����˵����</option>-->
<!--             <option value="������׼.��λ˵����">������׼.��λ˵����</option>-->
<!--             <option value="������׼.����ҵ����">������׼.����ҵ����</option>-->
<!--             <option value="������׼.����ҵ����">������׼.����ҵ����</option>-->
<!--          </select>-->
<!--          </td>     -->
<!--      </tr>-->
       <tr>
      	  <td width="20%"><div align="right">�����������</div></td>
        <td width="80%">
        <select name="DocContentType"  id="DocContentType" style="width:192px">
             <option value="�����ĵ�">�����ĵ�</option>
             <option value="����ͼ">����ͼ</option>
             <option value="��¼����">��¼����</option>
          </select>
          </td>     
      </tr>
<!--       <tr>-->
<!--      	  <td width="20%"><div align="right">ģ���ʶ:</div></td>-->
<!--        <td width="80%">-->
<!--        <select name="TempleteFlag"  id="TempleteFlag" style="width:192px">-->
<!--             <option value="0">0/��ģ��</option>-->
<!--             <option value="1">1/ģ��</option>-->
<!--          </select>-->
<!--          </td>     -->
<!--      </tr>-->
<!--      <tr> -->
<!--	  <td width="20%"><div align="right">����������</div></td>-->
<!--        <td width="80%"><input name="PartDocCount" type="text" class="input1" id="ParentOrgCode" onKeyDown="EnterKeyDo('')" value="0" size="30" maxlength="30" ></td>     -->
<!--       </tr>-->
<!--      <tr> -->
<!--	  <td width="20%"><div align="right">�����ˣ�</div></td>-->
<!--        <td width="80%"><input name="DrawUpPerson" type="text" class="input1" id="DrawUpPerson" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="30"></td>     -->
<!--       </tr>-->
<!--      <tr>-->
<!--	  <td width="20%"><div align="right">���Ʋ��ţ�</div></td>-->
<!--        <td width="80%"><input name="DrawUpOrg" type="text" class="input1" id="DrawUpOrg" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="30"></td>      -->
<!--      </tr>-->
            <tr> 
	  <td width="20%"><div align="right">�������ڣ�</div></td>
        <td width="80%"><input name="DrawUpDate" type="Wdate" class="input1" id="DrawUpDate" onfocus="new WdatePicker({lang:'zh-cn'})"  value="<%=date %>" size="30" maxlength="30"></td>     
       </tr>
<!--             <tr> -->
<!--	  <td width="20%"><div align="right">��׼���ڣ�</div></td>-->
<!--        <td width="80%"><input name="ApproveDate" type="Wdate" class="input1" id="ApproveDate" onfocus="new WdatePicker({lang:'zh-cn'})"  value="<%=date %>" size="30" maxlength="30"></td>     -->
<!--       </tr>-->
<!--             <tr> -->
<!--	  <td width="20%"><div align="right">��׼�ˣ�</div></td>-->
<!--        <td width="80%"><input name="Approver" type="text" class="input1" id="Approver" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="30"></td>     -->
<!--       </tr>-->
<!--            <tr> -->
<!--	  <td width="20%"><div align="right">��Ч��ʼ���ڣ�</div></td>-->
<!--        <td width="80%"><input name="ValidBeginDate" type="Wdate" class="input1" id="ValidBeginDate" onfocus="new WdatePicker({lang:'zh-cn'})"  value="<%=date %>" size="30" maxlength="30"></td>     -->
<!--       </tr>-->
<!--                   <tr> -->
<!--	  <td width="20%"><div align="right">��Ч�������ڣ�</div></td>-->
<!--        <td width="80%"><input name="ValidEndDate" type="Wdate" class="input1" id="ValidEndDate" onfocus="new WdatePicker({lang:'zh-cn'})"  value="<%=date %>" size="30" maxlength="30"></td>     -->
<!--       </tr>	     -->
	    <tr>  
	   <td width="20%"><div align="right">��ע��</div></td>
        <td width="80%"><input name="Memo" type="text" class="input1" id="Memo" onKeyDown="EnterKeyDo('')" value="" size="30" maxlength="3000"></td>     
	     </tr>
	     
	      <tr>
      <td>
         <input type="submit" name="Submit" value="�ύ" style="display:none">
          <input type="reset" name="reset" value="����" style="display:none">
          </td>
      </tr>
       <tr>
        <td>
        <div align="right">
        <input name="act" type="hidden" id="act" value="add">
        <input name="DocNo" type="hidden" id="DocNo" value="">
        <input name="DocClassCode" type="hidden" id="DocClassCode" value="">
        <input name="BelongMode" type="hidden" id="BelongMode" value="">
        <input name="BelongDocNo" type="hidden" id="BelongDocNo" value="<%=docNo%>">
        <input name="AttachDocCount" type="hidden" id="AttachDocCount" value="0">
        <input name="DocVersion" type="hidden" id="DocVersion" value="">
        <input name="TempleteFlag" type="hidden" id="TempleteFlag" value="0">
        <input name="DocClassName" type="hidden" id="DocClassName" value="">
        <input name="PartDocCount" type="hidden" id="PartDocCount" value="">
        <input name="DrawUpPerson" type="hidden" id="DrawUpPerson" value="">
        <input name="DrawUpOrg" type="hidden" id="DrawUpOrg" value="">
        <input name="Approver" type="hidden" id="Approver" value="">
        <input name="ApproveDate" type="hidden" id="ApproveDate" value="<%=date %>">
        <input name="ValidBeginDate" type="hidden" id="ValidBeginDate" value="<%=date %>">
        <input name="ValidEndDate" type="hidden" id="ValidEndDate" value="<%=date %>">
        </div>
<input name="DocVersionStatus" type="hidden" id="DocVersionStatus" value="�����汾">
          <input name="StoreFileFlag" type="hidden" id="StoreFileFlag" value="0">
          </td>
        <td><input name="action_class" type="hidden" id="action_class" value="com.action.std.StdAttachAction"></td>
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
</BODY>
</HTML>