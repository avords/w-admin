<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>上传合同模板</title>
<style>
.import{
	width:86%;
	margin:0 0 0 40px;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">上传合同模板</h4>
		</div>
			<jdf:form bean="request" scope="request">
				<form method="post" action="${dynamicDomain}/contracttemplate/save?ajax=1" class="form-horizontal import" id="isform" name="isform" enctype="multipart/form-data">
					<input type="hidden" name="companyId" value="1">
					<div class="box-body">
					<div class="row">
						<div class="col-sm-12 alert alert-info" id="messageBox">${message}</div>
					</div>
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label class="control-label"> 合同模板导入：</label>
								<input type="file" class="form-control" name="contractTemPath" id="contractTemPath">
							</div>
						</div>
						<div class="col-sm-10 col-md-10">
							<div id="loadingDiv" class="col-sm-8" style="margin: 20px; display: none;">
								<font style="font-color: red; font-weight: bold;">正在上传...<br>请勿关闭窗口</font>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="pull-right">
								<button type="button" 
									 class="btn btn-primary progressBtn" onclick="upTemplate();">
									确定
								</button>
							</div>
						</div>
					</div>
					</div>
				</form>
			</jdf:form>
		</div>
	<script type="text/javascript">
		function upTemplate(){
			$("#isform").submit();
			window.parent.$.colorbox.close();
		}
	
	</script>
</body>
</body>
</html>