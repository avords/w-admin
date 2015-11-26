<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.department" /></title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title"><jdf:message code="system.menu.department" /></h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/department/save" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<button type="button" class="btn btn-flat">部门名称：</button>
									</div>
									<input type="text" class="form-control" name="name">
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
						<div class="col-sm-12  col-md-12">
							<div class="pull-right">
								<a href="${dynamicDomain}/department/page">
									<button type="button" class="btn">
									<i class="glyphicon glyphicon-fast-backward"></i> 返回</button>
								</a>
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-floppy-save"></span>
										<jdf:message code="common.button.save"/>
								</button>
							</div>
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Department"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").rules("add", { 
				remote:{
					  url: "${dynamicDomain}/department/isUnique?ajax=1&objectId=${entity.objectId}", 
					  type: "post",
					  dataType: "json"
				},
				messages:{
					remote:"该名称已存在"
				}
			});
		});
	</script>
</body>
</html>