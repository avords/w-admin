<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="ajaxfileupload.js" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<title>查看-套餐</title>

</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">套餐新增/编辑</h4>
		</div>
			<form method="post" action=""   id="WelfarePackage" class="form-horizontal">
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
				
				
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label  class="col-sm-3 control-label">项目类型：</label>
										<div class="col-sm-9">
											<select class="search-form-control" name="itemType" id="itemTypes" disabled>
												<option value=""></option>
												<jdf:select dictionaryId="1600" valid="true" />
											</select>
										</div>
								</div>	
						</div>
					</div>
						
					<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label   class="col-sm-3 control-label">项目大类：</label>
									<div class="col-sm-9">
										<select name="bigItemId" class="search-form-control"  id="bigItems" disabled>
											<option value=""></option>
										</select>
									</div>	
								</div>
							</div>
					</div>
					<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
										<label  class="col-sm-3 control-label">项目分类：</label>
										<div class="col-sm-9">
											<select name="subItemId"  id="subItems" class="search-form-control" disabled>
												<option value=""></option>
											</select>
										</div>	
								</div>
							</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label  class="col-sm-3 control-label">套餐编号：</label>
										<span class="lable-span">${entity.packageNo } </span>
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label  class="col-sm-3 control-label">套餐名称：</label>
										<div class="col-sm-9">
											<input type="text"  class="search-form-control"  name="packageName"  id="packageName" disabled>
										</div>	
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label  class="col-sm-3 control-label">套餐类型：</label>
										<div class="col-sm-4">
											<select name="wpCategoryType" class="search-form-control"  id="wpCategoryTypes" disabled>
												<option value=""></option>
												<jdf:select dictionaryId="1602" valid="true" />
											</select>
										</div>	
										<div class="col-sm-5">
											<select name="wpCategoryId" class="search-form-control"  id="wpCategoryIds" disabled>
												<option value=""></option>
											</select>
										</div>	
									</div>	
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
										<div class="form-group">
											<label class="col-sm-3 control-label">套餐库存：</label>
											<div class="col-sm-8">
												<input type="checkbox"   name="realStockType"  id="StockType1"  value="1" disabled> <label for="StockType1">实体兑换卷</label>
												<input type="text"  name="realStock" id="realStock"  size="6" disabled>
											    <br/>
												<input type="checkbox"   name="virtualStockType"  id="StockType2"  value="2" disabled > <label for="StockType2">电子兑换卷</label>
												<input type="text"  name="virtualStock" id="virtualStock" size="6"  disabled>
											</div>
										</div>
						</div>
					</div>
					<div class="row">
									<div class="col-sm-6 col-md-6">
												<div class="form-group">
													<label  class="col-sm-3 control-label">套餐主图：</label>
													<div class="col-sm-9">
														<img   id="showPackageImg" style="width: 120px;height: 90px;" src="${dynamicDomain}${entity.packageImgUrl}">
<!-- 					                                    <input type="file" name="uploadFile"  id="uploadFile"  style="display: inline;">
 -->					                                   <!--  <input type="button" value="上传" onclick="ajaxFileUpload();" id="uploadButton"> -->
													</div>
												</div>
									</div>
					</div>	
					<div class="row">
						<div class="col-sm-6 col-md-6">
								<input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-3 control-label">可销售区域：</label>
                                    <div class="col-sm-8">
                                      <textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled">${sellAreaNames}</textarea>
                                    </div>
                                    <div class="col-sm-1">
                                    </div>
                                </div>
						</div>
					</div>
					<div class="row">
							<div class="col-sm-6 col-md-6">
											<div class="form-group">
												<div class="col-sm-3">
													<!-- <a id="recommendProduct"  href=""  onclick="mustchooseWpType()"
														class="pull-left btn btn-primary colorbox-double-template">选择推荐商品
													</a> -->
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
														<img   id="showPackageImg" style="width: 120px;height: 90px;"   class="product-image" src="${dynamicDomain}${skuPublish.product.mainPicture}">
													</div>
												</div>
											</div>
										</div>	
										<div class="col-sm-9 col-md-9">
											<div class="row">
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品标题：</label>
														<span class="lable-span">${skuPublish.name }</span>
													</div>
												</div>
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
															<label class="col-sm-3 control-label">优先级：</label>
															<span class="lable-span">${skuPublish.priority }</span>
														</div>
													</div>
											</div>
											<div class="row">
												<div class="col-sm-6 col-md-6">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品ID：</label>
														<span class="lable-span">${skuPublish.objectId }</span>
													</div>
												</div>
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
															<label class="col-sm-3 control-label">商品编号：</label>
															<span class="lable-span">${skuPublish.skuNo }</span>
														</div>
													</div>
											</div>
											<div class="row">
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
															<label class="col-sm-3 control-label">市场价：</label>
															<span class="lable-span">${skuPublish.marketPrice }</span>
														</div>
													</div>
													<div class="col-sm-6 col-md-6">
														<div class="form-group">
														<label class="col-sm-3 control-label">销售价：</label>
														<span class="lable-span">${skuPublish.sellPrice }</span>
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
													<%-- <a href="${dynamicDomain}/welfarePackage/wpProductAddTemplate?ajax=1&reserveCount=5"
														class="pull-left btn btn-primary colorbox-double-template">选择备选商品
													</a> --%>
												</div>
											</div>
							</div>
					</div>
					
					
					<div id="reserveProductList">
							<c:forEach items="${reserveProducts }" var="skuPublish" varStatus="num">
									<div class="row">
										<div class="col-sm-7 col-md-7">
											<div class="row">
												<div class="form-group">
													<label class="col-sm-3 control-label">备选商品${num.index+1 }：</label>
													<div class="col-sm-9">
														<img   id="showPackageImg"  class="product-image" src="${dynamicDomain}${skuPublish.product.mainPicture}">
													</div>
												</div>
											</div>
										</div>	
										<div class="col-sm-5 col-md-5">
											<div class="row">
												<div class="col-sm-12 col-md-12">
													<div class="form-group">
														<label class="col-sm-3 control-label">商品标题：</label>
														<span clss="lable-span">${skuPublish.name }</span>
													</div>
												</div>
											</div>	
											<div class="row">
													<div class="col-sm-12 col-md-12">
														<div class="form-group">
															<label class="col-sm-3 control-label">优先级：</label>
															<span clss="lable-span">${skuPublish.priority }</span>
														</div>
													</div>
											</div>
											<div class="row">
													<div class="col-sm-12 col-md-12">
														<div class="form-group">
															<label class="col-sm-3 control-label">市场价：</label>
															<span clss="lable-span">${skuPublish.marketPrice }</span>
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
												<label class="col-sm-2 control-label">套餐说明：</label>
												<div class="col-sm-9">
		                                        <textarea style="width:300px;height: 10px;" name="packageExplain" id="txt" disabled="disabled"></textarea>
			                                    <script type="text/javascript">
		                                     	window.onload = function(){
		                                     		try{
		                                     			CKEDITOR.replace( 'txt',{
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
										<label class="col-sm-3 control-label">立即生效：</label>
										<div class="col-sm-9">
											<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect1" value=1>是
											<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect2" value=2>否
										</div>
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label   class="col-sm-3 control-label">优先级：</label>
										<div class="col-sm-8">
											<input type="text"  class="search-form-control"  name="priority"  id="priority" disabled>
										</div>	
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label  class="col-sm-3 control-label">有效期：</label>
								<div class="col-sm-4">
									<input   name="startDate" id="startDate" type="text"   onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})"  class="search-form-control" format="yyyy-MM-dd HH:mm:ss" disabled />
								</div>
								<div class="col-sm-4">
									<input  name="endDate"  id="endDate"  type="text"  onclick="WdatePicker({dateFmt: 'yyyy-MM-dd HH:mm:ss'})" class="search-form-control" format="yyyy-MM-dd HH:mm:ss" disabled/>
								</div>	
							</div>
						</div>
					</div>
								
					<div class="row">
						<div class="editPageButton">
						<c:choose>
						    <c:when test="${action!=null }">
						        <a href="${dynamicDomain}${action}">
              <button type="button" class="btn">返回</button>
						    </c:when>
						    <c:otherwise>
						       <a href="${dynamicDomain}/welfarePackage/page">
              <button type="button" class="btn">返回</button>
						    </c:otherwise>
						</c:choose>
							
            </a>
						</div>
					</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfarePackage" />
<script type="text/javascript">

	function mustchooseWpType(){
		if($("#recommendProduct").attr('href')==""){
			alert("请先选择套餐类型，再选择商品");
			$("#recommendProduct").attr('class','pull-left btn btn-primary');
		}
	}

	function subForm(){
		$("#itemName").val($("#itemTypes").find("option:selected").text()+"-"+$("#bigItems").find("option:selected").text()+"-"+$("#subItems").find("option:selected").text());
		$("#WelfarePackage").attr("action","${dynamicDomain}/welfarePackage/saveToPage") ;
		if($("#areaIds").val()!=""){
			if($("#productIdArray").val()!=""){
				var priority = $("#priority").val();
				if(priority!=''&&!/^\d+\.?\d{0,1}$/.test(priority)){
	                alert('优先级必须为整数或1位小数');
	            }else{
	            	$("#WelfarePackage").submit();
	            }
			}else{
				alert("请选择推荐商品");
			}
		}else{
			alert("请选择套餐销售区域");
		}
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
					$("#StockType1").attr("disabled","disabled");
					$("#StockType2").attr("disabled","disabled")
					$("#immediatelyEffect1").attr("disabled","disabled")
					$("#immediatelyEffect2").attr("disabled","disabled")
			 }else{
			 }
			if("${entity.immediatelyEffect}"==1){
				$("#immediatelyEffect1").attr("checked","checked");
				$("#immediatelyEffectStatus").val(1);
				$("#startDate").attr("onclick","");
				$("#startDate").attr("readonly","readonly");
			}else if("${entity.immediatelyEffect}"==2){
				$("#immediatelyEffectStatus").val(2);
				$("#immediatelyEffect2").attr("checked","checked");
			}
			
			$("#immediatelyEffect1").click(function(){
				$("#startDate").attr("onclick","");
				$("#startDate").attr("readonly","readonly");
				var datetime = new Date();
				var year = datetime.getFullYear();
				var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;  
				var day = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();  
				var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();  
				var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();  
				var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();  
				var currentDate = year + "-" + month + "-" + day+" "+hour+":"+minute+":"+second; 
				$("#startDate").val(currentDate);
			})
			//项目类型下拉联动大类下拉
	        $("#itemTypes").change(function () {
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#bigItems").empty();
	            	$("#bigItems").append($("<option/>").text("--请选择--").attr("value","-1"));
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
	            	$("#subItems").append($("<option/>").text("--请选择--").attr("value","-1"));
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
	            	$("#wpCategoryIds").append($("<option/>").text("--请选择--").attr("value","-1"));
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
		            			}
	       	 			});
					}); 
	});
	
	//图片上传
		function ajaxFileUpload(){  
		    $.ajaxFileUpload( {  
		        url: '${dynamicDomain}/welfare/picture/uploadPicture?ajax=1',  
		        secureuri: false,  
		        fileElementId: "uploadFile",  
		        dataType: 'json',  
		        success: function(json, status) {
		            if(json.result){
		                var filePath = json.filePath;
		                var width = json.width;
		                var height = json.height;
		                var url = '${dynamicDomain}/welfare/picture/welfarePackageImgCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height;
		                $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"80%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
		            }
		        },error: function (data, status, e)//服务器响应失败处理函数
		        {
		            alert(e);
		        }
		    }  
		);
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
		setPackagePrice("");
		function setPackagePrice(dic){
			var price = $("#wpCategoryIds option:selected").text();
			$("#packagePrice").val(price.substring(0,price.indexOf("元")));
		}
</script>
</body>
</html>