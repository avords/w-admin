<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>基础信息管理</title>
<style>
.upView {
	margin: 7px 0 0 0;
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
</style>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					供应商信息维护
				</h4>
			</div>
			<form method="post" action="${dynamicDomain}/supplier/save"
				id="Supplier" class="form-horizontal">
				<input type="hidden" name="objectId"> 
				<input type="hidden" name="types" id="types"> 
				<input type="hidden" name="isSelf" id="isSelf">
				<input type="hidden" name="all" id="all">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="applyId" class="col-sm-4 control-label">客户经理</label>
								<div class="col-sm-8 upView">${entity.accountManager}</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="applyTime" class="col-sm-4 control-label">联系方式</label>
								<div class="col-sm-8">
									<div class="col-sm-8 upView">${entity.mobilephone}</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="pull-left">
									<h4>
										<b>基本信息:</b>
									</h4>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierNo" class="col-sm-4 control-label">供应商编号</label>
								<div class="col-sm-8 upView">${entity.supplierNo}</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierName" class="col-sm-4 control-label">供应商类型</label>
								<div class="col-sm-8">
									<jdf:checkBox dictionaryId="1314" name="type" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierName" class="col-sm-4 control-label">供应商名称</label>
								<div class="col-sm-8">
									<div class="col-sm-8 upView">${entity.supplierName}</div>
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
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="cardNo">
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
								<label for="companyId" class="col-sm-4 control-label"><font
									color="red">内卖企业</font></label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="companyName"> 
									<input type="hidden" class="search-form-control" name="companyId">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessTerm" class="col-sm-4 control-label">营业期限</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="businessTerm">
								</div>
								<div class="col-sm-1 upView">年</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="isSelf" class="col-sm-4 control-label">&nbsp;&nbsp;</label>
								<div class="col-sm-8">
									<input type="checkbox" name="onlySelf" value="1"> <font
										color="red">仅供内卖&nbsp;&nbsp;&nbsp;&nbsp;(说明：若选择内卖企业，则表示供应商与该企业为同一家公司，若勾选仅供内卖，则该供应商发布的商品，只面向该企业销售，反之对全平台销售。)</font>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessLicenseStart" class="col-sm-4 control-label">营业执照期限</label>
								<div class="col-sm-8">
									<input id="businessLicenseStart" name="businessLicenseStart"
										type="text" onClick="WdatePicker()"
										class="search-form-control" />
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessLicenseEnd" class="col-sm-4 control-label">到</label>
								<div class="col-sm-8">
									<input id="businessLicenseEnd" name="businessLicenseEnd"
										type="text" onClick="WdatePicker()"
										class="search-form-control" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="businessLicenseYear" class="col-sm-4 control-label">营业执照年检年度</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="businessLicenseYear">
								</div>
							</div>
						</div>
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
								<label for="organizationYear" class="col-sm-4 control-label">组织机构代码年检年度</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="organizationYear">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="organizationStart" class="col-sm-4 control-label">组织机构代码证期限</label>
								<div class="col-sm-8">
									<input id="organizationStart" name="organizationStart"
										type="text" onClick="WdatePicker()"
										class="search-form-control" />
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="organizationEnd" class="col-sm-4 control-label">到</label>
								<div class="col-sm-8">
									<input id="organizationEnd" name="organizationEnd" type="text"
										onClick="WdatePicker()" class="search-form-control" />
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
									<input type="text" class="search-form-control"
										name="yearTurnover">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-8">
							<div class="form-group">
								<label for="areaId" class="col-sm-3 control-label">办公地址</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${entity.areaId}" district="areaId"
										styleClass="form-control inline" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="form-group">
								<label for="addressDetail" class="col-sm-4 control-label">公司详细地址</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="addressDetail">
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
										name="commissioned">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="companyMoney" class="col-sm-4 control-label">公司注册资金</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
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
									<input type="text" class="search-form-control" name="email">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone" class="col-sm-4 control-label">联系人电话</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="telephone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="pull-left">
									<h4>
										<b>清算信息:</b>
									</h4>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cooperations" class="col-sm-4 control-label">合作方式</label>
								<div class="col-sm-8">
									<jdf:radio dictionaryId="1315" name="cooperations" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="liquidationName" class="col-sm-4 control-label">清算户名</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="liquidationName">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="liquidationNum" class="col-sm-4 control-label">清算账号</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="liquidationNum">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="bank" class="col-sm-4 control-label">开户行</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="bank">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="bankAddress" class="col-sm-4 control-label">银行所在地</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="bankAddress">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linker" class="col-sm-4 control-label">财务联系人</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="linker">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linkEmail" class="col-sm-4 control-label">财务联系邮箱</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="linkEmail">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="linkTelephone" class="col-sm-4 control-label">财务联系方式</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="linkTelephone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="moneyTerm" class="col-sm-4 control-label">拨款周期</label>
								<div class="col-sm-8">
									<select name="moneyTerm" id="moneyTerm"
										class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1316" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="realDay" class="col-sm-4 control-label">具体清算日期</label>
								<div class="col-sm-8" id="real">
								<input type="text" class="search-form-control" value="—请选择—">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoney" class="col-sm-4 control-label">保证金</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="guaranteeMoney">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoney" class="col-sm-4 control-label">清算币种</label>
								<div class="col-sm-8 upView">人民币</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoneyStart" class="col-sm-4 control-label">保证金有效期</label>
								<div class="col-sm-8">
									<input id="guaranteeMoneyStart" name="guaranteeMoneyStart"
										type="text" onClick="WdatePicker()" class="search-form-control" />
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="guaranteeMoneyEnd" class="col-sm-4 control-label">到</label>
								<div class="col-sm-8">
									<input id="guaranteeMoneyEnd" name="guaranteeMoneyEnd" type="text"
										onClick="WdatePicker()" class="search-form-control" />
								</div>
							</div>
						</div>
					</div>
					<jdf:bootstrapDomainValidate domain="Supplier" index="0"/>
				</div>
			</form>
		</jdf:form>
		
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
					<div class="pull-left">
						<h4>
							<b>代理品牌:</b>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<!-- 品牌列表 -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>品牌名称</th>
							<th>代理级别</th>
							<th>品牌授权期限</th>
							<th>&nbsp;&nbsp;产品类别&nbsp;&nbsp;</th>
							<th>&nbsp;&nbsp;佣金&nbsp;&nbsp;</th>
						</tr>
					</thead>
					<tbody id="brandBody">
						<c:forEach items="${supplierBrands}" var="item" varStatus="status">
							<tr>
								<td><jdf:columnCollectionValue items="brands" nameProperty="chineseName" value="${item.brandId}" /></td>
								<td>
					                <jdf:columnValue dictionaryId="1317" value="${item.brandLevel}" />
					            </td>
								<td><fmt:formatDate value="${item.termStart}" pattern="yyyy-MM-dd" />
								至<fmt:formatDate value="${item.termEnd}" pattern="yyyy-MM-dd" />
								</td>
								<td>${item.categoryOne}-${item.categoryTwo}-${item.categoryThree}</td>
								<td>0-1000元   1%
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>

		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
					<div class="pull-left">
						<h4>
							<b>配送区域:</b>
						</h4>
					</div>
				</div>
			</div>
			</div>
		<!-- 区域列表 -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>配送区域_省</th>
							<th>配送区域_市</th>
							<th>配送区域_区</th>
							<th>配送时效（天）</th>
							<th>配送价格（元）</th>
						</tr>
					</thead>
					<tbody id="areaBody">
						<c:forEach items="${supplierDispatchAreas}" var="item" varStatus="status">
							<tr>
								<td>-全国-</td>
								<td>-全国-</td>
								<td>-全国-</td>
								<td>${item.distributionTime}</td>
								<td>${item.distributionPrice}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<div class="form-group">
					<div class="pull-left">
						<h4>
							<b>附件:</b>
						</h4>
					</div>
				</div>
			</div>
		</div>
		<!--附件列表 -->
		<div class="row">
			<div class="col-sm-12 col-md-12">
				<table class="table table-bordered table-hover">
					<thead>
					</thead>
					<tbody id="fileBody">
						<c:forEach items="${supplierAttachs}" var="item" varStatus="status">
							<tr>
								<td>${item.attachName}</td>
								<td><c:if test="${item.attachName}"></c:if>
								<a href="${dynamicDomain}/${item.attachRoute}" target="_blank">
								<img src="${dynamicDomain}/${item.attachRoute}" width="400px" height="300px"/></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${view==1}">
			$(".hideView").hide();
		</c:if>
		<c:if test="${param.list==1}">
			$(".hideView").hide();
		</c:if>
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
  	});
	
	
	//拨款周期
	 var day = '<select name="realDay" id="realDay" class="search-form-control">';
	 for ( var i = 1; i < 29; i++) {
         day = day+'<option value="'+i+'">'+i+'</option>';
     } 
	 day = day+'</select>';
	 var week =  '<select name="realWeek" id="realWeek" class="search-form-control"><option value="1">星期一</option><option value="2">星期二</option><option value="3">星期三</option><option value="4">星期四</option><option value="5">星期五</option></select>';
	 $("#moneyTerm").bind("change",function(){
		 var term=$(this).val();
	        if(term){
	        	if(term=='1'){
	        		$('#real').html(day);
	        	}else if(term=='2'){
	        		$('#real').html(week);
	        	}
	        	
	        }
	    }).change();
	 
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
     
   	function setEnterprise(url,inputName){
		var cooperations = $('input[name="cooperations"]:checked').val();
		$("#enterprise-btn").attr("href",url+cooperations+"?ajax=1&inputName="+inputName);
	}
   	
	</script>
</body>
</html>