<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡密状态调整</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">卡密状态调整
			</h4>
		</div>
			<form method="post" action="${dynamicDomain}/cardUpdateLog/saveToPage?ajax=1" class="form-horizontal" id="CardUpdateLog">
				<input type="hidden" name="ids" value="${ids }">
				<div class="box-body">
                	<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="cardNewStatus" class="col-sm-2 control-label">卡密状态</label>
								<div class="col-sm-10">
									<jdf:radio dictionaryId="1604" name="cardNewStatus"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="applyRemark" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-10">
									<textarea rows="6" cols="8" class="form-control" name="applyRemark"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary" onclick="javascript:closeBox();">保存</button>
							</div>

						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="CardUpdateLog" />
	<script type="text/javascript">
	function closeBox(){
		if($("#CardUpdateLog").valid()){
			window.parent.$.colorbox.close();
			window.parent.location.reload();
		}
	}
	</script>
</body>