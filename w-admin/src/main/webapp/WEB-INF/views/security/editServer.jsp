<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>平台管理</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">平台管理
			<c:choose>
				<c:when test="${entity.objectId eq null }">—新增</c:when>
				<c:otherwise>—修改</c:otherwise>
			</c:choose>
			</h4>
		</div>
			<form method="post" action="${dynamicDomain}/server/saveToPage"
				id="Server" class="form-horizontal">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="platform" class="col-sm-4 control-label">平台名称</label>
								<div class="col-sm-8">
									<select name="platform" id="platform" class="search-form-control" onchange="javascript:setServerName()">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1112" valid="true" />
									</select>
									<input type="hidden" id="name" name="name">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="protocol" class="col-sm-4 control-label">协议</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="protocol">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="context" class="col-sm-4 control-label">上下文</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="context">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="domain" class="col-sm-4 control-label">域名</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="domain" id="domain">
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="port" class="col-sm-4 control-label">端口</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="port" id="port">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="ip" class="col-sm-4 control-label">IP</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="ip">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label class="col-sm-4 control-label">是否启用</label>
								<div class="col-sm-8">
									<select name="status" class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="109" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">保存
								</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Server" />
	<script type="text/javascript">
		function setServerName(){
			$("#name").val($("#platform").find("option:selected").text());
		}
	</script>
</body>
</html>