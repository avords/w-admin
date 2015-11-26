<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商门店管理</title>
</head>
<body>
	<div>
	<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				供应商门店管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/vendorSupplierShop/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_shopName" class="col-sm-4 control-label">门店名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_shopName">
								</div>
							</div>
						</div>
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label class="col-sm-2 control-label">门店地址：</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${param.search_STARTS_areaId}" district="search_STARTS_areaId" styleClass="form-control inline"/>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_isValid" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1110" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/vendorSupplierShop/create" class="btn btn-primary pull-left">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
					<button type="button" class="btn btn-primary" id="deleteAll"><i class="glyphicon glyphicon-trash"></i>
					</button>
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
						<button type="submit" class="btn btn-primary">查询
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="supplierShop.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="supplierShop.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox' style='margin-left:9px;;' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 4%;">
					<input type="checkbox" name="checkid" id="checkid" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 8%;text-align:center">
					<a href="${dynamicDomain}/vendorSupplierShop/edit/${currentRowObject.objectId}" class="btn btn-primary btn-mini">
						<i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="areaId" title="所在省市" headerStyle="width:8%;">
				</jdf:column>
				<jdf:column property="supplierShopNo" title="供应商内部门店代号" headerStyle="width:10%;" />
				<jdf:column property="shopName" title="门店名称" headerStyle="width:8%;" />
				<jdf:column property="address" title="门店地址" headerStyle="width:10%;" />
				<jdf:column property="telephone" title="门店联系电话" headerStyle="width:10%;" />
				<jdf:column property="isValid" title="状态" headerStyle="width:10%;" >
					<jdf:columnValue dictionaryId="1110" value="${currentRowObject.isValid}" />
				</jdf:column>
				<jdf:column property="updatedBy" title="修改人" headerStyle="width:10%;" >
					<jdf:columnCollectionValue items="users"  nameProperty="userName" value="${currentRowObject.updatedBy}"/>
				</jdf:column>
				<jdf:column property="updatedOn" cell="date" title="修改时间" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	$("#checkall").click( 
		function(){ 
			if(this.checked){ 
				$("input[name='checkid']").each(function(){this.checked=true;}); 
			}else{ 
				$("input[name='checkid']").each(function(){this.checked=false;}); 
			} 
	});
		
		
	$("#deleteAll").click(function(){ 
        var id="";
	 	if($("input[type='checkbox']").is(':checked')){
			$("input[name='checkid']:checked").each(function(){
				id+=this.value+",";
			}); 
			var ids=id.substring(0,id.lastIndexOf(","));
			alert(ids);
			$.ajax({
                url:"${dynamicDomain}/supplierShop/deleteAll/" + ids,
                type : 'post',
                dataType : 'json',
                success : function(json) {
                	if(json.result){
                		alert("删除成功");
                		window.location.reload(true);
                	}
                }
            });
		}else{
			alert("请勾选供应商");
		} 
	});
	
	$("#search_EQI_shopType").bind("change",function(){
	    if($(this).val()){
	        $.ajax({
	            url:"${dynamicDomain}/supplierShop/getSuppliers/" + $(this).val(),
	            type : 'post',
	            dataType : 'json',
	            success : function(json) {
	                $("#search_EQL_supplierId").children().remove();
	                $("#search_EQL_supplierId").append("<option value=''>—全部—</option>");
	                for ( var i = 0; i < json.suppliers.length; i++) {
	                    $("#search_EQL_supplierId").append("<option value='" + json.suppliers[i].objectId + "'>" + json.suppliers[i].supplierName + "</option>");
	                }
	                $("#search_EQL_supplierId").val('${supplier.objectId}');
	            }
	        });
	    }
	}).change();
	</script>
</body>
</html>