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
				action="${dynamicDomain}/productCompanyPrice/save"
				class="form-horizontal" id="editForm" onsubmit="return verification();">
				<div class="callout callout-info">
					<div class="message-right">${message }</div>
					<h4 class="modal-title">新增/编辑</h4>
				</div>
				<input type="hidden" name="objectId"/>
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="productCompanyPrice" class="col-sm-2 control-label">设置面向企业商品价格</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="productName" class="col-sm-2 control-label">主商品</label>
								<c:if test="${entity.objectId == null }">
									<div class="col-sm-1">
										<a href="${dynamicDomain}/product/productCompanyPriceTemplate?ajax=1&inputName=productCompanyPriceForm.product"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>
									</div>
								</c:if>
								<div class="col-sm-8 lable-div" id="productCompanyPriceForm.product"><c:if test="${product!=null }">[${product.objectId }]${product.name }</c:if></div>
								<input type="hidden" class="search-form-control" name="productCompanyPriceForm.productName" value="${product.name }"> 
								<input type="hidden" class="search-form-control" name="productCompanyPriceForm.productId" id="productId" value="${product.objectId }">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="companies" class="col-sm-2 control-label">面向企业</label>
								<c:if test="${entity.objectId == null }">
									<div class="col-sm-1">  
											<a href="${dynamicDomain}/company/multiCompanyTemplate?ajax=1&inputName=companies"
												class="pull-left btn btn-primary colorbox-template">选择 </a>
									</div>
								 </c:if>
								<div id="companies" class="col-sm-6" style="margin-left: 5px;">
									<c:if test="${company!=null }">
									    <div class="col-sm-12 col-md-12" id="companies0">
									        <div class="form-group">
	                                            <div class="col-sm-6">
	                                                <input type="hidden" class="search-form-control" name="productCompanyPriceForm.companies[0].objectId" value="${company.objectId }"/>
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
								<label for="companyUnionPrice" class="col-sm-2 control-label">按SKU定价</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<table border="1" style="width: 100%;">
								<thead>
									<tr>
										<th>操作</th>
										<th>序号</th>
										<th>商品编号</th>
										<th>属性1</th>
										<th>属性2</th>
										<th>商品标题</th>
										<th>商品型号</th>
										<th>供货价</th>
										<th>市场价</th>
										<th>销售价</th>
										<th>企业价格</th>
									</tr>
								</thead>
								<tbody id="skus">
								    <c:if test="${sku!=null }">
										<tr id="skus0">
										    <th><input type="checkbox" class="noBorder" name="schk" id="skus0" onclick="schkClick()"></th>
										    <th><input type="hidden" class="search-form-control" name="skuId" value="${sku.objectId }"/>1</th>
			                                <th>${sku.skuNo }</th>
			                                <th>${sku.attributeValue1 }</th>
			                                <th>${sku.attributeValue2 }</th>
			                                <th>${sku.name }</th>
			                                <th>${sku.productModel }</th>
			                                <th>${sku.supplyPrice }</th>
			                                <th>${sku.marketPrice }</th>
			                                <th>${sku.sellPrice }</th>
			                                <th><input type="hidden" class="search-form-control" name="productId" value="${sku.productId }"/><input type="text" style="width:80px" name="companyPrice" id="skus0"></th>
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
								<a href="${dynamicDomain}/productCompanyPrice/page"
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
            var productId = $('#productId').val();
            if(/^\s*$/.test(companies)){
                winAlert('面向企业不能为空！');
                return false;
            }
            if(productId==''){
                winAlert('主商品不能为空!');
                return false;
            }
            var skuPrice = new Array();
            $("input[name='companyPrice']").each(function(){
                skuPrice.push($(this).val());
            });
            for(var i=0;i<skuPrice.length;i++){
                if(!/^\d+\.?\d{0,2}$/.test(skuPrice[i])){
                    winAlert('sku销售价格最多两位小数');
                    return false;
                }
            }
            return true;
        }
        function verification(){
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
			jQuery.validator.addMethod("verifyPrice", function(value, element) {
				var decimal = /^\d*(\.\d{1,2})?$/;
				return this.optional(element) || (decimal.test(value));
				}, "小数位数不能超过两位");
		});
	</script>
</body>
</html>