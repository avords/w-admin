<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>菜单管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<jdf:message code="system.menu.menu" />
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/menu/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_EQI_type" class="col-sm-4 control-label">菜单名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_name">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/menu/create" class="btn btn-primary pull-left">
						<span class="glyphicon glyphicon-plus"></span>新增
					</a>
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">
							<span class="glyphicon glyphicon-search"></span>
							<jdf:message code="common.button.query" />
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="menu.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="menu.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 20%">
					<a href="${dynamicDomain}/menu/edit/${currentRowObject.objectId}"
						class="btn btn-primary btn-mini"> <i
						class="icon-pencil icon-white"></i> <jdf:message
							code="common.button.edit" />
					</a>
					<a
						href="javascript:toDeleteUrl('${dynamicDomain}/menu/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"> <i
						class="icon-trash icon-white"></i> <jdf:message
							code="common.button.delete" />
					</a>
					<c:if test="${currentRowObject.type==2}">
						<a
							href="${dynamicDomain}/menuLink/addMenuLink/${currentRowObject.objectId}"
							class="btn btn-primary btn-mini"> <i
							class="icon-link icon-white"></i> <jdf:message
								code="system.lable.menu.link" />
						</a>
					</c:if>
				</jdf:column>
				<jdf:column property="objectId" title="common.lable.id"
					style="width: 5%" />
				<jdf:column property="name" title="system.lable.menu.name"
					style="width:15%" />
				<jdf:column property="path" title="system.lable.menu.path"
					style="width:35%" />
				<jdf:column property="type" title="system.lable.menu.type"
					style="width:5%">
					<jdf:columnValue dictionaryId="106"
						value="${currentRowObject.type}" />
				</jdf:column>
				<jdf:column property="status" title="common.lable.status"
					style="width:5%">
					<jdf:columnValue dictionaryId="103"
						value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="orderId" title="system.lable.menu.order"
					style="width:5%" />
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>