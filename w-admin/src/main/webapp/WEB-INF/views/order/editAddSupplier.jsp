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
			<h4 class="modal-title">填写供应商收货信息</h4>
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
								<label for="receiptTelephone" class="col-sm-4 control-label">联系方式</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="receiptTelephone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptContacts" class="col-sm-4 control-label">联系人</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="receiptContacts">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptZope" class="col-sm-4 control-label">邮编</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="receiptZope">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">收货地址</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" name="receiptAddress">
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