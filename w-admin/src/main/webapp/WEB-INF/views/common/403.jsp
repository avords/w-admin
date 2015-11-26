<%@page import="com.handpay.ibenefit.framework.util.AjaxUtils"%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="taglibs.jsp"%>
<%
	String ajax = request.getParameter("ajax");
	if(ajax!=null&&ajax.equals("1")){
		AjaxUtils.doJsonResponse(response, "{\"status\":\"403\",\"message\":\"Forbidden\"}");
		return;
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>Error 403 (Forbidden)</title>
<style>
* {
	margin: 0;
	padding: 0
}

html,code {
	font: 15px/22px arial, sans-serif
}

html {
	background: #fff;
	color: #222;
	padding: 15px
}

body {
	margin: 7% auto 0;
	max-width: 390px;
	min-height: 230px;
	padding: 30px 0 15px
}

*>body {
	background: url(<jdf:theme/>img/403.jpg) 100% 0px no-repeat;
	padding-right: 205px
}

p {
	margin: 11px 0 22px;
	overflow: hidden
}

ins {
	color: #777;
	text-decoration: none
}

a img {
	border: 0
}

@media screen and (max-width:772px) {
	body {
		background: none;
		margin-top: 0;
		max-width: none;
		padding-right: 0
	}
}
</style>
</head>

<body>
<a href="<c:url value='/'/>"/>Home page</a>
<a href="<c:url value="/login/out?logoutFrom=1"/>">Logout</a>
<p>
	<b>403.</b>
	<ins>You are unauthorized to access this page.</ins>
</p>
</body>
</html>