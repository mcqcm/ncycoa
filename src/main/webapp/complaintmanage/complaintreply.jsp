<%@ page language="java" import="java.util.*,com.common.*" pageEncoding="gb2312"%>
<%@page import="com.entity.system.UserInfo"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="gb2312">
<title>�Ĵ��ϳ��̲�ר��</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">    
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="<%=path%>/jscomponent/easyui/themes/icon.css">
<script type="text/javascript" src="<%=path%>/jscomponent/jquery/jquery-1.8.0.min.js"></script>
<script type="text/javascript" src="<%=path%>/jscomponent/easyui/jquery.easyui.min.js"></script>
<script language="javascript" src="<%=path%>/js/DatePicker/WdatePicker.js"></script>
<script language="javascript" src="<%=path%>/js/public/check.js"></script>

<script type="text/javascript" src="../jscomponent/lhgdialog/lhgdialog.min.js?skin=iblue"></script>

</head>
<%
UserInfo u=(UserInfo)request.getSession().getAttribute("UserInfo");
String complaintno=request.getParameter("complaintno");
ComponentUtil cu=new ComponentUtil();
%>
<body>
<center>
        <form name="form1" id="form1"  method="post" action="../servlet/PageHandler">
            <table cellpadding="20">
                <tr>
                    <td>�ظ���:</td>
                    <td><%
                       out.print(cu.print("TBM_COMPLAINTREPLY", "REPLYPERSONCODE",u.getStaffcode()));
                    %></td>
                </tr>
               <tr>
                    <td>��Ӧ����:</td>
                    <td>
                        <%
                       out.print(cu.print("TBM_COMPLAINTREPLY", "REPLYCONTENT"));
                    %></td>
                </tr>
              
               <tr>
                    <td>�ظ����ϸ���:</td>
                   <td>
                     <input type="text" id="TBM_COMPLAINTREPLY.REPLYFILE" name="TBM_COMPLAINTREPLY.REPLYFILE">
                     <a id="btn_uploadfile" href="#"    class="easyui-linkbutton" data-options="iconCls:'icon-add',plain:true">�ϴ��ļ�</a>
                  </td>
                </tr>
                <tr>
                    <td>��ע:</td>
                   <td><%
                       out.print(cu.print("TBM_COMPLAINTREPLY", "MEMO"));
                    %></td>
                </tr>
                <tr>
                <td></td>
                <td><input type="button" id="btn_ok" style="display: " onclick="ret()" value="�ύ"></td>
                </tr>
             <input type="hidden" id="TBM_COMPLAINTREPLY.REPLYNO" name="TBM_COMPLAINTREPLY.REPLYNO" value="<%=IndexCode.getRecno("CR")%>">
            <input type="hidden" id="TBM_COMPLAINTREPLY.COMPLAINTNO" name="TBM_COMPLAINTREPLY.COMPLAINTNO" value="<%=complaintno%>">
            <input type="hidden" id="TBM_COMPLAINTREPLY.ENABLEDFLAG" name="TBM_COMPLAINTREPLY.ENABLEDFLAG" value="1">
             <input type="hidden" id="TBM_COMPLAINTREPLY.REPLYDATE" name="TBM_COMPLAINTREPLY.REPLYDATE" value="<%=Format.getNowtime2()%>">
            
             <input name="entity" id="entity" type="hidden" value="TBM_COMPLAINTREPLY"/>
             <input name="act" type="hidden" id="act" value="add">
             <input name="action_class" type="hidden" id="action_class" value="com.action.index.ComplaintReplyAction">
             <input type="submit" name="Submit" value="�ύ" style="display:none">
             <input type="reset" name="reset" value="����" style="display:none">
              
        </form>
       
        
    <script>
        function ret(){
        	var api = frameElement.api;
        	if(sumbit_check())
	   	    {
	    			 document.all("Submit").click();
	    			 (api.data)({code:"refresh"});
	   	    }
        }
       
        $("#btn_uploadfile").click(function(){
        	createwindow("�ļ��ϴ�","fileupload/fileupload.jsp",350,130);
        	    });
        function createwindow(title, url, width, height) {
        	var api = frameElement.api, W = api.opener;
    		W.$.dialog({
    			data:returnValue,
    			id:'CLHG1976D',
    			content : 'url:' + url,
    			lock : true,
    			width : width,
    			height : height,
    			title : title,
    			opacity : 0.3,
    			cache : false,
    			ok : function() {
    				$('#btn_ok', this.iframe.contentWindow.document).click();
    				return true;
    			},
    			cancelVal : '�ر�',
    			cancel : true/* Ϊtrue�ȼ���function(){} */
    		});}
        function returnValue(data){
           document.getElementById("TBM_COMPLAINTREPLY.REPLYFILE").value=data.code;
       }
    </script>
</body>
</html>
<%
out.print(cu.getCheckstr());
%>