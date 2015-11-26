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
				<c:forEach items="${logitems }" var="cardOperateLog" varStatus="num">
					<c:choose>
						<c:when test="${num.index eq 0 }">
							<div class="row">
								<div class="col-sm-8 col-md-8">
									<div class="form-group">
										<label class="col-sm-2 control-label">操作日志：</label>
										<label class="col-sm-6 control-label">
											${cardOperateLog.operateUser }
													<fmt:formatDate value="${cardOperateLog.operateTime }" pattern=" yyyy-MM-dd  HH:mm"/> 将
													${cardOperateLog.operateAmount } 份卡密置为 <jdf:dictionaryName  dictionaryId="1604"  value="${cardOperateLog.operateType }"/>
										</label>
									</div>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="row">	
								<div class="col-sm-8 col-md-8">
									<div class="form-group">
										<label class="col-sm-2 control-label"></label>
										<label class="col-sm-6 control-label">
											${cardOperateLog.operateUser }
													<fmt:formatDate value="${cardOperateLog.operateTime }" pattern=" yyyy-MM-dd  HH:mm"/> 将
													${cardOperateLog.operateAmount } 份卡密置为 <jdf:dictionaryName  dictionaryId="1604"  value="${cardOperateLog.operateType }"/>  
										</label>
									</div>
								</div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:forEach>	
				<div class="box-footer">
		            <div class="row">
		              <div class="editPageButton">
						<a href="${dynamicDomain}/cardInfo/page/${createInfoId}" >
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