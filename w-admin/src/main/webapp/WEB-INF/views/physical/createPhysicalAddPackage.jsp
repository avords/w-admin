<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增体检套餐加项包</title>
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
				  新增体检套餐加项包
				</h4>
		</div>
		
		<jdf:form bean="entity" scope="request">
		    <form method="post" action="${dynamicDomain}/physicalAddtional/savePackage" class="form-horizontal" id="AddtionalPhysicalForm"  onsubmit="javascript:return submitAddPackage();">
		    <input type="hidden" name="objectId">
		    <div class="box-body">
		    
		    <div class="row">
		        	<div  class="col-sm-12 col-md-12">
						<div class="form-group">
							<label for="type" class="col-sm-4 control-label">适用企业:</label>
							<div class="col-sm-3">
							     <label><input name="companyType" type="radio"  onclick="canselect(0)"  value="0"/>所有企业 
									<input name="companyType" type="radio" onclick="canselect(1)" value="1" checked="checked"/>选择企业
								</label>	
								<label>
								</label>
							</div>
							
							<div class="col-sm-4" id="findcompanybutton" >
							 
							   <a href="${dynamicDomain }/company/listCompanysTemplate?ajax=1&inputName=companyForms"
										id="enterprise-btn"
										class="pull-left btn btn-primary colorbox-double-template">
										选择企业 </a>
										 
							 </div>
						</div>
					</div>
 
		       </div>
		    
		    	<div class="row">
						<div  class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="mainPackageName" class="col-sm-4 control-label">主套餐名称*:</label>
										 
										<div class="col-sm-4">
										
											  <a href="${dynamicDomain }/physicalPackage/physicalPackageAddtionalTemplate?ajax=1&inputName=mainWelfareForms&packageType=0"
												id="enterprise-btn"
												class="pull-left btn btn-primary colorbox-double-template">
												请选择 </a>
												 
										 </div>
										</div>
								</div>	
						</div>
					</div>
				
						
				<div class="row">
						<div class="col-sm-12 col-md-12" >
								<div class="form-group">
									<label for="addPackageName" class="col-sm-4 control-label">加项套餐名称*:</label>
										 
										<div class="col-sm-4"> 
										 <a href="${dynamicDomain }/physicalPackage/physicalPackageAddtionalTemplate?ajax=1&inputName=addtionalWelfareForms&packageType=1"
										  id="enterprise-btn" class="pull-left btn btn-primary colorbox-double-template">
										  请选择 </a>
										</div>
								</div>	
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12" >
								<div class="form-group">
									<label for="addPackageName" class="col-sm-4 control-label">套餐属性*:</label>
										<div class="col-sm-2"> 
											<input name="packageAttr" type="checkbox"   value="10" />男
										</div>
										<div class="col-sm-2"> 
											<input name="packageAttr" type="checkbox"   value="00" />女未婚
										</div>
										<div class="col-sm-2"> 
											<input name="packageAttr" type="checkbox"   value="01" />女已婚
										</div>
								</div>	
						</div>
					</div>
				<c:forEach items="${supplierList}"  var="supplier"  varStatus="num"  >
					<c:choose>
						<c:when test ="${num.index eq 0 }">
							<div class="row">
								<div class="col-sm-12 col-md-12" >
										<div class="form-group">
											<label for="" class="col-sm-4 control-label">选择体检品牌*:</label>
											<div class="col-sm-3">
												<input name="tjBrand" type="checkbox"   value="${supplier.objectId}" />${supplier.supplierName}
											</div>
										</div>
								</div>
							</div>	
						</c:when>
						<c:otherwise>
						<div class="row">
							<div class="col-sm-12 col-md-12" >
									<div class="form-group">
										<label class="col-sm-4 control-label"></label>
										<div class="col-sm-3">
											<input name="tjBrand" type="checkbox"   value="${supplier.objectId}" />${supplier.supplierName}
										</div>
									</div>
							</div>
						</div>	
						</c:otherwise>
						</c:choose>
					</c:forEach>
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
										<label for="status" class="col-sm-4 control-label">状态:</label>
									<div class="col-sm-8">
										 
										 <jdf:radio  name="status"  dictionaryId="111"/>
							              
									</div>
								</div>
							</div>
					</div>	
					
					 
					
		     <div class="box-footer">
					<div class="row">
						<div class="editPageButton">
						
								<button type="submit"   class="btn btn-primary"  validateMethod="submitAddPackage();">
											保存
								</button>
										
								<button type="button" class="btn btn-primary" onclick="cancel();">
									 取消
								</button>
						</div>
							
					</div>
			 </div>
	         
	         <div>
	            <div class="callout callout-info">
					<h4 class="modal-title">
					  已选企业
					</h4>
				</div>
	            <div class="row">
				  <div class="col-sm-12 col-md-12" id="companyForms" >
				  </div>
				</div>
			 </div>
			 <div>
			  <div class="callout callout-info">
					<h4 class="modal-title">
					  已选主套餐
					</h4>
				</div>
				<div class="row" >
						<div class="col-sm-12 col-md-12" id="mainWelfareForms" >
						</div>
				</div>
			 </div>
			<div>
			  <div class="callout callout-info">
					<h4 class="modal-title">
					  已选加项套餐
					</h4>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-12" id="addtionalWelfareForms" >
					</div>
			    </div>	
			</div>
		    </form>
		</jdf:form>
				
 </div>	
	<jdf:bootstrapDomainValidate domain="AddtionalPhysicalForm"/>
	 <script type="text/javascript">  
	 
	 reloadParent = false;
	 var checkItems=new Array();
	 
	  function cancel(){
		  window.location.href="${dynamicDomain}/physicalAddtional/page";
	  }
	  
	  function ShowDailog(PageHref,Title,Height,Width){
		  var dleft =(screen.availHeight-Height)/2;
		  var dtop =(screen.availWidth-Width)/2;
		  window.showModalDialog(PageHref,window,Title,"scrollbars=yes;resizable=no;help=no;status=no;center=yes;dialogTop=25;dialogLeft="+ dleft +";dialogTop="+ dtop +";dialogHeight="+Height+"px;dialogWidth="+Width+"px;");
		  
	  }
	  
	  var win=null;
	  var priceStr = "";//套餐价格字符串
	   
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
	  
	  
	  function closeColorBox(boxId){
		  $("#"+boxId).colorbox().close();
	  }
	  
	  function del(divId) {
	      $("#"+divId).remove();
	  }
	  
	  function canselect(a){
			if(a==0){
				$("#findcompanybutton").css('display','none'); 
				
			} else {
				$("#findcompanybutton").css('display',''); 
			}	
			 
		}
	 
	  function submitAddPackage() {
		  var companyType ;
		  $("input[name='companyType']").each(function(){
			  if ($(this).attr("checked")) {
				  companyType = $(this).val();
			  }
		  });
		  
		 var companys = $("#companyForms").find("input[type='hidden']");
		
		 if (companyType == 1 && (null == companys || companys.length == 0)) {
			 alert("请选择企业");
			 return false;
		 }
		 
		 var mainWelfareForms = $("#mainWelfareForms").find("input[type='hidden']");
		
		 if ( null == mainWelfareForms || mainWelfareForms.length == 0 ) {
			 alert("请选择主套餐");
			 return false;
		 }
		 
		 var addtionalWelfareForms = $("#addtionalWelfareForms").find("input[type='hidden']");
		
		 if ( null == addtionalWelfareForms || addtionalWelfareForms.length == 0 ) {
			 alert("请选择加项套餐");
			 return false;
		 }
		 if( $("input[name='packageAttr']").attr('checked') != 'checked'){
			 alert("请选择套餐属性");
			 return false;
			}
		 if( $("input[name='tjBrand']").attr('checked') != 'checked'){
			 alert("请选择体检品牌");
			 return false;
			}
		 
		 return true;
	  }
</script>
</body>
</html>