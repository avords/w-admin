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
											<select class="search-form-control" name="itemType" id="itemTypes" disabled="disabled">
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
										<select name="bigItemId" class="search-form-control"  id="bigItems" disabled="disabled">
											<option value=""></option>
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
											<select name="subItemId"  id="subItems" class="search-form-control" disabled="disabled">
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
											         	  	<input type="text" class="search-form-control" name="packageNo" value="${nextNo}" disabled="disabled" readonly="readonly">
											           </c:when>
											           <c:otherwise>
											            	 <input type="text" class="search-form-control" name="packageNo" disabled="disabled"  readonly="readonly">	
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
							<input type="text" class="search-form-control" name="packageName" disabled="disabled">
							</div>
							</div>
					</div>
		       </div>
		       <div class="row">
		        	<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="type" class="col-sm-4 control-label">套餐类型</label>
							<div class="col-sm-8">
											<select name="packageType" class="search-form-control"  id="j_packageType"  disabled="disabled">
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
							<input type="text" class="search-form-control" name="packagePrice" disabled="disabled">
							</div>
							</div>
					</div>
		       </div>
			<div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">套餐库存</label>
						<div class="col-sm-8">
						<c:choose>
						<c:when test="${entity.objectId eq null }">
						        <label><input name="stockType" type="checkbox" disabled="disabled"  value="1"/>实体兑换券<input type="text"  name="packageStock"  id="packageStock_1" disabled="disabled"></label>
								<label><input name="stockType" type="checkbox" disabled="disabled"  value="2"/>电子兑换券<input type="text"  name="packageStock" id="packageStock_2" disabled="disabled"></label>	
						</c:when>
						<c:otherwise>
						       <c:choose>
						           <c:when test="${entity.stockType==1 }">
						           <label><input name="stockType" type="checkbox"  disabled="disabled" value="1"/>实体兑换券<input type="text"  name="packageStock"  id="packageStock_1" disabled="disabled"></label>
						           </c:when>
						           <c:otherwise>
						             <label><input name="stockType" type="checkbox" disabled="disabled"  value="2"/>电子兑换券<input type="text"  name="packageStock" id="packageStock_2" disabled="disabled"></label>	
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
						<label for="packageImgUrl" class="col-sm-2 control-label">套餐主图(00px ** 00px)</label>
						   <div class="col-sm-10">
                                    <img id="showLogo" width="100px" height="100px"  name="packageImgUrl" src="${dynamicDomain}${entity.packageImgUrl}">
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
															<input name="tjOrg" type="checkbox" disabled="disabled"  value="${supplier. supplierName}_${supplier. objectId}" 
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
						</div>
					</div>
				</div>
				
		</div>
		<div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">体检项目</label>
					      <div id="editDiv"  class="col-sm-8">
					      	<div id="item_table" style="width: 755px;">
				             <table  border="0" cellspacing="0" cellpadding="0" class="table table-bordered" width="100%">
				                 <thead>
									 <tr>
									<td class="tableHeader" >优先级</td>
									<td class="tableHeader" >一级项目名称</td>
									<td class="tableHeader" >二级项目名称</td>
									<td class="tableHeader" >男性</td>
									<td class="tableHeader" >女未婚</td>
									<td class="tableHeader" >女已婚</td>
								
									</tr>
								</thead>
								
								 <c:forEach items="${piVoList }" var="item" varStatus="num">
								 <tbody class="tableBody">
								   <tr class="odd">
									<td style="width: 10%;text-align: center;">${item.priority}</td>
									<td style="width:30%">${item.firstItemname }</td>
									<td style="width:30%">${item.secondItemName}</td>
									<td style="width:10%"><c:if test="${item.isMan==1}">★</c:if></td>
									<td style="width:10%"><c:if test="${item.isWomanMarried==1}">★</c:if></td>
									<td style="width:10%"><c:if test="${item.isWomanUnmarried==1}">★</c:if></td>
							    </tr>
								 </tbody>
						 </c:forEach>
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
						          <table border="0" cellspacing="0" cellpadding="0" class="table table-bordered" width="100%">
						          <c:forEach items="${spList }" var="spinfo" varStatus="num">
						           <tr >
						           <td colspan="4">${spinfo.supplyName }</td>
						           </tr>
						           <tr>
							           <td width="80px;"></td>
							           <td width="80px;">
								           	<table width="100%">
								           		<tr>
								           			<td width="50px;">男</td>
								           			<td>
								           				<input type="text" disabled="disabled" name="supplyCode" id="supplyCode_man_${spinfo.supplyId}" data-val="${spinfo.supplyName }_${spinfo.supplyId}_man" value=""/>
								           			</td>
								           		</tr>
								           	</table>
							           	</td>
							           <td width="80px;">
							           		<table width="100%">
								           		<tr>
								           			<td width="50px;">女未婚</td>
								           			<td>
									           			<input type="text"  disabled="disabled" name="supplyCode"  id="supplyCode_girl_${spinfo.supplyId}"  data-val="${spinfo.supplyName }_${spinfo.supplyId}_girl" value=""/>
								           			</td>
								           		</tr>
								           	</table>
								       </td>
							           <td width="80px;">
							           		<table width="100%">
								           		<tr>
									           		<td width="50px;">女已婚</td>
									           		<td>
								           				<input type="text"  disabled="disabled" name="supplyCode"  id="supplyCode_lady_${spinfo.supplyId}"  data-val="${spinfo.supplyName }_${spinfo.supplyId}_lady" value=""/>
									           		</td>
								           		</tr>
								           	</table>
								       </td> 
						           </tr>
						            <tr >
						           <td>门市价</td>
						           <td>${spinfo.manMarketPrice }</td>
						           <td>${spinfo.womenUnmarriedMarketPrice}</td>
						           <td>${spinfo.womenMarketPrice}</td> 
						           </tr>
						             <tr >
						           <td>供货价</td>
						           <td>${spinfo.manSupplyPrice}</td>
						           <td>${spinfo.womenUnmarriedSupplyPrice}</td>
						           <td>${spinfo.womenSupplyPrice}</td> 
						           </tr>
						          </c:forEach>
						          </table>
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
	                                	window.onload = function(){
	                                		 CKEDITOR.config.readOnly = true;
	                                		 CKEDITOR.config.toolbarStartupExpanded = false;
	                                		 CKEDITOR.replace( 'txtEdit',{height: '200px', width: '752px', 
			                                     	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
			                                     });
		                                     CKEDITOR.replace( 'packageExplain',{height: '200px', width: '752px', 
		                                     	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
		                                     });
	                                    };
	                          	 	  </script> 
						</div>
					</div>
				</div>
		</div> 
		 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">是否立即上架</label>
						<div class="col-sm-8">
								 <input type="radio"   name="immediatelyEffect"  id="immediatelyEffect1"  disabled="disabled" value=1>是
									<input type="radio"   name="immediatelyEffect"  id="immediatelyEffect2" disabled="disabled" value=0>否
						</div>
					</div>
				</div>
		</div>    
		
	 <div class="row">
				  <div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="status" class="col-sm-4 control-label">优先级</label>
						<div class="col-sm-8">
								 <input type="text" name="priority" disabled="disabled">
						</div>
					</div>
				</div>
		</div> 
		
	 <div class="row">
	                           <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="startDate"  class="col-sm-2 control-label">有效期</label>
                                    <div class="col-sm-10">
                                        <input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"  type="text" style="width:155px;height:33px;" disabled="disabled" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})">——
                                        <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"  type="text" style="width:155px;height:33px;" disabled="disabled" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
	 </div> 
     <div class="box-footer">
			<div class="row">
				<div class="editPageButton">
								<button type="button" class="btn btn-primary" onclick="cancel();">
									 返回
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
				$("#supplyCode_girl_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.girlSupplyCode);
			}
			if(!isEmpty(physicalSupplyVo.manSupplierCode)){
				$("#supplyCode_man_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.manSupplierCode);
			}
			if(!isEmpty(physicalSupplyVo.ladySupplyCode)){
				$("#supplyCode_lady_"+physicalSupplyVo.supplierId).val(physicalSupplyVo.ladySupplyCode);
			}
		}
	 }
	 function loadwpCategoryData(){
		 
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
	 }
	 
	 $(document).ready(function(){
		 //loadSup();
		 loadwpCategoryData();
		 <c:choose>
			<c:when test="${entity.objectId eq null }">
			 $("#editDiv").css("display","none");
			</c:when>
			  <c:otherwise>
			  $("#editDiv").css("display","block");
	           </c:otherwise>
	     </c:choose>
	     
	     <c:if test="${!empty psList}">
		     <c:forEach items="${psList }" var="psl" varStatus="i">
			   $("input[name=supplierCode_"+"${psl.supplierId}"+"]").val("${psl.supplierCode}");
			</c:forEach>
      </c:if>
      if("${entity.immediatelyEffect}"==1){
			$("#immediatelyEffect1").attr("checked","checked");
		}else if("${entity.immediatelyEffect}"==0){
			$("#immediatelyEffect2").attr("checked","checked");
		}
      loadSupplyCode();//加载供应商编号
		 });
	 
	 reloadParent = false;
	 var checkItems=new Array();
	 function doSumbit(){
		 var isSub = true;
		 $("#itemName").val($("#itemTypes").find("option:selected").text()+"-"+$("#bigItems").find("option:selected").text()+"-"+$("#subItems").find("option:selected").text());
		 var priority=0;
		 var  packageEntityStock;
		 var packageElecStock;
		 $("input[name='stockType']:checkbox").each(function(){ 
			 if ("checked" == $(this).attr("checked")) { 
				 var packType=$(this).attr('value')
				 if(packType==1){
					      packageEntityStock=$("#packageStock_1").val();
					      $("#packageEntityStock").val(packageEntityStock);
						  if(packageEntityStock=="" || packageEntityStock==null){
							  alert("请填写实体兑换券数量");
							  return false;
						  }
				 }
				 else  if(packType==2){
					     packageElecStock=$("#packageStock_2").val();
					     $("#packageElecStock").val(packageElecStock);
						 if(packageElecStock=="" || packageElecStock==null){
							 alert("请填写电子兑换券数量");
							  return false;
						  }
				 }
				 
			 }
		 });
		 if((packageEntityStock==null  || packageEntityStock=="") && (packageElecStock==null || packageElecStock=="") ){
			 alert("套餐库存不能为空");
			  return false;
		 }
		 
		    var str="";
		    $('input[name="tjOrg"]:checked').each(function(){
                var tjOrg=$(this).val();
                var supplyId=tjOrg.split("_")[1];
                var supplierCode=$("input[name=supplierCode_"+supplyId+"]").val();
                if(supplierCode==""|| supplierCode==null){
                	alert("请填写"+tjOrg.split("_")[0]+"套餐编号");
                	 isSub = false;
                }
                str+=tjOrg+"_"+supplierCode+"&";
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
					  str= checkItems[j].split("_");
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
		    $('input[name="tjOrg"]:checked').each(function(){
                var tjOrg=$(this).val();
                var supplyId=tjOrg.split("_")[1];
                tjOrgs+=supplyId+",";
                });
		    if(tjOrgs!="" && tjOrgs!=null){
		    	tjOrgs=tjOrgs.substring(0,tjOrgs.length-1);
		    }else{
		    	alert('请选择体检机构!');
		    	return false;
		    }
		    var url="${dynamicDomain}/physicalPackage/selectItem?ajax=1&tjOrgs="+tjOrgs;
		    document.getElementById("selPhyItem").href = url;
		    
		    $("#selPhyItem").colorbox({
                opacity : 0.2,
                fixed : true,
                width : "920px",
                height : "40%",
                iframe : true,
                onClosed : function() {
                },
                title:"选择体检项目",
                overlayClose : false
            });
		   
	  }
	  var priceStr = "";//套餐价格字符串
	  function childrenWin(selectValues){
		  $("#editDiv").css("display","none");
		  $("#selectItem").html('');
		  var tableStr;
		  var tableStr=' <table id="ec_table" border="0" cellspacing="0" cellpadding="0" class="table table-bordered" width=""> ';
		  tableStr+='<thead> <tr>';
		  tableStr+='<td class="tableHeader" >优先级</td>';
		  tableStr+='<td class="tableHeader" >一级项目名称</td>';
		  tableStr+='<td class="tableHeader" >二级项目名称</td>';
		  tableStr+='<td class="tableHeader" >男性</td>';
		  tableStr+='<td class="tableHeader" >女未婚</td>';
		  tableStr+='<td class="tableHeader" >女已婚</td>';
		  tableStr+='<td class="tableHeader" >操作</td>';
		  tableStr+='</tr></thead>';
		  for(var j=0;j<selectValues.length;j++){
			  checkItems.push(selectValues[j]);
			  var str= new Array();   
			 str= selectValues[j].split("_");
		    
			 tableStr+=' <tbody class="tableBody">';
			 tableStr+='<tr class="odd">';
			 tableStr+='<td style="width: 4%;text-align: center;"><input type="text"  nam="priotry"  id=objectid_'+str[0]+'  value='+(j+1)+'></td>';
			 tableStr+=' <td style="width:10%">'+str[2]+'</td>';
			  tableStr+=' <td style="width:10%">'+str[3]+'</td>';
			  if(str[4]==1){
				  tableStr+=' <td style="width:10%">★</td>';
			  }else{
				  tableStr+=' <td style="width:10%"></td>';
			  }

			  if(str[5]==1){
				  tableStr+=' <td style="width:10%">★</td>';
			  }else{
				  tableStr+=' <td style="width:10%"></td>';
			  }
			  if(str[6]==1){
				  tableStr+=' <td style="width:10%">★</td>';
			  }else{
				  tableStr+=' <td style="width:10%"></td>';
			  }
			  if(str[7] != "" && str[7] != null && typeof(str[7]) != "undefined"){
				  priceStr+=(str[7]+"|");  
			  }
			  tableStr+=' <td style="width:10%"><a href="javascript:void(0)" onclick="removeSel(this,\''+str[0]+'\')" val='+str[0]+'>删除</a></td>';
			 tableStr+=' </tr></tbody>';
			 }
		  tableStr+='</table>';
		  
		  
		  //$("#selectItem").css("display","block");
		  $("#item_table").html(tableStr);
		  var divStr="";
		  var  priceHtml = makePriceHtml(priceStr);		  
		  divStr+=" <p><span>供应商</span><span>价格</span><span>：&nbsp;&nbsp; </span></p>";
		  divStr+=  "<div id='priceTableDiv'>"+priceHtml+"</div>";
		  //$("#selectItem").append(divStr);
		  $("#price_table").html(divStr);
		  $("#editDiv").show();
		  $("#selPhyItem").colorbox.close();
	  }
	  
	  function makePriceHtml(priceStr){
		  if(endWith("|",priceStr)){
			  priceStr = priceStr.substring(0, priceStr.length-1);
		  }
		  var allSupResMap = makePrice(priceStr);
		  var priceHtml = "<table >";
		  allSupResMap.each(function(key,value,index){
			  var supResMap = allSupResMap.get(key);
			  priceHtml+="<tr>";
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
				 	 	priceHtml+="男";
				  priceHtml+="</td>";
				  priceHtml+="<td  width='80px;'>";
				 	 	priceHtml+="女未婚";
				  priceHtml+="</td>";
				  priceHtml+="<td  width='80px;'>";
					  	priceHtml+="女已婚";
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
		    	return true;
	  }
	  
	  
	  
	  function removeSel(obj,toRemoveItemId){
		  var removedStr = "";
		   var val=$(obj).attr("val");
			//只是清空数据
			for(var i=0;i<checkItems.length;i++){
				  var str= new Array();   
				str= checkItems[i].split("_");
				if(str[0]==val){
					checkItems[i]="";
				}
			}			 
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
	  
	  function ajaxFileUpload() {  
          $.ajaxFileUpload({  
              url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
              secureuri: false,  
              fileElementId: 'uploadFile',  
              dataType: 'json',  
              success: function(json, status) {
                  if(json.result){
	                    var filePath = json.filePath;
	                    $('#logo').val(filePath);
	                    $('#showLogo').attr('src','${dynamicDomain}'+filePath);
                  }
              },error: function (data, status, e)//服务器响应失败处理函数
              {
                  alert(e);
              }
          }  
      );
          return false;  
      }  
	  
	  function loadSup(){
		 var supplierList =  ${supplierList};
		 var psList =  ${psList};
		 var checked = false;
		 var supplier = null;
		 var psl = null;
		 var supHtml  = "";
		 for (var i = 0; i < supplierList.length; i++) {
			 supplier = supplierList[i];
			for (var m = 0; m < psList.length; m++) {
				 psl = psList[m];
				if(supplier.objectId==psl.supplierId){
					checked = true;
				}
			}
			supHtml+="<input name='tjOrg' type='checkbox'   value='"+supplier.supplierName+"_"+supplier.objectId+"'  />";
			supHtml+="<input name='supplierCode_"+supplier.objectId+"' type='text' />";
			alert(supHtml);
		}
	  }
	  
	  function closeColorBox(boxId){
		  $("#"+boxId).colorbox().close();
	  }
</script>
</body>
</html>