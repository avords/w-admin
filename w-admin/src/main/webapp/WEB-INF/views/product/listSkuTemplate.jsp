<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>品牌信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				品牌信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/sku/skuTemplate?ajax=1" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品编号：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_skuNo">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setSku();" class="btn btn-primary pull-left">
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
		sortRowsCallback="limit" action="skuTemplate?ajax=1">
			<jdf:export view="csv" fileName="sku.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="sku.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.productNo}-${currentRowObject.attributeValue1}-${currentRowObject.attributeValue2}-${currentRowObject.name}-${currentRowObject.productModel}-${currentRowObject.supplyPrice}-${currentRowObject.marketPrice}-${currentRowObject.sellPrice}-${currentRowObject.productId}" />
				</jdf:column>
				<jdf:column property="checkStatus" title="商品状态" headerStyle="width:10%;" />
				<jdf:column property="productNo" title="商品编号" headerStyle="width:15%;" />
				<jdf:column property="name" title="商品名称" headerStyle="width:20%;" />
				<jdf:column property="categoryId" title="商品类别" headerStyle="width:10%;" />
				<jdf:column property="attributeValue1" title="尺寸" headerStyle="width:10%;" />
				<jdf:column property="attributeValue2" title="颜色" headerStyle="width:10%;" />								
				<jdf:column property="sellPrice" title="商品价格" headerStyle="width:15%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setSku(){
		var skus = getCheckedValuesString($("input[name='schk']")).split(",");
		var skuDiv = $(window.parent.document).find("tbody[id='${inputName}']");
		for(var i in skus){
			var sku = skus[i].split("-");
			var j = parseInt(i) + 1;
			skuDiv.html(skuDiv.html()+'<tr id="${inputName}'+i+'"><th><input type="checkbox" class="noBorder" name="schk" id="${inputName}'+i+'" onclick="schkClick()"></th><th>'+'<input type="hidden" class="search-form-control" name="skuId" value="'+sku[0]+'"/>'+j+'</th><th>'+sku[1]+'</th><th>'+sku[2]+'</th>'+
					'<th>'+sku[3]+'</th><th>'+sku[4]+'</th><th>'+sku[5]+'</th><th>'+sku[6]+'</th><th>'+sku[7]+'</th><th>'+sku[8]+'</th>'+'<input type="hidden" class="search-form-control" name="productId" value="'+sku[9]+'"/></th><th><input type="text" style="width:80px" name="companyPrice" id="${inputName}'+i+'"></th></tr>');
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>