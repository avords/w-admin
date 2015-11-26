<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>套餐信息</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				套餐信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physicalPackage/physicalPackageAddtionalTemplate?ajax=1&inputName=${inputName}&packageType=${packageType}" method="post"
				class="form-horizontal">
				<div class="box-body">
					 	
					<div class="row">
							 
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
					<a href="javascript:setWelfarePackages();" class="btn btn-primary pull-left"> 确认 </a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit"  
		sortRowsCallback="limit" action="physicalPackageAddtionalTemplate?ajax=1&inputName=${inputName}&packageType=${packageType}">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 5%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" 
							value="${currentRowObject.objectId}-${currentRowObject.packagePrice}-${currentRowObject.packageName}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="packageName" title="套餐名称" style="width:15%" />
				<jdf:column property="packagePrice" title="套餐价格" style="width:10%" />
				<jdf:column property="packageType" title="套餐类型" style="width:10%" >
					<jdf:columnValue dictionaryId="1607" value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="stockType" title="套餐库存" style="width:15%">
					<jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />(${currentRowObject.packageStock})
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" style="width:10%" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	var paramName = '';
	
	<c:choose>
	  <c:when test="${inputName eq 'mainWelfareForms'}">
	     paramName = 'mainPackageId';
	  </c:when>
	  
	  <c:when test="${inputName eq 'addtionalWelfareForms'}">  
	    paramName = 'addPackageId';
	  </c:when>
	</c:choose>
	
		function setWelfarePackages(){
			if(getCheckedValuesString($("input[name='schk']"))==null){
	            alert('请选择套餐');
	            return;
	        }
			
			var products = getCheckedValuesString($("input[name='schk']")).split(",");
			var productDiv = $(window.parent.document).find("div[id='${inputName}']");
			 var packageNames = "";
			
			for(var i in products){
				var product = products[i].split("-");//id-price-name
				var productName = product[2];
				
				packageNames += productName + ",";
				productDiv.html(productDiv.html()+'<div class="row" id="${inputName}'+i+'"><div class="col-sm-12 col-md-12"><div class="form-group">'+
						'<input type="hidden" name="${inputName}['+i+'].'+ paramName +'" value="'+product[0]+'">'+
						'<label class="col-sm-1 control-label"></label>'+
						'<div class="col-sm-8"><div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
						'<label  class="col-sm-2 product-control-label">套餐名：</label>'+
						'<div class="col-sm-4"><span class="lable-span">'+productName+'</span></div> '+
						 
						'<label class="col-sm-2 product-control-label">套餐价格：</label>'+
						'<div class="col-sm-2"><span class="lable-span">'+product[1]+'</span></div> ' +
						'<div class="col-sm-2"><button type="button" onclick="javascript:del(\'${inputName}'+i+'\')" class="btn btn-primary">删除</button></div></div></div></div>'+
						'  </div></div></div></div>');
			}
			
		 
			parent.$.colorbox.close();
		}
		
$(document).ready(function () {
			
			//项目类型下拉联动大类下拉
	        $("#itemTypes").change(function () {
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#bigItems").empty();
	            	$("#bigItems").append($("<option/>").text("—请选择—").attr("value",""));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=1&itemType="+itemType,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		            				//alert(data.items[i].objectId );
		                          	$("#bigItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			  if("${bigItemId}"!=""){
			            				 $("#bigItems").val("${bigItemId}").change();
			            			 }
		            			}
	       	 			});
					}).change(); 
			
	        //大类下拉联动分类下拉
	        $("#bigItems").change(function () {
	        	var	bigItemId = $("#bigItems").val();
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#subItems").empty();
	            	$("#subItems").append($("<option/>").text("—请选择—").attr("value",""));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=2&itemType="+itemType+"&bigItemId="+bigItemId,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		            				//alert(data.items[i].objectId );
		                          	$("#subItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			  if("${subItemId}"!=""){
			            				 $("#subItems").val("${subItemId}").change();
			            			 }
		            			}
	       	 			});
					}); 
			});
	</script>
</body>
</html>