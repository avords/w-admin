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
				<span style="color: red;font-size:20px" ><stong>恭喜您！预约成功</stong></span><br>
				<span  ><stong>请您及时到达相应地点准时参加！</stong></span><br>
				<span ><stong>预祝您有一个满意的体验！</stong></span>
			</div>
			
    </div>
    <div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" id="confirmTime" onclick="viewPhysicalDetail();">查看</button>
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
			window.location.href = '${dynamicDomain}/CardExchange/viewPhysicalDetail/${cardNo}';
		}
	
	</script>

</body>
</html>