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
		<div class="box-body">
			<div class="row">
				<div class="col-sm-12 col-md-12">
					<div class="form-group">
						<div class="col-sm-8">
							<textarea class="col-sm-4 control-label" rows="4" cols="80" name="reasons" id="reasons"></textarea>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="editPageButton">
					<button type="button" onClick="return saveReasons();" class="btn btn-primary">
						<jdf:message code="common.button.save" />
					</button>
			</div>
		</div>
	</div>
	<jdf:bootstrapDomainValidate domain="companyFollow" />
	<script type="text/javascript">
	function saveReasons(){
		var reason=$("#reasons").val();
		if(reason==""){
			alert("请输入原因");
		}
		$.ajax({  
		    url:"${dynamicDomain}/companyAccount/verifyFail/",
			type : 'post',
			data : "id=${companyAccountId}&reasons="+reason+"&data="+ (new Date().getDate()),
			dataType : 'json',
			success : function(msg) {
				if(msg.result==true){
					window.parent.location.reload();
				}
			}
		});
	 }
	</script>
</body>
</html>