<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="体检预约结果" /></title>
</head>
<body>

	<form action="#" id="subOrderDetailForm" name="subOrderDetailForm" method="post">
	<div class="callout callout-info">
        <h4 class="modal-title">
            <jdf:message code="体检预约结果" />
        </h4>
    </div>
	
	<div class="box-body">
		
			<div align="center">
				<span style="color: red;font-size:20px" ><stong>体检预约失败</stong></span><br>
				<span  ><stong>请重新预约！</stong></span><br>
			</div>
			
    </div>
    <div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" id="reSubscribe" onclick="reSubscribe();">重新预约</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary progressBtn">返回</button>
							</div>
						</div>
					</div>

	</form>
	<script>
		var isFtFot = false;
		$(function() {
			
			// 判断是否选择
			$('#reSubscribe').click(function() {
				window.location.href = '${dynamicDomain}/CardExchange/appointmentFirst';
			});
			
			
		});
		function reSubscribe(){
			window.location.href = '${dynamicDomain}/CardExchange/page';
		}
	
	</script>

</body>
</html>