<%@page contentType="application/json;charset=gb2312" language="java" errorPage="" %>
<%@page import="edu.cqu.ncycoa.plan.PlanHelper" %>
<%
	response.setContentType("application/json;charset=gb2312");
	response.setHeader("Pragma", "No-cache");
	response.setHeader("Cache-Control", "no-cache");
	response.setDateHeader("Expires", 0);
	
	if(request.getParameter("staffcode") == null){
		return;
	}
	
	PlanHelper.delTask(request.getParameter("staffcode"));
	
	response.getWriter().flush();
	response.getWriter().close();
 %>
