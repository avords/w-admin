<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>员工退保</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">员工退保</h4>
    </div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/insureUserRefund/save?ajax=1" class="form-horizontal" id="addRefundInsure" name="addSupplier" >
				<input type="hidden" name="objectId" value="${entity.objectId}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptContacts" class="col-sm-4 control-label">保险合同号：</label>
								<div class="col-sm-8">
									<input type="text" class="form-control required " maxlength="50" name="contractNo" id="contractNo">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptTelephone" class="col-sm-4 control-label">退保账号</label>
								<div class="col-sm-8">
									<input type="text" class="form-control required phone" maxlength="20" name="refundName" id="refundName">
								</div>
							</div>
						</div>
						<div class="editPageButton">
							<button type="button" onclick="check();"  class="btn btn-primary">
								验证
							</button>
						</div>
					</div>
					<div id="agree" style="display: none;">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">员工姓名</label>
								<div class="col-sm-8" id="userName">
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">手机号码</label>
								<div class="col-sm-8" id="phone">
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">订单号</label>
								<div class="col-sm-8" id="orderNo">
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">保险商品</label>
								<div class="col-sm-8" id="proName">
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">商品规格</label>
								<div class="col-sm-8" id="attribute1Value">
									
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">退保费</label>
								<div class="col-sm-8">
									<input type="text" class="form-control required" maxlength="20" name="refundPremiumq" id="refundPremiumq">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">退保时间</label>
								<div class="col-sm-8">
									<input type="text" class="form-control required" onClick="WdatePicker()" name="refundDate" id="refundDate">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiptAddress" class="col-sm-4 control-label">备注</label>
								<div class="col-sm-8">
									<textarea rows="4" cols="10" name="remark" id="remark"></textarea>
								</div>
							</div>
						</div>
					</div>
					</div>
					<div id="noAgree" style="display: none;">
						<span class="" id="errorMsg">
                		</span>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" onclick="save();"  class="btn btn-primary">
								新增
							</button>
						</div>

					</div>
				</div>
		</div>
		</form>
		</jdf:form>
	</div>
<script type="text/javascript">
$(function(){
	$("#addRefundInsure").validate();
	
});

function check(){
	var contractNo = $("#contractNo").val();
	var refundName = $("#refundName").val();
	var valid = $("#addRefundInsure").valid();
	if (valid) {
		$.ajax({
			url : "${dynamicDomain}/insureUserRefund/check",
			type : 'post',
			data:{'contractNo':contractNo,'refundName':refundName},
			dataType : 'json',
			success : function(data) {
				var result = data.result;
				if (result) {
					var insureOrderUser = data.insureOrderUser;
					var insureOrder = data.insureOrder;
					$("#userName").html(insureOrderUser.userName);
					$("#phone").html(insureOrderUser.mobilePhone);
					$("#orderNo").html(insureOrder.generalOrderNo);
					$("#proName").html(insureOrder.proName);
					$("#attribute1Value").html(insureOrder.attribute1ValueId);
					$("#agree").show();
					$("#noAgree").hide();
					
	            }else{
					var msg = data.msg;
	              	$("#errorMsg").html(msg);
	              	$("#agree").hide();
					$("#noAgree").show();
	           }
			}
		});
	}
}
function save(){
	$('#addRefundInsure').submit();
	window.parent.$.colorbox.close();
}
</script>
</body>
</html>