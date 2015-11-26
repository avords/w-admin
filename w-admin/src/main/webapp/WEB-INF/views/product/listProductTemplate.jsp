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
			<form action="${dynamicDomain}/product/productTemplate?ajax=1" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_name">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setProduct();" class="btn btn-primary pull-left">
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="productTemplate?ajax=1">
			<jdf:export view="csv" fileName="product.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="product.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="0" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.productNo}-${currentRowObject.name}-${currentRowObject.category.name}-${currentRowObject.supplierName}-${currentRowObject.sellPrice}" />
				</jdf:column>
				<jdf:column property="objectId" title="ID" headerStyle="width:10%;" />
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
	function setProduct(){
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("tbody[id='${inputName}']");
		var count = $("#${inputName} tr",window.parent.document).length;
		for(var i in products){
			var product = products[i].split("-");
			productDiv.html(productDiv.html()+'<tr id="${inputName}'+count+'"><th><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></th><th>'+'<input type="hidden" class="search-form-control" name="productShieldForm.${inputName}['+count+'].objectId" value="'+product[0]+'"/>'+(count+1)+'</th><th>'+product[1]+'</th><th>'+product[2]+'</th>'+
					'<th>'+product[3]+'</th><th>'+product[4]+'</th><th>'+product[5]+'</th></tr>');
	          count =count+1;
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>