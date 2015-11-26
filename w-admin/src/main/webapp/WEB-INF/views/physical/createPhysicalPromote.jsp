<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增&编辑</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">
           <c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                   <c:otherwise>
                                                                编辑
                </c:otherwise>                      
           </c:choose>
             </h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/physicalPromote/saveToPage" id="PhysicalPromote" class="form-horizontal"  onsubmit="javascript:return submitPomotePackage();">
				<div class="box-body">
				    <div class="row">
				    	<div class="col-sm-6 col-md-12">
				    		<div class="form-group">
								<label for="physicalPromoteForm.useCompany" class="col-sm-2 control-label">适用企业</label>
								<div class="col-sm-3">
									<input type="radio"   name="physicalPromoteForm.useCompany"  id="useCompany1" value=0 checked="checked" onclick="canselect(0)">所有企业
									<input type="radio"   name="physicalPromoteForm.useCompany"  id="useCompany2" value=1 onclick="canselect(1)">选择企业									
								</div>
							</div>
						</div>
					</div>
					
					<div class="row" id="findcompanybutton" style="display:none;">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
							<label for="usecompany" class="col-sm-2 control-label">选择适用企业</label>
								<div class="col-sm-2" >
									<a
										href="${dynamicDomain}/company/multiCompanyforphypromoteTemplate?ajax=1&inputName=physicalPromoteForm.companys"
										class="pull-left btn btn-primary colorbox-double-template">选择适用企业
									</a>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label  for="packageNo" class="col-sm-2 control-label"> 主套餐名称</label>
								<div class="col-sm-1">
									<a href="${dynamicDomain}/physicalPackage/physicalPackagePromoteTemplate?ajax=1&inputName=physicalPromoteForm.welfares&packageType=0"
										class="pull-left btn btn-primary colorbox-double-template">选择
									</a>
								</div>
								<div id="physicalPromoteForm.oldPackage" class="col-sm-8">
                                </div>
                             	<input type="hidden" class="search-form-control" name="physicalPromoteForm.oldPackageNo"> 
								<input type="hidden" class="search-form-control" name="physicalPromoteForm.oldPackageName">
								<input type="hidden" class="search-form-control" name="physicalPromoteForm.oldPackagePrice">
							</div>
						</div>
					</div>
										
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label  for="packageNo" class="col-sm-2 control-label">升级套餐名称</label>
								<div class="col-sm-1">
									<a 
										href="${dynamicDomain}/physicalPackage/physicalPackagePromoteTemplate?ajax=1&inputName=physicalPromoteForm.addtionalWelfares&packageType=0"
										class="pull-left btn btn-primary colorbox-double-template">选择
									</a>
								</div>
								<div id="physicalPromoteForm.destPackage" class="col-sm-8">
                                </div>
                                <input type="hidden" class="search-form-control" name="physicalPromoteForm.destPackageNo"> 
								<input type="hidden" class="search-form-control" name="physicalPromoteForm.destPackageName">
                                <input type="hidden" class="search-form-control" name="physicalPromoteForm.destPackagePrice">
                                
							</div>
						</div>
					</div>
					
                  <div class="row">
							<div class="col-sm-6 col-md-12">
								<div class="form-group">
										<label for="status" class="col-sm-2 control-label">状态</label>
									<div class="col-sm-8">
										 <jdf:radio  name="status"  dictionaryId="111"/>
									</div>
								</div>
							</div>
					</div>	
					 
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="submit"  class="btn btn-primary "   validateMethod="submitPomotePackage();">提交</button>
							<a href="${dynamicDomain}/physicalPromote/page" class="btn btn-primary">取消</a>
						</div>
					</div>
			</div>
			</div>
			
			
			
              <div>
			   <div class="callout callout-info">
					<h4 class="modal-title">
					  已选企业
					</h4>
				</div>
				 <div class="row"  >
						 <div id="physicalPromoteForm.companys" attr="selectedCompany" class="col-sm-8">

                          </div>
				 </div>
			 </div>

			<div>
			   <div class="callout callout-info">
					<h4 class="modal-title">
					  已选主套餐
					</h4>
				</div>
				 <div class="row"  >
						<div class="col-sm-12 col-md-12" attr="selectedMain" id="physicalPromoteForm.welfares" >
						</div>
				 </div>
			 </div>
		       
			<div>
			   <div class="callout callout-info">
					<h4 class="modal-title">
					  已选升级套餐
					</h4>
				</div>	 
				<div class="row">
					<div class="col-sm-12 col-md-12" attr="selectedPromote"  id="physicalPromoteForm.addtionalWelfares" >
					</div>
			    </div>	
		  </div>
		       
	</form>
	</jdf:form>
	</div>
<jdf:bootstrapDomainValidate domain="PhysicalPromote"/>
		<script type="text/javascript">
			function canselect(a){
				if(a==0){
					$("#findcompanybutton").css('display','none'); 
					
				} else {
					$("#findcompanybutton").css('display',''); 
				}	
				
				$("input[name='physicalPromoteForm.useCompany']").val(a);
			}
			
		    function del(divId) {
			    $("#"+divId).remove();
			}
		    
		    function chckFiled(){
		    	var cpscope = $("input[name='physicalPromoteForm.useCompany']").val();
		    	if (cpscope==2){
		    		var comDiv = $(window.parent.document).find("div[id='physicalPromoteForm.companys']");
		    		var hascompany = comDiv.find("div[id='company0']");
		    		if(hascompany==null || hascompany == ""){
		    			alert("请选择企业！");
		    		    return false;
		    		}
		    	}
		    	
				 
		    	
		    }
		    
		    function submitPomotePackage() {
				  var companyType ;
				  $("input[name='physicalPromoteForm.useCompany']").each(function(){
					  if ($(this).attr("checked")) {
						  companyType = $(this).val();
					  }
				  });
				 var companys = $("div[attr='selectedCompany']").find("input[type='hidden']");
				 
				 if (companyType == 1 && (null == companys || companys.length == 0)) {
					 alert("请选择企业");
					 return false;
				 }
				 
				 var mainWelfareForms = $("div[attr='selectedMain']").find("input[type='hidden']");
				
				 if ( null == mainWelfareForms || mainWelfareForms.length == 0 ) {
					 alert("请选择主套餐");
					 return false;
				 }
				 return true ;
			  }  
	</script>
	
	
</body>