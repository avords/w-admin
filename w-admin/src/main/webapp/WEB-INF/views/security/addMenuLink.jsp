<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.lable.menu.link"/></title>
</head>
<body>
	<div class="panel">
		<div class="panel-header">
			<i class="icon-link"></i><jdf:message code="system.lable.menu.link"/>
		</div>
		<div class="panel-content">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/menuLink/save?ajax=1" class="form-horizontal" id="MenuLink">
					<input type="hidden" name="objectId">	
					<input type="hidden" name="menuId" value="${menuId}">
					<div class="row">
						<div class="span12 alert alert-info" id="messageBox">
							${message}
						</div>
            			<div class="span6">
							<div class="control-group">
								<label class="control-label" for="url"><jdf:message code="system.lable.menu.url"/></label>
								<div class="controls">
									<input type="text" name="url" id="url" class="input-medium">
								</div>
							</div>
						</div>
            			<div class="span6">
							<div class="control-group">
								<label class="control-label" for="remark"><jdf:message code="common.lable.remark"/></label>
								<div class="controls">
									<input type="text" name="remark" id="remark" class="input-medium">
								</div>
							</div>
						</div>
						<div class="span12 pull-right text-right">
		                	<button type="submit" class="btn btn-primary"><i class="icon-save icon-white"></i><jdf:message code="common.button.save"/></button>
		                </div>
					</div>
				</form>
			</jdf:form>
			<hr>
			<c:forEach var="item" items="${menuLinks}" varStatus="num">
				<form action="${dynamicDomain}/menuLink/save?ajax=1" method="post" class="form-horizontal" id="form_${num.index}">
					<input type="hidden" name="objectId" value="${item.objectId}">
					<input type="hidden" name="menuId" value="${item.menuId}">
					<div class="row">
            			<div class="span3">
							<div class="control-group">
								<label class="control-label" for="url"><jdf:message code="system.lable.menu.url"/></label>
								<div class="controls">
									<input type="text" name="url" class="input-medium" value="${item.url}">
								</div>
							</div>
						</div>
            			<div class="span3">
							<div class="control-group">
								<label class="control-label" for="remark"><jdf:message code="common.lable.remark"/></label>
								<div class="controls">
									<input type="text" name="remark" class="input-medium"  value="${item.remark}">
								</div>
							</div>
						</div>
						<div class="span12 pull-right text-right">
		                	<button type="submit" class="btn btn-primary btn-mini"><i class="icon-save icon-white"></i><jdf:message code="common.button.save"/></button>
		                	<button type="button" class="btn btn-danger btn-mini" onclick="$('#form_${num.index}').attr('action','${dynamicDomain}/menuLink/delete/${item.objectId}?ajax=1').submit();"><jdf:message code="common.button.delete"/></button>
		                </div>
					</div>
				</form>
			<hr>
			</c:forEach>
		</div>
	</div>
	<jdf:bootstrapDomainValidate domain="MenuLink"/>
</body>
</html>