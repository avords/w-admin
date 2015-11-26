<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Language" content="zh-cn" />
<meta http-equiv="Pragma" content="no-cache" />
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="Cache-Control" content="no-cache" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><decorator:title default="Welcome!" /></title>
<decorator:head />
<jdf:themeFile file="main-page.js" />
<jdf:themeFile file="jquery.cookie.js" />
</head>
<body class="skin-blue sidebar-mini">
	<div class="wrapper">
		<%@include file="../common/page_header.jsp"%>
		<%@include file="../common/page_sidebar.jsp"%>
		<div class="content-wrapper">
			<div class="page-body">
				<decorator:body />
			</div>
		</div>
		<%@include file="../common/page_foot.jsp"%>
	</div>
	<script type="text/javascript">
	$(function() {
		if (typeof ($.cookie('secondLevelMenu')) != "undefined") {
			$("#firstLevelMenu").text($.cookie('firstLevelMenu'));
			$("#secondLevelMenu").text($.cookie('secondLevelMenu'));
		}
	});
	
	function logOperation(url, operationId, customerFunction) {
		  customerFunction;
		  $.ajax({
			 url:"${dynamicDomain}/logOperation?ajax=1",
		     type:'post',
			 dataType:'json',
			 data:{'operationId':operationId},
			 success:function(data){
				 
			 },
			 error:function(errorData){
				 
			 }
		});  
	}
	</script>
</body>
</html>