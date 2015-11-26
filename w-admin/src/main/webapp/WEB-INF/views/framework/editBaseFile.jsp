<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="editForm">
		<h3>文件上传下载测试</h3>
		<form id="form1" action="${dynamicDomain}/baseFile/uploadAndDownload" method="post" enctype="multipart/form-data" >
			<input type="file" name="uploadFile">
			<button type="submit">提交</button>
			<button type="button" onclick="window.location='page'">返回</button>
		</form>
	</div>
</body>
</html>
