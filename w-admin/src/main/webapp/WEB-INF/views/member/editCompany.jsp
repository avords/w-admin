<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业管理</title>
<style>
.upView {
	margin: 7px 0 0 0;
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
                              企业入驻申请
          <c:choose>
            <c:when test="${entity.objectId eq null }">新增</c:when>
            <c:when test="${not empty entity.objectId && view eq null && param.list eq null}">修改</c:when>
            <c:when test="${not empty param.list}">审核</c:when>
            <c:otherwise>详情</c:otherwise>
          </c:choose>
        </h4>
      </div>
      <form method="post" action="${dynamicDomain}/company/saveToPage" class="form-horizontal" id="Company" onsubmit="return checkLogo();" enctype="multipart/form-data">
        <input type="hidden" name="objectId"> 
        <input type="hidden" name="verify" id="verify"> 
        <%--
         <input type="hidden" name="welfarePointName" id="welfarePointName">
         --%>
        <div class="box-body">
          <c:if test="${not empty objectId }">
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="verifyStatus" class="col-sm-4 control-label">审核状态</label>
                  <div class="col-sm-6 upView">
                    <jdf:columnValue dictionaryId='1304' value='${entity.verifyStatus}' />
                    <fmt:formatDate value="${entity.updatedOn}" pattern="yyyy-MM-dd" />
                  </div>
                </div>
              </div>
              <c:if test="${entity.verifyStatus==2 }">
                <div class="col-sm-6 col-md-6">
                  <div class="form-group">
                    <label for="applicantId" class="col-sm-4 control-label">审核未通过原因</label>
                    <div class="col-sm-6 upView">${reject}</div>
                  </div>
                </div>
              </c:if>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="applicantId" class="col-sm-4 control-label">申请人</label>
                  <div class="col-sm-6 upView">${applierName}</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="applyTime" class="col-sm-4 control-label">申请时间</label>
                  <div class="col-sm-6 upView">
                    <fmt:formatDate value='${entity.updatedOn}' pattern='yyyy-MM-dd HH:mm:ss' />
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="managerId" class="col-sm-4 control-label">客户经理</label>
                  <div class="col-sm-6 upView">${managerName }</div>
                </div>
              </div>
            </div>
          </c:if>
          <c:if test="${empty view && empty param.list}">
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyName" class="col-sm-4 control-label">企业名称 </label>
                  <c:if test="${entity.verifyStatus!=3 }">
                    <div class="col-sm-6">
                      <input type="text" class="search-form-control" name="companyName" id="companyName">
                    </div>
                  </c:if>
                  <c:if test="${entity.verifyStatus==3 }">
                    <div class="col-sm-6 upView">${entity.companyName }</div>
                  </c:if>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="shortName" class="col-sm-4 control-label">二级域名简称</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="shortName">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="logoId" class="col-sm-4 control-label">企业logo </label>
                  <div class="col-sm-6">
                    <input type="hidden" name="logoId" id="logoId">
                    <img alt="logo" class="logoImg" height="80px" width="80px">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
              	<div class="form-group">
                  <label for="welfarePointName" class="col-sm-4 control-label">福利积分别名</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" id="welfarePointName" maxlength="2" name="welfarePointName">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="" class="col-sm-2 control-label"></label>
                  <div class="col-sm-3">
                    <input type="file" class="search-form-control img_type" style="display: inline;" name="uploadFile1" id="uploadFile1">
                  </div>
                  <div class="col-sm-1 upView">
                    <input type="button" value="上传" style="display: inline;" onclick="ajaxFileUpload1();" id="uploadButton1">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="type" class="col-sm-4 control-label">企业规模</label>
                  <div class="col-sm-6">
                    <select name="type" id="type" class="search-form-control">
                      <option value="">—请选择—</option>
                      <jdf:select dictionaryId="1301" />
                    </select>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="registrationNo" class="col-sm-4 control-label">工商注册号</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="registrationNo">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="webSite" class="col-sm-4 control-label">企业网址</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="webSite">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyStatus" class="col-sm-4 control-label">企业状态</label>
                  <div class="col-sm-6">
                    <select name="companyStatus" id="companyStatus" class="search-form-control">
                      <jdf:select dictionaryId="1302" />
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyDay" class="col-sm-4 control-label">开业日期</label>
                  <div class="col-sm-6">
                    <input id="companyDay" name="companyDay" type="text" onClick="WdatePicker()" class="search-form-control" />
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyMoney" class="col-sm-4 control-label">注册资本</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="companyMoney" id="companyMoney">
                  </div>
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="linker" class="col-sm-4 control-label">联系人 </label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="linker">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="email" class="col-sm-4 control-label">联系邮箱 </label>
                  <div class="col-sm-6">
                    <input type="text" class="email search-form-control" name="email">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="phone" class="col-sm-4 control-label">办公电话</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="phone" id="phone" onblur="checkTel(1);">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="telephone" class="col-sm-4 control-label">手机 </label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control mobile" name="telephone" id="telephone">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-8">
                <div class="form-group">
                  <label for="areaId" class="col-sm-3 control-label">企业所在地</label>
                  <div class="col-sm-8">
                    <ibs:areaSelect code="${entity.areaId}" district="areaId" styleClass="form-control inline" />
                  </div>
                </div>
              </div>
              <div class="col-sm-4 col-md-4">
                <div class="form-group">
                  <label for="companyType" style="margin-left: -90px;" class="col-sm-3 control-label">行业</label>
                  <div class="col-sm-9">
                    <select name="companyType" id="companyType" class="search-form-control">
                      <option value="">—请选择—</option>
                      <jdf:select dictionaryId="1303" />
                    </select>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="addressDetail" class="col-sm-2 control-label">企业详细地址 </label>
                  <div class="col-sm-9">
                    <input type="text" class="search-form-control" name="addressDetail">
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="attachment" class="col-sm-2 control-label">附件 </label>
                  <div class="col-sm-3" >
                    <input type="file" class="search-form-control"  name="uploadFile2" id="uploadFile2">
                  </div>
                  <div class="col-sm-1 upView" >
                      <input type="button" value="上传"  onclick="ajaxFileUpload2();" id="uploadButton2">
                  </div>
                  <div class="col-sm-6 upView" >
                    <font size="3px">（营业执照、税务登记证及组织机构代码认证等）</font>
                  </div>
                </div>
              </div>
            </div>
             <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <input type="hidden" name="attachment"  id="attachment">
                  <label for="" class="col-sm-2 control-label"> </label>
                  <div class="col-sm-10">
                      <span  id="subImg">
                          <c:forEach items="${attachs }" var="item" varStatus="status">
                            <div style="width: 250px;display: inline-block;">
                                <a style="cursor: pointer;display: block;margin-left: 210px;" class="subDelete" data-path="${item }">删除</a>                        
                                <img alt="" src="${dynamicDomain}${item}" width="250px" height="200px;">
                              </div>
                          </c:forEach>
                      </span>
                    </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="remark" class="col-sm-2 control-label">备注</label>
                  <div class="col-sm-9">
                    <textarea type="text" rows="3" cols="36" class="search-form-control" name="remark"></textarea>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="followSum" class="col-sm-2 control-label">开设功能</label>
                  <div class="col-sm-8">
                     <jdf:checkBox dictionaryId="1310" name="functions" />
<!--                     <input type="checkbox" name="functions" value="1">显示IBSlogo -->
<!--                     <input type="checkbox" name="functions" value="10000004">激励 -->
<!--                     <input type="checkbox" name="functions" value="9999999">福利 -->
<!--                     <input type="checkbox" name="functions" value="4">员工成长体系 -->
<!--                     <input type="checkbox" name="functions" value="10000010">统计报表 -->
<!--                     <input type="checkbox" name="functions" value="6">仅供企业内卖 -->
                    </br> <font color="red">注:若选择“仅供企业内卖”，则该企业和员工商城仅展现企业内卖供应商发布的商品。</font>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="editPageButton">
                <button type="submit" class="btn btn-primary" id="saveButton" onclick="saveCompany();">
                  <jdf:message code="common.button.save" />
                </button>
                <button type="submit" class="btn btn-primary" id="verifyButton" onclick="verifyCompany();">提交审核</button>
                <a href="${dynamicDomain}/company/page" class="btn">返回</a>
              </div>
            </div>
          </c:if>
          <c:if test="${not empty view || not empty param.list}">
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyName" class="col-sm-4 control-label">企业名称 </label>
                  <div class="col-sm-6 upView">${entity.companyName }</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="shortName" class="col-sm-4 control-label">二级域名简称</label>
                  <div class="col-sm-6 upView">${entity.shortName}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="logoId" class="col-sm-4 control-label">企业logo </label>
                  <div class="col-sm-6 upView">
                    <img alt="logo" src="${dynamicDomain}/${entity.logoId}" height="100px" width="100px">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="welfarePointName" class="col-sm-4 control-label">福利积分别名</label>
                  <div class="col-sm-6 upView">
                    <div class="col-sm-6 upView">${entity.welfarePointName}</div>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="type" class="col-sm-4 control-label">企业规模</label>
                  <div class="col-sm-6 upView">
                    <jdf:columnValue dictionaryId='1301' value='${entity.type}' />
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="registrationNo" class="col-sm-4 control-label">工商注册号</label>
                  <div class="col-sm-6 upView">${entity.registrationNo}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="webSite" class="col-sm-4 control-label">企业网址</label>
                  <div class="col-sm-6 upView">${entity.webSite}</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyStatus" class="col-sm-4 control-label">企业状态</label>
                  <div class="col-sm-6 upView">
                    <jdf:columnValue dictionaryId='1302' value='${entity.companyStatus}' />
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyDay" class="col-sm-4 control-label">开业日期</label>
                  <div class="col-sm-6 upView">
                    <fmt:formatDate value='${entity.companyDay}' pattern='yyyy-MM-dd' />
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyMoney" class="col-sm-4 control-label">注册资本</label>
                  <div class="col-sm-6 upView">${entity.companyMoney}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="linker" class="col-sm-4 control-label">联系人 </label>
                  <div class="col-sm-6 upView">${entity.linker}</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="email" class="col-sm-4 control-label">联系邮箱 </label>
                  <div class="col-sm-6 upView">${entity.email}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="phone" class="col-sm-4 control-label">办公电话</label>
                  <div class="col-sm-6 upView">${entity.phone}</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="telephone" class="col-sm-4 control-label">手机</label>
                  <div class="col-sm-6 upView">${entity.telephone}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="areaId" class="col-sm-4 control-label">企业所在地</label>
                  <div class="col-sm-8 upView">${areaName}</div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="companyType" class="col-sm-4 control-label">行业</label>
                  <div class="col-sm-6 upView">
                    <jdf:columnValue dictionaryId='1303' value='${entity.companyType}' />
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="addressDetail" class="col-sm-2 control-label">企业详细地址 </label>
                  <div class="col-sm-9 upView">${entity.addressDetail}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <input type="hidden" name="attachment"  id="attachment">
                  <label for="attachment" class="col-sm-2 control-label">附2件 </label>
                  <div class="col-sm-10">
                      <span  id="subImg">
                          <c:forEach items="${attachs }" var="item" varStatus="status">
                            <div style="width: 250px;display: inline-block;">  
                                <img alt="" src="${dynamicDomain}/${item}" width="250px" height="200px;">
                              </div>
                          </c:forEach>
                      </span>
                    </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="remark" class="col-sm-2 control-label">备注</label>
                  <div class="col-sm-9 upView">${entity.remark}</div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="followSum" class="col-sm-2 control-label">开设功能</label>
                  <div class="col-sm-9 upView">
                    <c:forEach items="${companyFunctions}" var="companyFunction" varStatus="num">
                      <jdf:columnValue dictionaryId='1310' value='${companyFunction.functionId}' />&nbsp;&nbsp;&nbsp;&nbsp;
                    </c:forEach>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="editPageButton">
                <c:if test="${not empty param.list}">
                  <button type="button" class="btn btn-primary" onclick="if(confirm('您确认审核通过吗？')){verifySuccess();}">审核通过</button>
                  <button type="button" class="btn btn-primary" id="reject">审核不通过</button>
                  <a href="${dynamicDomain}/company/verify" class="btn">返回</a>
                </c:if>
              </div>
            </div>
          </c:if>
        </div>
        <!-- box-body -->
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Company" />
  <script type="text/javascript">
  function checkLogo(){
  var filePath = $('#logoId').val();
	$("#errorL").css("display", "none");
	var errorL = "<label id=\"errorL\" class=\"validate_input_errorL\"><font color='red'>请上传企业logo</font></label>";
	if (filePath == "") {
		<c:if test="${entity.objectId eq null}">
		$("#uploadFile1").after(errorL);
		$("#uploadFile1").focus();
		return false;
		</c:if>
	}
	$("#errorM").css("display", "none");
		var money = $("#companyMoney").val();
		var errorM = "<label id=\"errorM\" class=\"validate_input_errorM\"><font color='red'>注册资本不能为负</font></label>";
		if (Number(money) < 0) {
			$("#companyMoney").after(errorM);
			$("#companyMoney").focus();
			return false;
		}

		$("#errorA").css("display", "none");
		var area = $("#city").val();
		var errorA = "<label id=\"errorA\" class=\"validate_input_errorA\"><font color='red'>企业所在地省市不能为空</font></label>";
		if (area == "") {
			$("#_areaId").after(errorA);
			$("#province").focus();
			return false;
		}

	}

	function verifySuccess() {
		$.ajax({
            url:"${dynamicDomain}/company/checkCompanyStatus/${entity.objectId}",
            type : 'post',
            dataType : 'json',
            success : function(json) {
            	if(json.result){
            		var url='${dynamicDomain}/company/verifySuccess?id=${entity.objectId}';
            		window.location.href=url;
            	}else{
            		winAlert("企业数据已发生变更");
            	}
            	
            }
        });
	}

	$(document).ready(function() {
		refreshParentPage(true);
		deleteA();
		var logoPath="${entity.logoId}";
		$('img.logoImg').attr('src','${dynamicDomain}'+logoPath);
		
		<c:if test="${not empty entity.objectId}">
			var functionIds = "${functionIds}";
		</c:if>
		//新增仅供内卖默认不选
		<c:if test="${empty entity.objectId}">
			var functionIds="1,10000004,9999999,4";
		</c:if>
		if (functionIds != "") {
			var functionId = functionIds.split(",");
			for ( var i = 0; i < functionId.length; i++) {
				var checkboxs = $("input[type='checkbox'][name='functions'][value='"
						+ functionId[i] + "']");
				$.each(checkboxs, function() {
					this.checked = "checked";
				});
			}
		}
	});

	$("#reject").click(function() {
		$.ajax({
            url:"${dynamicDomain}/company/checkCompanyStatus/${entity.objectId}",
            type : 'post',
            dataType : 'json',
            success : function(json) {
            	if(json.result){
            		var url = "${dynamicDomain}/companyReject/create?ajax=1&id=${entity.objectId}";
            		$.colorbox({
            			href : url,
            			opacity : 0.2,
            			fixed : true,
            			width : "33%",
            			height : "45%",
            			iframe : true,
            			onClosed : function() {
            				if (reloadParent) {
            					var url1='${dynamicDomain}/company/verify';
            					parent.location.href=url1;
            				}
            			},
            			overlayClose : false
            		});
            	}else{
            		winAlert("企业数据已发生变更");
            	}
            	
            }
        });
		
	});
	
	
	function ajaxFileUpload1() { 
		var filePath = $('#uploadFile1').val();
    	if(!filePath) {
            alert('请选择文件！');
            return ;
        }
		fileSuffix = /.[^.]+$/.exec(filePath);
		if (fileSuffix == ".jpg" || fileSuffix == ".bmp" || fileSuffix == ".png" || 
				fileSuffix == ".JPG" || fileSuffix == ".BMP" || fileSuffix == ".PNG") {
			$.ajaxFileUpload({  
	            url: '${dynamicDomain}/company/uploadCompanyLogo?ajax=1',  
	            secureuri: false,  
	            fileElementId: 'uploadFile1',  
	            dataType: 'json',  
	            success: function(json, status) {
	                if(json.result){
	                    var filePath = json.filePath;
	                    $('input[name="logoId"]').val(filePath);
	                    $('img.logoImg').attr('src','${dynamicDomain}'+filePath);
	                    $('#uploadButton1').val('重新上传');
	                }else{
	                	alert(json.msg);
	                }
  		        },error: function (data, status, e){//服务器响应失败处理函数
  		           	alert(e);
  		        }
	        });
		} else {
			$("#uploadFile1").after(errorLo);
			$("#uploadFile1").focus();
			return false;
		}
    return false;  
  	} 
	
	function ajaxFileUpload2() { 
    	var filePath = $('#uploadFile2').val();
    	if(!filePath) {
            alert('请选择文件！');
            return ;
        }
    	var attachs=$("#attachment").val();
    	var array = new Array();
    	array = attachs.split(",");
    	if(array.length>=6){
    		alert("附件不能大于6张");
    		return false;
    	}
        $.ajaxFileUpload({  
            url: '${dynamicDomain}/company/uploadCompanyAttach?ajax=1',  
            secureuri: false,  
            fileElementId: 'uploadFile2',  
            dataType: 'json',  
            success: function(json, status) {
                if(json.result){
                   var filePath = json.filePath;
                   var img='<div style="width: 250px;display: inline-block;">'+
                   '<a style="cursor: pointer;display: block;margin-left: 210px;" class="subDelete" data-path="'+filePath+'">删除</a>'+
                   '<img alt="" src="${dynamicDomain}'+filePath+'" width="250px" height="200px;"></div>';
                   $("#subImg").append(img);
                   var attachs=$("#attachment").val();
                   if(attachs==''){
                       $("#attachment").val(filePath);
                   }else{
                       $("#attachment").val(attachs+','+filePath);
                   }
                   deleteA();
                }else{
                	alert(json.msg);
                }
            },error: function (data, status, e)//服务器响应失败处理函数
            {
                alert(e);
            }
        }  
        );        
        return false;  
  	} 
	
	//附件删除
	function deleteA(){
      $('.subDelete').click(function(){
          var subPicture = $(this).data('path');
          var obj = $(this);
          $.ajax({
              url:"${dynamicDomain}/company/deleteCompanyAttaach",
              type : 'post',
              dataType : 'json',
              data:{'filePath':subPicture},
              success : function(json) {
                  obj.parent().remove();
                  //更新附件路径
                  var paths = '';
                  $('.subDelete').each(function(){
                  	var path = $(this).data('path');
                  	if(paths==''){
                  		paths = path;
                  	}else{
                  		paths = paths+','+path;
                  	}
                  });
                  $('#attachment').val(paths);
              }
          });
      });
	}
	
	function saveCompany(){
		$('#Company').validate();
		$('#functionIdss').val(getCheckedValuesString(document.getElementsByName('functions')));
		$("#verifyButton").attr("disabled", true); 
		return true;
	}
	
	function verifyCompany(){
		$('#verify').val(1);
		$('#functionIdss').val(getCheckedValuesString(document.getElementsByName('functions')));		
		$("#saveButton").attr("disabled", true); 
		return true;
	}
</script>
</body>
</html>