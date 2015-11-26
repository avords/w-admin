<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业组织架构设置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业组织架构设置
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/companyDepartment/page" method="post" class="form-horizontal">
				<input type="hidden" name="search_EQL_companyId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">部门名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_name">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">备注：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_remark">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/companyDepartment/create?companyId=${param.search_EQL_companyId}&ajax=1" class="btn btn-primary colorbox-double pull-left">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询 </button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="user.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 8%">
					<a href="${dynamicDomain}/companyDepartment/edit/${currentRowObject.objectId}?ajax=1"
						class="btn btn-primary btn-mini colorbox-double"><i
						class="glyphicon glyphicon-pencil"></i>
					</a>
					<a href="javascript:toDeleteUrl('${dynamicDomain}/companyDepartment/delete/${currentRowObject.objectId}?search_EQL_companyId=${param.search_EQL_companyId}')"
						class="btn btn-danger btn-mini"><i class="glyphicon glyphicon-trash"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="companyId" title="所属企业" headerStyle="width:8%;" >
					 <jdf:columnCollectionValue items="companys"  nameProperty="companyName" value="${currentRowObject.companyId}"/>
				</jdf:column>
				<jdf:column property="name" title="部门名称" headerStyle="width:10%;" />
				<jdf:column property="sortNo" title="排序" headerStyle="width:10%;" />
				<jdf:column property="headCount" title="部门人数" headerStyle="width:8%;" />
				<jdf:column property="remark" title="备注" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>