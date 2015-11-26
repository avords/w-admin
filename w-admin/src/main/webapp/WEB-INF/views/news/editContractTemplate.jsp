<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>上传合同附件</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">上传合同附件</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/contracttemplate/save" class="form-horizontal" id="editForm" enctype="multipart/form-data">
					<input type="hidden" name="objectId">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<label for="attachmentNo" class="btn btn-flat">请选择合同模板：</label>
									</div>
									<input type="file" class="form-control" name="contractTemPath" id="contractTemPath">
								</div>
							</div>
						</div>
						
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary progressBtn">
									<span class="glyphicon glyphicon-floppy-save"></span>
										上传
								</button>
								<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">返回</button>
							</div>
								
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Contract"/>
	<script type="text/javascript">
	function comeBack(){
		window.location.href = '${dynamicDomain}/contract/page';
	}
	</script>
</body>
</html>