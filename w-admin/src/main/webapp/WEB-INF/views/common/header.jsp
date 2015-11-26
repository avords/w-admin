<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="taglibs.jsp"%>
<%
  String message = request.getParameter("message");
  if (message == null) {
    message = String.valueOf(request.getAttribute("message"));
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
<meta http-equiv="X-UA-Compatible" content="IE=edge;Chrome=1">
<meta name="renderer" content="webkit">
<jdf:themeFile file="css/bootstrap.min.css" />
<jdf:themeFile file="css/jquery-ui-1.10.0.custom.min.css" />
<jdf:themeFile file="css/colorbox.css" />
<jdf:themeFile file="css/font-awesome.min.css" />
<jdf:themeFile file="css/AdminLTE.min.css" />
<jdf:themeFile file="css/morris.css" />
<jdf:themeFile file="css/daterangepicker-bs3.css" />
<jdf:themeFile file="css/skins/skin-blue.min.css" />
<jdf:themeFile file="css/jquery-jvectormap-1.2.2.css" />
<!--[if lt IE 9]>
<jdf:themeFile file="html5.js" />
<jdf:themeFile file="respond.min.js"/>
<link href="${staticDomain}js/cross-domain/respond-proxy.html" id="respond-proxy" rel="respond-proxy" />
<link href="${dynamicDomain}/static/js/cross-domain/respond.proxy.gif" id="respond-redirect" rel="respond-redirect" />
<script src="${dynamicDomain}/static/js/cross-domain/respond.proxy.js"></script>
<![endif]-->

<jdf:themeFile file="css/ionicons.min.css" />
<jdf:themeFile file="css/dataTables.bootstrap.css" />
<jdf:themeFile file="css/extremecomponents.css" />
<jdf:themeFile file="css/skins/WdatePicker.css" />

<jdf:themeFile file="jquery-1.9.1.min.js" />
<jdf:themeFile file="jquery-migrate-1.2.1.min.js" />
<jdf:themeFile file="jquery-ui-1.10.0.custom.min.js" />
<jdf:themeFile file="jquery.colorbox.js" />
<jdf:themeFile file="jquery.tooltipster.min.js" />
<jdf:themeFile file="bootstrap.min.js" />
<jdf:themeFile file="jquery.metadata.js" />
<jdf:themeFile file="jquery.validate.min.js" />
<jdf:themeFile file="additional-methods.js" />
<jdf:themeFile file="jquery.validate_zh.js" />
<jdf:themeFile file="jquery.cookie.js" />
<jdf:themeFile file="icheck.min.js" />
<jdf:themeFile file="WdatePicker.js" />
<jdf:themeFile file="areaSelect.js" />
<jdf:themeFile file="dateFormat.js" />
<jdf:themeFile file="jquery.popup.js" />
<jdf:themeFile file="jquery.alert.js" />

<!-- ################### 用于覆盖样式和脚本 Start ####################### -->
<jdf:themeFile file="css/common.css" />
<jdf:themeFile file="common.js" />
<!-- ################### 用于覆盖样式和脚本 End ####################### -->

<script type="text/javascript">
var processMessage = "<jdf:message code="system.lable.process"/>";
var sureToDelete="<jdf:message code="common.js.sureToDelete"/>";
var loginUrl = "${loginUrl}";
var appRoot = "${dynamicDomain}";
var cookiePath = "${cookiePath}";
var cookieDomain = "${cookieDomain}";
var sessionName = "${sessionName}";
var timeoutOfLogout = 30;
var currentModuleId = "${currentModuleId}";
</script>