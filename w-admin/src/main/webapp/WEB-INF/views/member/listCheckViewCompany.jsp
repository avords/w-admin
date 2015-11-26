<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业信息查询</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业信息查询
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/viewInfo" method="post"
				class="form-horizontal">
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
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
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
								<label class="col-sm-4 control-label">手机： </label>
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
									<ibs:areaSelect code="${param.search_STARTS_areaId}" district="search_STARTS_areaId" styleClass="form-control inline"/>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="viewInfo">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" headerStyle="width: 17%">
					<a href="${dynamicDomain}/companyStaff/importStaffs/${currentRowObject.objectId}?ajax=1"class="colorbox btn btn-primary">导入员工</a>
					<a href="${dynamicDomain}/companyDepartment/page?search_EQL_companyId=${currentRowObject.objectId}" class="btn btn-primary">维护部门</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column alias="logoId" title="企业logo" sortable="false" viewsAllowed="html" headerStyle="width: 8%">
                	<img class="avatar-32" src="${dynamicDomain}/${currentRowObject.logoId}" width="40px" alt="logo">
                </jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">
					<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}" target="_blank">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.companyName}</font></a></div>
				</jdf:column>
				<jdf:column property="webSite" title="企业网址" headerStyle="width:7%;" >
                     <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.webSite}">${currentRowObject.webSite}</div>
                </jdf:column>     
				<jdf:column property="type" title="企业规模" headerStyle="width:8%;">
                    <div class="text-ellipsis" style="width: 120px;" title="<jdf:columnValue dictionaryId='1301' value='${currentRowObject.type}' />">
					<jdf:columnValue dictionaryId="1301" value="${currentRowObject.type}" /></div>
				</jdf:column>
				<jdf:column property="verifyStatus" title="审核状态" headerStyle="width:8%;">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.verifyStatus}" />
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:6%;" />
				<jdf:column property="email" title="联系人邮箱" headerStyle="width:8%;" />
				<jdf:column property="phone" title="办公电话" headerStyle="width:8%;" />
				<jdf:column property="telephone" title="手机" headerStyle="width:7%;" />
				<jdf:column property="staffs" title="已导入员工人数" headerStyle="width:8%;" viewsAllowed="html">
					<a href="${dynamicDomain}/staff/page?search_EQL_companyId=${currentRowObject.objectId}" class=""><font size="3">${currentRowObject.staffs}</font></a>
				</jdf:column>
                <jdf:column property="1" title="已导入员工人数" headerStyle="width:8%;" viewsDenied="html">
                  ${currentRowObject.staffs}
                </jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#search_GED_createDate").datepicker({
				format : 'yyyy-mm-dd'
			});
		});

		function unlock(loginName) {
			$(".unlock").attr("disabled", true);
			$.ajax({
				url : "${dynamicDomain}/user/unlock/" + loginName
						+ "?timstamp=" + (new Date()).valueOf(),
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						showMessage("解锁成功", 60000);
					}
					$(".unlock").attr("disabled", false);
				}
			});
		}
	</script>
</body>
</html>