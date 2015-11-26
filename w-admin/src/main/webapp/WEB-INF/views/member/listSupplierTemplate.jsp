<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				供应商信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/supplier/supplierTemplate?ajax=1&functionName=${functionName}" method="post" class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">供应商名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_supplierName">
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
		sortRowsCallback="limit" action="supplierTemplate?ajax=1">
			<jdf:export view="csv" fileName="supplier.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="supplier.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 20%">
					<button type="button" class="btn btn-primary" onclick="javascript:setSupplier(${currentRowObject.objectId},'${currentRowObject.supplierName}')">选择</button>
				</jdf:column>
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;" viewsAllowed="html">
                  <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.supplierName}">
					${currentRowObject.supplierName}
                  </div>
				</jdf:column>
				<jdf:column property="commissioned" title="联络人" headerStyle="width:40%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setSupplier(supplierId,supplierName){
		$(window.parent.document).find("input[name='${inputName}Name']").val(supplierName);
		$(window.parent.document).find("input[name='${inputName}Id']").val(supplierId);
		try{
			if(!'${functionName}'==''){
				parent.${functionName}();
			}
		}catch(e){
			
		}
		
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>