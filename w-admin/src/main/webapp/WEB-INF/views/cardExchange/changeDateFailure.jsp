<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="体检改期结果" /></title>
</head>
<body>

	<form action="#" id="subOrderDetailForm" name="changeDate" method="post">
	<div class="callout callout-info">
        <h4 class="modal-title">
            <jdf:message code="体检改期结果" />
        </h4>
    </div>
	
	<div class="box-body">
		
			<div align="center">
				<span style="color: red;font-size:20px" ><stong>体检改期失败!</stong></span><br>
				<span  ><stong>请重新改期！</stong></span><br>
			</div>
			
    </div>
    <div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" id="confirmTime" onclick="viewPhysicalDetail();">重新改期</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary progressBtn">返回</button>
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
		function viewPhysicalDetail(){
			window.location.href = '${dynamicDomain}/CardExchange/page';
		}
	
	</script>

</body>
</html>