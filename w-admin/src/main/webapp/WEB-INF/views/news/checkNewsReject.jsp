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
		<div class="callout callout-info" style="height: 35px;">
			<div class="message-right">${message}</div>
			<h5>请输入不通过原因:</h5>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/newsnotify/saveCheckReason?ajax=1&objectId=${objectId}" class="form-horizontal reject" id="editForm" >
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-8">
									<textarea class="col-sm-4 control-label" rows="4" cols="80" name="remark" id="remark" required="required"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
							<button type="button" class="btn btn-primary progressBtn" onclick="saveCheckReason();">
								<jdf:message code="common.button.save" />
							</button>
							<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">
								返回
							</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<script type="text/javascript">
	function saveCheckReason() {
		var length  = $("#remark").val().length;
		if(length == 0){
			alert("请输入不通过原因！");
		}
		else if(length > 250){
			alert("内容不能超过250字符");
		}
		else{
			 $("#editForm").submit(); 
			 parent.toList();
		}
		 
	}
	function comeBack(){
		window.parent.$.colorbox.close();
	}
	</script>
</body>
</html>