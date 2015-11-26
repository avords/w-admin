<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增体检套餐</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<jdf:themeFile file="Map.js"/>
<jdf:themeFile file="phyPrice.js"/>
</head>
<body>
	<div>
		<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
				<c:choose>
						<c:when test="${entity.objectId eq null }">新增</c:when>
						<c:otherwise>修改</c:otherwise>
					</c:choose>
					体检套餐
				</h4>
		</div>
		
		<jdf:form bean="entity" scope="request">
		    <form method="post" action="${dynamicDomain}/physicalPackage/savephysicalPackage" class="form-horizontal" id="physicalForm">
		    <input type="hidden" name="objectId">
		    <input type="hidden" name="itemName" id="itemName">
		    <input type="hidden" name="physicalSupplyInfos"  id="physicalSupplyInfos">
		    <input type="hidden" name="packageEntityStock"  id="packageEntityStock">
		    <input type="hidden" name="immediatelyEffectStatus" id="immediatelyEffectStatus">
		    <input type="hidden" name="packageElecStock"  id="packageElecStock">
		    <input type="hidden" name="pkgItem"  id="pkgItem">
		    <input type="hidden" name="status">
		    <input type="hidden" name="welfareType" value="1">
		    <div class="box-body">
		    	<div class="row">
						<div class="col-sm-6 col-md-6">
								<div class="form-group">
									<label for="itemType" class="col-sm-4 control-label">项目类型</label>
										<div class="col-sm-8">
											<select class="search-form-control" name="itemType" id="itemTypes">
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
									<label   for="bigItemId" class="col-sm-4 control-label">项目大类</label>
									<div class="col-sm-8">
										<select name="bigItemId" class="search-form-control required"  id="bigItems">
										</select>
									</div>	
								</div>
							</div>
					</div>
					
					<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="form-group">
										<label   for="subItemId"  class="col-sm-4 control-label">项目分类</label>
										<div class="col-sm-8">
											<select name="subItemId"  id="subItems" class="search-form-control">
												<option value=""></option>
											</select>
										</div>	
								</div>
							</div>
					</div>
					
					<c:choose>
						<c:when test="${entity.objectId eq null }">
							 <input type="hidden" name="packageNo">
						</c:when>
						<c:otherwise>
							<div class="row">
					       	  <div class="col-sm-6 col-md-6">
									<div class="form-group">
										<label for="packageNo" class="col-sm-4 control-label">套餐编号</label>
											 <div class="col-sm-8">
												 <c:choose>
											           <c:when test="${nextNo !=null }">
											         	  	<input type="text" class="search-form-control" name="packageNo" value="${nextNo}" readonly="readonly">
											           </c:when>
											           <c:otherwise>
											            	 <input type="text" class="search-form-control" name="packageNo"  readonly="readonly">	
											           </c:otherwise>
											       </c:choose>
											 </div>
										</div>
								</div>
					       </div>
						</c:otherwise>
					</c:choose>
					
					
		        <div class="row">
		        	<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="packageName" class="col-sm-4 control-label">套餐名称</label>
							<div class="col-sm-8">
							<input type="text" class="search-form-control" name="packageName">
							</div>
							</div>
					</div>
		       </div>
		       
		        <div class="row">
		        	<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="type" class="col-sm-4 control-label">套餐类型</label>
							<div class="col-sm-8">
<%-- 							  <jdf:radio dictionaryId="1607" name="packageType"/> --%>
											<select name="packageType" class="search-form-control"  id="j_packageType" onchange="packageTypeChange(this.value);">
												<jdf:select dictionaryId="1607" valid="true" />
											</select>
							</div>
							</div>
					</div>
		       </div>
		      <div class="row">
		        	<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="packagePrice" class="col-sm-4 control-label">销售价</label>
							<div class="col-sm-8">
							<input type="text" class="search-form-control" name="packagePrice" id="j_packagePrice">
							</div>
							</div>
					</div>
		       </div>
			<div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label class="col-sm-4 control-label">套餐库存</label>
						<div class="col-sm-8">
						<c:choose>
						<c:when test="${entity.objectId eq null }">
						        <input name="stockType" type="checkbox"   value="1" id="physical-stock-type"/><label for="physical-stock-type">实体兑换券</label>
						        <input type="text"  name="packageStock_"  id="packageStock_1" >
						        <br/>
								<input name="stockType" type="checkbox"  id="electical-stock-type"  value="2"/><label for="electical-stock-type">电子兑换券</label>	
								<input type="text"  name="packageStock_" id="packageStock_2" >
						</c:when>
						<c:otherwise>
						       <c:choose>
						           <c:when test="${entity.stockType==1 }">
						           <input name="stockType" type="checkbox"   value="1" id="physical-stock-type"/><label for="physical-stock-type">实体兑换券</label>
						           <input type="text"  name="packageStock"  id="packageStock_1" >
						           </c:when>
						           <c:otherwise>
						            <input name="stockType" type="checkbox" id="electical-stock-type"  value="2"/> <label for="electical-stock-type">电子兑换券</label>
						            <input type="text"  name="packageStock" id="packageStock_2" >	
						           </c:otherwise>
						       </c:choose>
						</c:otherwise>
					  </c:choose>
								
						</div>
					</div>
				</div>
		</div>
        
        
         <input type="hidden" name="packageImgUrl" id="logo">
         <div class="row">
				<div class="col-sm-12 col-md-12" id="picture">
					<div class="form-group">
						<label for="packageImgUrl" class="col-sm-2 control-label">套餐主图</label>
						   <div class="col-sm-10">
                                    <img id="showLogo" width="100px" height="100px"  name="packageImgUrl" src="${dynamicDomain}${entity.packageImgUrl}">
                                    <input type="file" name="uploadFile" id="uploadFile" style="display: inline;"> 
									<input type="button" value="裁剪图片" onclick="ajaxFileUpload();" id="uploadButton">
									<input type="button" value="默认上传" onclick="ajaxFileUpload_direct();" id="uploadButton">
                              </div>
						</div>
			</div> 
	   </div>

	 <div class="row">
				  <div class="col-sm-12 col-md-12">
					<div class="form-group">
						<label for="status" class="col-sm-2 control-label">机构</label>
						<div class="col-sm-10">

						  <table>
							  <c:forEach items="${supplierList}" var="supplier" varStatus="status"  >
										<tr>
											<td>
												<table>
													<tr>
														<td width="190px;">
															<input name="tjOrg" type="checkbox"   value="${supplier. supplierName}_${supplier. objectId}" 
												   			<c:if test="${not empty psList}">
												   				<c:forEach items="${psList }" var="psl" varStatus="i">
															    	<c:if test="${supplier.objectId==psl.supplierId}">checked="checked" </c:if> 
												       			</c:forEach>
												   			</c:if>
												    	 />
												   		${supplier. supplierName}
														</td>
													</tr>
												</table>
											</td>
										</tr>
							</c:forEach> 
						</table>
						
						
						  <%-- 
						  <table>
							  <c:forEach items="${supplierList}" var="supplier" varStatus="status"  >
									<c:choose>
										<c:when test="${(status.index)%3==0 && status.index==0}">	 
												<tr><td>
												<table>
													<tr>
														<td width="120px;">
															<input name="tjOrg" type="checkbox"   value="${supplier. supplierName}_${supplier. objectId}" 
												   		<c:if test="${not empty psList}">
												   			<c:forEach items="${psList }" var="psl" varStatus="i">
															    	<c:if test="${supplier.objectId==psl.supplierId}">checked="checked" </c:if> 
												       		</c:forEach>
												   		</c:if>
												     />
												   		${supplier. supplierName}
														</td>
														<td width="160px;">
															<input name="supplierCode_${supplier. objectId}" type="text" />
														</td>
													</tr>
												</table>
												</td>
										</c:when>
										<c:when test="${(status.index)%3==0 && status.index!=0}">	 
												</tr><tr><td>
														<table>
													<tr>
														<td width="120px;">
															<input name="tjOrg" type="checkbox"   value="${supplier. supplierName}_${supplier. objectId}" 
												   		<c:if test="${not empty psList}">
												   			<c:forEach items="${psList }" var="psl" varStatus="i">
															    	<c:if test="${supplier.objectId==psl.supplierId}">checked="checked" </c:if> 
												       		</c:forEach>
												   		</c:if>
												     />
												   		${supplier. supplierName}
														</td>
														<td width="160px;">
															<input name="supplierCode_${supplier. objectId}" type="text" />
														</td>
													</tr>
												</table>
												</td>
												<c:if test="${(fn:length(atts))==(status.index+1) && (status.index+1)%2!=0}">
													<td></td><td></td></tr>
												</c:if>
										</c:when>
										<c:when test="${(status.index)%3!=0}">
												<td>
														<table>
													<tr>
														<td width="120px;">
															<input name="tjOrg" type="checkbox"   value="${supplier. supplierName}_${supplier. objectId}" 
												   		<c:if test="${not empty psList}">
												   			<c:forEach items="${psList }" var="psl" varStatus="i">
															    	<c:if test="${supplier.objectId==psl.supplierId}">checked="checked" </c:if> 
												       		</c:forEach>
												   		</c:if>
												     />
												   		${supplier. supplierName}
														</td>
														<td width="160px;">
															<input name="supplierCode_${supplier. objectId}" type="text" />
														</td>
													</tr>
												</table>
												</td>
												<c:if test="${(fn:length(atts))==(status.index+1) && (status.index+1)%2==0}">
													<td></td></tr
												</c:if>
										</c:when>
									 	<c:otherwise>
										</c:otherwise>
								    </c:choose>		
							</c:forEach> 
						</table>--%>
						</div>
					</div>
				</div>
				
		</div>
		
		 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">选择体检项目</label>
					       <a href="javascript:void(0);" id="selPhyItem" class="btn btn-primary" onclick="doSelPhyItem();">选择  </a>
					</div>
				</div>
		</div>
		
		<div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label class="col-sm-4 control-label"></label>
					      <div id="editDiv"  class="col-sm-8">
					      	<div style="width: 755px;">
				             <table  border="0" cellspacing="0" cellpadding="0" class="table table-bordered" width="100%">
				                 <thead>
									 <tr style="background-color: rgb(221,221,221);">
									<td class="tableHeader" >优先级</td>
									<td class="tableHeader" >一级项目名称</td>
									<td class="tableHeader" >二级项目名称</td>
									<td class="tableHeader" >男性</td>
									<td class="tableHeader" >女已婚</td>
									<td class="tableHeader" >女未婚</td>
									<td class="tableHeader" >操作</td>
									</tr>
								</thead>
								 <tbody class="tableBody" id="item_table" >
								 </tbody>
				          </table>
				          </div>
					</div>
					</div>
				</div>
		</div>
		 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="packageContent" class="col-sm-4 control-label">供应商价格</label>
						<div class="col-sm-8">
								<div id="price_table" style="width: 755px;">
						        </div>
						</div>
					</div>
				</div>
		</div>
		<div class="eXtremeTable"  id="selectItem" style="display: none"></div>
		 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="packageContent" class="col-sm-4 control-label">套餐简介</label>
						<div class="col-sm-8">
							<textarea style="width:900px;height: 200px;" name="packageContent" id="txtEdit"></textarea>
						</div>
					</div>
				</div>
		</div>
		
		<div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label class="col-sm-4 control-label" for="content">使用说明</label>
						<div class="col-sm-8">
							 <textarea style="width:100px;height: 200px;" name="packageExplain" id="packageExplain"></textarea>
                             <script type="text/javascript">
                             try{
                            	 function loadEditor(id,config) {
	                                 var instance = CKEDITOR.instances[id];
	                                 if(instance) {
	                                     CKEDITOR.remove(instance);
	                                 }
	                                 CKEDITOR.replace(id,config);
	                             }
                             	window.onload = function(){
                             		loadEditor('txtEdit',{
                             				height: '200px', 
                             				width: '752px',
                             				filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
                             				});
                             	    loadEditor('packageExplain',{
                             	    	height: '200px', 
                             	    	width: '752px', 
                             	    	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
                             	    });
                                 };
                             }catch(ex){
                            	 alert(ex);
                             }
	                            
                       	 	 </script> 
						</div>
					</div>
				</div>
		</div> 
		 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label" id="immediatelyEffect_lable">是否立即上架</label>
						<div class="col-sm-8">
                            <input type="radio"   name="immediatelyEffect"  id="immediatelyEffect1" value=1>是
							<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect2" value=0>否
                        </div>
					</div>
				</div>
		</div>    
		
	 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">优先级</label>
						<div class="col-sm-8">
								 <input type="text" name="priority">
						</div>
					</div>
				</div>
		</div> 
		
	 <div class="row">
	                           <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="startDate"  class="col-sm-2 control-label">有效期</label>
                                    <div class="col-sm-10">
                                        <input  value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"  type="text" style="width:155px;height:33px;" readonly="readonly" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})">——
                                        <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"  type="text" style="width:155px;height:33px;" readonly="readonly"  id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
	 </div> 
     <div class="box-footer">
			<div class="row">
				<div class="editPageButton">
				
						<button type="button" class="btn btn-primary progressBtn" onclick="doSumbit(this);">
									保存
						</button>
								
								<button type="button" class="btn btn-primary" onclick="cancel();">
									 取消
								</button>
							</div>
								
						</div>
			 </div>
		    </div>
		    </form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfarePackage"/>
	 <script type="text/javascript">
	 function isEmpty(obj){if(obj != null && obj != "" && typeof(obj) != "undefined"){return false;}else{return true;}}
	 
	 var physicalSupplyVoJson = ${physicalSupplyVoJson};
	 //加载供应商编号
	 function loadSupplyCode(){
		 for (var i = 0; i < physicalSupplyVoJson.length; i++) {
			 var physicalSupplyVo = physicalSupplyVoJson[i];
			if(!isEmpty(physicalSupplyVo.girlSupplyCode)){
				if(parseInt(physicalSupplyVo.girlSupplyCode) != 0){
					$("#supplyCode_girl_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.girlSupplyCode);
				}
			}
			if(!isEmpty(physicalSupplyVo.manSupplierCode)){
				if(parseInt(physicalSupplyVo.manSupplierCode) != 0){
					$("#supplyCode_man_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.manSupplierCode);
				}
			}
			if(!isEmpty(physicalSupplyVo.ladySupplyCode)){
				if(parseInt(physicalSupplyVo.ladySupplyCode) != 0){
					$("#supplyCode_lady_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.ladySupplyCode);
				}
			}
		}
	 }
	 function loadwpCategoryData(){
		//项目类型下拉联动大类下拉
	        $("#itemTypes").change(function () {
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#bigItems").empty();
	            	$("#bigItems").append("<option value=\"\"></option>");
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
	 }
	 
	 $(document).ready(function(){
		 loadwpCategoryData();
		 <c:choose>
			<c:when test="${entity.objectId eq null }">
			 $("#editDiv").css("display","none");
			 $("#immediatelyEffectStatus").val(0);
				$("#immediatelyEffect2").attr("checked","checked");
			</c:when>
			  <c:otherwise>
			  $("#editDiv").css("display","block");
			  if("${entity.immediatelyEffect}"==1){
					$("#immediatelyEffect1").attr("checked","checked");
					$("#immediatelyEffectStatus").val(1);
					$("#startDate").attr("onclick","");
					$("#startDate").attr("readonly","readonly");
				}else if("${entity.immediatelyEffect}"==0){
					$("#immediatelyEffectStatus").val(0);
					$("#immediatelyEffect2").attr("checked","checked");
				}
	           </c:otherwise>
	     </c:choose>
      
      
      $("#immediatelyEffect1").click(function(){
			 document.getElementById("startDate").onclick = function() {
				    
				  };
			var datetime = new Date();
			var year = datetime.getFullYear();
			var month = datetime.getMonth() + 1 < 10 ? "0" + (datetime.getMonth() + 1) : datetime.getMonth() + 1;  
			var day = datetime.getDate() < 10 ? "0" + datetime.getDate() : datetime.getDate();  
			var hour = datetime.getHours()< 10 ? "0" + datetime.getHours() : datetime.getHours();  
			var minute = datetime.getMinutes()< 10 ? "0" + datetime.getMinutes() : datetime.getMinutes();  
			var second = datetime.getSeconds()< 10 ? "0" + datetime.getSeconds() : datetime.getSeconds();  
			var currentDate = year + "-" + month + "-" + day+" "+hour+":"+minute+":"+second; 
			$("#startDate").val(currentDate);
			var d1 = $("#startDate").val(),d1 = new Date(d1);
			var d2 = $("#endDate").val(),d2 = new Date(d2);
			if(d1>d2){
				$("#endDate").val('');
			}
		})
		 $("#immediatelyEffect2").click(function(){
			 document.getElementById("startDate").onclick = function() {
				    WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true});
				  };
			$("#startDate").val("");
			$("#endDate").val("");
		})
		
		 if("${entity.packageType}" == '0'){
			  $("#immediatelyEffect_lable").html("是否立即上架");
		  }else if("${entity.packageType}" == '1'){
			  $("#immediatelyEffect_lable").html("是否立即生效");
		  }
      
      		loadSupplyCode();//加载供应商编号
      		
      		childrenWin(null);  // 加载体检项目和价格
		 });
	 
	 reloadParent = false;
	 var checkItems= ${selPhysicalItemStrInfo};
	 function doSumbit(saveBtn){
		 var isSub = true;
		 $("#itemName").val($("#itemTypes").find("option:selected").text()+"-"+$("#bigItems").find("option:selected").text()+"-"+$("#subItems").find("option:selected").text());
		 var priority=0;
		 var  packageEntityStock;
		 var packageElecStock;
		 var packageEntityStockChecked =false;
		 var packageElecStockChecked =false;
		 var price = $("#j_packagePrice").val();
		 if(price  == '' || price == null || typeof(price) == "undefined"){
			 alert("请填写销售价！");
			 return false;
		 }
		 $("input[name='stockType']:checkbox").each(function(){ 
			 if ("checked" == $(this).attr("checked")) { 
				 var packType=$(this).attr('value');
				 if(packType==1){
					 packageEntityStockChecked = true;
					      packageEntityStock=$("#packageStock_1").val();
					      $("#packageEntityStock").val(packageEntityStock);
				 }
				 else  if(packType==2){
					 packageElecStockChecked = true;
					     packageElecStock=$("#packageStock_2").val();
					     $("#packageElecStock").val(packageElecStock);
				 }
			 }
		 });
		 if(packageEntityStockChecked||packageElecStockChecked){//已勾选库存类型
			 if(packageEntityStockChecked){
				 if((packageEntityStock==null  || packageEntityStock=="")){
					 alert("请填写实体兑换券数量");
					 return false;
				 }
			 }
			 if(packageElecStockChecked){
				 if((packageElecStock==null  || packageElecStock=="")){
					 alert("请填写电子兑换券数量");
					 return false;
				 }
			 }
		 }else{
			 alert("请勾选套餐类型，并输入库存数量");
			 return false;
		 }
		 //if((packageEntityStock==null  || packageEntityStock=="") && (packageElecStock==null || packageElecStock=="") ){
	     if(!packageEntityStock && !packageElecStock ){
			  alert('请至少填写一种库存信息！');
			  return false;
		 }
		 
		    var str="";
		    $('input[name="supplyCode"]').each(function(){
                var codeStr = $(this).attr("data-val");
		    	var code=$(this).val();
		    	if(!isEmpty(code)){
		    		codeStr += ("_"+code);
		    		str+=codeStr+"&";
		    	}else{
		    		codeStr += ("_0");
		    		str+=codeStr+"&";
		    	}
                if(code==""|| code==null){
                	//alert("请填写"+tjOrg.split("_")[0]+"套餐编号");
                	// isSub = false;
                }
                });
		    if(str!="" && str!=null){
		    	str=str.substring(0,str.length-1);
		    	$("#physicalSupplyInfos").val(str);
		    }
		    if(!isSub){
		    	return isSub;
		    }
		    var pkgItem="";
			 for(var j=0;j<checkItems.length;j++){
				 if(checkItems[j]!='' && checkItems[j]!=null){
					 var str= new Array(); 
					 str = checkItems[j];					 
					 str = str.split("_");
					 pkgItem+=str[1]+","+str[0]+","+$("#objectid_"+str[0]).val()+"&";
				 }
		    }
           
			 if(pkgItem!="" && pkgItem!=null){
				 pkgItem=pkgItem.substring(0,pkgItem.length-1);
			    	$("#pkgItem").val(pkgItem);
			    }
			 priority = $("input[name='priority']").val();
			  if(priority==""|| priority==null){
              	alert("请填写优先级");
              	return false;
              }
// 		 $(saveBtn).attr({"onclick":""});
		 $('#physicalForm').submit(); 
	 }
	 
	  function cancel(){
		  window.location.href="${dynamicDomain}/physicalPackage/page";
	  }
	  
	  function ShowDailog(PageHref,Title,Height,Width){
		  var dleft =(screen.availHeight-Height)/2;
		  var dtop =(screen.availWidth-Width)/2;
		  window.showModalDialog(PageHref,window,Title,"scrollbars=yes;resizable=no;help=no;status=no;center=yes;dialogTop=25;dialogLeft="+ dleft +";dialogTop="+ dtop +";dialogHeight="+Height+"px;dialogWidth="+Width+"px;");
		  
	  }
	  
	  var win=null;
	  function doSelPhyItem(){
		  var tjOrgs="";
		  var choosedItemIds = "";
		    $('input[name="tjOrg"]:checked').each(function(){
                var tjOrg=$(this).val();
                var supplyId=tjOrg.split("_")[1];
                tjOrgs+=supplyId+",";
            });
		    $('input[name="j_physicalItemId"]').each(function(){
                var physicalItemId=$(this).val();
                choosedItemIds+=physicalItemId+",";
            });
		    if(tjOrgs!="" && tjOrgs!=null){
		    	tjOrgs=tjOrgs.substring(0,tjOrgs.length-1);
		    	 var url="${dynamicDomain}/physicalPackage/selectItem?ajax=1&tjOrgs="+tjOrgs+"&choosedItemIds="+choosedItemIds;
				    document.getElementById("selPhyItem").href = url;
				    $("#selPhyItem").colorbox({
		                opacity : 0.2,
		                fixed : true,
		                width : "920px",
		                height : "60%",
		                iframe : false,
		                onClosed : function() {
		                },
		                title:"",
		                overlayClose : false
		            });
		    }else{
		    	alert('请选择体检机构!');
		    	$("#selPhyItem").removeClass('cboxElement');
		    	$("#selPhyItem").attr('href','javascript:void(0);');
		    	return false;
		    }
	  }
	  
	  var priceStr = "";//套餐价格字符串
	  var choosedItem = ${selPhysicalItemStrInfo};
	  function childrenWin(selectValues){
		  for(var i=0;selectValues&&i<selectValues.length;i++){
			  checkItems.push(selectValues[i]);
		  }	   
		  /*	      
		  if(selectValues != null && selectValues.length >0 ){
			  for ( var i in selectValues) {
				  checkItems.push(selectValues[i]);
				}
		  }		  
		  */
		  priceStr = "";
		  $("#editDiv").css("display","none");
		  $("#selectItem").html('');
		  var tableStr='';
		  for(var j=0;j<checkItems.length;j++){
			  var str= new Array();   
			  str = checkItems[j];	
			 str= str.split("_");
			 tableStr+='<tr class="odd">';
			 tableStr+='<td style="width: 8%;text-align: center;"><input type="text" style="width: 50px;" name="priotry"  id=objectid_'+str[0]+'  value='+(j+1)+'>';
			 tableStr+='<input type="hidden" name="j_physicalItemId" value="'+str[0]+'"></td>';
			 tableStr+=' <td  style="width:30%">'+str[2]+'</td>';
			  tableStr+=' <td style="width:30%">'+str[3]+'</td>';
			  if(str[4]==1){
				  tableStr+=' <td style="width:8%">★</td>';
			  }else{
				  tableStr+=' <td style="width:8%"></td>';
			  }

			  if(str[5]==1){
				  tableStr+=' <td style="width:8%">★</td>';
			  }else{
				  tableStr+=' <td style="width:8%"></td>';
			  }
			  if(str[6]==1){
				  tableStr+=' <td style="width:8%">★</td>';
			  }else{
				  tableStr+=' <td style="width:8%"></td>';
			  }
			  if(str[7] != "" && str[7] != null && typeof(str[7]) != "undefined"){
				  priceStr+=(str[7]+"|");  
			  }
			  tableStr+=' <td style="width:8%"><a href="javascript:void(0)" onclick="removeSel(this,\''+str[0]+'\')" val='+str[0]+'>删除</a></td>';
			 tableStr+=' </tr>';
			 }
		  
		  
		  $("#item_table").html(tableStr);
		  resetPriotry();//重置优先级排序
		  var divStr="";
		  var  priceHtml = "";
		  
		  if(priceStr!= null && priceStr!= ""){
				priceHtml = makePriceHtml(priceStr);
			}
		  divStr+=  "<div id='priceTableDiv'>"+priceHtml+"</div>";
		  $("#price_table").html(divStr);
		  loadSupplyCode();//再次加载供应商编号 把已有的编号赋上
		  $("#editDiv").show();
		  //$("#selPhyItem").colorbox.close();
		  $.colorbox.close();
	  }
	  
	  function resetPriotry(){
		  $('#item_table input[name="priotry"]').each(function(i,priotry){
			  $(priotry).val(i+1);
          });
	  }
	  
	  function makePriceHtml(priceStr){
		  if(endWith("|",priceStr)){
			  priceStr = priceStr.substring(0, priceStr.length-1);
		  }
		  var allSupResMap = makePrice(priceStr);
		  var priceHtml = "<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" class=\"table table-bordered\" width=\"100%\">";
		  allSupResMap.each(function(key,value,index){
			  var supResMap = allSupResMap.get(key);
			  priceHtml+="<tr  style=\"background-color: rgb(221,221,221);\">";
				  priceHtml+="<td colspan='4'>";
				  var supName = "";
				  	if(key != null){
				  		var keyStr = key.split("_");
				  		if(keyStr[1]!=null){
				  			supName  = keyStr[1];
				  		}
				  	}
				  	if(supName != null){
				  		priceHtml+=supName;
				  	}else{
				  		priceHtml+="";
				  	}
				  priceHtml+="</td>";
			  priceHtml+="</tr>";
			  
			  priceHtml+="<tr>";
				  priceHtml+="<td  width='80px;'>";
				  priceHtml+="</td>";
				  priceHtml+="<td  width='80px;'>";
// 				 priceHtml+="男";
					  priceHtml+="<table width='100%'>";
					  priceHtml+="<tr>";
	    			  priceHtml+="<td width='50px;'>男</td>";
		    		  priceHtml+="<td>";
			    	  priceHtml+="<input type='text' name='supplyCode' id='supplyCode_man_"+keyStr[0]+"'  data-val='"+supName+"_"+keyStr[0]+"_man'  value=''/>";
				      priceHtml+="</td>";
				      priceHtml+="</tr>";
				  	  priceHtml+="</table>";
			  	  
				  priceHtml+="</td>";
				  priceHtml+="<td  width='80px;'>";
				  
					  priceHtml+="<table width='100%'>";
					  priceHtml+="<tr>";
	    			  priceHtml+="<td width='50px;'>女未婚</td>";
		    		  priceHtml+="<td>";
			    	  priceHtml+="<input type='text'  name='supplyCode'  id='supplyCode_girl_"+keyStr[0]+"'   data-val='"+supName+"_"+keyStr[0]+"_girl'  value=''/>";
				      priceHtml+="</td>";
				      priceHtml+="</tr>";
				  	  priceHtml+="</table>";
			  	  
				  priceHtml+="</td>";
				  priceHtml+="<td  width='80px;'>";
					  priceHtml+="<table width='100%'>";
					  priceHtml+="<tr>";
	    			  priceHtml+="<td width='50px;'>女已婚</td>";
		    		  priceHtml+="<td>";
			    	  priceHtml+="<input type='text'  name='supplyCode'  id='supplyCode_lady_"+keyStr[0]+"'   data-val='"+supName+"_"+keyStr[0]+"_lady'  value=''/>";
				      priceHtml+="</td>";
				      priceHtml+="</tr>";
				  	  priceHtml+="</table>";
				  priceHtml+="</td>";
		  	priceHtml+="</tr>";
		  	
		  	priceHtml+="<tr>";
			  priceHtml+="<td>";
			  	priceHtml+="门市价";
			  priceHtml+="</td>";
			  priceHtml+="<td>";
			  		var manMsPrice = "";
			  		if(supResMap.get("manResMap") != null){
			  			if(supResMap.get("manResMap").get("msPrice") != null){
			  				manMsPrice =supResMap.get("manResMap").get("msPrice");
				  		}	
			  		}
			 	 	if(manMsPrice != null){
			 	 		priceHtml += manMsPrice;
			 	 	}else{
			 	 		priceHtml += "";
			 	 	}
			  priceHtml+="</td>";
			  priceHtml+="<td>";
				  var felUnmarriedMsPrice = "";
			  		if(supResMap.get("felUnmarriedResMap") != null){
			  			if(supResMap.get("felUnmarriedResMap").get("msPrice") != null){
			  				felUnmarriedMsPrice =supResMap.get("felUnmarriedResMap").get("msPrice");
				  		}	
			  		}
			 	 	if(felUnmarriedMsPrice != null){
			 	 		priceHtml += felUnmarriedMsPrice;
			 	 	}else{
			 	 		priceHtml += "";
			 	 	}
			  priceHtml+="</td>";
			  priceHtml+="<td>";
					  var felMarriedResMsPrice = "";
				  		if(supResMap.get("felMarriedResMap") != null){
				  			if(supResMap.get("felMarriedResMap").get("msPrice") != null){
				  				felMarriedResMsPrice =supResMap.get("felMarriedResMap").get("msPrice");
					  		}	
				  		}
				 	 	if(felMarriedResMsPrice != null){
				 	 		priceHtml += felMarriedResMsPrice;
				 	 	}else{
				 	 		priceHtml += "";
				 	 	}
			  priceHtml+="</td>";
	  	priceHtml+="</tr>";
	  	
	  	priceHtml+="<tr>";
		  priceHtml+="<td>";
		  	priceHtml+="供货价";
		  priceHtml+="</td>";
		  priceHtml+="<td>";
		  		var manMsPrice = "";
		  		if(supResMap.get("manResMap") != null){
		  			if(supResMap.get("manResMap").get("supPrice") != null){
		  				manMsPrice =supResMap.get("manResMap").get("supPrice");
			  		}	
		  		}
		 	 	if(manMsPrice != null){
		 	 		priceHtml += manMsPrice;
		 	 	}else{
		 	 		priceHtml += "";
		 	 	}
		  priceHtml+="</td>";
		  priceHtml+="<td>";
			  var felUnmarriedMsPrice = "";
		  		if(supResMap.get("felUnmarriedResMap") != null){
		  			if(supResMap.get("felUnmarriedResMap").get("supPrice") != null){
		  				felUnmarriedMsPrice =supResMap.get("felUnmarriedResMap").get("supPrice");
			  		}	
		  		}
		 	 	if(felUnmarriedMsPrice != null){
		 	 		priceHtml += felUnmarriedMsPrice;
		 	 	}else{
		 	 		priceHtml += "";
		 	 	}
		  priceHtml+="</td>";
		  priceHtml+="<td>";
				  var felMarriedResMsPrice = "";
			  		if(supResMap.get("felMarriedResMap") != null){
			  			if(supResMap.get("felMarriedResMap").get("supPrice") != null){
			  				felMarriedResMsPrice =supResMap.get("felMarriedResMap").get("supPrice");
				  		}	
			  		}
			 	 	if(felMarriedResMsPrice != null){
			 	 		priceHtml += felMarriedResMsPrice;
			 	 	}else{
			 	 		priceHtml += "";
			 	 	}
		  priceHtml+="</td>";
		priceHtml+="</tr>";
          });
		  priceHtml+="</table>";
		  return priceHtml;
	  }
	  
	  function endWith(str,toStr){
		    	if(str==null||str==""||toStr.length==0||str.length>toStr.length)
		    	  return false;
		    	if(toStr.substring(toStr.length-str.length)==str)
		    	  return true;
		    	else
		    	  return false;
		    	//return true;
	  }
	  
	  
	  
	  function removeSel(obj,toRemoveItemId){
		  var removedStr = "";
		   var val=$(obj).attr("val");
			//只是清空数据
			checkItems = copyDelCheckItems(checkItems,val);			 
			$(obj).parent().parent().remove(); 
			if(toRemoveItemId != null && priceStr != null){
				var prices = priceStr.split("|");
				for (var i = 0; i < prices.length; i++) {
					if(prices[i] != toRemoveItemId){
						if(prices[i] != null && prices[i] != ""){
							if(!startWith(toRemoveItemId+"&", prices[i])){
								removedStr+=(prices[i]+"|");
							}
						}
					}
				}
			}
			priceStr = removedStr;
			var priceHtml = "";
			if(priceStr!= null && priceStr!= ""){
				priceHtml = makePriceHtml(priceStr);
			}
			$("#priceTableDiv").html(priceHtml);
		
	}
	 
	  //删除已选择体检项目
	 function copyDelCheckItems(checkItems,toDel){
		 var res = new Array();
		 for (var i = 0; i < checkItems.length; i++) {
			 if(checkItems[i] != null){
				 var str= new Array();  
				 str = checkItems[i];
				str= str.split("_");
				if(str[0] != toDel){
					res.push(checkItems[i]);
				}
			 }
		}
		 return res;
	 }
	  
	  function closeColorBox(boxId){
		  $("#"+boxId).colorbox().close();
	  }
	  
	  function packageTypeChange(packageType){
		  if(packageType == '0'){
			  $("#immediatelyEffect_lable").html("是否立即上架");
		  }else if(packageType == '1'){
			  $("#immediatelyEffect_lable").html("是否立即生效");
		  }
	  }
	  function ajaxFileUpload() {
			var uploadFileImg = $('#uploadFile').val();
			if(!uploadFileImg){
				alert('请选择图片');
				return false;
			}
			$.ajaxFileUpload({
				url : '${dynamicDomain}/physicalPackage/picture/uploadCutPic?ajax=1&Sheight=400&Swidth=500',
				secureuri : false,
				fileElementId : 'uploadFile',
				dataType : 'json',
				success : function(json, status) {
					if (json.result) {
						var filePath = json.filePath;
						var width = json.width;
						var height = json.height;
						var Swidth = json.Swidth;
						var Sheight = json.Sheight;
						var url = '${dynamicDomain}/physicalPackage/picture/picCrop?ajax=1&filePath='
								+ filePath
								+ "&width="
								+ width
								+ "&height="
								+ height
								+ "&Sheight="
								+ Sheight + "&Swidth=" + Swidth;
						$.colorbox({
							opacity : 0.2,
							href : url,
							fixed : true,
							width : "70%",
							height : "65%",
							iframe : true,
							onClosed : function() {
								if (false) {
									location.reload(true);
								}
							},
							overlayClose : false
						});
					}
				},
				error : function(data, status, e){
					alert("系统异常，请联系管理员！");
				}
			});
			return false;
		}
		
		function ajaxFileUpload_direct() { 
			var uploadFileImg = $('#uploadFile').val();
			if(!uploadFileImg){
				alert('请选择图片');
				return false;
			}
			$.ajaxFileUpload({  
	            url: '${dynamicDomain}/physicalPackage/picture/directUpload?ajax=1',  
	            secureuri: false,  
	            fileElementId: 'uploadFile',  
	            dataType: 'json',  
	            success: function(json, status) {
	                if(json.result){
	                    var filePath = json.filePath;
	                    $('input[name="packageImgUrl"]').val(filePath);
	                    $('#showLogo').attr('src','${dynamicDomain}'+filePath);
	                  /*   $('#uploadButton1').val('重新上传'); */
	                }else{
	                	alert(json.msg);
	                }
		        },error: function (data, status, e){//服务器响应失败处理函数
		           	alert("系统异常，请联系管理员！");
		        }
	        });
			
	  	}
		
</script>
</body>
</html>