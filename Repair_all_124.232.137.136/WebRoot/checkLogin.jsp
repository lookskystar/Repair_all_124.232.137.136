<%@ page language="java" pageEncoding="UTF-8"%>
<%--jsp登录状态检测 --%>
<%
	String type = request.getParameter("type");
	if(type==null || !"1".equals(type)){
		if(session.getAttribute("session_user")==null){
			response.sendRedirect(request.getContextPath()+"/login.jsp");
			return;
		}
	}
%>