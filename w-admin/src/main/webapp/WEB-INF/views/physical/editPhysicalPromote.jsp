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
                                                                编辑
             </h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/physicalPromote/updatePhysicalPromote" id="PhysicalPromote" onsubmit="return chckFiled()" id="PhysicalPromote" class="form-horizontal">
				<div class="box-body">
				    <div class="row">
				    	<div class="col-sm-6 col-md-12">
				    		<div class="form-group">
								<label for="physicalPromoteForm.useCompany" class="col-sm-2 control-label">适用企业</label>
								<div class="col-sm-3">
									${physicalpromote.companyName }
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label  for="packageNo" class="col-sm-2 control-label"> 主套餐名称</label>
								<div class="col-sm-4">
									 ${physicalpromote.mainPackageName }
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label  for="packageNo" class="col-sm-2 control-label">升级套餐名称</label>
								<div class="col-sm-1">
									<a 
										href="${dynamicDomain}/physicalPackage/physicalPackageoneTemplate?ajax=1&inputName=physicalPromoteForm.addtionalWelfares&packageType=0"
										class="pull-left btn btn-primary colorbox-double-template">选择
									</a>
								</div>
                                 <input type="hidden" name="promotePackageId" id="promotePackageId" value="">
                                <input type="hidden" name="promoteCode" value="${physicalpromote.promoteCode }"> 
								<input type="hidden" name="oldPrice" value="${physicalpromote.promotePrice }">
                                <input type="hidden" name="oldPromotePackageId" value="${physicalpromote.promotePackageId }">
							</div>
						</div>
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
								<label for="promotePrice" class="col-sm-2 control-label">已选升级套餐</label>
								 <div id="physicalPromoteForm.addtionalWelfares" class="col-sm-8">
									<div class="col-sm-12 col-md-12" id="packagepackageId">
										<div class="form-group">
											<div class="col-sm-6">${physicalpromote.promotePackageName }</div>
										</div>
									</div>
								</div>
								</div>
							</div>	
					</div>
					
                   <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="promotePrice" class="col-sm-2 control-label">升级价格</label>
								<div class="col-sm-5">
									<input type="text" class="decimal2 required search-form-control" name="promotePrice" value="${physicalpromote.promotePrice}">
								</div>
								</div>
							</div>	
					</div>
					 
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary">提交</button>
							<a href="${dynamicDomain}/physicalPromote/page" class="btn btn-primary">取消</a>
						</div>
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
		    	$("#promotePackageId").val('');
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
		    
	</script>
</body>