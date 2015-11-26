<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.user"/></title>
</head>
<body>
	<div class="panel">
		<div class="panel-header">
			<i class="icon-edit"></i><jdf:message code="system.menu.function_security"/>
		</div>
		<div class="panel-content">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/opera/save?ajax=1" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">	
					<div class="row">
						<div class="span12 alert alert-info" id="messageBox">
							${message}
						</div>
            			<div class="span12">
							<div class="control-group">
								<label class="control-label" for="name"><jdf:message code="system.lable.function.name"/></label>
								<div class="controls">
									<input type="text" name="name" id="name" class="input-medium">
								</div>
							</div>
						</div>
            			<div class="span12">
							<div class="control-group">
								<label class="control-label" for="code"><jdf:message code="system.lable.function.code"/></label>
								<div class="controls">
									<input type="text" name="code" id="code" class="input-medium">
								</div>
							</div>
						</div>
						<div class="span12 pull-right text-right">
		                	<button type="submit" class="btn btn-primary"><i class="icon-save icon-white"></i><jdf:message code="common.button.save"/></button>
		                	<c:if test="${not empty message}">
								<button type="button" onclick="toUrl('${dynamicDomain}/opera/create?ajax=1')" class="btn btn-primary">
									<jdf:message code="common.button.goonAdd"/><i class="icon-double-angle-right icon-white"></i>
								</button>
							</c:if>
		                </div>
					</div>
				</form>
			</jdf:form>
		</div>
	</div>
	<jdf:bootstrapDomainValidate domain="Operation"/>
	<script type="text/javascript">
		$(document).ready(function() {
			$("#name").rules("add", { 
				remote:{
					  url: "${dynamicDomain}/opera/nameExists?ajax=1&objectId=${entity.objectId}", 
					  type: "post",
					  dataType: "json"
				},
				messages:{
					remote:"该名称已存在"
				}
			});
			$("#code").rules("add", { 
				remote:{
					  url: "${dynamicDomain}/opera/codeExists?ajax=1&objectId=${entity.objectId}", 
					  type: "post",
					  dataType: "json"
				},
				messages:{
					remote:"该编码已存在"
				}
			});
			refreshParentPage(true);
		});
	</script>
</body>
</html>