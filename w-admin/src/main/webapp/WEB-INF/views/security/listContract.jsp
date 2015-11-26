<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>合同管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<jdf:message code="system.menu.user" />
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/contract/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">合同签订对象：</button>
								</div>
								<select name="search_EQI_customerType" class="search-form-control">
									<option value="">—全部—</option>
									<jdf:select dictionaryId="104" valid="true" />
								</select>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">合同编号：</button>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_contractNo">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">对方名称：</button>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_customerName">
							</div>
						</div>
				</div>
				
				<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<button type="button" class="btn btn-flat">对方编号：</button>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_customerNo">
							</div>
						</div>
						
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/contract/create" class="btn btn-primary pull-left">
						<span class="glyphicon glyphicon-plus"></span>新增
					</a>
					
					<a href="#" class="pull-left">
						<button type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-export"></span>导出
						</button>
					</a>
					<div class="pull-right">
<!-- 						<button type="button" class="btn" onclick="clearForm(this)"> -->
<!-- 							<span class="glyphicon glyphicon-remove"></span> -->
<%-- 							<jdf:message code="common.button.clear" /> --%>
<!-- 						</button> -->
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
			<jdf:export view="csv" fileName="user.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 20%">
					<a href="${dynamicDomain}/contract/edit/${currentRowObject.objectId}"
						class="btn btn-primary btn-mini colorbox"> <i
						class="glyphicon glyphicon-pencil"></i> <jdf:message
							code="common.button.edit" />
					</a>
					<a
						href="javascript:toDeleteUrl('${dynamicDomain}/contract/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"> <i
						class="glyphicon glyphicon-trash"></i> <jdf:message
							code="common.button.delete" />
					</a>

				</jdf:column>
				<jdf:column property="contractNo"
					title="合同编号" headerStyle="width:20%;" />
				<jdf:column property="customerType" title="合同签订对象"
					headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="104"
						value="${currentRowObject.customerType}" />
				</jdf:column>
				<jdf:column property="startDate" cell="date" title="合同开始时间"  style="width:20%" />
				<jdf:column property="endDate" cell="date" title="合同结束时间"  style="width:20%" />
				<%-- <jdf:column property="email" title="common.lable.email"
					headerStyle="width:15%;" />
				<jdf:column property="type" title="system.lable.user.type"
					headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="104"
						value="${currentRowObject.type}" />
				</jdf:column> --%>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>