<%@page import="com.common.Format"%>
<%@page import="com.business.BuyReportEvent"%>
<%@page contentType="application/json;charset=gb2312" language="java"  errorPage="" %>
<%
	response.setContentType("application/json;charset=gb2312");
    
    response.getWriter().write(new BuyReportEvent().getBuyreporteventJson("RP", "", Format.NullToBlank(request.getParameter("starttime")), Format.NullToBlank(request.getParameter("endtime")), Format.NullToBlank(request.getParameter("buymode"))));
    
	response.getWriter().flush();
	response.getWriter().close();
 %>
