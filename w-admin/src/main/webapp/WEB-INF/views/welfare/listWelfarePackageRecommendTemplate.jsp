<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>推荐套餐管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				推荐套餐管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfarePackage/welfarePackageRecommendTemplate?ajax=1&inputName=${inputName}" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">项目类型:</label>
										<div class="col-sm-8">
											<select class="search-form-control" name="itemTypes" id="itemTypes">
												<option value="">—全部—</option>
												<jdf:select dictionaryId="1600" valid="true" />
											</select>
										</div>
								</div>
							</div>	
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label for="search_EQI_bigItemId"   class="col-sm-4 control-label">项目大类:</label>
									<div class="col-sm-8">
										<select name="search_EQI_bigItemId" class="search-form-control"  id="bigItems">
											<option value="">—全部—</option>
											<jdf:selectCollection items="bigItems" optionValue="objectId"  optionText="itemName" />
										</select>
									</div>	
								</div>
							</div>
							<div class="col-sm-4  col-md-4">
								<div class="form-group">
									<label for="search_EQI_subItemId"  class="col-sm-4 control-label">项目分类:</label>
									<div class="col-sm-8">
										<select name="search_EQI_subItemId"  id="subItems" class="search-form-control">
											<option value="">—全部—</option>
										</select>
									</div>	
								</div>
							</div>
					</div>	
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">套餐类型:</label>
									<div class="col-sm-8">
										<select  name="search_EQI_wpCategoryType" class="search-form-control">
											<option value="">—全部—</option>
											<jdf:select dictionaryId="1602" valid="true" />
										</select>
									</div>
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
							<%-- <div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">状态:</label>
									<div class="col-sm-8">
										<select name="search_EQI_status"  class="search-form-control">
											<option value=""></option>
											<jdf:select dictionaryId="111" valid="true" />
										</select>
									</div>
								</div>		
							</div>	 --%>
					</div>	
							
				</div>
				<div class="box-footer">
					<a href="javascript:void(0);" onclick="setWelfarePackages();" class="btn btn-primary pull-left">
						确认
					</a>
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
		sortRowsCallback="limit" action="welfarePackageRecommendTemplate?ajax=1">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 5%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="packageName" title="套餐名称" style="width:15%" />
				<jdf:column property="wpCategoryType" title="套餐类型" style="width:10%" >
					<jdf:columnValue dictionaryId="1602"	value="${currentRowObject.wpCategoryType}" />
				</jdf:column>
				<jdf:column property="stockType" title="商品类型" style="width:10%">
					<jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" style="width:10%" />
				<input type="hidden" id="pacname${currentRowObject.objectId}" value="${currentRowObject.packageName}"/>
				<input type="hidden" id="pacCategoryType${currentRowObject.objectId}" value="${currentRowObject.wpCategoryType}"/>
				<input type="hidden" id="pacImgUrl${currentRowObject.objectId}" value="${currentRowObject.packageImgUrl}"/>
				<input type="hidden" id="pacnameCategoryId${currentRowObject.objectId}" value="${currentRowObject.wpCategoryId}"/>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		function setWelfarePackages(){
			if(getCheckedValuesString($("input[name='schk']"))==null){
	            alert('请选择福利套餐');
	            return false;
	        }
			var products = getCheckedValuesString($("input[name='schk']")).split(",");
			var productDiv = $(window.parent.document).find("div[id='${inputName}']");
			var index = parseInt($(window.parent.document).find("input[id='index']").val());
			var packageBudgetName;
			for(var i in products){
				var product = products[i];
				var pacname = $("#pacname"+product).val();
				var pacCategoryType = $("#pacCategoryType"+product).val();
				var pacImgUrl = $("#pacImgUrl"+product).val();
				var pacnameCategoryId = $("#pacnameCategoryId"+product).val();
				var index_num = parseInt(parseInt(index)+parseInt(i));
				$.ajax(
						{
							url : "${dynamicDomain}/welfarePackageCategory/getWelfarePackageBudget/"+product,
							type : 'post',
							dataType : 'json',
							data:"productName="+pacname,
							async:false,
							success : function(msg)
							{
								if (msg.packageBudget!=null)
								{
									packageBudgetName = msg.packageBudget;
									productDiv.html(productDiv.html()+'<div class="row" id="${inputName}'+index_num+'"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<input type="hidden" name="${inputName}['+index_num+'].productId" value="'+product+'">'+
											'<input type="hidden" name="type" value="1">'+
											'<label class="col-sm-1 control-label"></label>'+
											'<div class="col-sm-3"><img src="${dynamicDomain}'+pacImgUrl+'" width="240px" height="120px;">'+
											'</div><div class="col-sm-8"><div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">商品标题：</label>'+
											'<div class="col-sm-6"><span class="lable-span">'+msg.productName+'</span></div></div></div></div>'+
											'<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">预算等级：</label>'+
											'<div class="col-sm-6"><span class="lable-span">'+packageBudgetName+'</span></div></div></div></div>'+
											'<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">优先级：</label>'+
											'<div class="col-sm-1"><input type="text" name="${inputName}['+index_num+'].priority" value="0" class="order-form-control"></div>'+
											'<div class="col-sm-6"><button type="button" onclick="javascript:deleteProductRecommendDiv(\'${inputName}'+index_num+'\')" class="btn btn-primary">删除</button></div></div></div></div></div></div></div></div>');
									$(window.parent.document).find("input[id='index']").val(parseInt(index)+products.length);
									parent.$.colorbox.close();
								}else{
									productDiv.html(productDiv.html()+'<div class="row" id="${inputName}'+index_num+'"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<input type="hidden" name="${inputName}['+index_num+'].productId" value="'+product+'">'+
											'<input type="hidden" name="type" value="1">'+
											'<label class="col-sm-1 control-label"></label>'+
											'<div class="col-sm-3"><img src="${dynamicDomain}'+pacImgUrl+'" width="240px" height="120px;">'+
											'</div><div class="col-sm-8"><div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">商品标题：</label>'+
											'<div class="col-sm-6"><span class="lable-span">'+msg.productName+'</span></div></div></div></div>'+
											'<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">预算等级：</label>'+
											'<div class="col-sm-6"><span class="lable-span">获取预算等级失败</span></div></div></div></div>'+
											'<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
											'<label for="companyName" class="col-sm-2 product-control-label">优先级：</label>'+
											'<div class="col-sm-1"><input type="text" name="${inputName}['+index_num+'].priority" value="0" class="order-form-control"></div>'+
											'<div class="col-sm-6"><button type="button" onclick="javascript:deleteProductRecommendDiv(\'${inputName}'+index_num+'\')" class="btn btn-primary">删除</button></div></div></div></div></div></div></div></div>');
									$(window.parent.document).find("input[id='index']").val(parseInt(index)+products.length);
									parent.$.colorbox.close();
									}
							}
						});
			}
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