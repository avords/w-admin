<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.department" /></title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<a href="${dynamicDomain}/department/create" class="pull-right">
				<button type="submit" class="btn btn-primary"><span class="glyphicon glyphicon-plus"></span>新增</button>
			</a>
			<h4 class="modal-title">
				<jdf:message code="system.menu.department" />
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/department/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">部门名称：</button>
								</div>
								<input type="text" class="form-control" name="search_LIKES_name">
							</div>
						</div>
						<!-- <div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">部门名称：</button>
								</div>
								<input type="text" class="form-control" name="search_LIKES_name">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">部门名称：</button>
								</div>
								<input type="text" class="form-control" name="search_LIKES_name">
							</div>
						</div> -->
					</div>
				</div>
				<div class="box-footer">
							<div class="message-left">
								${message }
							</div>
							<div class="pull-right">
								<button type="button" class="btn" onclick="clearForm(this)">
									<span class="glyphicon glyphicon-remove"></span>
									<jdf:message code="common.button.clear" />
								</button>
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
			<jdf:export view="csv" fileName="department.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="department.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 20%">
					<a
						href="${dynamicDomain}/department/edit/${currentRowObject.objectId}"
						class="btn btn-primary btn-mini colorbox"> <i
						class="glyphicon glyphicon-pencil"></i> <jdf:message
							code="common.button.edit" />
					</a>
					<a
						href="javascript:toDeleteUrl('${dynamicDomain}/department/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"> <i
						class="glyphicon glyphicon-trash"></i> <jdf:message
							code="common.button.delete" />
					</a>

				</jdf:column>
				<jdf:column property="objectId"
					title="system.lable.dept.department_id" style="width: 10%" />
				<jdf:column property="name" title="system.lable.dept.name"
					style="width: 35%" />
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>