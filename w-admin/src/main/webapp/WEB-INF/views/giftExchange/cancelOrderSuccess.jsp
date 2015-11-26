<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="运营端-礼券兑换" /></title>
</head>
<body>

	<form action="${dynamicDomain}/giftExchange/index" id="subOrderDetailForm" name="subOrderDetailForm" method="post">
	<div class="callout callout-info">
        <h4 class="modal-title">
            <div class="message-right">${msg }</div>
            <jdf:message code="运营端-礼券兑换" />
        </h4>
    </div>
	<div class="box-body">
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label  class="col-sm-4 control-label">
						<stong>${resultMap.msg}</stong>
					</label>
				</div>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label  class="col-sm-4 control-label">
						<a href="#" class="f-ib showDetail">重新兑换</a>
						<a href="#" class="f-ib showDetail">返回</a>
					</label>
				</div>
			</div>
		</div>
	
	</div>
</form>
<script>
	var isFtFot = false;
	$(function() {
		
		// 判断是否选择
		$('.showDetail').click(function() {
			$("#subOrderDetailForm").submit();
		});
		
		
	});
	

</script>

</body>
</html>