<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				商品信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/product/productRecommentsTemplate?ajax=1&inputName=${inputName}" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
				    <div class="row">
              <div class="col-sm-4 col-md-4">
                  <div class="form-group">
                       <label class="col-sm-4 control-label">一级分类：</label>
                       <div class="col-sm-8">
                        <select name="firstId" id="category1" class="form-control">
                            <option value="">—全部—</option>
                            <jdf:selectCollection items="firstCategory" optionValue="firstId" optionText="name"/>
                       </select>
                      </div>
                  </div>
              </div>
              <div class="col-sm-4 col-md-4">
                  <div class="form-group">
                          <label class="col-sm-4 control-label">二级分类：</label>
                      <div class="col-sm-8">
                        <select name="secondId" id="category2" class="form-control">
                       </select>
                      </div>
                  </div>
              </div>
              <div class="col-sm-4 col-md-4">
                  <div class="form-group">
                          <label class="col-sm-4 control-label">三级分类：</label>
                      <div class="col-sm-8">
                       <select name="search_EQL_categoryId" id="category3" class="form-control">
                      </select>
                      </div>
                  </div>
              </div>
          </div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 form-lable">商品名称：</label>
									<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_name">
									</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 form-lable">商品货号：</label>
									<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_productNo">
									</div>
							</div>
						</div>
						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 form-lable">商品型号：</label>
									<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_productModel">
									</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setProducts();" class="btn btn-primary pull-left">
						确认
					</a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="productRelevanceTemplate?ajax=1">
			<jdf:export view="csv" fileName="product.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="product.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" 
				headerStyle="width: 10%" style="text-align:center">
					<button type="button" class="btn btn-primary" onclick="javascript:setProduct(${currentRowObject.objectId},'${currentRowObject.name}')">选择</button>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount"
					title="序号" style="width:4%;text-align:center" />
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;"/>
				<jdf:column property="productNo" title="商品货号" headerStyle="width:15%;" />
				<jdf:column property="name" title="商品名称" headerStyle="width:20%;" />
<%-- 				<jdf:column property="name" title="商品类别" headerStyle="width:20%;" /> --%>
				<jdf:column property="sellPrice" title="商品价格" headerStyle="width:15%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setProduct(productId,productName){
		var productDiv = $(window.parent.document).find("div[id='${inputName}']");
		<%--productDiv.html('['+productId+']'+productName);--%>
		productDiv.html('<input type="type" class="search-form-control" name="productName" value="'+productName+'"/>'
				  );
		$(window.parent.document).find("input[name='${inputName}Name']").val(productName);
		$(window.parent.document).find("input[name='${inputName}Id']").val(productId);
		parent.$.colorbox.close();
	}
    $(function(){
        $("#category1").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/productCategory/secondCategory/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#category2").children().remove();
                        $("#category2").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.secondCategory.length; i++) {
                            $("#category2").append("<option value='" + json.secondCategory[i].secondId + "'>" + json.secondCategory[i].name + "</option>");
                        }
//                         $("#category2").val('${category.secondId}').change();
                        $("#category2").val('${param.search_EQS_secondId}').change();
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
                        $("#category3").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.thirdCategory.length; i++) {
                            $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
                        }
                        $("#category3").val('${param.search_EQL_categoryId}').change();
                    }
                });
            }
         }).change();
    });
	</script>
</body>
</html>