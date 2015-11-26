<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.function_security"/></title>
</head>
<body>
	<div class="panel">
		<div class="panel-header">
			<i class="icon-table"></i><jdf:message code="system.menu.function_security"/>
			<div class="actions-bar pull-right ">
				<a href="${dynamicDomain}/opera/create?ajax=1" class="btn btn-success colorbox">
					<i class="icon-plus-sign icon-white"></i><jdf:message code="common.button.add"/>
				</a>
			</div>
		</div>
		<div class="panel-content">
			<jdf:form bean="request" scope="request">
				<form action="${dynamicDomain}/opera/page" method="post" class="form-horizontal">
					<div class="row-fluid">
						<div class="span12">
							<div id="messageBox" class="alert alert-info" style="display:none">${message}</div>
						</div>
						<div class="span6">
							<div class="control-group">
								<label class="control-label" for="search_LIKES_name"><jdf:message code="system.lable.function.name"/></label>
								<div class="controls">
									<input type="text" name="search_LIKES_name" class="input-medium" />
								</div>
							</div>
						</div>
						<div class="span6">
							<div class="control-group">
								<label class="control-label" for="search_LIKES_code"><jdf:message code="system.lable.function.code"/></label>
								<div class="controls">
									<input type="text" name="search_LIKES_code" class="input-medium" />
								</div>
							</div>
						</div>
						<div class="span12 pull-right text-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i><jdf:message code="common.button.clear"/>
							</button>
							<button type="submit" class="btn btn-primary">
								<i class="icon-search icon-white"></i><jdf:message code="common.button.query"/>
							</button>
						</div>
					</div>
				</form>
			</jdf:form>
			<div id="tableDiv">
				<jdf:table items="items"  retrieveRowsCallback="limit" var="currentRowObject" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
					<jdf:export view="csv" fileName="operation.csv"/>
					<jdf:export view="xls" fileName="operation.xls"/>
					<jdf:row>
						<jdf:column property="name" title="system.lable.function.name" style="width:40%" />
						<jdf:column property="code" title="system.lable.function.code" style="width: 40%"/>
						<jdf:column alias="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 20%">
							<a href="${dynamicDomain}/opera/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox">
								<i class="icon-pencil icon-white"></i><jdf:message code="common.button.edit"/>
							</a>
							<a href="javascript:toDeleteUrl('${dynamicDomain}/opera/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
								<i class="icon-trash icon-white"></i><jdf:message code="common.button.delete"/>
							</a>
						</jdf:column>
					</jdf:row>
				</jdf:table>
			</div>
		</div>
	</div>
</body>
</html>