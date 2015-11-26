<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>福利套餐信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				福利套餐信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfarePackage/welfarePackagePriceTemplate?ajax=1" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">套餐编号：</label>
								</div>
								<input type="text" class="search-form-control" name="search_STARTS_packageNo">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">套餐名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_packageName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setPackage();" class="btn btn-primary pull-left">
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
		sortRowsCallback="limit" action="welfarePackagePriceTemplate?ajax=1">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}|${currentRowObject.itemName}|${currentRowObject.packageNo}|${currentRowObject.packageName}|<jdf:columnValue dictionaryId='1606' value='${currentRowObject.stockType}' />|${currentRowObject.packagePrice}|${currentRowObject.welfareType}" />
				</jdf:column>
				<jdf:column property="itemName" title="项目" headerStyle="width:20%;" />
				<jdf:column property="wpCategoryType" title="套餐类型" headerStyle="width:10%;">
				    <jdf:columnValue dictionaryId="1602"    value="${currentRowObject.wpCategoryType}" />
				</jdf:column>
				<jdf:column property="stockType" title="商品类型" headerStyle="width:10%;">
				    <jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" headerStyle="width:15%;" />
				<jdf:column property="packageStock" title="套餐库存" headerStyle="width:10%;" />
				<jdf:column property="packageName" title="套餐名称" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setPackage(){
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("tbody[id='${inputName}']");
		var count = $("#${inputName} tr",window.parent.document).length;
		for(var i in products){
			var product = products[i].split("|");
			var familyStr = '';
			if(product[6]=='1'){
				familyStr = '<input type="text" style="width:80px" name="familyPrice" id="family'+count+'" value="'+product[5]+'">';
			}else{
				familyStr = '<input type="hidden" style="width:80px" name="familyPrice" id="family'+count+'">';
			}
			productDiv.html(productDiv.html()+'<tr id="${inputName}'+count+'"><th><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></th><th>'+
					'<input type="hidden" class="search-form-control" name="packageId" value="'+product[0]+'"/>'+(count+1)+
					'</th><th>'+product[1]+'</th><th>'+product[2]+'</th><th>'+product[3]+'</th><th>'+product[4]+'</th>'+
					'<th><input type="text" style="width:80px" name="companyPrice" id="company'+count+'" value="'+product[5]+'"></th>'+
					'<th>'+familyStr+'</th></tr>');
		count = count+1;
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>