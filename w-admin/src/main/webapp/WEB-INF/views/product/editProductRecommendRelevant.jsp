<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>相关商品推荐管理</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					相关商品推荐管理
					<c:choose>
						<c:when test="${entity.objectId eq null }">新增</c:when>
						<c:otherwise>修改</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<form method="post"
				action="${dynamicDomain}/productRecommendRelevant/saveToPage"
				id="ProductRecommendRelevant" class="form-horizontal" onsubmit="return verification();">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="productName" class="col-sm-2 control-label">主商品</label>
								<div class="col-sm-2">
									<a
										href="${dynamicDomain}/product/productRelevanceTemplate?ajax=1&inputName=product"
										class="pull-left btn btn-primary colorbox-double-template">选择主商品
									</a>
								</div>               
								<div class="col-sm-5 lable-div" id="product">
                                      
								</div>
                                  
							    <input type="hidden" class="search-form-control" name="productName"> 
								<input type="hidden" class="search-form-control" name="productId">
							
                </div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label  for="relevantProductName" class="col-sm-2 control-label">相关商品</label>
								<div class="col-sm-2">
									<a
										href="${dynamicDomain}/product/productRelevancesTemplate?ajax=1&inputName=productRecommendRelevantForm.products"
										class="pull-left btn btn-primary colorbox-double-template">添加相关商品
									</a>
								</div>
								<div id="productRecommendRelevantForm.products" class="col-sm-8">
                
                                </div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label class="col-sm-2 control-label"></label>
								<div class="col-sm-10 ">
									<label><input type="checkbox"
										name="productRecommendRelevantForm.isRelevant" value="1"><span
										class="lable-span">相互相关</span></label>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">提交</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary">返回</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="ProductRecommendRelevant" />
  
  <script type="text/javascript">
  function del(divId) {
      $("#"+divId).remove();
  }
  
  function verifiEmpty(){
  	var productId = $("input[name='productId']").val();
  	var products = $("div[id='productRecommendRelevantForm.products']").text();
  	if(productId==''){
  		winAlert('主商品不能为空!');
  		return false;
  	}
  	if(/^\s*$/.test(products)){
  		winAlert('相关商品不能为空！');
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