<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>填写供应商收货信息</title>


<style>
</style>

</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">填写拒绝原因</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/vendorChangeOrder/save?ajax=1"
				class="form-horizontal" id="ChangeOrder" name="ChangeOrder" >
			<input type="hidden" name="objectId" value="${entity.objectId}"> 
			<input type="hidden" name="orderStatus" value="${orderStatus }"> 
			<div class="box-body">
				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="form-group">
							<div class="col-sm-12">
								<textarea style="width: 300px; height: 200px;" name="refuseReason" ></textarea>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="row">
					<div class="editPageButton">
						<button type="submit" class="btn btn-primary">
							<jdf:message code="common.button.save" />
						</button>
					</div>

				</div>
			</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="ChangeOrder" />
	<script type="text/javascript">
		$(function() {
		});
	</script>
</body>
</html>