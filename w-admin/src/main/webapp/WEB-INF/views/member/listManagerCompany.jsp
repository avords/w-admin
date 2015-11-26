<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>客户经理企业跟进管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				客户经理企业跟进
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/manager" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业规模：</label>
								<div class="col-sm-8">
									<select name="search_EQI_type" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1301" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">行业：</label>
								<div class="col-sm-8">
									<select name="search_EQI_companyType" class="search-form-control">
                                        <option value="">—全部—</option>
										<jdf:select dictionaryId="1303" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">手机：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_telephone">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_linker">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人邮箱：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_email">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label class="col-sm-2 control-label">企业所在地：</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${param.search_STARTS_areaId}" district="search_STARTS_areaId" styleClass="form-control inline"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this);$('#search_STARTS_areaId').val('')">
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="manager">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" headerStyle="width: 6%">
					<a href="${dynamicDomain}/companyFollow/create?ajax=1&id=${currentRowObject.objectId}"class="colorbox-big btn btn-primary">跟进</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column property="verifyStatus" title="状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.verifyStatus}" />
				</jdf:column>
				<jdf:column property="1" title="跟进次数" headerStyle="width:7%;" viewsDenied="html">
					${currentRowObject.followSum}
				</jdf:column>
				<jdf:column property="followSum" title="跟进次数" headerStyle="width:7%;" viewsAllowed="html">
					<a href="${dynamicDomain}/companyFollow/create?ajax=1&id=${currentRowObject.objectId}"class="colorbox-big">
					<font size="3px;">${currentRowObject.followSum}</font>
					</a>
				</jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">
					<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}" target="_blank">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.companyName}</font></a></div>
				</jdf:column>
				<jdf:column property="webSite" title="企业网址" headerStyle="width:7%;" >
                     <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.webSite}">${currentRowObject.webSite}</div>
                </jdf:column> 
				<jdf:column property="companyType" title="行业" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1303" value="${currentRowObject.companyType}" />
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:6%;" />
				<jdf:column property="email" title="联系人邮箱" headerStyle="width:8%;" />
				<jdf:column property="phone" title="办公电话" headerStyle="width:7%;" />
				<jdf:column property="telephone" title="手机" headerStyle="width:7%;" />
				<jdf:column property="channels" title="了解渠道" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1309" value="${currentRowObject.channels}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">

	</script>
</body>
</html>