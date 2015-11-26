<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增/编辑</title>
<style>
.checkbox-lineh {
	margin-top: 10px;
}

.product-standard {
	height: 50px;
}

.attribute-remark {
	width: 50px;
}

.attribute-value span {
	margin-right: 0px;
}

.attribute-value .attValItem {
	margin-right: 10px;
}

table th {
	text-align: center;
}

table tbody tr td input {
	width: 60px;
}

.detail-picture img {
	margin-right: 10px;
}

.attValue {
	width: 20px;
	margin-right: 0px;
}

.noBorder {
	border-left: 0;
	border-right: 0;
	border-top: 0;
	border-bottom: 0;
}

.welfare-div {
	margin-top: 10px;
}

.welfare-tag {
	background-color: white;
	border: 1px solid black;
	outline: none;
}

.welfare-tag-border {
	border: 1px solid red;
}
</style>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post"
				action="${dynamicDomain}/welfareCompanyPrice/save"
				class="form-horizontal" id="editForm" onsubmit="return customeValid();">
				<div class="callout callout-info">
					<div class="message-right">${message }</div>
					<h4 class="modal-title">新增/编辑</h4>
				</div>
				<input type="hidden" name="objectId"/>
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="productCompanyPrice" class="col-sm-2 control-label">设置面向企业套餐价格</label>
							</div>
						</div>
					</div>
					<c:if test="${entity.objectId == null }">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="productName" class="col-sm-2 control-label">套餐</label>
										<div class="col-sm-1">
											<a href="${dynamicDomain}/welfarePackage/welfarePackagePriceTemplate?ajax=1&inputName=welfarePackages"
	                                            class="pull-left btn btn-primary colorbox-double-template">选择
	                                        </a>    
										</div>
								</div>
							</div>
						</div>
					</c:if>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="companies" class="col-sm-2 control-label">面向企业</label>
								<c:if test="${entity.objectId == null }">
									<div class="col-sm-1">  
											<a href="${dynamicDomain}/company/multiWelfareCompanyTemplate?ajax=1&inputName=companies"
												class="pull-left btn btn-primary colorbox-template">选择 </a>
									</div>
								 </c:if>
								<div id="companies" class="col-sm-6" style="margin-left: 5px;">
									<c:if test="${company!=null }">
									    <div class="col-sm-12 col-md-12" id="companies0">
									        <div class="form-group">
	                                            <div class="col-sm-6">
	                                                <input type="hidden" class="search-form-control" name="welfareCompanyPriceForm.companies[0].objectId" value="${company.objectId }"/>
	                    ${company.companyName }
	                                            </div>
<!-- 	                                            <div class="col-sm-2"> -->
<!-- 	                                                  <a href="javascript:del('companies0')" class="btn btn-primary">删除</a> -->
<!-- 	                                            </div> -->
                                            </div>
                                        </div>
									</c:if>
							    </div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="companyUnionPrice" class="col-sm-2 control-label">企业统一销售价</label>
								<div class="col-sm-2">
									<input type="text" class="verifyPrice search-form-control"
										name="companyUnionPrice" id="companyUnionPrice">
								</div>
								<label for="RMB" class="col-sm-0 control-label">元</label>
							</div>
						</div>
					</div>
					<div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="form-group">
                                <label for="companyFamilyPrice" class="col-sm-2 control-label">为家属购买价格</label>
                                <div class="col-sm-2">
                                    <input type="text" class="verifyPrice search-form-control"
                                        name="companyFamilyPrice" id="companyFamilyPrice">
                                </div>
                                <label for="RMB" class="col-sm-0 control-label">元</label>
                            </div>
                        </div>
                    </div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="companyUnionPrice" class="col-sm-2 control-label">按套餐</label>
							</div>
						</div>
					</div>
					<div class="row">
                            <div class="col-sm-12 col-md-12">
                                <table border="1" style="width: 100%;" >
                                  <thead>
                                     <tr>
                                         <th>操作</th><th>序号</th><th>项目</th><th>福利套餐编号</th><th>福利套餐名称</th>
                                         <th>商品类型</th><th>企业价格</th><th>家属价格</th>
                                     </tr>
                                  </thead>
                                  <tbody id="welfarePackages">
                                     <c:if test="${welfarePackage!=null and entity!=null}">
	                                      <tr id="welfarePackages0">
	                                           <th><a href="javascript:del('welfarePackages0')" class="btn btn-primary">删除</a></th>
	                                           <th><input type="hidden" class="search-form-control" name="packageId" value="${welfarePackage.objectId }"/>1</th>
	                                           <th>${welfarePackage.itemName}</th>
	                                           <th>${welfarePackage.packageNo }</th>
	                                           <th>${welfarePackage.packageName }</th>
	                                           <th><jdf:columnValue dictionaryId="1606"  value="${welfarePackage.stockType}" /></th>
	                                           <th><input type="text" style="width:80px" name="companyPrice" id="company0" value="${entity.companyPrice}"></th>
	                                           <th><input type="text" style="width:80px" name="familyPrice" id="family0" value="${entity.familyPrice}"></th>
	                                      </tr>
                                      </c:if>
                                  </tbody>
                                </table>
                            </div>
                     </div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">确定</button>
								<a href="${dynamicDomain}/welfareCompanyPrice/page"
									class="btn btn-primary">返回</a>
							</div>

						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="ProductCompanyPrice" />
	<script type="text/javascript">
		function del(divId)
		{
			$("#" + divId).remove();
		}
		function verifiEmpty(){
            var companies = $('#companies').text();
            if(/^\s*$/.test(companies)){
                alert('面向企业不能为空！');
                return false;
            }
            var welfarePackages=$('#welfarePackages').text();
            if(/^\s*$/.test(welfarePackages)){
            	alert('套餐不能为空！');
            	return false;
            }
            var skuPrice = new Array();
            $("input[name='companyPrice']").each(function(){
                skuPrice.push($(this).val());
            });
            for(var i=0;i<skuPrice.length;i++){
                if(!/^\d+\.?\d{0,2}$/.test(skuPrice[i])){
                    alert('面向企业价格最多两位小数');
                    return false;
                }
            }
            
            var familyPrice = new Array();
            $("input[name='familyPrice']").each(function(){
            	familyPrice.push($(this).val());
            });
            for(var i=0;i<familyPrice.length;i++){
                if(!/^\d*\.?\d{0,2}$/.test(familyPrice[i])){
                    alert('家属价格最多两位小数');
                    return false;
                }
            }
            return true;
        }
        function customeValid(){
            var flag = verifiEmpty();
            return flag;
        }
		$(function(){
			$('#companyUnionPrice').blur(function(){
				var unionPrice = $(this).val();
				$("input[name='companyPrice']").each(function(){
					$(this).val(unionPrice);
				});
			});
			$('#companyFamilyPrice').blur(function(){
                var familyPrice = $(this).val();
                $("input[name='familyPrice']").each(function(){
                    $(this).val(familyPrice);
                });
            });
			jQuery.validator.addMethod("verifyPrice", function(value, element) {
				var decimal = /^\d*(\.\d{1,2})?$/;
				return this.optional(element) || (decimal.test(value));
				}, "小数位数不能超过两位");
		});
	</script>
</body>
</html>