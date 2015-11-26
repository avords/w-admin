<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>导入结果</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right"></div>
			<h4 class="modal-title">导入结果:</h4>
			<u><a href="${dynamicDomain}/fastOrder/page" target="_blank">立即查看</a></u>
		</div>
		${result}
	</div>
</body>
</body>
</html>