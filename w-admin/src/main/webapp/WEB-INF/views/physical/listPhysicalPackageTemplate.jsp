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
			<form action="${dynamicDomain}/physicalPackage/physicalPackageTemplate?ajax=1" method="post"
				class="form-horizontal">
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
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setPackage();" class="btn btn-primary pull-left">确认</a>
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
		sortRowsCallback="limit" action="physicalPackageTemplate?ajax=1">
			<jdf:export view="csv" fileName="physicalPackage.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="physicalPackage.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.packageNo}-${currentRowObject.packageName}-<jdf:columnValue dictionaryId="1119" value="${currentRowObject.packageType}" />" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" headerStyle="width:15%;" />
				<jdf:column property="packageName" title="套餐名称" headerStyle="width:20%;" />
				<jdf:column property="packageType" title="商品类型" headerStyle="width:10%;">
				   <jdf:columnValue dictionaryId="1119" value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="packageStock" title="套餐剩余库存" headerStyle="width:10%;" />
				<jdf:column property="startDate" title="广告有效期" headerStyle="width:15%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setPackage(){
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("tbody[id='${inputName}']");
		var count = $("#${inputName} tr",window.parent.document).length;
		for(var i in products){
			var product = products[i].split("-");
			productDiv.html(productDiv.html()+'<tr id="${inputName}'+count+'"><th><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></th><th>'+'<input type="hidden" class="search-form-control" name="productShieldForm.${inputName}['+count+'].objectId" value="'+product[0]+'"/>'+(count+1)+'</th>'+
					'<th>'+product[1]+'</th><th>'+product[2]+'</th><th>'+product[3]+'</th></tr>');
		    count = count+1;
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>