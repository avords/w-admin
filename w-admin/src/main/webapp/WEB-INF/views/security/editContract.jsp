<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>合同管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">合同管理</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/contract/save" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<label for="customerType" class="btn btn-flat">
										合同签订对象：</label>
									</div>
									<select name="customerType" id="customerType" class="form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="104"/>
									</select>
								</div>
							</div>
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<label for="customerName"  class="btn btn-flat">对方名称：</label>
									</div>
									<input type="text" class="form-control" name="customerName">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<label for="contractNo" class="btn btn-flat">合同编号：</label>
									</div>
									<input type="text" class="form-control" name="contractNo">
								</div>
							</div>
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<label for="attachmentNo" class="btn btn-flat">上传合同文件：</label>
									</div>
									<input type="text" class="form-control" name="attachmentNo">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<button type="button" class="btn btn-flat">合同开始时间：</button>
									</div>
									<input id="startDate"  name="startDate" type="text" onClick="WdatePicker()" class="search-form-control"/>
								</div>
								
							</div>
							<div class="col-sm-6 col-md-6">
								<div class="input-group">
									<div class="input-group-btn">
										<button type="button" class="btn btn-flat">合同结束时间：</button>
									</div>
									<input id="endDate"  name="endDate" type="text" onClick="WdatePicker()" class="search-form-control"/>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-floppy-save"></span>
										<jdf:message code="common.button.save"/>
								</button>
								<a href="${dynamicDomain}/contract/page" class="back-btn">返回</a>
							</div>
								
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Contract"/>
	<script type="text/javascript">
		
	</script>
</body>
</html>