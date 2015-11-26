<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="select2.js" />
<title>供应商管理</title>
<style>
.upView {
	margin: 7px 0 0 0;
}
.title{
  text-align: right;
}
.list{
  width:93%;
  margin:0 0 0 60px;
}
table th {
	text-align: center;
}
table td {
	text-align: center;
}
table tbody tr td input {
	width: 60px;
}
.col-sm-8 span {
	display: block;
	margin-top: 7px;
}
.businessTerm {
	display: block;
	margin-top: 7px;
}
.btnL{
    margin-left:10px;
}
</style>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					供应商入驻申请
					<c:choose>
						<c:when test="${entity.objectId eq null }">新增</c:when>
						<c:when test="${not empty param.list}">审核</c:when>
						<c:when test="${not empty view}">详情</c:when>
						<c:otherwise>修改</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<form method="post" action="${dynamicDomain}/supplier/save"
				id="Supplier" class="form-horizontal">
				<input type="hidden" name="objectId" id="overallId"> 
				<input type="hidden" name="types" id="types"> 
				<input type="hidden" name="isSelf" id="isSelf">
				<input type="hidden" name="all" id="all">
				<div class="box-body">
					<c:if test="${not empty param.edit || not empty param.list || not empty view}">
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label for="status" class="col-sm-4 control-label">审核状态</label>
									<div class="col-sm-8 upView">
										<jdf:columnValue dictionaryId='1304' value='${entity.status}' />
                                        <fmt:formatDate value="${entity.updatedOn}" pattern="yyyy-MM-dd" />
									</div>
								</div>
							</div>
							<c:if test="${entity.status==2 }">
								<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label for="reasons" class="col-sm-4 control-label">审核未通过原因</label>
										<div class="col-sm-8 upView">${entity.reasons}</div>
									</div>
								</div>
							</c:if>
						</div>
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label for="applyId" class="col-sm-4 control-label">申请人</label>
									<div class="col-sm-8 upView">${applierName}</div>
								</div>
							</div>
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label for="applyTime" class="col-sm-4 control-label">申请时间</label>
									<div class="col-sm-8 upView">
										<fmt:formatDate value='${entity.applyTime}' pattern='yyyy-MM-dd HH:mm:ss' />
									</div>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-2 title" onclick="switchBase();">
									<h4>
										<b>基本信息<button type="button" class="btn btn-default btn-xs btnL btnL"><i id="iBase" class="fa fa-angle-down"></i></button></b>
									</h4>
								</div>
                                <div class="col-sm-9 hideView0">
                                <hr/>
                                </div>
								<div class="pull-right hideSave0">
									<button type="button" class="btn btn-primary" id="partbutton1" onClick="baseSave();">保存</button>
								</div>
							</div>
						</div>
					</div>
                    <div class="hideView0">
					<div class="row">
						<c:if test="${not empty objectId }">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierNo" class="col-sm-4 control-label">供应商编号</label>
								<div class="col-sm-8 upView">${entity.supplierNo}</div>
							</div>
						</div>
						</c:if>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="type" class="col-sm-4 control-label">供应商类型<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<c:choose>
										<c:when test="${entity.objectId eq null }"><jdf:checkBox dictionaryId="1314" name="type" /></c:when>
										<c:when test="${not empty param.list}">
												<span class="">
											<c:if test="${supplierTypeList != null}">
											<c:forEach items="${supplierTypeList}" var="supplierType">
												<jdf:dictionaryName dictionaryId="1314" value="${supplierType.typeId}" />&nbsp;&nbsp;
											</c:forEach>
											</c:if>
												</span>
										</c:when>
										<c:when test="${not empty view}">
												<span class="">
											<c:if test="${supplierTypeList != null}">
											<c:forEach items="${supplierTypeList}" var="supplierType" >
												<jdf:dictionaryName dictionaryId="1314" value="${supplierType.typeId}" />&nbsp;&nbsp;
											</c:forEach>
											 </c:if>
												</span>
										</c:when>
										<c:otherwise><jdf:checkBox dictionaryId="1314" name="type" /></c:otherwise>
									</c:choose>
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierName" class="col-sm-4 control-label">供应商名称</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" id="supplierName"
										name="supplierName" >
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="simpleName" class="col-sm-4 control-label">供应商简称</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="simpleName">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="legalrepresentative" class="col-sm-4 control-label">法人代表姓名</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="legalrepresentative">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cardType" class="col-sm-4 control-label">证件类型</label>
								<div class="col-sm-8">
									<select name="cardType" id="cardType"
										class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1306" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cardNo" class="col-sm-4 control-label">证件号码</label>
								<div class="col-sm-8" id="CDNo">
									<input type="text" class="search-form-control" name="cardNo" id="cardNo">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="companyType" class="col-sm-4 control-label">公司类型</label>
								<div class="col-sm-8">
									<select name="companyType" id="companyType"
										class="form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1307" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="simpleName" class="col-sm-4 control-label"><font color="red">内卖企业</font></label>
								<c:choose>
									<c:when test="${entity.objectId eq null }">
										<div class="col-sm-6">
											<input type="text" class="search-form-control" name="companyName" > 
											<input type="hidden" class="search-form-control" name="companyId">
										</div>
									</c:when>
									<c:when test="${not empty param.list}">
									<div class="col-sm-8">
									<input type="text" class="search-form-control" name="companyName" >
									</div>
									</c:when>
									<c:when test="${not empty view}">
									<div class="col-sm-8">
									<input type="text" class="search-form-control" name="companyName" >
									</div>
									</c:when>
									<c:otherwise>
										<div class="col-sm-6">
											<input type="text" class="search-form-control" name="companyName" > 
											<input type="hidden" class="search-form-control" name="companyId">
										</div>
									</c:otherwise>
								</c:choose>
								<div class="col-sm-2">
									<c:choose>
										<c:when test="${entity.objectId eq null }">
											<a href="${dynamicDomain }/company/innerCompany?ajax=1&inputName=company"
											id="enterprise-btn" class="pull-left btn btn-primary colorbox-template"> 选择 </a>
										</c:when>
										<c:when test="${not empty param.list}"></c:when>
										<c:when test="${not empty view}"></c:when>
										<c:otherwise>
											<a href="${dynamicDomain }/company/innerCompany?ajax=1&inputName=company"
											id="enterprise-btn" class="pull-left btn btn-primary colorbox-template"> 选择 </a>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessTerm" class="col-sm-4 control-label">营业期限</label>
								<c:choose>
									<c:when test="${entity.objectId eq null }">
										<div class="col-sm-7">
											<input type="text" class="search-form-control integer" name="businessTerm" id="businessTerm">
										</div>
									</c:when>
									<c:when test="${not empty param.list}">
										<div class="col-sm-7 businessTerm" >
											${entity.businessTerm }年
										</div>
									</c:when>
									<c:when test="${not empty view}">
										<div class="col-sm-7 businessTerm" >
											${entity.businessTerm }年
										</div>
									</c:when>
									<c:otherwise>
										<div class="col-sm-7">
											<input type="text" class="search-form-control integer" name="businessTerm" id="businessTerm">
										</div>
									</c:otherwise>
								</c:choose>
                                <c:if test="${empty view && empty param.list}">
								<div class="col-sm-1 upView">年</div></c:if>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
                            <c:if test="${empty view && empty param.list}">
             	                <label for="isSelf" class="col-sm-4 control-label">&nbsp;&nbsp;</label>
                                <div class="col-sm-8">
                                    <input type="checkbox" name="onlySelf" value="1" onclick="checkCompany();"> 
                                    <font color="red">仅供内卖&nbsp;&nbsp;&nbsp;&nbsp;(说明：若选择内卖企业，则表示供应商与该企业为同一家公司，若勾选仅供内卖，则该供应商发布的商品，只面向该企业销售，反之对全平台销售。)</font>
                                </div>
                            </c:if>
                            <c:if test="${not empty view || not empty param.list}">
                                <label for="isInSelling" class="col-sm-4 control-label"><font color="red">是否仅供内卖</font></label>
                                <div class="col-sm-8">
                                    <c:if test="${entity.isInSelling==1}">
                                        <div class="upView"><font color="red">是</font></div>
                                     </c:if>
                                     <c:if test="${entity.isInSelling!=1}">
                                        <div class="upView"><font color="red">否</font></div>
                                     </c:if>
                                </div>
                            </c:if>
							</div>
						</div>
					</div>
                    <div class="row">
                      <div class="col-sm-6 col-md-6">
                        <div class="form-group">
                          <label for="businessLicenseNo" class="col-sm-4 control-label">营业执照注册号</label>
                          <div class="col-sm-8">
                            <input type="text" class="search-form-control"
                              name="businessLicenseNo">
                          </div>
                        </div>
                      </div>
                    </div>
					<div class="row">
                        <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                              <label for="businessLicenseYear" class="col-sm-4 control-label">营业执照年检年度</label>
                              <div class="col-sm-8">
                                <input type="text" class="search-form-control integer"
                                  name="businessLicenseYear">
                              </div>
                            </div>
                        </div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessLicenseStart" class="col-sm-4 control-label">营业执照期限</label>
								<div class="col-sm-4">
									<input id="businessLicenseStart" name="businessLicenseStart"
										type="text" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'businessLicenseEnd\')}',dateFmt:'yyyy-MM-dd'})"
										class="search-form-control" />
								</div>
                                <div class="col-sm-4">
                                  <input id="businessLicenseEnd" name="businessLicenseEnd"
                                    type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'businessLicenseStart\')}',dateFmt:'yyyy-MM-dd'})"
                                    class="search-form-control" />
                                </div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="organizationYear" class="col-sm-4 control-label">组织机构代码年检年度</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control integer"
										name="organizationYear">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="organizationStart" class="col-sm-4 control-label">组织机构代码证期限</label>
								<div class="col-sm-4">
									<input id="organizationStart" name="organizationStart"
										type="text" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'organizationEnd\')}',dateFmt:'yyyy-MM-dd'})"
										class="search-form-control" />
								</div>
                                <div class="col-sm-4">
                                  <input id="organizationEnd" name="organizationEnd" type="text"
                                    onClick="WdatePicker({minDate:'#F{$dp.$D(\'organizationStart\')}',dateFmt:'yyyy-MM-dd'})" class="search-form-control" />
                                </div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="companyDay" class="col-sm-4 control-label">公司成立日</label>
								<div class="col-sm-8">
									<input id="companyDay" name="companyDay" type="text"
										onClick="WdatePicker()" class="search-form-control" />
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="yearTurnover" class="col-sm-4 control-label">年营业额</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control decimal2"
										name="yearTurnover">
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="commissioned" class="col-sm-4 control-label">被授权人</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="commissioned" id="commissioned">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="companyMoney" class="col-sm-4 control-label">公司注册资金</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control decimal2"
										name="companyMoney">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="email" class="col-sm-4 control-label">联系人邮箱</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control email" name="email" id="email">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone" class="col-sm-4 control-label">联系人电话</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control mobile" name="telephone" id="telephone">
								</div>
							</div>
						</div>
					</div>
                    <div class="row">
                        <div class="col-sm-12 col-md-8">
                          <div class="form-group">
                            <label for="telephone" class="col-sm-3 control-label">办公地址</label>
                            <div class="col-sm-8">
                              <c:choose>
                                <c:when test="${entity.objectId eq null }">
                                  <ibs:areaSelect code="${entity.areaId}" district="areaId1" province="province1" city="city1"
                                    styleClass="form-control inline" />
                                </c:when>
                                <c:when test="${not empty param.list}">
                                <span>${areaName }</span>
                                </c:when>
                                <c:when test="${not empty view}">
                                <span>${areaName }</span>
                                </c:when>
                                <c:otherwise>
                                  <ibs:areaSelect code="${entity.areaId}" district="areaId1" province="province1" city="city1"
                                    styleClass="form-control inline" />
                                </c:otherwise>
                              </c:choose>
                            </div>
                          </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                          <div class="form-group">
                            <label for="addressDetail" class="col-sm-2 control-label">公司详细地址</label>
                            <div class="col-sm-8">
                              <input type="text" class="search-form-control"
                                name="addressDetail" id="addressDetail">
                            </div>
                          </div>
                        </div>
                    </div>
                    </div>
                    <jdf:bootstrapDomainValidate domain="Supplier" index="0"/>
                  </div>
                </form>
              </jdf:form>
              
              <!-- 清算信息 -->      
              <jdf:form bean="liquid" scope="request">
				   <div class="row">
					   <div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-2 title" onclick="switchLiquid();">
									<h4>
										<b>清算信息<button type="button" class="btn btn-default btn-xs btnL"><i id="iLiquid" class="fa fa-angle-down"></i></button></b>
									</h4>
								</div>
                                <div class="col-sm-9 hideView1">
                                <hr/>
                                </div>
								<div class="pull-right hideSave1">
									<button type="button" class="btn btn-primary" id="partbutton2" onClick="liquidationSave();">保存</button>
								</div>
							</div>
						</div>
					</div>
					<form method="post" action="${dynamicDomain}/supplierLiquidation/save"  id="SupplierLiquidation" class="hideView1 form-horizontal">
                      <input type="hidden" name="objectId">
                      <input type="hidden" name="liquidFlag" id="liquidFlag">
                      <input type="hidden" name="supplierIDL" id="supplierIDL" value="${entity.objectId }">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cooperations1" class="col-sm-4 control-label">合作方式</label>
								<div class="col-sm-8">
									<c:choose>
										<c:when test="${entity.objectId eq null }">
											<jdf:radio dictionaryId="1315" name="cooperations1"/>
										</c:when>
										<c:when test="${not empty param.list}">
											<span>
												<jdf:dictionaryName dictionaryId="1315" value="${entity.cooperations}" />
											</span>
										</c:when>
										<c:when test="${not empty view}">
											<span>
												<jdf:dictionaryName dictionaryId="1315" value="${entity.cooperations}" />
											</span>
										</c:when>
										<c:otherwise><jdf:radio dictionaryId="1315" name="cooperations1"/></c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="liquidationName1" class="col-sm-4 control-label">清算户名</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="liquidationName1" id="liquidationName1">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="liquidationNum1" class="col-sm-4 control-label">清算账号</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="liquidationNum1" id="liquidationNum1">
								</div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="bank1" class="col-sm-4 control-label">开户行</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="bank1" id="bank1">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="bankAddress1" class="col-sm-4 control-label">银行所在地</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="bankAddress1" id="bankAddress1">
								</div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linker1" class="col-sm-4 control-label">财务联系人</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="linker1" id="linker1">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linkEmail1" class="col-sm-4 control-label">财务联系邮箱</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control email" name="linkEmail1" >
								</div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linkTelephone1" class="col-sm-4 control-label">财务联系方式</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control phone"
										name="linkTelephone1" id="linkTelephone1">
								</div>
							</div>
						</div>
                        <div class="col-sm-6 col-md-6">
                          <div class="form-group">
                            <label for="guaranteeMoney1" class="col-sm-4 control-label">清算币种</label>
                            <div class="col-sm-8 upView">人民币</div>
                          </div>
                        </div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="moneyTerm1" class="col-sm-4 control-label">拨款周期</label>
								<div class="col-sm-8">
									<select name="moneyTerm1" id="moneyTerm1"
										class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1316" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="realDay1" class="col-sm-4 control-label">具体清算日期</label>
								<div class="col-sm-8 " id="real">
								<input type="text" class="search-form-control hideView" value="—请选择—">
								</div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoney1" class="col-sm-4 control-label">保证金</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control"
										name="guaranteeMoney1">
								</div>
								<div class="col-sm-2 upView">万元</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoneyStart1" class="col-sm-4 control-label">保证金有效期</label>
								<div class="col-sm-4">
									<input id="guaranteeMoneyStart1" name="guaranteeMoneyStart1"
										type="text" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'guaranteeMoneyEnd1\')}',dateFmt:'yyyy-MM-dd'})" class="search-form-control" />
								</div>
                                <div class="col-sm-4">
                                  <input id="guaranteeMoneyEnd1" name="guaranteeMoneyEnd1" type="text"
                                    onClick="WdatePicker({minDate:'#F{$dp.$D(\'guaranteeMoneyStart1\')}',dateFmt:'yyyy-MM-dd'})" class="search-form-control" />
                                </div>
							</div>
						</div>
					</div>
					<div class="row hideDiv">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="accountManager1" class="col-sm-4 control-label">客户经理</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="accountManager1" id="accountManager1">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="mobilephone1" class="col-sm-4 control-label">手机号码</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control mobile" name="mobilephone1" id="mobilephone1">
								</div>
							</div>
						</div>
					</div>
			<jdf:bootstrapDomainValidate domain="SupplierLiquidation" index="4"/>
            </form>
        </jdf:form>
		
		<jdf:form bean="brand" scope="request">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="form-group">
						<div class="col-sm-2 title" onclick="switchBrand();">
							<h4>
								<b>代理品牌<button type="button" class="btn btn-default btn-xs btnL"><i id="iBrand" class="fa fa-angle-down"></i></button></b>
							</h4>
						</div>
                        <div class="col-sm-9 hideView2">
                          <hr/>
                        </div>
						<div class="pull-right hideSave2">
							<button type="button" class="btn btn-primary" id="partbutton3" onClick="brandSave();">保存</button>
						</div>
					</div>
				</div>
			</div>
			<form method="post" action="${dynamicDomain}/supplierBrand/save"
				id="SupplierBrand" class="form-horizontal hideView2">
				<input type="hidden" name="objectId">
				<input type="hidden" name="supplierID" id="supplierID" value="${entity.objectId }">
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="brandId" class="col-sm-4 control-label">品牌</label>
							<div class="col-sm-8">
								<select name="brandId" id="pinpai" style="width:300px;">
									<option value="">-请选择-</option>
									<jdf:selectCollection items="brands" optionValue="objectId" optionText="chineseName" />
								</select>
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="brandLevel" class="col-sm-4 control-label">代理级别</label>
							<div class="col-sm-8">
								<select name="brandLevel" id="brandLevel"
									class="search-form-control">
									<option value="">—请选择—</option>
									<jdf:select dictionaryId="1317" />
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="termStart" class="col-sm-4 control-label">品牌授权期限</label>
							<div class="col-sm-4">
								<input id="termStart" name="termStart" type="text"
									onClick="WdatePicker({maxDate:'#F{$dp.$D(\'termEnd\')}',dateFmt:'yyyy-MM-dd'})" class="search-form-control" />
							</div>
                            <div class="col-sm-4">
                              <input id="termEnd" name="termEnd" type="text"
                                onClick="WdatePicker({minDate:'#F{$dp.$D(\'termStart\')}',dateFmt:'yyyy-MM-dd'})" class="search-form-control" />
                            </div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="form-group">
							<label for="organizationStart" class="col-sm-2 control-label">产品分类</label>
							<div class="col-sm-3">
								<div>
									<select name="category1" id="category1"
										class="search-form-control" style="width: 100%;">
										<option value="">—一级分类—</option>
										<jdf:selectCollection items="firstCategory"
											optionValue="firstId" optionText="name" />
									</select>
								</div>
							</div>
							<div class="col-sm-3">
								<div>
									<select name="category2" id="category2"
										class="search-form-control" style="width: 100%;">
									</select>
								</div>
							</div>
							<div class="col-sm-4">
								<div>
									<select name="category3" id="category3"
										class="search-form-control" style="width: 100%;">
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row hideView">
						<div class="editPageButton">
							<button type="button" class="btn" onclick="addBrand();">添加品牌</button>
						</div>
					</div>
				</div>
				<jdf:bootstrapDomainValidate domain="SupplierBrand" index="1"/>
			</form>
		</jdf:form>
		<!-- 品牌列表 -->
		<div class="row hideView2">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover list">
					<thead>
						<tr id="brand_00">
							<th>操作</th>
							<th>品牌名称</th>
							<th>代理级别</th>
							<th>品牌授权期限</th>
							<th>&nbsp;&nbsp;产品类别&nbsp;&nbsp;</th>
							<th>&nbsp;&nbsp;佣金&nbsp;&nbsp;</th>
						</tr>
					</thead>
					<tbody id="brandBody">
						<c:forEach items="${supplierBrands}" var="item" varStatus="status">
							<tr id="brand_${status.index}">
								<td>
								<c:choose>
									<c:when test="${entity.objectId eq null }">
									<a href="###" onclick="deleteBrand(${item.objectId},${status.index})"> 删除</a>
									</c:when>
									<c:when test="${not empty param.list}"></c:when>
									<c:when test="${not empty view}"></c:when>
									<c:otherwise>
									<a href="###" onclick="deleteBrand(${item.objectId},${status.index})"> 删除</a>
									</c:otherwise>
								</c:choose>
								</td>
								<td><jdf:columnCollectionValue items="brands" nameProperty="chineseName" value="${item.brandId}" /></td>
								<td>
					                <jdf:columnValue dictionaryId="1317" value="${item.brandLevel}" />
					            </td>
								<td><fmt:formatDate value="${item.termStart}" pattern="yyyy-MM-dd" />
								至<fmt:formatDate value="${item.termEnd}" pattern="yyyy-MM-dd" />
								</td>
								<td>${item.categoryOne}-${item.categoryTwo}-${item.categoryThree}</td>
								<td>
								<c:choose>
									<c:when test="${empty param.list && empty view}">
										<c:if test="${not empty item.commissionWay}">
											<c:choose>
											<c:when test="${item.commissionWay eq 1 }">
                                                <div class="text-ellipsis" style="width: 120px;" title="<c:forEach items='${item.brandCommissions}' var='item1' varStatus='num'>
												${item1.moneyStart}~${item1.moneyStop}元${item1.percent}%
												</c:forEach>">
												<c:forEach items="${item.brandCommissions}" var="item1" varStatus="num">
												${item1.moneyStart}~${item1.moneyStop}元${item1.percent}%&nbsp;&nbsp;
												</c:forEach></div></c:when>
											<c:otherwise><c:if test="${not empty item.moneyper }">每笔收取${item.moneyper}元</c:if></c:otherwise>
											</c:choose>
										</c:if>
											<a onclick="setMoney(${item.objectId},${item.supplierId});" href="javascript:void(0);" style="cursor:auto;">设置</a>
									</c:when>
									<c:otherwise>
										<c:if test="${not empty item.commissionWay}">
											<c:choose>
											<c:when test="${item.commissionWay eq 1 }">
												<div class="text-ellipsis" style="width: 120px;" title="<c:forEach items='${item.brandCommissions}' var='item1' varStatus='num'>
												${item1.moneyStart}~${item1.moneyStop}元${item1.percent}%
												</c:forEach>">
												<c:forEach items="${item.brandCommissions}" var="item1" varStatus="num">
												${item1.moneyStart}~${item1.moneyStop}元${item1.percent}%&nbsp;&nbsp;
												</c:forEach></div></c:when>
											<c:otherwise><c:if test="${not empty item.moneyper }">每笔收取${item.moneyper}元</c:if></c:otherwise>
											</c:choose>
										</c:if>
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
        
		<jdf:form bean="area" scope="request">
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
					<div class="col-sm-2 title" onclick="switchArea();">
						<h4>
							<b>配送区域<button type="button" class="btn btn-default btn-xs btnL"><i id="iArea" class="fa fa-angle-down"></i></button></b>
						</h4>
					</div>
                    <div class="col-sm-9 hideView3">
                      <hr/>
                    </div>
					<div class="pull-right hideSave3">
						<button type="button" class="btn btn-primary" id="partbutton4" onClick="areaSave();">保存</button>
					</div>
				</div>
			</div>
			</div>
			<form method="post" action="${dynamicDomain}/supplierDispatchArea/save"
				id="SupplierDispatchArea" class="form-horizontal hideView3">
				<input type="hidden" name="objectId">
				<input type="hidden" name="supplierIDD" id="supplierIDD" value="${entity.objectId }">
				<div class="row">
					<div class="col-sm-12 col-md-8">
						<div class="form-group">
							<label for="areaId2" class="col-sm-3 control-label">地区<span class="not-null">*：</span></label>
							<div class="col-sm-8 hideView">
								<ibs:areaSelect code="${area.areaId}" district="areaId2" province="province2" city="city2"
									styleClass="form-control inline" />
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="distributionTime" class="col-sm-4 control-label">配送时效（天）</label>
							<div class="col-sm-8">
								<input type="text" class="search-form-control" name="distributionTime" id="distributionTime">
							</div>
						</div>
					</div>
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="distributionPrice" class="col-sm-4 control-label">配送价格（元）</label>
							<div class="col-sm-8">
								<input type="text" class="search-form-control" name="distributionPrice" id="distributionPrice">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row hideView">
						<div class="editPageButton">
							<button type="button" class="btn" onClick="addArea();">添加区域</button>
						</div>
					</div>
				</div>
				<jdf:bootstrapDomainValidate domain="SupplierDispatchArea" index="2"/>
			</form>
		</jdf:form>
		<!-- 区域列表 -->
		<div class="row hideView3">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover list">
					<thead>
						<tr id="area_00">
							<th>操作</th>
							<th>配送区域_省</th>
							<th>配送区域_市</th>
							<th>配送区域_区</th>
							<th>配送时效（天）</th>
							<th>配送价格（元）</th>
						</tr>
					</thead>
					<tbody id="areaBody">
						<c:forEach items="${supplierDispatchAreas}" var="item" varStatus="status">
							<tr id="area_${status.index }">
								<td>
								<c:choose>
									<c:when test="${entity.objectId eq null }">
									<a href="###" onclick="deleteArea(${item.objectId},${status.index})"> 删除</a>
									</c:when>
									<c:when test="${not empty param.list}"></c:when>
									<c:when test="${not empty view}"></c:when>
									<c:otherwise>
									<a href="###" onclick="deleteArea(${item.objectId},${status.index})"> 删除</a>
									</c:otherwise>
								</c:choose>
								</td>
								<td>${item.provName}</td>
								<td>${item.cityName}</td>
								<td>${item.areaName}</td>
								<td>${item.distributionTime}</td>
								<td><fmt:formatNumber type="number" value="${item.distributionPrice}" maxFractionDigits="2"/></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
    
		<jdf:form bean="attach" scope="request">
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
					<div class="col-sm-2 title" onclick="switchAttach();">
						<h4>
							<b>上传附件<button type="button" class="btn btn-default btn-xs btnL"><i id="iAttach" class="fa fa-angle-down"></i></button></b>
						</h4>
					</div>
                    <div class="col-sm-9 hideView4">
                      <hr/>
                    </div>
				</div>
			</div>
		</div>
		<form method="post" action="${dynamicDomain}/supplierAttach/save"
				id="SupplierAttach" class="form-horizontal hideView4" enctype="multipart/form-data">
				<input type="hidden" name="objectId">
				<input type="hidden" name="supplierIDDD" id="supplierIDDD" value="${entity.objectId }">
				<div class="row hideView">
					<div class="col-sm-12 col-md-12">
						<div class="form-group">
							<label for="" class="col-sm-2 control-label"></label>
							<div class="col-sm-3">
								<input type="file" class="search-form-control" name="attachName" id="attachName">
							</div>
							<div class="col-sm-1" style="padding-left:55px;">
								<input type="button" class="btn" value="上传文件" onclick="addAttach();">
							</div>
						</div>
					</div>
				</div>
			<jdf:bootstrapDomainValidate domain="SupplierAttach" index="3"/>
		</form>
		</jdf:form>
		<!--附件列表 -->
		<div class="row hideView4">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover list">
					<thead>
						<tr id="attach_00">
							<th>文件名</th>
							<th>查看</th>
							<th>删除</th>
						</tr>
					</thead>
					<tbody id="fileBody">
						<c:forEach items="${supplierAttachs}" var="item" varStatus="status">
							<tr id="attach_${status.index }">
								<td>${item.attachName}</td>
								<td><a href="${dynamicDomain}/${item.attachRoute}" target="_blank"><i class="glyphicon glyphicon-search"></i></a></td>
								<td>
								<c:choose>
									<c:when test="${entity.objectId eq null }">
									<a href="###" onclick="deleteAttach(${item.objectId},${status.index})"><i class="glyphicon glyphicon-trash"></i></a>
									</c:when>
									<c:when test="${not empty param.list}"></c:when>
									<c:when test="${not empty view}"></c:when>
									<c:otherwise>
									<a href="###" onclick="deleteAttach(${item.objectId},${status.index})"><i class="glyphicon glyphicon-trash"></i></a>
									</c:otherwise>
								</c:choose>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row hideView4">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
                    <label  class="col-sm-2 control-label"></label>
                    <div class="col-sm-10">
                    <p style="background-color:#FAFAD2;width:93%;padding:5px;font-size:13px;">
                    1.营业执照副本、组织机构代码证、国税地税登记证<br>
                    2.法人授权委托书、被授权人身份证复印件<br>
                    3.品牌授权委托书<br>
                    4.资产负债表、损益表或验资（出资）报告（汇总表）<br>
                    5.其他（有助于证明生产经营与管理能力的证书）</p>
                    </div>
				</div>
			</div>
		</div>
		<div class="box-footer">
			<div class="row hideView">
				<div class="editPageButton">
					<button type="button" class="btn btn-primary" id="mainbutton0" onClick="allSave(0);">保存</button>
					<button type="button" class="btn btn-primary" id="mainbutton1" onClick="allSave(1);">提交审核</button>
					<a href="${dynamicDomain}/supplier/page">
						<button type="button" class="btn">返回</button>
					</a>
				</div>
			</div>
			<div class="row">
				<div class="editPageButton">
					<c:if test="${not empty param.list}">
						<button type="button" class="btn btn-primary" onclick="return verifySuccess();">
							审核通过
						</button>
						<button type="button" class="btn btn-primary" id="reject">
							 审核不通过
						</button>
						<a href="${dynamicDomain}/supplier/verify">
							<button type="button" class="btn">返回</button>
						</a>
					</c:if>
				</div>
			</div>
		</div>

	</div>
	<script type="text/javascript">
	var view = '${view}';
	var list = '${param.list}';
	var cooperations = '${entity.cooperations}';
	initCooperations(cooperations);
	if (view!="" ||list!="") {
		viewPage("SupplierLiquidation");
		viewPage("Supplier");
		viewPage("SupplierBrand");
		viewPage("SupplierDispatchArea");
		viewPage("SupplierAttach");
		$(".hideView").hide();
	}
	$(document).ready(function() {
		$(".hideView0").show();
		$(".hideView1").show();
		$(".hideView2").show();
		$(".hideView3").show();
		$(".hideView4").show();
		if (view!="" ||list!="") {
			$(".hideSave0").hide();
			$(".hideSave1").hide();
			$(".hideSave2").hide();
			$(".hideSave3").hide();
		}else{
			$(".hideSave0").show();
			$(".hideSave1").show();
			$(".hideSave2").show();
			$(".hideSave3").show();
		}
		
		//供应商名称判断
		$("#supplierName").rules("add",{
	        remote : {
	            url : "${dynamicDomain}/supplier/isUnique?ajax=1&fieldName=supplierName&objectId=${entity.objectId}",
	            type : "post",
	            data: {
	                value: function () {
	                    return $('#supplierName').val();
	                }
	            },
	            dataType : "json"
	        },
	        messages : {
	            remote : "该供应商名称已存在"
	        }
	    });
		
		//供应商类型
		var typeIds="${typeIds}";
		if(typeIds!=""){
			var typeId = typeIds.split(",");
			for (var i=0;i<typeId.length ;i++ ){
				var checkboxs = $("input[type='checkbox'][name='type'][value='"+typeId[i]+"']");
				$.each(checkboxs,function (){
				   this.checked="checked";
				});
			}
		}
		
		//是否仅供内卖
		<c:if test="${entity.isInSelling==1}">
		var checkboxs = $("input[type='checkbox'][name='onlySelf'][value='1']");
			$.each(checkboxs,function (){
		   		this.checked="checked";
			});
		</c:if>
	
		//合作方式
		var cooperation = $('input[name="cooperations1"]:checked').val();
		if(cooperation=="1"){
			$(".hideDiv").show();
        	initCooperations(cooperations);
		}else if(cooperation=="2"){
			$(".hideDiv").hide();
		}
		//品牌
		$("#pinpai").select2();
  	});
	
	//企业内卖判断
	function checkCompany(){
		var isInselling=$('input[name="onlySelf"]:checked').val();
		var company=$('input[name="companyName"]').val();
		if(isInselling=="1"){
			 while(company.lastIndexOf(" ")>=0){
				 company = company.replace(" ","");
			 }
			 if(company==null || company.length == 0){
				alert("请先选择内卖企业");
				$("[name='onlySelf']").removeAttr("checked");
				return false;
			}
		}
	}
	
	//合作方式收缩
	$('input[name="cooperations1"]').bind("change",function(){
		 var term=$(this).val();
	        if(term){
	        	if(term=='1'){
	        		$(".hideDiv").show();
	        		
	        	}else if(term=='2'){
	        		$(".hideDiv").hide();
	        	}
	        }
	    }).change();
	
	//配送区域的长度
	var al=${fn:length(supplierDispatchAreas)};
	var sumAreas=${fn:length(supplierDispatchAreas)};
	
	//基本信息保存
	function baseSave(){
		var supplierId='';
		var type=$("input[name='type']:checked").length;
		if(type==0){
			alert("供应商类型不能为空");
			return false;
		}
		var val = $("input[name='supplierName']").val(),val = $.trim(val);
		if(!val.length){
			alert("供应商名称不能为空");
			return false;
		}
		
		var val = $("select[name='companyType']").val();
		if(!val){
			alert("公司类型不能为空");
			return false;
		}
		var val = $("input[name='businessTerm']").val();
		if(!val){
			alert("营业期限不能为空");
			return false;
		}
		var val = $("input[name='commissioned']").val(),val = $.trim(val);
		if(!val.length){
			alert("被授权人不能为空");
			return false;
		}
		var val = $("input[name='email']").val(),val = $.trim(val);
		if(!val.length){
			alert("联系人邮箱不能为空");
			return false;
		}
		var val = $("input[name='telephone']").val(),val = $.trim(val);
		if(!val.length){
			alert("联系电话不能为空");
			return false;
		}
		var val = $("input[name='addressDetail']").val(),val = $.trim(val);
		if(!val.length){
			alert("公司详细地址不能为空");
			return false;
		}
		
		
		if($("#Supplier").valid()){
			$('#types').val(getCheckedValuesString(document.getElementsByName('type')));
			$('#isSelf').val(getCheckedValuesString(document.getElementsByName('onlySelf')));
            var param = $("#Supplier").serialize();
			$("#partbutton2").attr("disabled", true);
			$("#partbutton3").attr("disabled", true); 
			$("#partbutton4").attr("disabled", true);
			$("#mainbutton0").attr("disabled", true);
			$("#mainbutton1").attr("disabled", true);
            $.ajax({
                 url : "${dynamicDomain}/supplier/save",
                 type : "post",
                 async: false,
                 dataType : "json",
                 data: param,
                 success : function(json) {
                	 if(json.supId){
                		 supplierId=json.supId;
                		 $("#overallId").val(supplierId);
                		 $("#supplierIDL").val(supplierId);
                		 $("#supplierID").val(supplierId);
                		 $("#supplierIDD").val(supplierId);
                		 $("#supplierIDDD").val(supplierId);
                	 }
                	 if(json.firArea){
 	            		var str = '<tr id="area_0">'
             			+ '<td><a href="###" onclick="deleteArea('+json.firArea.objectId+','+0+')"> 删除</a></td>'
             			+ '<td>'+json.firArea.provName+'</td>'
             			+ '<td>'+json.firArea.cityName+'</td>'
             			+ '<td>'+json.firArea.areaName+'</td>'
             			+ '<td>'+json.firArea.distributionTime+'</td>'
             			+ '<td>'+json.firArea.distributionPrice+'</td>'
             			+ '</tr>';
 	            		$("#area_00").after(str);
 	            		al=Number(al)+1;
 	            		sumAreas=Number(sumAreas)+1;
 	            	}
 	                if(json.result){
 	                	alert("基本信息保存成功");
 	                }
        			$("#partbutton2").removeAttr("disabled");
        			$("#partbutton3").removeAttr("disabled");
        			$("#partbutton4").removeAttr("disabled");
        			$("#mainbutton0").removeAttr("disabled");
        			$("#mainbutton1").removeAttr("disabled");
                 }
             });
		}
		return $("#overallId").val();
	}
	
	
	//清算信息保存
	function liquidationSave(){
		var liquidWay = $('input[name="cooperations1"]:checked').val();
		var overallId=$("#overallId").val();
		if(""==overallId){
			alert("请先保存基本信息");
		}else{
			$('#types').val(getCheckedValuesString(document.getElementsByName('type')));
			$('#isSelf').val(getCheckedValuesString(document.getElementsByName('onlySelf')));
			if(liquidWay=="1"){
				if($("#SupplierLiquidation").valid()){
					$("#partbutton1").attr("disabled", true);
					$("#partbutton3").attr("disabled", true); 
					$("#partbutton4").attr("disabled", true);
					$("#mainbutton0").attr("disabled", true);
					$("#mainbutton1").attr("disabled", true);
					$.ajax({
			            url:"${dynamicDomain}/supplierLiquidation/save" ,
			            data:$('#SupplierLiquidation').serialize(),
			            type : 'post',
			            async: false,
			            dataType : 'json',
			            success : function(json) {
			                if(json.result){
			                	$("#liquidFlag").val('true');
			                	alert("清算信息保存成功");
			                }
		        			$("#partbutton1").removeAttr("disabled");
		        			$("#partbutton3").removeAttr("disabled");
		        			$("#partbutton4").removeAttr("disabled");
		        			$("#mainbutton0").removeAttr("disabled");
		        			$("#mainbutton1").removeAttr("disabled");
			            }
			        });
				}
			}else if(liquidWay=="2"){
				$("#partbutton1").attr("disabled", true);
				$("#partbutton3").attr("disabled", true); 
				$("#partbutton4").attr("disabled", true);
				$("#mainbutton0").attr("disabled", true);
				$("#mainbutton1").attr("disabled", true);
				$.ajax({
		            url:"${dynamicDomain}/supplierLiquidation/save" ,
		            data:$('#SupplierLiquidation').serialize(),
		            type : 'post',
		            async: false,
		            dataType : 'json',
		            success : function(json) {
		                if(json.result){
		                	$("#liquidFlag").val('true');
		                	alert("清算信息保存成功");
		                }
	        			$("#partbutton1").removeAttr("disabled");
	        			$("#partbutton3").removeAttr("disabled");
	        			$("#partbutton4").removeAttr("disabled");
	        			$("#mainbutton0").removeAttr("disabled");
	        			$("#mainbutton1").removeAttr("disabled");
		            }
		        });
			}
		} 
		return $("#liquidFlag").val();
	}
	
	var bl=${fn:length(supplierBrands)};
	var sumBrands=${fn:length(supplierBrands)};
	//添加品牌
	function addBrand(){ 
		var id2=$("#overallId").val();
		if(id2==''){
			alert("请先保存基本信息");
			return false;
		} 
		var pinpai=$("#pinpai option:selected").val();
		var level=$("#brandLevel option:selected").val(); 
		var start=$("#termStart").val();
		var end=$("#termEnd").val();
		var third=$("#category3 option:selected").val();
		if(third==''){
			alert('产品分类必须选择到三级分类');
			return false;
		}
		if(pinpai=='' || level=='' || start=='' || end==''){
			$('#SupplierBrand').submit();
		}else{
			$.ajax({
	            url:"${dynamicDomain}/supplierBrand/save" ,
	            data:$('#SupplierBrand').serialize(),
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.brandError){
	            		alert("该代理品牌信息存在");
	            	}else if(json.sBrand!=null){
	            		var str = '<tr id="brand_'+bl+'">'
            			+ '<td><a href="###" onclick="deleteBrand('+json.sBrand.objectId+','+bl+')"> 删除</a></td>'
            			+ '<td>'+json.brandName+'</td>'
            			+ '<td>'+json.levelName+'</td>'
            			+ '<td>'+json.time+'</td>'
            			+ '<td>'+json.sBrand.categoryOne+'-'+json.sBrand.categoryTwo+'-'+json.sBrand.categoryThree+'</td>'
            			+ '<td><a onclick="setMoney('+json.sBrand.objectId+','+json.sBrand.supplierId+');" style="cursor:auto;">设置</a></td>'
            			+ '</tr>';
	            		if(sumBrands=="0"){
	            			 $("#brand_00").after(str);
	            		}else{
	            			var bll=Number(bl)-1;
	            			$("#brand_"+ bll).after(str);
	            		}
	            		 bl=Number(bl)+1;
	            		 sumBrands=Number(sumBrands)+1;
		                $('#SupplierBrand')[0].reset(); 
	            	}
	            }
	        });
		} 
	}
	
	//删除品牌
	function deleteBrand(oID,trID){
		if(confirm("您确定要删除？")){
			$.ajax({
	            url:"${dynamicDomain}/supplierBrand/deleteBrand/"+oID ,
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.result){
	            		sumBrands=Number(sumBrands)-1;
	            		$('#brand_'+trID).remove();
	            	}
	            }
	        });
		}
	}
	
	//代理品牌保存
	function brandSave(){
		var overallId=$("#overallId").val();
		if(""==overallId){
			alert("请先保存基本信息");
		}else{
			$("#partbutton1").attr("disabled", true);
			$("#partbutton2").attr("disabled", true); 
			$("#partbutton4").attr("disabled", true);
			$("#mainbutton0").attr("disabled", true);
			$("#mainbutton1").attr("disabled", true);
			$.ajax({
	            url:"${dynamicDomain}/supplierBrand/saveBrands?supplierID="+overallId ,
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.noBrands){
	            		alert("请先添加品牌");
	            	}else if(json.result){
	            		alert("供应商的代理品牌保存成功");
	            	}
        			$("#partbutton1").removeAttr("disabled");
        			$("#partbutton2").removeAttr("disabled");
        			$("#partbutton4").removeAttr("disabled");
        			$("#mainbutton0").removeAttr("disabled");
        			$("#mainbutton1").removeAttr("disabled");
	            }
	        });
		}
	}
	
	//设置佣金
	function setMoney(sbId,sId){
		$.ajax({
            url:"${dynamicDomain}/supplierBrand/checkBrands?supplierID="+sId ,
            type : 'post',
            dataType : 'json',
            success : function(json) {
            	if(json.result){
            		alert("您有代理品牌未保存，请先保存代理品牌");
            	}else{
            		var setUrl='${dynamicDomain}/brandCommission/edit/'+sbId+'?supplierID='+sId+'&ajax=1';
            		$.colorbox({href:setUrl,opacity:0.2,fixed:true,width:"65%", height:"90%", iframe:true,
            			onClosed:function(){ if(reloadParent){}},overlayClose:false});
            	}
            }
        });
	}
	
	//添加区域
	function addArea(){
		var id2=$("#overallId").val();
		if(id2==''){
			alert("请先保存基本信息");
			return false;
		} 
		var day=$("#distributionTime").val();
		var price=$("#distributionPrice").val();
		var area = $("#areaId2").val();
		$("#errorA").css("display", "none");
		var errorA = "<label id=\"errorA\" class=\"validate_input_errorA\"><font color='red'>地区不能为空</font></label>";
		
		if(day=='' || price=='' || area==''){
			if (area == "") {
				$("#_areaId2").after(errorA);
				$("#province2").focus();
				return false;
			}else{
				$('#SupplierDispatchArea').submit();
			}
		}else{
			$.ajax({
	            url:"${dynamicDomain}/supplierDispatchArea/save" ,
	            data:$('#SupplierDispatchArea').serialize(),
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.areaError){
	            		alert("该配送区域信息存在");
	            	}else{
	            		var str = '<tr id="area_'+al+'">'
            			+ '<td><a href="###" onclick="deleteArea('+json.sArea.objectId+','+al+')"> 删除</a></td>'
            			+ '<td>'+json.sArea.provName+'</td>'
            			+ '<td>'+json.sArea.cityName+'</td>'
            			+ '<td>'+json.sArea.areaName+'</td>'
            			+ '<td>'+json.sArea.distributionTime+'</td>'
            			+ '<td>'+json.sArea.distributionPrice+'</td>'
            			+ '</tr>';
            			if(sumAreas=="0"){
            				$("#area_00").after(str);
            			}else{
            				var all=Number(al)-1;
    		                $("#area_"+ all).after(str);
            			}
            			al=Number(al)+1;
            			sumAreas=Number(sumAreas)+1;
		                $("#areaId2").val('');
		                $("#city2").empty(); 
		                $("#_areaId2").empty(); 
		                $('#SupplierDispatchArea')[0].reset(); 
	            	}
	            }
	        });
		}
	}
	
	//删除区域
	function deleteArea(oID,trID){
		if(confirm("您确定要删除？")){
			$.ajax({
	            url:"${dynamicDomain}/supplierDispatchArea/deleteArea/"+oID ,
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.result){
	            		sumAreas=Number(sumAreas)-1;
	            		$('#area_'+trID).remove();
	            	}
	            }
	        });
		}
	}
	
	//配送区域保存
	function areaSave(){
		var overallId=$("#overallId").val();
		if(""==overallId){
			alert("请先保存基本信息");
		}else{
			$("#partbutton1").attr("disabled", true);
			$("#partbutton2").attr("disabled", true); 
			$("#partbutton3").attr("disabled", true);
			$("#mainbutton0").attr("disabled", true);
			$("#mainbutton1").attr("disabled", true);
			$.ajax({
	            url:"${dynamicDomain}/supplierDispatchArea/saveAreas?supplierIDD="+overallId ,
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	if(json.noAreas){
	            		alert("请先添加区域");
	            	}else if(json.result){
	            		alert("供应商的配送区域保存成功");
	            	}
        			$("#partbutton1").removeAttr("disabled");
        			$("#partbutton2").removeAttr("disabled");
        			$("#partbutton3").removeAttr("disabled");
        			$("#mainbutton0").removeAttr("disabled");
        			$("#mainbutton1").removeAttr("disabled");
	            }
	        });
		}
	}
	
	var cl=${fn:length(supplierAttachs)};
	var sumAttachs=${fn:length(supplierAttachs)};
	//添加附件
	function addAttach() {
		var id2=$("#overallId").val();
		if(id2==''){
			alert("请先保存基本信息");
			return false;
		} 
		var name = $("#attachName").val();
		$("#errorB").css("display", "none");
		var errorB = "<label id=\"errorB\" class=\"validate_input_errorB\"><font color='red'>附件格式应为：jpg、jpeg、png</font></label>";
		if(name==''){
			$("#attachName").focus();
		}else{
			if(Number(sumAttachs)>4){
				alert("最多上传5个附件");
				$("#attachName").val('');
				return false;
			}
			fileSuffix=/.[^.]+$/.exec(name);
			if(fileSuffix == ".jpg" || fileSuffix == ".jpeg" || fileSuffix == ".png"){
				$.ajaxFileUpload({  
				            url: '${dynamicDomain}/supplierAttach/uploadAttach?ajax=1&supplierIDDD='+id2,  
				            secureuri: false,  
				            fileElementId: 'attachName',  
				            dataType: 'json',  
				            success: function(json, status) {
				            	if(json.id){
				       				var str = '<tr id="attach_'+cl+'">'
			            			+ '<td>'+json.name+'</td>'
			            			+ '<td><a href="${dynamicDomain}/'+json.path+'" target="_blank"><i class="glyphicon glyphicon-search"></i></a></td>'
			            			+ '<td><a href="###" onclick="deleteAttach('+json.id+','+cl+')"><i class="glyphicon glyphicon-trash"></i></a></td>'
			            			+ '</tr>';
			            			if(sumAttachs=="0"){
			            				$("#attach_00").after(str);
			            			}else{
			            				var cll=Number(cl)-1;
						                $("#attach_"+ cll).after(str);
			            			}
			            			sumAttachs=Number(sumAttachs)+1;
			            			cl=Number(cl)+1;
					                $('#attachName').val(''); 
				            	}
				            },error: function (data, status, e)//服务器响应失败处理函数
				            {
				                alert(e);
				            }
				        }  
				    );
			}else{
				$("#attachName").after(errorB);
				$("#attachName").focus();
				return false;
			}
		}
        return false;  
    } 
	
	//删除附件
	function deleteAttach(oID,trID){
		if(confirm("您确定要删除？")){
			$.ajax({
	            url:"${dynamicDomain}/supplierAttach/deleteAttach/"+oID ,
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	            	sumAttachs=Number(sumAttachs)-1;
            		$('#attach_'+trID).remove();
	            }
	        });
		}
	}
	
	//总保存//提交审核
	function allSave(flag){
		var id=baseSave();
		var overallId=$("#overallId").val();
		if(id!=''){
			var suppL=liquidationSave();
			var lFlag=$("#liquidFlag").val();
			if(lFlag=="true"){
				if(flag=='1'){
					if(sumBrands=='0'){
						alert("请先添加品牌");
						return false;
					}
					if(sumAreas=='0'){
						alert("请先添加区域");
						return false;
					}
				}
				if(flag=='1'){
					$("#mainbutton0").attr("disabled", true);
					$("#mainbutton1").attr("disabled", true);
				}
				if(flag=='0'){
					$("#mainbutton0").attr("disabled", true);
					$("#mainbutton1").attr("disabled", true);
				}
				url="${dynamicDomain}/supplier/allSave/?id="+overallId+"&verify="+flag;
				window.location.href=url;
			}	
		}
	}
	
	//证件
	var cd='<input type="text" class="search-form-control isIdCardNo" id="cardNo" name="cardNo">';
	$("#cardType").bind("change",function(){
	 	var term=$(this).val();
        if(term){
        	if(term=='1'){//身份证
        		$('#cardNo').addClass("search-form-control isIdCardNo");
        	}else{
        		$('#cardNo').removeClass("isIdCardNo");
        	}
        }
    }).change();
	
	//拨款周期
	 var day = '<select name="realDay1" id="realDay1" class="search-form-control">';
	 for ( var i = 1; i < 29; i++) {
         day = day+'<option value="'+i+'">'+i+'</option>';
     } 
	 day = day+'</select>';
	 var week =  '<select name="realWeek1" id="realWeek1" class="search-form-control"><option value="1">星期一</option><option value="2">星期二</option><option value="3">星期三</option><option value="4">星期四</option><option value="5">星期五</option></select>';
	 $("#moneyTerm1").bind("change",function(){
		 var term=$(this).val();
	        if(term){
	        	if(term=='1'){
	        		$('#real').html(day);
	        	}else if(term=='2'){
	        		$('#real').html(week);
	        	}
	        	
	        }
	    }).change();
	init();
	$("#Supplier").validate();
	function init(){
		var moneyTerm = "${liquid.moneyTerm1}";
		var realDay = "${liquid.realDay1}";
		var realWeek = "${liquid.realWeek1}";
		if (moneyTerm!=null && moneyTerm!="") {
			if(moneyTerm=='1'){
        		$('#real').html(day);
        	}else if(moneyTerm=='2'){
        		$('#real').html(week);
        	}
			$("#moneyTerm1").attr("value",moneyTerm);
		}
		if (realDay!=null && realDay!="") {
			$("#realDay1").attr("value",realDay);
		}
		if (realWeek!=null && realWeek!="") {
			$("#realWeek1").attr("value",realWeek);
		}
		
		//初始化时变为只读
		if (view!="" ||list!="") {
			viewPage("SupplierLiquidation");
			viewPage("Supplier");
			viewPage("SupplierBrand");
			viewPage("SupplierDispatchArea");
			viewPage("SupplierAttach");
		}
		
	}
	//产品类别
	$("#category1").val('${category.firstId}').change();
    $("#category1").bind("change",function(){
        if($(this).val()){
            $.ajax({
                url:"${dynamicDomain}/productCategory/secondCategory/" + $(this).val(),
                type : 'post',
                dataType : 'json',
                success : function(json) {
                    $("#category2").children().remove();
                    $("#category2").append("<option value=''>—二级分类—</option>");
                    for ( var i = 0; i < json.secondCategory.length; i++) {
                        $("#category2").append("<option value='" + json.secondCategory[i].secondId + "'>" + json.secondCategory[i].name + "</option>");
                    }
                    $("#category2").val('${category.secondId}').change();
                }
            });
        }
     }).change();

     $("#category2").bind("change",function(){
        if($(this).val()){
            $.ajax({
                url:"${dynamicDomain}/productCategory/thirdCategory/" + $(this).val(),
                type : 'post',
                dataType : 'json',
                success : function(json) {
                    $("#category3").children().remove();
                    $("#category3").append("<option value=''>—三级分类—</option>");
                    for ( var i = 0; i < json.thirdCategory.length; i++) {
                        $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
                    }
                    $("#category3").val('${category.objectId}');
                }
            });
        }
    }).change();
     
   	//审核通过
   	function verifySuccess(){
   		if(confirm("您确定审核通过吗？")){
   			$.ajax({  
   			    url:"${dynamicDomain}/supplier/verifySuccess/",
   				type : 'post',
   				data : "id=${entity.objectId}&data="+ (new Date().getDate()),
   				dataType : 'json',
   				success : function(msg) {
   					if(msg.result==true){
   						var url="${dynamicDomain}/supplier/verify?message=操作成功";
   						window.location.href=url;
   					}else{
   						winAlert(msg.message);
   					}
   				}
   			});
   		}	 
	 }
   	
   	//审核不通过
   	$("#reject").click(function(){ 
		var url="${dynamicDomain}/companyReject/create?ajax=1&id=${entity.objectId}&supplierReject=1";
		$.colorbox({href:url,opacity:0.2,fixed:true,width:"35%", height:"45%", iframe:true,
		onClosed:function(){ if(reloadParent){parent.location.reload(true);}},overlayClose:false});
	});
   	
   	function initCooperations(cooperations){
   		if (cooperations!=null && cooperations!="") {
   			if(cooperations=="1"){
   	            $("input[name='cooperations1'][value='1']").attr("checked",true);
   				$(".hideDiv").show();
			}else{
				$("input[name='cooperations1'][value='2']").attr("checked",true);
				$(".hideDiv").hide();
			}
		}
   	}
   	function switchBase(){
   		if($(".hideView0").is(":hidden")){
   			$("#iBase").removeClass("fa fa-angle-left");
   			$("#iBase").addClass("fa fa-angle-down");
   			$(".hideView0").show();
   			if(view=="" && list==""){
   				$(".hideSave0").show();
   			}
   		}else{
   			$("#iBase").removeClass("fa fa-angle-down");
   			$("#iBase").addClass("fa fa-angle-left");
   			$(".hideView0").hide();
   			$(".hideSave0").hide();
   		}
   	}
   	function switchLiquid(){
   		if($(".hideView1").is(":hidden")){
   			$("#iLiquid").removeClass("fa fa-angle-left");
   			$("#iLiquid").addClass("fa fa-angle-down");
   			$(".hideView1").show();
   			if(view=="" && list==""){
   				$(".hideSave1").show();
   			}
   		}else{
   			$("#iLiquid").removeClass("fa fa-angle-down");
   			$("#iLiquid").addClass("fa fa-angle-left");
   			$(".hideView1").hide();
   			$(".hideSave1").hide();
   		}
   	}
   	function switchBrand(){
   		if($(".hideView2").is(":hidden")){
   			$("#iBrand").removeClass("fa fa-angle-left");
   			$("#iBrand").addClass("fa fa-angle-down");
   			$(".hideView2").show();
   			if(view=="" && list==""){
   				$(".hideSave2").show();
   			}
   		}else{
   			$("#iBrand").removeClass("fa fa-angle-down");
   			$("#iBrand").addClass("fa fa-angle-left");
   			$(".hideView2").hide();
   			$(".hideSave2").hide();
   		}
   	}
   	function switchArea(){
   		if($(".hideView3").is(":hidden")){
   			$("#iArea").removeClass("fa fa-angle-left");
   			$("#iArea").addClass("fa fa-angle-down");
   			$(".hideView3").show();
   			if(view=="" && list==""){
   				$(".hideSave3").show();
   			}
   		}else{
   			$("#iArea").removeClass("fa fa-angle-down");
   			$("#iArea").addClass("fa fa-angle-left");
   			$(".hideView3").hide();
   			$(".hideSave3").hide();
   		}
   	}
   	function switchAttach(){
   		if($(".hideView4").is(":hidden")){
   			$("#iAttach").removeClass("fa fa-angle-left");
   			$("#iAttach").addClass("fa fa-angle-down");
   			$(".hideView4").show();
   		}else{
   			$("#iAttach").removeClass("fa fa-angle-down");
   			$("#iAttach").addClass("fa fa-angle-left");
   			$(".hideView4").hide();
   		}
   	}
	</script>
</body>
</html>