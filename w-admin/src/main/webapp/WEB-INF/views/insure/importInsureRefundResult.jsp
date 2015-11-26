<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>导入结果</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				导入结果:
			</h4>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="platform" class="col-sm-4 control-label">${result}</label>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="row">
					<div class="editPageButton">
						<a href="${dynamicDomain}/insureOrder/excResult/${insureOrderId}" class="btn btn-primary"  target="_blank">下载</a>错误数据
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>