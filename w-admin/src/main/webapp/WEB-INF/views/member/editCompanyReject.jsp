<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>审核不通过原因</title>
<style>
.reject{
    width: 400px;
    padding-left:20px;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">请输入审核不通过的原因：</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/companyReject/save?ajax=1&id=${param.id}" class="form-horizontal reject" id="CompanyReject" >
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-8">
									<textarea class="col-sm-4 control-label {maxlength:250}" rows="4" cols="180" name="rejectContent" id="rejectContent" ></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
						<c:if test="${empty  param.supplierReject}">
							<button type="button" class="btn btn-primary" onclick="companyReject();">
								<jdf:message code="common.button.save" />
							</button>
						</c:if>
						<c:if test="${not empty  param.supplierReject}">
							<button type="button" class="btn btn-primary" onClick="supplierReject();">
								<jdf:message code="common.button.save" />
							</button>
						</c:if>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="CompanyReject" />
	<script type="text/javascript">
	function companyReject(){
		var reasons=$("#rejectContent").val();
		if(reasons==""){
			alert("请输入原因");
			return false;
		}else if(reasons.length>250){
			alert("长度不能超过250字符");
			return false;
		}else{
			$('#CompanyReject').submit();
		}
	}
	
	function supplierReject(){
		var reasons=$("#rejectContent").val();
		if(reasons==""){
			alert("请输入原因");
			return false;
		}else{
			urlEnd="${dynamicDomain}/supplier/verify?message=操作成功";
			$.ajax({
				url : "${dynamicDomain}/supplier/verifyFail/"+reasons+"?id=${param.id}"
						+ "&timstamp=" + (new Date()).valueOf(),
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						window.parent.location.href=urlEnd;
					}else{
						winAlert(msg.message);
					}
				}
			});
		}
		
	}
	</script>
</body>
</html>