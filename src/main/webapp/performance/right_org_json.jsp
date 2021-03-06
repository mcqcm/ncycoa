<%@page contentType="application/json;charset=gb2312" language="java"  errorPage="" %>
<%@page import="com.entity.system.UserInfo"%>
<%@page import="com.entity.system.Org" %>
<%@page import="com.performance.RightDataHelper" %>
<%@page import="java.util.List" %>

<%
	response.setContentType("application/json;charset=gb2312");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	
	if(request.getParameter("taskType") == null || request.getParameter("staffcode") == null){
		response.getWriter().write("[]");
		response.getWriter().flush();
		response.getWriter().close();
		return;
	}
	
	StringBuffer sb = new StringBuffer();
	
	List<Org> orgs = RightDataHelper.getOrgs(request.getParameter("staffcode"), request.getParameter("taskType"));
	sb.append("[");
	for(Org org : orgs){
		sb.append("{\"orgcode\":").append("\""+org.getCode()+"\"").append(",");
		sb.append("\"orgname\":").append("\""+org.getName()+"\"").append("},");
	}
	if(sb.length() > 1) sb.delete(sb.length() - 1, sb.length());
    sb.append("]");
		
	response.getWriter().write(sb.toString());
	response.getWriter().flush();
	response.getWriter().close();
%>
