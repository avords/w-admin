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
			<form action="${dynamicDomain}/supplierShop/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_shopType" class="col-sm-4 control-label">供应商类型：</label>
								<div class="col-sm-8">
									<select name="search_EQI_shopType" id="search_EQI_shopType" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1314" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQL_supplierId" class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									<select name="search_EQL_supplierId" id="search_EQL_supplierId" class="search-form-control">
							        </select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_shopName" class="col-sm-4 control-label">门店名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_shopName">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">省：</label>
                                <div class="col-sm-8">
                                    <select name="search_LIKES_province" class="search-form-control" id="area1">
                                        <option value="">—全部—</option>
                                        <jdf:selectCollection items="firstArea" optionValue="objectId" optionText="name"/>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">市：</label>
                                <div class="col-sm-8">
                                    <select name="search_LIKES_city" class="search-form-control" id="area2">
                                        <option value="">—全部—</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">区：</label>
                                <div class="col-sm-8">
                                    <select name="search_LIKES_district" class="search-form-control" id="area3">
                                        <option value="">—全部—</option>
                                    </select>
                                </div>
                            </div>
                        </div>
					</div>
					<div class="row">
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
					<a href="${dynamicDomain}/supplierShop/create" class="btn btn-primary pull-left">
						<span class="glyphicon glyphicon-plus"></span>
					</a>
					<button type="button" class="btn btn-primary" id="deleteAll"><i class="glyphicon glyphicon-trash"></i>
					</button>
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this);$('#search_STARTS_areaId').val('')">
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
					<a href="${dynamicDomain}/supplierShop/edit/${currentRowObject.objectId}" class="btn btn-primary btn-mini">
						<i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="supplierName" title="供应商" headerStyle="width:10%;" viewsAllowed="html">
                     ${currentRowObject.supplierName}
				</jdf:column>
				<jdf:column property="areaName" title="所在省市" headerStyle="width:8%;">
					 ${currentRowObject.provinceName}—${currentRowObject.cityName}—${currentRowObject.areaName}
				</jdf:column>
				<jdf:column property="supplierShopNo" title="供应商内部门店代号" headerStyle="width:10%;" />
				<jdf:column property="shopName" title="门店名称" headerStyle="width:10%;" >
                  <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.shopName}">
                  ${currentRowObject.shopName}</div>
                </jdf:column>
				<jdf:column property="address" title="门店地址" headerStyle="width:10%;" />
				<jdf:column property="telephone" title="门店联系电话" headerStyle="width:10%;" />
				<jdf:column property="isValid" title="状态" headerStyle="width:10%;" >
					<jdf:columnValue dictionaryId="1110" value="${currentRowObject.isValid}" />
				</jdf:column>
				<jdf:column property="userName" title="修改人" headerStyle="width:10%;" >
					${currentRowObject.userName}
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
	 		if(confirm("你确定要删除？")){
	 			$("input[name='checkid']:checked").each(function(){
					id+=this.value+",";
				}); 
				var ids=id.substring(0,id.lastIndexOf(","));
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
	 		}
		}else{
			alert("请勾选供应商门店");
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
	<script type="text/javascript">
	$(function(){
		$("#area1").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/advert/getCity/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#area2").children().remove(); 
                        $("#area2").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.citys.length; i++) {
                            $("#area2").append("<option value='" + json.citys[i].areaCode + "'>" + json.citys[i].name + "</option>");
                        }
                        if("${city}"!=""){
           				 $("#area2").val("${city}").change();
           			 }
                    }   
                });
            }
         }).change();
		$("#area2").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/advert/getDistrict/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#area3").children().remove(); 
                        $("#area3").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.districts.length; i++) {
                            $("#area3").append("<option value='" + json.districts[i].areaCode + "'>" + json.districts[i].name + "</option>");
                        }
                        if("${district}"!=""){
           				 $("#area3").val("${district}").change();
           			 }
                    }   
                });
            }
         }).change();

	});
	</script>
</body>
</html>