<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="taglibs.jsp"%>
<!DOCTYPE html>
<html lang=en>
<meta charset=utf-8>
<meta name=viewport
	content="initial-scale=1, minimum-scale=1, width=device-width">
<title>Error 404 (Not Found)</title>
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
	min-height: 180px;
	padding: 30px 0 15px
}

*>body {
	background: url(<jdf:theme/>img/404.gif) 100% 5px
		no-repeat;
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
<a href="<c:url value="/"/>"/>Home page</a>
<p>
	<b>404.</b>
	<ins>That’s an error.</ins>
<p>
	The requested URL
	was not found on this server.
</html>