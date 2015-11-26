<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>平台管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				平台管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/server/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_platform" class="col-sm-4 control-label">平台名称：</label>
								<div class="col-sm-8">
									<select name="search_EQI_platform" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1112" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_context" class="col-sm-4 control-label">上下文：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
									name="search_LIKES_context">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_domain" class="col-sm-4 control-label">域名：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
									name="search_LIKES_domain">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/server/create?ajax=1"
						class="pull-left colorbox-mini btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">
							<span class="glyphicon glyphicon-search"></span>
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
			<jdf:export view="csv" fileName="server.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="server.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="操作" title="操作" sortable="false"
					viewsAllowed="html" style="width: 15%;text-align:center">
					<a
						href="${dynamicDomain}/server/edit/${currentRowObject.objectId}?ajax=1"
						class="btn btn-primary btn-mini colorbox-mini"><i
						class="glyphicon glyphicon-pencil"></i> </a>
					<a
						href="javascript:toDeleteUrl('${dynamicDomain}/server/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"><i
						class="glyphicon glyphicon-trash"></i> </a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="platform" title="所属平台" style="width:20%;">
					<jdf:columnValue dictionaryId="1112"
						value="${currentRowObject.platform}" />
				</jdf:column>
				<jdf:column property="domain" title="域名" style="width:20%" />
				<jdf:column property="port" title="端口" style="width:10%" />
				<jdf:column property="context" title="上下文" style="width:20%" />
				<jdf:column property="status" title="状态" style="width:10%">
					<jdf:columnValue dictionaryId="107"
						value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>