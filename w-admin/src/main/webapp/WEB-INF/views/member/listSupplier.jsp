<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商入驻管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				供应商入驻管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/supplier/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_supplierName" class="col-sm-4 control-label">供应商名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_supplierName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_supplierNo" class="col-sm-4 control-label">供应商编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_supplierNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_supplierStatus" class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_supplierStatus" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1110" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
                            <div class="form-group">
                              <label for="search_EQL_brandId" class="col-sm-4 control-label">代理品牌：</label>
                              <div class="col-sm-8">
                                <select name="search_EQL_brandId" class="search-form-control">
									<option value="">—全部—</option>
									<jdf:selectCollection items="brands" optionValue="objectId" optionText="chineseName"/>
								</select>
                              </div>
                            </div>
                        </div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_status" class="col-sm-4 control-label">审核状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1304" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">创建日期：</label>
								<div class="col-sm-4">
						            <input  name="search_GED_createdOn"  id="search_GED_createdOn" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_createdOn\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
								</div>
								<div class="col-sm-4">
									<input  id="search_LED_createdOn" name="search_LED_createdOn"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_createdOn\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_contractNo" class="col-sm-4 control-label">合同号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_contractNo">
								</div>
							</div>
						</div>
                        <div class="col-sm-4 col-md-4">
                          <div class="form-group">
                            <label class="col-sm-4 control-label">合同有效期：</label>
                            <div class="col-sm-4">
                               <input  name="search_GED_contractTerm"  id="search_GED_contractTerm" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_contractTerm\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
                            </div>
                            <div class="col-sm-4">
                              <input  id="search_LED_contractTerm" name="search_LED_contractTerm"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_contractTerm\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
                            </div>
                          </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                          <div class="form-group">
                            <label class="col-sm-4 control-label">营业执照期限：</label>
                            <div class="col-sm-4">
                                    <input  name="search_GED_businessLicenseEnd"  id="search_GED_businessLicenseEnd" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_businessLicenseEnd\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
                            </div>
                            <div class="col-sm-4">
                              <input  id="search_LED_businessLicenseEnd" name="search_LED_businessLicenseEnd"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_businessLicenseEnd\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
                            </div>
                          </div>
                        </div>
					</div>
					<div class="row">
                       <div class="col-sm-4 col-md-4">
                          <div class="form-group">
                            <label for="search_EQI_typeId" class="col-sm-4 control-label">供应商类型：</label>
                            <div class="col-sm-8">
                              <select name="search_EQI_typeId" class="search-form-control">
                                <option value="">—全部—</option>
                                <jdf:select dictionaryId="1314" valid="true" />
                              </select>
                            </div>
                          </div>
                        </div> 
                    </div>	
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/supplier/create" class="pull-left btn btn-primary">
						 <span class="glyphicon glyphicon-plus"></span>
					</a>
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
			<jdf:export view="csv" fileName="supplier.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="supplier.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 10%">
				<c:if test="${currentRowObject.status!=0}">
					<a href="${dynamicDomain}/supplier/edit/${currentRowObject.objectId}?edit=1" class="btn btn-primary btn-mini"> 
					<i class="glyphicon glyphicon-pencil"></i></a>
				</c:if>
				<c:if test="${currentRowObject.status!=3 && currentRowObject.status!=0}">
					<a href="javascript:toDeleteUrl('${dynamicDomain}/supplier/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"><i class="glyphicon glyphicon-trash"></i>
					</a>
				</c:if>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="status" title="审核状态" headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="supplierNo" title="供应商编号" headerStyle="width:10%;" />
				<jdf:column property="1" title="供应商名称" headerStyle="width:10%;" viewsDenied="html">
					${currentRowObject.supplierName}
				</jdf:column>
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;" viewsAllowed="html">
                  <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.supplierName}">
				  <a href="${dynamicDomain}/supplier/view/${currentRowObject.objectId}" target="_blank">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.supplierName}</font></a>
                  </div>
				</jdf:column>
				<jdf:column property="businessLicenseEnd" title="营业执照期限" headerStyle="width:15%;" >
                <c:if test="${not empty currentRowObject.businessLicenseEnd}">
				<fmt:formatDate value="${currentRowObject.businessLicenseStart}" pattern="yyyy-MM-dd" />
				~<fmt:formatDate value="${currentRowObject.businessLicenseEnd}" pattern="yyyy-MM-dd" />
                </c:if>
				</jdf:column>
				<jdf:column property="contractNo" title="合同号" headerStyle="width:10%"/>
				<jdf:column property="commissioned" title="联络人" headerStyle="width:10%;" />
				<jdf:column property="telephone" title="联络人电话" headerStyle="width:10%;" />
				<jdf:column property="supplierStatus" title="状态" headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="1110" value="${currentRowObject.supplierStatus}" />
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