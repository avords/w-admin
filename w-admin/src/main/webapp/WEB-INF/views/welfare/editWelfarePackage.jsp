<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="ajaxfileupload.js" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<title>新增&编辑-套餐</title>

<style>
.required-span{
	color:red;
}
 
#productList .form-group>span  {
  height: 27px;
  display: inline-block;
  margin-top: 6px;
}
.col-sm-9{
	white-space: nowrap;
}
 
</style>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">套餐        
            <c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                   <c:otherwise>
                                                                编辑
                </c:otherwise>                      
           </c:choose>
            </h4>
		</div>
			<form method="post" action=""   id="WelfarePackage" class="form-horizontal"  onsubmit="javascript:return subForm();">
				<input type="hidden" name="objectId">
				<input type="hidden" name="packageNo">
				<input type="hidden" name="itemName" id="itemName">
				<input type="hidden" name="stockType">
				<input type="hidden" name="immediatelyEffectStatus" id="immediatelyEffectStatus">
				<input type="hidden" name="packageStock">
				<input type="hidden" name="status">
				<input type="hidden" name="packageImgUrl"  id="packageImgUrl">
				<input type="hidden" name="reserveproductIdArray"  id="reserveproductIdArray">
				<input type="hidden" name="productIdArray"  id="productIdArray">
                <input type="hidden" name="packagePrice"  id="packagePrice">
				<input type="hidden" name="recomcount"  id="recomcount">
				<input type="hidden" name="welfareType"  id="welfareType" value="0">
				<input type="hidden" name="startDate"  id="startDate"> 
				<input type="hidden" name="index" id="index" value="0">
				<input type="hidden" name="priorityTonoArray" id="priorityTonoArray">
				<input type="hidden" name="sPriorityTonoArray" id="sPriorityTonoArray">
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label  for="itemType" class="col-sm-3 control-label">项目类型</label>
										<div class="col-sm-3">
											<select class="search-form-control" name="itemType" id="itemTypes">
												<option value=""></option>
												<jdf:select dictionaryId="1600" valid="true" />
											</select>
										</div>
									<label  for="bigItemId"  class="col-sm-3 control-label">项目大类</label>
									<div class="col-sm-3">
										<select name="bigItemId" class="search-form-control"  id="bigItems">
											<option value=""></option>
										</select>
									</div>	
								</div>	
						</div>
						<div class="col-sm-6 col-md-6">
								<div class="form-group">
										<label for="subItemId"  class="col-sm-3 control-label">项目分类</label>
										<div class="col-sm-3">
											<select name="subItemId"  id="subItems" class="search-form-control">
												<option value=""></option>
											</select>
										</div>	
										<label  class="col-sm-3 control-label">套餐编号：</label>
										<span class="lable-span">${entity.packageNo } </span>
								</div>
							</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label for="packageName"  class="col-sm-3 control-label">套餐名称</label>
										<div class="col-sm-9">
											<input type="text"  class="search-form-control"  name="packageName"  id="packageName">
										</div>	
									</div>
						</div>
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label for="wpCategoryType"   class="col-sm-3 control-label">套餐类型</label>
										<div class="col-sm-4">
											<select name="wpCategoryType" class="search-form-control"  id="wpCategoryTypes">
												<option value=""></option>
												<jdf:select dictionaryId="1602" valid="true" />
											</select>
										</div>	
										<div class="col-sm-5">
											<select name="wpCategoryId" onchange="javascript:setPackagePrice(this);" class="search-form-control"  id="wpCategoryIds">
												<option value=""></option>
											</select>
										</div>	
									</div>	
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
										<div class="form-group">
											<label class="col-sm-3 control-label">套餐库存<span class="required-span">*</span></label>
											<div class="col-sm-9">
												<input type="checkbox"   name="realStockType"  id="StockType1"  value="1" ><label for="StockType1">实体兑换券</label>
												<input type="text"  name="realStock" id="realStock"  size="6">
											 	<br/>
												<input type="checkbox"   name="virtualStockType"  id="StockType2"  value="2"   ><label  for="StockType2">电子兑换券</label>
												<input type="text"  name="virtualStock" id="virtualStock" size="6" >
											</div>
										</div>
						</div>
					</div>
					<div class="row">
									<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label  class="col-sm-3 control-label">套餐主图<span class="required-span">*：</span></label>
													<div class="col-sm-9">
														<img   id="showPackageImg" style="width: 160px;height: 160px;" src="${dynamicDomain}${entity.packageImgUrl}">
					                                    <input type="file" name="uploadFile"  id="uploadFile"  style="display: inline;">
					                                    <input type="button" value="裁剪图片" onclick="ajaxFileUpload1();" id="uploadButton1">
					                                    <input type="button" value="默认上传" onclick="ajaxFileUpload2();" id="uploadButton2">
													</div>
												</div>
									</div>
					</div>	
					<div class="row">
						<div class="col-sm-6 col-md-6">
								<input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-3 control-label">可销售区域<span class="required-span">*：</span></label>
                                    <div class="col-sm-8">
                                      <textarea class="form-control" name="areaNames" id="areaNames" rows="4"  cols="100" disabled="disabled">${sellAreaNames}</textarea>
                                    </div>
                                    <div class="col-sm-1">
                                      <a href="${dynamicDomain}/area/searchMultipleCity?selectedIds=${sellAreas }&areaIds=areaIds&areaNames=areaNames&ajax=1"  class="colorbox-define">
                                          <button type="button" class="btn btn-primary">选择</button>
                                      </a>
                                    </div>
                                </div>
	                            <div class="col-sm-12 col-md-12">
	                                <div class="form-group">
	                                        <label for="logo"  class="col-sm-2 control-label"></label>
	                                    <div class="col-sm-6" id="countrywide">
	                                    	全国<input type="checkbox" id="isCountrywide" value="2" onclick="allCountry();">
	                                    </div>
	                                </div>
	                            </div>                                		
						</div>
					</div>
					<div class="row" style="display:none" id="recommendProductDiv">
							<div class="col-sm-6 col-md-6">
											<div class="form-group">
												<div class="col-sm-3">
													<a id="recommendProduct"  href=""  onclick="mustchooseWpType()"
														class="pull-left btn btn-primary colorbox-double-template">选择推荐商品<span class="required-span">*</span>
													</a>
												</div>
											</div>
							</div>
					</div>
					
					
					<div id="productList">
						<c:forEach items="${products }" var="skuPublish" varStatus="num">
									<div class="row">
										<div class="col-sm-3 col-md-3">
											<div class="row">
												<div class="form-group">
													<label class="col-sm-3 control-label">推荐商品${num.index+1 }：</label>
													<div class="col-sm-9">
														<img id="showPackageImg" style="width: 120px;height: 90px;" src="${dynamicDomain}${skuPublish.product.mainPicture}">
													</div>
												</div>
											</div>
										</div>	
										<div class="col-sm-9 col-md-9">
											<div class="row">
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品标题：</label>
														<span>${skuPublish.name }</span>
													</div>
												</div>
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">优先级：</label>
														 <div class="col-sm-2">
                                       						<input type="text" class="form-control sortNoVerify" name="productPriority" id="productPriority${num.index }" value="${skuPublish.priority }" >
                                   						 </div>
													</div>
												</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品ID：</label>
														<span>${skuPublish.objectId }</span>
													</div>
												</div>
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
														<label class="col-sm-3 control-label">商品编号：</label>
														<span>${skuPublish.skuNo }</span>
														</div>
													</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">市场价：</label>
														<span>${skuPublish.marketPrice }</span>
													</div>
												</div>
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
														<label class="col-sm-3 control-label">销售价：</label>
														<span>${skuPublish.sellPrice }</span>
														</div>
													</div>
											</div>
										</div>
							</div>
						</c:forEach>
					</div>
					
					<div class="row">
							<div class="col-sm-6 col-md-6">
											<div class="form-group">
												<div class="col-sm-3">
													<a href="${dynamicDomain}/welfarePackage/wpProductAddTemplate?ajax=1&reserveCount=5"
														class="pull-left btn btn-primary colorbox-double-template">选择备选商品
													</a>
												</div>
											</div>
							</div>
					</div>
					
					
					<div id="reserveProductList">
							<c:forEach items="${reserveProducts }" var="skuPublish" varStatus="num">
									<div class="row">
										<div class="col-sm-6 col-md-6">
											<div class="row">
												<div class="form-group">
													<label class="col-sm-3 control-label">备选商品${num.index+1 }：</label>
													<div class="col-sm-9">
														<img   id="showPackageImg" style="width: 120px;height: 90px;" src="${dynamicDomain}${skuPublish.product.mainPicture}">
													</div>
												</div>
											</div>
										</div>	
										<div class="col-sm-6 col-md-6">
											<div class="row">
												<div class="col-sm-12 col-md-12">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品标题：</label>
														<span>${skuPublish.name }</span>
													</div>
												</div>
											</div>	
											<div class="row">
													<div class="col-sm-12 col-md-12">
														<div class="form-group">
															<label class="col-sm-3 control-label">优先级：</label>
															<div class="col-sm-2">
                                        						<input type="text" class="form-control sortNoVerify" name="sProductPriority" id="sProductPriority${num.index }" value="${skuPublish.priority }" >
                                    						 </div>
														</div>
													</div>
											</div>
											<div class="row">
													<div class="col-sm-12 col-md-12">
														<div class="form-group">
															<label class="col-sm-3 control-label">市场价：</label>
															<span>${skuPublish.marketPrice }</span>
														</div>
													</div>
											</div>
											<div class="row">
													<div class="col-sm-12 col-md-12">
														<div class="form-group">
														<label class="col-sm-3 control-label">销售价：</label>
														<span>${skuPublish.sellPrice }</span>
														</div>
													</div>
											</div>
										</div>
							</div>
						</c:forEach>
					</div>
					
					<div class="row">
							<div class="col-sm-6 col-md-9">
											<div class="form-group">
												<label class="col-sm-2 control-label">套餐说明<span class="required-span">：</span></label>
												<!-- <div class="col-sm-9">
													<textarea rows="10"  cols="65" name="packageExplain" id="packageExplain"></textarea>
												</div> -->
												<div class="col-sm-10">
			                                        <textarea style="width:10px;height: 10px;" name="packageExplain" id="packageExplain"></textarea>
				                                    <script type="text/javascript">
			                                     	window.onload = function(){
			                                     		try{
			                                     			CKEDITOR.replace( 'packageExplain',{
			                                     				height:200,
			             	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadNewsNotify?ajax=1"
			             	                                });
			                                     		}catch(ex){
			                                     			//window.console && console.log(ex);
			                                     		}
			         	                                
			         	                            };
			                               		 	</script>
			                                    </div>
											</div>
							</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label  for="priority" class="col-sm-3 control-label">优先级</label>
										<div class="col-sm-2">
											<input type="text"  class="search-form-control sortNoVerify"  name="priority"  id="priority">
										</div>	
										<label for="immediatelyEffect" class="col-sm-3 control-label">立即生效</label>
										<div class="col-sm-4">
											<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect1" value=1>是
											<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect2" value=2>否
										</div>
									</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="endDate" class="col-sm-3 control-label">有效期</label>
								<div class="col-sm-4">
									<input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="frontDate" name="frontDate" size="14" class="Wdate required" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:false})">
								</div>
								<div class="col-sm-4">
									<input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'frontDate\')}',readOnly:false})">
								</div>	
							</div>
						</div>
					</div>
								
					<div class="row">
						<div class="editPageButton">
							<button type="submit"   class="btn btn-primary"  validateMethod="subForm();">提交</button>
						</div>
					</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfarePackage" />
<script type="text/javascript">
/**
 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
 */
function getUpdateColumnString(columnItem, split) {
	
	var checkItem = document.getElementsByName("productPriority");
	
	if (split == null) {
		split = ",";
	}
	str = "";
	for (var i = 0; i < checkItem.length; i++) {
		/* if (checkItem[i].checked == true) {
			str = appendSplit(str, columnItem[i].value, split);
		} */
		str = appendSplit(str, columnItem[i].value, split);	
	}
	if (str == "") {
		return null;
	}
	return str;
}


function getpUpdateColumnString(columnItem, split) {
	
	var checkItem = document.getElementsByName("sProductPriority");
	
	if (split == null) {
		split = ",";
	}
	str = "";
	for (var i = 0; i < checkItem.length; i++) {
		/* if (checkItem[i].checked == true) {
			str = appendSplit(str, columnItem[i].value, split);
		} */
		str = appendSplit(str, columnItem[i].value, split);	
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
	var isInit = true;
	function mustchooseWpType(){
		if($("#recommendProduct").attr('href')==""){
			alert("请先选择套餐类型，再选择商品");
			$("#recommendProduct").attr('class','pull-left btn btn-primary');
		}
	}

	function subForm(){
		var bool = true;
		$.each($('input[name="productPriority"]'),function(){
			if( (typeof ($(this).val()) === 'undefined' || $(this).val() == '')){
				bool=false;
				$(this).focus();
				alert("请添加商品排序顺序");
				return false;
			}
		});
		$.each($('input[name="sProductPriority"]'),function(){
			if( (typeof ($(this).val()) === 'undefined' || $(this).val() == '')){
				bool=false;
				$(this).focus();
				alert("请添加备选商品排序顺序");
				return false;
			}
		});
		if(!bool){
			return false;
		}
		$("#startDate").val($("#frontDate").val());
		$("#itemName").val($("#itemTypes").find("option:selected").text()+"-"+$("#bigItems").find("option:selected").text()+"-"+$("#subItems").find("option:selected").text());
		$("#WelfarePackage").attr("action","${dynamicDomain}/welfarePackage/saveToPage") ;
		var realStockType = document.getElementsByName("realStockType");
		var virtualStockType = document.getElementsByName("virtualStockType");
		var virtualStock = $("#virtualStock").val();
		var realStock = $("#realStock").val();
		$("#priorityTonoArray").val(getUpdateColumnString(document.getElementsByName("productPriority")));
		$("#sPriorityTonoArray").val(getpUpdateColumnString(document.getElementsByName("sProductPriority")));
		if(realStockType == "" && virtualStockType == ""){
			alert("请选择库存！");
			return false;
		}
		if(virtualStock == "" && realStock == "" ){
			alert("请选择库存！");
			return false;
		}
		
		
		
		if($("#productIdArray").val()!=""){
			var strpros = $("#productIdArray").val();
			var strcuted = strpros.split(",");
			if(parseInt($("#recomcount").val())!=strcuted.length){
				alert("请选择符合套餐数量的推荐套餐！");
				return false;
			}
		}else{
			alert("请选择推荐商品");
			return false;
		}
		
		var packageName = $("#packageName").val();
		packageName = $.trim(packageName);
		var len = mixLenCheck(packageName);
		if(len > 100){
			alert('套餐名称过长');
			return false;
		}
		
		/* var packageExplain = $.trim($('#packageExplain').val());
		if(!packageExplain.length){
			alert('请填写套餐说明！');
			return false;
		} */
		if($("#areaIds").val()!=""){
			if($("#productIdArray").val()!=""){
	            	return true;
			}else{
				alert("请选择推荐商品");
				return false;
			}
		}else{
			alert("请选择套餐销售区域");
			return false;
		}
		
		/*
		var priority =  $.trim($('#priority').val());
		if(!priority.length){
			alert('请填写优先级！');
			return false;
		}
		*/
	}
	
	$(document).ready(function () {
			 if("${entity.objectId}"!=""){
				 if ("${entity.stockType}"==1){
					$("#StockType1").attr("checked",true);
					$("#realStock").val("${entity.packageStock}");
					$("#realStockType") .val(1);
				 }
				 if ("${entity.stockType}"==2){
					$("#StockType2").attr("checked",true);
					$("#virtualStock").val("${entity.packageStock}");
					 $("#virtualStockType") .val(2);
				 }
				 if("${entity.status}"==2){
					 $("#StockType1").attr("disabled","disabled");
					 $("#StockType2").attr("disabled","disabled");
					 $("#immediatelyEffect1").attr("disabled","disabled");
					 $("#immediatelyEffect2").attr("disabled","disabled");
				 }else{
					 $("#StockType1").attr("disabled","disabled");
					 $("#StockType2").attr("disabled","disabled");
				 }
			 }else{
			 }
			if("${entity.immediatelyEffect}"==1){
				$("#immediatelyEffect1").attr("checked","checked");
				$("#immediatelyEffectStatus").val(1);
				$("#frontDate").attr("disabled","disabled");
				//$("#startDate").attr("readonly","readonly");
			}else if("${entity.immediatelyEffect}"==2){
				$("#immediatelyEffectStatus").val(2);
				$("#immediatelyEffect2").attr("checked","checked");
			}
			
			$("#immediatelyEffect1").click(function(){
				$("#frontDate").attr("disabled","disabled");
				//$("#startDate").attr("readonly","readonly");
				var datetime = new Date();
				var year = datetime.getFullYear();
				var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;  
				var day = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();  
				var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();  
				var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();  
				var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();  
				var currentDate = year + "-" + month + "-" + day+" "+hour+":"+minute+":"+second; 
				$("#startDate").val(currentDate);
				$("#frontDate").val(currentDate);
				$("#endDate").val("");
			});
			$("#immediatelyEffect2").click(function(){
				$("#frontDate").removeAttr("disabled");
				$("#startDate").val($("#frontDate").val());
			});
			
			//项目类型下拉联动大类下拉
	        $("#itemTypes").change(function () {
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#bigItems").empty();
	            	$("#bigItems").append($("<option/>").text("--请选择--"));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=1&itemType="+itemType,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		                          	$("#bigItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			 if("${entity.bigItemId}"!=""){
		            				 $("#bigItems").val("${entity.bigItemId}").change();
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
	            	$("#subItems").append($("<option/>").text("--请选择--"));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=2&itemType="+itemType+"&bigItemId="+bigItemId,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		                          	$("#subItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			  if("${entity.subItemId}"!=""){
			            				 $("#subItems").val("${entity.subItemId}").change();
			            			 }
		            			}
	       	 			});
					}); 
	        
	        //套餐类型下拉联动下属套餐
	        $("#wpCategoryTypes").change(function () {
	        	var	wpCategoryType = $("#wpCategoryTypes").val();
	            //清除二级下拉列表
	            	$("#wpCategoryIds").empty();
	            	$("#wpCategoryIds").append($("<option/>").text("--请选择--"));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getWpCategoryItem?wpCategoryType="+wpCategoryType,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		                          	$("#wpCategoryIds").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].wpCategoryItemName+"</option>");
		            			  }
		            			  if("${entity.wpCategoryId}"!=""){
			            				 $("#wpCategoryIds").val("${entity.wpCategoryId}").change();
			            			 }
		            			}
	       	 			});
					}).change(); 
	        
	        //根据选择的套餐具体类型id，获得推荐商品数目参数
	        $("#wpCategoryIds").change(function () {
	        	var	wpCategoryId = $("#wpCategoryIds").val();
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getRecommendCount?wpCategoryId="+wpCategoryId,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			var 	recommendCount = data.welfarePackageCategory.firstParameter;
		            			 $("#recommendProduct").attr('href','${dynamicDomain}/welfarePackage/wpProductAddTemplate?ajax=1&recommendCount='+recommendCount)	;
		            			 document.getElementById( "recommendProductDiv").style.display= "block";
		            			 $("#recomcount").val(recommendCount);
		            			}
	       	 			});
					}); 
	        

    		
   			 
	});
	
	
	function ajaxFileUpload1(){  
		var filePath = $('#uploadFile').val();
    	if(!filePath) {
            alert('请选择图片！');
            return ;
        }
	    $.ajaxFileUpload({  
	        url: '${dynamicDomain}/welfare/picture/uploadPicture?ajax=1',  
	        secureuri: false,  
	        fileElementId: "uploadFile",    
	        dataType: 'json',  
	        success: function(json, status) {
	            if(json.result =='true'){
	                var filePath = json.filePath;
	                var width = json.width;
	                var height = json.height;
	                var url = '${dynamicDomain}/welfare/picture/welfarePackageImgCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height;
	                $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"80%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
	            }else{
	            	alert(json.message);
	            	return false;
	            }
	        },error: function (data, status, e)//服务器响应失败处理函数
	        {
	            alert(e);
	        }
	    });
	    return false;  
	}
	
	
	//图片上传
	function ajaxFileUpload2(){  
		var filePath = $('#uploadFile').val();
    	if(!filePath) {
            alert('请选择图片！');
            return ;
        }
	    $.ajaxFileUpload({  
	        url: '${dynamicDomain}/welfare/picture/uploadPicture?ajax=1',  
	        secureuri: false,  
	        fileElementId: "uploadFile",    
	        dataType: 'json',  
	        success: function(json, status) {
	            if(json.result =='true'){
	            	var filePath = '${dynamicDomain}' + json.filePath;
					$("#showPackageImg").attr('src', filePath);
					$("#packageImgUrl").val(json.filePath);
	            }else{
	            	alert(json.message);
	            	return false;
	            }
	        },error: function (data, status, e)//服务器响应失败处理函数
	        {
	            alert(e);
	        }
	    });
	    return false;  
	}
		
		$(".colorbox-define").colorbox({
            opacity : 0.2,
            fixed : true,
            width : "65%",
            height : "80%",
            iframe : true,
            onClosed : function() {
                if (false) {
                    location.reload(true);
                }
            },
            overlayClose : false
        });
		function setPackagePrice(dic){
			var price = $("#wpCategoryIds option:selected").text();
			$("#packagePrice").val(price.substring(0,price.indexOf("元")));
		    if(!isInit) 
		    	clearProductDivHtml(); 
		    isInit = false; 
		}
		
		function clearProductDivHtml(){
			$("#productList").empty();
			$("#productIdArray").val('');
			
			$("#reserveProductList").empty();
			$("#reserveproductIdArray").val('');
		}
		
		function del(divid,id){
			$("#"+divid).remove();
			var str = $("#productIdArray").val();
			var regx = new RegExp(',?'+id);
			var str1 = str.replace(regx, "");
			str1 = str1.replace(/^,/, "");
			$("#productIdArray").val(str1);
		}
		
		function delRev(divid,id){
			$("#"+divid).remove();
			var str = $("#reserveproductIdArray").val();
			var regx = new RegExp(',?'+id);
			var str1 = str.replace(regx, "");
			str1 = str1.replace(/^,/, "");
			$("#reserveproductIdArray").val(str1);
		}
		
		function allCountry(){
			var allcounbox = $("#isCountrywide");
			if(allcounbox.val()==1){
				$("#areaIds").attr("value","");
				$("#areaNames").attr("value","");
				allcounbox.val('2');
				return true;
			}
			if(allcounbox.val()==2){
	        	$.ajax({
	   				url : "${dynamicDomain}/area/defaultAllCity?ajax=1",
	   				type : 'post',
	   				dataType : 'json',
	   				success : function(citys) {
	   					if(citys.length > 0){
	   						var ids = "";
	   						var names = "";
	   						for ( var j = 0; j < citys.length; j++) {
	   							var city = citys[j];
	   								ids += city.areaCode + ",";
	   								names += city.name + ",";   					
	   						}
	   						$("#areaIds").val(ids);
	   						$("#areaNames").val("全国");
	   					}else{
	   						alert("获取全国地区失败！");
	   					}
	   				}
	   			});
	        	allcounbox.val('1');
			}

			
			     
		}
		 
</script>
</body>
</html>