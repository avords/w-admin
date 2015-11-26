<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡密全部操作日志</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				卡密全部操作日志
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="" method="post"  class="">
				<div class="row">
					<div class="col-sm-8 col-md-8">
						<div class="form-group">
							<label class="col-sm-2 control-label"></label>
						</div>
					</div>
				</div>
				<c:forEach items="${data}" var="cardOperateLog" varStatus="num">
					<c:choose>
						<div class="row">	
								<div class="col-sm-8 col-md-10">
									<div class="form-group">
										<label class="col-sm-2 control-label"></label>
										<label class="col-sm-8 control-label">
										  ${cardOperateLog.operateUserName } &nbsp;&nbsp;&nbsp; <fmt:formatDate value="${cardOperateLog.operateTime}" pattern=" yyyy-MM-dd  HH:mm:ss"/>&nbsp;&nbsp;&nbsp;${cardOperateLog.operateRemark}
										</label>
									</div>
								</div>
							</div>
					</c:choose>
				</c:forEach>	
				<div class="box-footer">
		            <div class="row">
		              <div class="editPageButton">
						<a href="${dynamicDomain}/cardBind/handlePageCardInfo?packageID=${packageID}">
							<button type="button" class="btn btn-primary">返回</button>
						</a>
					</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
</body>
</html>