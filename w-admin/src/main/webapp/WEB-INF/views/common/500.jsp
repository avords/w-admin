<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" isErrorPage="true"%>
<%@ include file="header.jsp"%>
<%
	String errorMessage = null;
	if (exception == null){
		exception = (Exception) request.getAttribute("javax.servlet.error.exception");
		if(exception==null){
			exception = (Exception) session.getAttribute("javax.servlet.jsp.jspException");
			session.removeAttribute("javax.servlet.jsp.jspException");
		}
	}
	if(exception!=null){
		errorMessage = exception.getMessage();
	}else{
		errorMessage = (String)session.getAttribute("errorMessage");
	}
	
%>
	<title>Error 500 (Internal Server Error)</title>
</head>
<body>
	<div>
		<div class="entry-header">
			<img src="<jdf:theme/>img/warning.gif">
			<button type="button" class="btn btn-primary" onclick="if (detail_error_msg.style.display == 'none'){detail_error_msg.style.display = '';parent.iframeAutoFit();}else{detail_error_msg.style.display = 'none';}"><i class="icon-circle-arrow-down"></i>详细信息</button>
			<button type="button" class="btn btn-primary" onclick="javascript:history.go(-1);"><i class="icon-circle-arrow-left"></i>返回</button>
			<div class="span12">
				<b>Error: </b> <span>${errorMessage}</span>
			</div>
		</div>
		<div class="span12 entry-content" id="detail_error_msg" style="display:none;">
			<pre class="prettyprint linenums Lang-css">
				<span class="nocode">
			<%
				while(exception != null){
					exception.printStackTrace(new PrintWriter(out));
					if (exception instanceof JspException){
				      exception = ((JspException) exception).getRootCause();
				    }else if (exception instanceof ServletException){
				      exception = ((ServletException) exception).getRootCause();
				    }else {
				    	exception = exception.getCause();
				    }
				}
			%>
				</span>
			</pre>
		</div>
	</div>
</body>
</html>
