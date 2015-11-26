<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>套餐列表</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				套餐列表
			</h4>
		</div>
	</div>
	<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/companyTemplate?ajax=1" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="search_LIKES_companyName" class="form-lable">企业名称：</label>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_companyName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
						<button type="submit" class="btn btn-primary">查询
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	<div>
		<jdf:table items="items" var="currentRowObject"cardCreateInfo<div class="form-group has-error">
								<label for="companyName" class="col-sm-4 control-label">公司名称<span class="not-null">*：</span></label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="companyName" readonly="readonly"><span for="companyName" generated="true" class="error"></span> 
									<input type="hidden" class="search-form-control" name="companyId">
								</div>
								<div class="col-sm-2">
									<a href="/w-admin/user/getEnterprise/1?ajax=1&amp;inputName=company" onclick="javascript:setEnterprise('/w-admin/user/getEnterprise/','company');" id="enterprise-btn" class="pull-left btn btn-primary colorbox-template cboxElement">
											选择
									</a>
								</div>
							</div><div class="form-group has-error">
								<label for="companyName" class="col-sm-4 control-label">公司名称<span class="not-null">*：</span></label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="companyName" readonly="readonly"><span for="companyName" generated="true" class="error"></span> 
									<input type="hidden" class="search-form-control" name="companyId">
								</div>
								<div class="col-sm-2">
									<a href="/w-admin/user/getEnterprise/1?ajax=1&amp;inputName=company" onclick="javascript:setEnterprise('/w-admin/user/getEnterprise/','company');" id="enterprise-btn" class="pull-left btn btn-primary colorbox-template cboxElement">
											选择
									</a>
								</div>
							</div><div class="form-group has-error">
								<label for="companyName" class="col-sm-4 control-label">公司名称<span class="not-null">*：</span></label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="companyName" readonly="readonly"><span for="companyName" generated="true" class="error"></span> 
									<input type="hidden" class="search-form-control" name="companyId">
								</div>
								<div class="col-sm-2">
									<a href="/w-admin/user/getEnterprise/1?ajax=1&amp;inputName=company" onclick="javascript:setEnterprise('/w-admin/user/getEnterprise/','company');" id="enterprise-btn" class="pull-left btn btn-primary colorbox-template cboxElement">
											选择
									</a>
								</div>
							</div>
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="companyTemplate?ajax=1">
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" 
				headerStyle="width: 10%" style="text-align:center">
					<button type="button" class="btn btn-primary" onclick="javascript:setCompany(${currentRowObject.objectId},'${currentRowObject.companyName}')">选择</button>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false" />
				<jdf:column property="companyName" title="企业名称" headerStyle="width:20%;"/>
				<jdf:column property="linker" title="联系人" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setCompany(companyId,companyName){
		$(window.parent.document).find("input[name='${inputName}Name']").val(companyName);
		$(window.parent.document).find("input[name='${inputName}Id']").val(companyId);
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>