<%@page import="com.entity.index.ReferPara"%>
<%@page contentType="application/json;charset=gb2312" language="java"  errorPage="" %>
<%
	response.setContentType("application/json;charset=gb2312");
	response.getWriter().write(new ReferPara().getparajson());
	response.getWriter().flush();
	response.getWriter().close();
 %>
