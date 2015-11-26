<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="运营端-礼券兑换" /></title>
</head>
<body>

	<form action="${dynamicDomain}/giftExchange/subOrderDetail" id="subOrderDetailForm" name="subOrderDetailForm" method="post">
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
					<label for="password" class="col-sm-4 control-label">
						<stong>恭喜您！兑换成功</stong>
					</label>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label for="password" class="col-sm-10 control-label">
						<span style="color: red"><stong>请记住如下订单号和预留联系方式，以便查询订单。</stong></span>
					</label>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label for="password" class="col-sm-4 control-label">订单号：
					</label>
					<div class="col-sm-8">
						<c:forEach items="${subOrderList}" var="subOrder">
							${subOrder.subOrderNo}</br>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label for="password" class="col-sm-4 control-label">预留联系方式:
					</label>
					<div class="col-sm-8">
						${order.receiptMoblie}
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-6 col-md-6">
				<div class="form-group">
					<label for="password" class="col-sm-4 control-label">
						<a href="#" class="f-ib showDetail">查看兑换详情</a>
					</label>
				</div>
			</div>
		</div>
		
		
		
		<div class="row">
			<div class="form-group">
				<label class="col-sm-4 control-label">
					<button type="button" class="btn btn-primary j-btn-back">返回 </button>
				</label>
			</div>
		</div>
		
		
		<input type="hidden" name="orderNo" id="orderNo" value="${order.generalOrderNo}"/>
		
		<%-- <c:if test="${resultMap.code != '0'}">
			<div class="row">
				<div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="password" class="col-sm-4 control-label">
							<stong>兑换失败:${resultMap.msg}</stong>
						</label>
					</div>
				</div>
			</div>
		</c:if> --%>
    </div>

	</form>
	<script>
		var isFtFot = false;
		$(function() {
			
			// 判断是否选择
			$('.showDetail').click(function() {
				$("#subOrderDetailForm").submit();
			});
			
			
			$(".j-btn-back").click(function(){
				$("#subOrderDetailForm").attr("action","${dynamicDomain}/giftExchange/index");
				$("#subOrderDetailForm").submit();
			});
			
			
		});
		
	
	</script>

</body>
</html>