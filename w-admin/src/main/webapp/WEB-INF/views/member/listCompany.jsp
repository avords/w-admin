<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业入驻管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业入驻管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_type" class="col-sm-4 control-label">企业规模：</label>
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
								<label for="search_LIKES_companyName" class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_companyName" class="col-sm-4 control-label">行业：</label>
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
								<label class="col-sm-4 control-label">审核状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_verifyStatus" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1304" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_linker">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人邮箱：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_email">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">手机：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_telephone">
								</div>
							</div>
						</div>
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label class="col-sm-2 control-label">企业所在地：</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${param.search_STARTS_areaId}" district="search_STARTS_areaId" city="_city" province="_province" styleClass="form-control inline"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业来源：</label>
								<div class="col-sm-8">
									<select name="search_EQI_originId" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1300" valid="true" />
									</select>
								</div>
							</div>
						</div>
                        <div class="col-sm-4 col-md-4">
                          <div class="form-group">
                            <label class="col-sm-4 control-label">是否指派：</label>
                            <div class="col-sm-8">
                              <select name="search_EQI_isAccountManager" class="search-form-control">
                                <option value="">—全部—</option>
                                <jdf:select dictionaryId="1305" valid="true" />
                              </select>
                            </div>
                          </div>
                        </div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/company/create" class="btn btn-primary pull-left">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this);$('#search_STARTS_areaId').val('')">
								<i class="icon-remove icon-white"></i>重置
							</button>
						<button type="submit" class="btn btn-primary">查询
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
	<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" headerStyle="width: 13%">
					<c:if test="${currentRowObject.verifyStatus!=0}">
					<a href="${dynamicDomain}/company/edit/${currentRowObject.objectId}" class="btn btn-primary btn-mini"> 
					<i class="glyphicon glyphicon-pencil"></i> 
					</a>
					</c:if>
					<a href="${dynamicDomain}/company/callOn?ajax=1&ids=${currentRowObject.objectId}" class="btn btn-primary btn-mini colorbox"> 
					 指派
					</a>
					<!--  a href="javascript:toDeleteUrl('${dynamicDomain}/company/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini"> 
					<i class="glyphicon glyphicon-trash"></i> <jdf:message code="common.button.delete" />
					</a>-->
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column property="originId" title="企业来源" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1300" value="${currentRowObject.originId}" />
				</jdf:column>
				<jdf:column property="logoId" title="企业logo" headerStyle="width:7%;">
                	<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}" target="_blank">
                  <img class="avatar-32" src="${dynamicDomain}/${currentRowObject.logoId}" width="40px" alt="logo"></a>
                </jdf:column>
                <jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">
					<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}" target="_blank">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.companyName}</font></a></div>
				</jdf:column>
				<jdf:column property="managerName" title="客户经理" headerStyle="width:7%" />
				<jdf:column property="type" title="企业规模" headerStyle="width:8%;">
                    <div class="text-ellipsis" style="width: 120px;" title="<jdf:columnValue dictionaryId='1301' value='${currentRowObject.type}' />">
					<jdf:columnValue dictionaryId="1301" value="${currentRowObject.type}" /></div>
				</jdf:column>
				<jdf:column property="companyStatus" title="企业状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1302" value="${currentRowObject.companyStatus}" />
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:6%;" />
				<jdf:column property="email" title="联系人邮箱" headerStyle="width:8%;" />
				<jdf:column property="phone" title="办公电话" headerStyle="width:7%;" />
				<jdf:column property="telephone" title="手机" headerStyle="width:6%;" />
				<jdf:column property="verifyStatus" title="审核状态" headerStyle="width:7%;">
					<c:if test="${currentRowObject.verifyStatus==3}">
                    <font color="green"><jdf:columnValue dictionaryId="1304" value="3" /></font>
                    </c:if>
                    <c:if test="${currentRowObject.verifyStatus!=3}">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.verifyStatus}" />
                    </c:if>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	</script>
</body>
</html>