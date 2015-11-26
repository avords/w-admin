<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>账户充值</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="select2.js"/>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">账户充值</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/companyAccount/saveToPage?ajax=1" class="form-horizontal" id="CompanyAccount" >
				<input type="hidden" name="objectId">
				<input type="hidden" name="companyId" id="companyId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label  for="companyAdminId" class="col-sm-4 control-label"> 公司名称</label>
								<div class="col-sm-6">
								<select name="companyAdminId" id="COMName" style="width:300px;">
									<option value="">-请选择-</option>
									<jdf:selectCollection items="companys" optionValue="objectId" optionText="companyName"/>
								</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label for="companyAdminId" class="col-sm-4 control-label" >充值帐户</label>
								<div class="col-sm-6" id="lable" style="padding-top:6px;">
									<div id="COMAccount"></div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-12">
							<div class="form-group">
								<label for="rechargeMoney" class="col-sm-4 control-label">充值金额</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="rechargeMoney" id="rechargeMoney">
								</div>
								<div class="col-sm-1"><span class="lable-span">元</span></div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
						<button type="button" class="btn btn-primary" onclick="saveAccount();">
							提交
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="CompanyAccount"/>
	<script type="text/javascript">
	$('#COMName').select2();
    <c:if test="${view==1 }">
    $('input').each(function(){
        $(this).attr('disabled','disabled');
    });
    $('select').each(function(){
        $(this).attr('disabled','disabled');
    });
    </c:if>
    
	function saveAccount(){
		var company=$('#COMName option:selected').val();
		var money=$('#rechargeMoney').val();
		if(company==""){
			alert("公司名称不能为空");
		}else if(money==""){
			alert("充值金额不能为空");
		}else{
			if(Number(money)<=0){
				alert("充值金额不能为负和0");
			}else{
				$('#companyId').val(company);
				$('#CompanyAccount').submit();
			}
		}
	}
	$(function(){
		  $("#COMName").bind("change",function(){
             if($(this).val()){
                 $.ajax({
                     url:"${dynamicDomain}//companyAccount/getAccountByCompanyId/" + $(this).val(),
                     type : 'post',
                     dataType : 'json',
                     success : function(json) {
                    	 if(json.loginName==false){
                    		 alert("该企业无账户，请先添加企业账户");
                    		 $('#COMName').val('');
                    	 }else{
                    		 $("#COMAccount").remove();
                             $("#lable").append("<div id='COMAccount'>"+json.loginName+"</div>");
                    	 }
                     }
                 });
             }
          }).change();
	});
	</script>
</body>
</html>