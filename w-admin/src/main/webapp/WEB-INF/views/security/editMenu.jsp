<%@page import="com.handpay.ibenefit.security.entity.Menu"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.menu" /></title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">
				<jdf:message code="system.menu.menu" />
			</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/menu/save"
				class="form-horizontal" id="editForm">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="type" class="form-lable">菜单类型：</label>
								</div>
								<select name="type" id="type" class="form-control">
									<jdf:select dictionaryId="106" />
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="name" class="form-lable">菜单名称：</label>
								</div>
								<input type="text" class="form-control" name="name">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="parentId" class="form-lable">上级菜单：</label>
								</div>
								<select name="parentId" class="form-control">
									<option value="0">--</option>
									<jdf:selectCollection items="pathes" optionValue="objectId"
										optionText="path" />
								</select>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="status" class="form-lable">菜单状态：</label>
								</div>
								<select name="status" id="status" class="form-control">
									<option value="">—请选择—</option>
									<jdf:select dictionaryId="103" />
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">菜单顺序：</label>
								</div>
								<input type="text" class="form-control" name="orderId"
									id="orderId">
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable"><jdf:message
											code="system.lable.menu.server" />：</label>
								</div>
								<select name="serverId" class="form-control">
									<jdf:selectCollection items="servers" optionValue="objectId"
										optionText="name" />
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12 menuContent">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">URL：</label>
								</div>
								<input type="text" class="form-control" name="url" id="url">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary">
								<span class="glyphicon glyphicon-floppy-save"></span>
								<jdf:message code="common.button.save" />
							</button>
							<a href="${dynamicDomain}/menu/page" class="back-btn">返回</a>
						</div>

					</div>
				</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Menu" />
	<script type="text/javascript">
		function typeChange(){
			if($("#type").val()=="<%=Menu.TYPE_FOLDER%>") {
				$(".menuContent").hide();
				$("#orderId").attr("colspan", 3);
			} else {
				$("#orderId").attr("colspan", 1);
				$(".menuContent").show();
			}
		}
		$(document).ready(function() {
			$("#type").change(function() {
				typeChange();
			});
		});
		typeChange();
	</script>
</body>
</html>