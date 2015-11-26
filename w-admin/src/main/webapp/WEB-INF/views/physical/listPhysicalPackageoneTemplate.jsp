<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检套餐信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physicalPackage/physicalPackageoneTemplate?ajax=1&inputName=physicalPromoteForm.addtionalWelfares&packageType=0" method="post"
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
						<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">套餐名称:</label>
									<div class="col-sm-8">
										<input type="text" class="search-form-control" name="search_LIKES_packageName">
									</div>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="physicalPackageoneTemplate?ajax=1&inputName=physicalPromoteForm.addtionalWelfares&packageType=0">
			<jdf:export view="csv" fileName="physicalPackage.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="physicalPackage.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" 
				headerStyle="width: 10%" style="text-align:center">
					<button type="button" class="btn btn-primary" onclick="javascript:setPackage('${currentRowObject.objectId}','${currentRowObject.packageName}','${currentRowObject.packagePrice}' )">选择</button>
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" headerStyle="width:15%;" />
				<jdf:column property="packageName" title="套餐名称" headerStyle="width:20%;" />
				<jdf:column property="packagePrice" title="套餐价格" headerStyle="width:10%;" />
				<jdf:column property="packageType" title="套餐类型" headerStyle="width:10%;">
				   <jdf:columnValue dictionaryId="1607" value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="stockType" title="套餐库存" headerStyle="width:15%;">
				   <jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />(${currentRowObject.packageStock})
				</jdf:column>
				 
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setPackage(packageId,packageName,packagePrice){
		var packageDiv = $(window.parent.document).find("div[id='${inputName}']");
		packageDiv.html('<div class="col-sm-12 col-md-12" id="package'+packageId+'"><div class="form-group"><div class="col-sm-6">'+
				packageName+
				'</div><div class="col-sm-2"><a href="javascript:del(\'package'+packageId+'\')" class="btn btn-primary">删除</a></div></div></div>'
				  );
		$(window.parent.document).find("input[name='promotePackageId']").val(packageId);
		parent.$.colorbox.close();
	}
	</script>
	
</body>
</html>