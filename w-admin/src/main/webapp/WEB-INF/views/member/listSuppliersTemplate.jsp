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
			<form action="${dynamicDomain}/supplier/suppliersTemplate?ajax=1" method="post"
				class="form-horizontal">
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
					<a href="javascript:setSuppliers();" class="btn btn-primary pull-left">
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
		sortRowsCallback="limit" action="suppliersTemplate?ajax=1">
			<jdf:export view="csv" fileName="supplier.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="supplier.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.supplierName}" />
				</jdf:column>
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:40%;" viewsAllowed="html">
                  <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.supplierName}">
					${currentRowObject.supplierName}
                  </div>
				</jdf:column>
				<jdf:column property="commissioned" title="联络人" headerStyle="width:40%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setSuppliers(){
		var suppliers = getCheckedValuesString($("input[name='schk']")).split(",");
		var supplierDiv = $(window.parent.document).find("div[id='${inputName}']");
		var count = $("#${inputName}",window.parent.document).children().length;
		for(var i in suppliers){
			var supplier = suppliers[i].split("-");
			supplierDiv.html(supplierDiv.html()+'<div class="col-sm-12 col-md-12" id="${inputName}'+count+'"><div class="form-group">'+
					'<div class="col-sm-8"><input type="hidden" class="search-form-control" name="productShieldForm.${inputName}['+count+'].objectId" value="'+supplier[0]+'"/>'+
					'<input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.${inputName}['+count+'].supplierName" value="'+supplier[1]+'"/>'+
					'</div><div class="col-sm-4"><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></div></div></div>');
			count = count+1;
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>