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
			<form action="${dynamicDomain}/supplierShop/getSupplierShop?ajax=1" method="post" class="form-horizontal">
			<input type="hidden" name="objectIdArray" id="objectIdArray">
			<input type="hidden" name="supplierId" id="supplierId">
				<div class="box-body">
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
						
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="saveShop();">保存选中门店</button>
					</div>
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
					<input type="checkbox" name="checkid" id="checkid"  value="${currentRowObject.objectId}-${currentRowObject.shopName}">
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="supplierId" title="供应商" headerStyle="width:10%;" >
					<a href="${dynamicDomain}/supplier/view/${currentRowObject.supplierId}" >
					<font style="font-size:14px;color:blue;text-decoration: underline;"><jdf:columnCollectionValue items="suppliers"  nameProperty="supplierName" value="${currentRowObject.supplierId}"/></font></a>
				</jdf:column>
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
	function saveShop(){
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("checkid")));
		if($("#objectIdArray").val() == ""){

		}
		else{
			//$("#physicalReport").submit();
			var companies = getCheckedValuesString($("input[name='checkid']")).split(",");
			var companyDiv = $(window.parent.document).find("div[id='shopNameList']");
			var count = $("#shopNameList",window.parent.document).children().length;
			companyDiv.html("");
			for(var i in companies){
				var company = companies[i].split("-");
				companyDiv.html(companyDiv.html()+'<div class="row"><div class="col-sm-12 col-md-12" id="shopNameList'+count+'"><div class="form-group">'+
						'<div class="col-sm-6"><input type="hidden" class="search-form-control" name="shopId" value="'+company[0]+'"/>'+
						'<input type="hidden" class="search-form-control" name="shopName" value="'+company[1]+'"/>'+
						'<label class="col-sm-6 control-label">'+company[1]+'</label>'+
						'</div></div></div></div>');
			    count = count+1;
			}
			parent.$.colorbox.close();
		}
				
		/* $("#physicalReport").submit();   */
	}
		/**
		 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
		 */
		function getUpdateColumnString(columnItem, split) {
			var checkItem = document.getElementsByName("checkid");
			if (split == null) {
				split = ",";
			}
			str = "";
			for (var i = 0; i < checkItem.length; i++) {
				if (checkItem[i].checked == true) {
					str = appendSplit(str, columnItem[i].value, split);
				}
					
			}
			if (str == "") {
				return null;
			}
			return str;
		}
		/**
		 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
		 */
		function appendSplit(str, strAppend, split) {
			if (str == null || str == "") {
				return strAppend;
			} else {
				return str + "," + strAppend;
			}
		}
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