<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>客户经理跟进管理</title>
<style>
.panel-body {
	padding: 6px 1px 6px 7px;
}

.panel-title {
	margin-top: 0;
	margin-bottom: 0;
	font-size: 13px;
	color: inherit;
	padding: 2px;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">客户经理跟进详情</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/companyFollow/save?ajax=1&companyId=${companyId}" class="form-horizontal hideDiv" id="CompanyFollow">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="explains" class="col-sm-4 control-label">跟&nbsp;&nbsp;进&nbsp;&nbsp;人</label>
								<div class="col-sm-8">
									<span class="lable-span">${userName}</span>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="explains" class="col-sm-4 control-label">跟进时间</label>
								<div class="col-sm-6">
									<span class="lable-span"><fmt:formatDate
											value="${followTime}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="explains" class="col-sm-4 control-label">跟进说明</label>
								<div class="col-sm-6">
									<textarea class="search-control-label {maxlength:250}" rows="5" cols="50" name="explains" id="explains"></textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" class="btn btn-primary" onclick="saveFollow();">保存</button>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<div>
		<c:forEach items="${items }" var="companyFollow">
			<div class="panel panel-default" style="width: 96%">
				<div class="panel-heading">
					<h4 class="panel-title">
						跟&nbsp;&nbsp;进&nbsp;&nbsp;人：
						<jdf:columnCollectionValue items="users" nameProperty="userName"
							value="${companyFollow.managerId}" />
					</h4>
					<h4 class="panel-title">
						跟进时间：
						<fmt:formatDate value="${companyFollow.followTime}"
							pattern="yyyy-MM-dd HH:mm:ss" />
					</h4>
				</div>
				<div class="panel-body">
					<div class="panel-body" style="word-break:break-all;">跟进说明：${companyFollow.explains}</div>
				</div>
			</div>
		</c:forEach>
	</div>
	<jdf:bootstrapDomainValidate domain="CompanyFollow" />
	<script type="text/javascript">
	$(document).ready(function() {
		<c:if test="${param.apply==1}">
			$(".hideDiv").hide();
		</c:if>
	});
	
	function saveFollow(){
		var val=$("#explains").val();
		if(val==""){
			alert("请输入原因");
		}else{
			$('#CompanyFollow').submit();
		}
		
	}
	</script>
</body>
</html>