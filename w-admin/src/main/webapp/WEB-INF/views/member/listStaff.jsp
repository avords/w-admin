<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业员工查询</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业员工查询
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/staff/page?search_EQL_companyId=${param.search_EQL_companyId}" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">员工姓名：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_staffName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">邮箱：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_email">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系方式</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_telephone">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							重置
						</button>
						<button type="submit" class="btn btn-primary">
							<jdf:message code="common.button.query" />
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="Staff.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="Staff.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column property="userName" title="员工姓名" headerStyle="width:7%;"/>
				<jdf:column property="departmentId" title="所属机构" headerStyle="width:7%;">
                	<jdf:columnCollectionValue items="departments"  nameProperty="name" value="${currentRowObject.departmentId}"/>
                </jdf:column>
				<jdf:column property="email" title="员工邮箱" headerStyle="width:6%;" />
				<jdf:column property="birthday" title="员工生日" headerStyle="width:6%;" cell="date"/>
				<jdf:column property="type" title="员工证件类型" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1306" value="${currentRowObject.type}" />
				</jdf:column>
				<jdf:column property="cardNo" title="员工证件号码" headerStyle="width:6%;" />
				<jdf:column property="mobilePhone" title="员工联系方式" headerStyle="width:7%;"/>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>