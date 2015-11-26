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
			<div class="message-right">${message }</div>
			<h4 class="modal-title">请输入审核不通过原因</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/product/saveCheckReason?ajax=1&productId=${productId}" class="form-horizontal reject" id="editForm" >
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-8">
									<textarea class="{required:true,maxlength:250} col-sm-4 control-label" rows="4" cols="80" name="remark"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
							<button type="submit" class="btn btn-primary">
								<jdf:message code="common.button.save" />
							</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<script type="text/javascript">
	$(function(){
		$('#editForm').validate();
		if('${param.result}'=='true'){
            parent.winAlertReloadUrl('操作成功!','${dynamicDomain}/sku/checkPage');
            parent.$.colorbox.close();
        }
	});
	</script>
</body>
</html>