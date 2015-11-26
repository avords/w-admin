<%@page import="com.handpay.ibenefit.security.SecurityConstants"%>
<%@page import="com.handpay.ibenefit.framework.config.GlobalConfig"%>
<%@page import="com.handpay.ibenefit.framework.FrameworkConstants"%>
<%@page import="com.handpay.ibenefit.framework.util.DomainUtils"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="taglibs.jsp"%>
<%@page import="java.util.List"%>
<%
  String dynamicDomain = DomainUtils.getDynamicDomain();
    request.setAttribute("dynamicDomain",dynamicDomain);
  String message = request.getParameter(FrameworkConstants.MESSAGE);
  if (message == null) {
    message = String.valueOf(request.getAttribute(FrameworkConstants.MESSAGE));
  }
  if (message == null || "null".equals(message)) {
    message = "";
  }else{
    request.setAttribute("message", message);
  }
%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
var processMessage = "<jdf:message code="system.lable.process"/>";
var sureToDelete="<jdf:message code="common.js.sureToDelete"/>";
var loginUrl = "<%=GlobalConfig.getLoginUrl()%>";
var appRoot = "${dynamicDomain}";
var cookiePath = "<%=GlobalConfig.getCookiePath()%>";
var cookieDomain = "<%=GlobalConfig.getCookieDomain()%>";
var sessionName = "<%=GlobalConfig.getSessionName()%>";
var tokenName = "<%=SecurityConstants.SECURITY_TOKEN%>";
var timeoutOfLogout = 10;
var currentModuleId = "${currentModuleId}";

</script>
