<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>添加设置</title>
<style>
.checkbox-lineh{
margin-top:10px;
}
.product-standard{
height: 50px;
}
.attribute-remark{
 width: 50px;
}
.attribute-value span{
margin-right: 0px;
}
.attribute-value .attValItem{
margin-right: 10px;
}
table th{
text-align: center;
}
table tbody tr td input{
width: 60px;
}
.detail-picture img{
margin-right: 10px;
}
.attValue{
width: 20px;
margin-right: 0px;
}
.noBorder{
border-left: 0;
border-right: 0;
border-top: 0;
border-bottom: 0;
}
.welfare-div{
margin-top: 10px;
}
.welfare-tag{
background-color: white;
border: 1px solid black;
outline:none;
}
.welfare-tag-border{
border: 1px solid red;
}
</style>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		<jdf:form bean="entity" scope="request">
			        <form method="post" action="${dynamicDomain}/productShield/save" class="form-horizontal" id="editForm" onsubmit="return verification();">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title">添加设置</h4>
			        </div>
                    <input type="hidden" name="objectId">
                    <input type="hidden" name="releaseType" value="1">
                    <input type="hidden" name="checkStatus" id="checkStatus">
                    <div class="box-body">
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="companyName" class="col-sm-2 control-label">选择企业</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/company/productShieldCompanyTemplate?ajax=1&inputName=productShieldForm.company"
											class="pull-left btn btn-primary colorbox-template">选择
										</a>
									</div>
									<div class="col-sm-6">
										<input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.companyName" value="${company.companyName}"> 
										<input type="hidden" class="search-form-control" name="productShieldForm.companyId" value="${company.objectId}">
									</div>
								</div>
							</div>                            
                        </div>
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="suppliers" class="col-sm-2 control-label">屏蔽供应商</label>
                                    <div class="col-sm-1">
                                    	<a href="${dynamicDomain}/supplier/suppliersTemplate?ajax=1&inputName=suppliers"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>
                                    </div>
                                    <div id="suppliers" class="col-sm-8" style="margin-left: 5px;">
                                      <c:forEach items="${suppliers }" var="item" varStatus="status"> 
                                         <div class="col-sm-12 col-md-12" id="suppliers${status.index }"><div class="form-group">
                                        <div class="col-sm-8">
                                        <input type="hidden" class="search-form-control" name="productShieldForm.suppliers[${status.index }].objectId" value="${item.objectId}"/>
                                        <input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.suppliers[${status.index }].supplierName" value="${item.supplierName }"/>
                                       </div><div class="col-sm-4"><a href="javascript:del('suppliers${status.index }')" class="btn btn-primary">删除</a></div></div></div>
                                      </c:forEach>
									</div>
								</div>
							</div>                               
                        </div>                                                
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="brands" class="col-sm-2 control-label">屏蔽品牌</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/brand/brandTemplate?ajax=1&inputName=brands"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>
									</div>
									<div id="brands" class="col-sm-8" style="margin-left: 5px;">
									  <c:forEach items="${brands }" var="item" varStatus="status"> 
									    <div class="col-sm-12 col-md-12" id="brands${status.index }"><div class="form-group">
                                        <div class="col-sm-8"><input type="hidden" class="search-form-control" name="productShieldForm.brands[${status.index }].objectId" value="${item.objectId }"/>
					                    <input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.brands[${status.index }].chineseName" value="${item.chineseName }"/>
					                    </div><div class="col-sm-4"><a href="javascript:del('brands${status.index }')" class="btn btn-primary">删除</a></div></div></div>
									  </c:forEach>
									</div>
								</div>
							</div>                               
                        </div>
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="productCategories" class="col-sm-2 control-label">屏蔽商品分类</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/productCategory/productCategoryTemplate?ajax=1&inputName=productCategories"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>
									</div>
									<div id="productCategories" class="col-sm-8" style="margin-left: 5px;">
									     <c:forEach items="${productCategories }" var="item" varStatus="status"> 
									         <div class="col-sm-12 col-md-12" id="productCategories${status.index }"><div class="form-group">
						                    <div class="col-sm-8"><input type="hidden" class="search-form-control" name="productShieldForm.productCategories[${status.index }].objectId" value="${item.objectId }"/>
						                    <input type="hidden" class="search-form-control" name="productShieldForm.productCategories[${status.index }].layer" value="${item.layer }"/>
						                    <input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.productCategories[${status.index }].name" value="${item.name }"/>
						                    </div><div class="col-sm-4"><a href="javascript:del('productCategories${status.index }')" class="btn btn-primary">删除</a></div></div></div>
									     </c:forEach>
                                    </div>
								</div>
							</div>                               
                        </div>                        
						<div class="row">
							<div class="col-sm-12 col-md-12 menuContent">
								<div class="form-group">
									<label for="lifeServies" class="col-sm-2 control-label">屏蔽生活服务</label>
									<div class="col-sm-10">
										<jdf:checkBox dictionaryId="1115" name="productShieldForm.lifeServies"/>
									</div>
								</div>
							</div>
						</div>
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="products" class="col-sm-2 control-label">屏蔽商品</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/product/productTemplate?ajax=1&inputName=products"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>
									</div>
								</div>								
							</div>                               
                        </div>                         
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="Packages" class="col-sm-2 control-label">屏蔽套餐</label>
									<div class="col-sm-2">
										<a href="${dynamicDomain}/welfarePackage/welfarePackageTemplate?ajax=1&inputName=welfarePackages"
											class="pull-left btn btn-primary colorbox-double-template">选择
										</a>										
									</div>								
								</div>
							</div>                               
                        </div>                                                 
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <table border="1" style="width: 100%;" >
                                  <thead>
                                     <tr>
                                         <th>操作</th><th>序号</th><th>商品货号</th><th>商品名称</th><th>商品类别</th>
                                         <th>供应商名称</th><th>销售价格</th>
                                     </tr>
                                  </thead>
                                  <tbody id="products">
                                     <c:forEach items="${products }" var="item" varStatus="status"> 
                                      <tr id="products${status.index }">
	                                       <th><a href="javascript:del('products${status.index }')" class="btn btn-primary">删除</a></th>
	                                       <th><input type="hidden" class="search-form-control" name="productShieldForm.products[${status.index }].objectId" value="${item.objectId }"/>${status.count }</th>
	                                       <th>${item.productNo}</th>
	                                       <th>${item.name }</th>
	                                       <th>${item.category.firstName }-${item.category.secondName }-${item.category.name }</th>
	                                       <th>${item.supplierName }</th>
	                                       <th>${item.sellPrice }</th>
                                      </tr>
                                      </c:forEach>
                                  </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row"></div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <table border="1" style="width: 100%;" >
                                  <thead>
                                     <tr>
                                         <th>操作</th><th>序号</th><th>项目</th><th>福利套餐编号</th><th>福利套餐名称</th>
                                         <th>商品类型</th>
                                     </tr>
                                  </thead>
                                  <tbody id="welfarePackages">
                                     <c:forEach items="${welfarePackages }" var="item" varStatus="status"> 
                                      <tr id="welfarePackages${status.index }">
                                           <th><a href="javascript:del('welfarePackages${status.index }')" class="btn btn-primary">删除</a></th>
                                           <th><input type="hidden" class="search-form-control" name="productShieldForm.welfarePackages[${status.index }].objectId" value="${item.objectId }"/>${status.count }</th>
                                           <th>${item.itemName}</th>
                                           <th>${item.packageNo }</th>
                                           <th>${item.packageName }</th>
                                           <th><jdf:columnValue dictionaryId="1606"  value="${item.stockType}" /></th>
<%--                                            <th><jdf:columnValue dictionaryId="1602"    value="${item.wpCategoryType}" /></th> --%>
                                      </tr>
                                      </c:forEach>
                                  </tbody>
                                </table>
                            </div>
                        </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="submit" class="btn btn-primary">确定
                                </button>
                                <a href="${dynamicDomain}/productShield/page" class="btn btn-primary">返回</a>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="ProductShield"/>
    <script type="text/javascript">
    function del(divId) {
        $("#"+divId).remove();
    }
        function checkProductShieldFormLifeServies(){
        	<c:forEach items="${lifeServies}" var = "item" varStatus="status">
        		$("input[value='${item.itemId}'].flat-red").attr('checked','checked');
        	</c:forEach>
        }
        $(function(){
        	checkProductShieldFormLifeServies();
        });
        
        function verifiEmpty(){
        	var companyId = $("input[name='productShieldForm.companyId']").val();
        	var suppliers = $('#suppliers').text();
        	var brands = $('#brands').text();
        	var productCategories = $('#productCategories').text();
        	var lifeServies = $("input[name='productShieldForm.lifeServies']:checked").length;
        	var products = $('#products').text();
        	var welfarePackages = $('#welfarePackages').text();
        	if(/^\s*$/.test(suppliers)&&/^\s*$/.test(brands)&&/^\s*$/.test(productCategories)&&lifeServies=='0'&&/^\s*$/.test(products)&&/^\s*$/.test(welfarePackages)){
        		winAlert('屏蔽项不能为空！');
        		return false;
        	}
        	if(companyId==''){
        		winAlert('企业不能为空!');
        		return false;
        	}
        	return true;
        }
        function verification(){
            var flag = verifiEmpty();
            return flag;
        }
    </script>
</body>
</html>