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
			<form action="${dynamicDomain}/product/productCompanyPriceTemplate?ajax=1"
				method="post" class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品名称：</label>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_name">
							</div>
						</div>                   
                        </div>
					</div>
				<div class="box-footer">
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
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="productCompanyPriceTemplate?ajax=1">
			<jdf:export view="csv" fileName="product.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="product.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
			    <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" 
                headerStyle="width: 10%" style="text-align:center">
                    <button type="button" class="btn btn-primary" onclick="javascript:setProduct(${currentRowObject.objectId},'${currentRowObject.name}')">选择</button>
                </jdf:column>
<%-- 				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" --%>
<%--                             style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false"> --%>
<%--                             <input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.productNo}-${currentRowObject.name}-${currentRowObject.category.name}-${currentRowObject.supplierName}-${currentRowObject.sellPrice}" /> --%>
<%--                 </jdf:column> --%>
                <jdf:column property="supplierName" title="供应商名称" headerStyle="width:15%;" />
                <jdf:column property="productNo" title="商品货号" headerStyle="width:15%;" />
                <jdf:column property="name" title="商品名称" headerStyle="width:20%;" />
                <jdf:column property="category.name" title="商品类别" headerStyle="width:15%;">
                 ${currentRowObject.category.firstName}-${currentRowObject.category.secondName}-${currentRowObject.category.name}
                </jdf:column>
                <jdf:column property="sellPrice" title="商品价格" headerStyle="width:15%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setProduct(productId,productName){
		var productDiv = $(window.parent.document).find("div[id='${inputName}']");
		productDiv.html('['+productId+']'+productName);
		$(window.parent.document).find("input[name='${inputName}Name']").val(productName);
		$(window.parent.document).find("input[name='${inputName}Id']").val(productId);
		var skuDiv = $(window.parent.document).find("#skus");
		skuDiv.html('');
		$.ajax({
            url:"${dynamicDomain}/sku/querySkus/" + productId,
            type : 'post',
            dataType : 'json',
            data:"timstamp=" + (new Date()).valueOf(),
            success : function(json) {
            	var skus = json.skus;
            	for(var i in skus){
            		skuDiv.html(skuDiv.html()+'<tr id="${inputName}'+i+'"><th>'+
            				'<input type="checkbox" class="noBorder" name="schk" id="${inputName}'+i+'" onclick="schkClick()"></th><th>'+
            				'<input type="hidden" class="search-form-control" name="skuId" value="'+skus[i].objectId+'"/>' + i + '</th>'+
            				'<th>'+skus[i].skuNo+'</th><th>'+skus[i].attributeValue1+'</th>'+
        						'<th>'+skus[i].attributeValue2+'</th><th>'+skus[i].name+'</th>'+
        						'<th>'+skus[i].productModel+'</th><th>'+skus[i].supplyPrice+'</th>'+
        						'<th>'+skus[i].marketPrice+'</th><th>'+skus[i].sellPrice+'</th>'
        					+'<input type="hidden" class="search-form-control" name="productId" value="'+skus[i].productId+'"/></th><th>'
        					+'<input type="text" style="width:80px" name="companyPrice" id="${inputName}'+i+'"></th></tr>');
        		}
            	parent.$.colorbox.close();
            }
        });
		
		
	}
	</script>
</body>
</html>