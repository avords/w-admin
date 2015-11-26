<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="FilterMultSelect.js" />
<title>用户角色配置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">用户角色配置-${user.userName}</h4>
		</div>
		<form action="${dynamicDomain}/user/saveUserRole"
			method="post" name="UserRole" id="UserRole" class="form-horizontal"
			onsubmit="prepare();">
			<input type="hidden" name="userId" value="${user.objectId}">
			<div class="box-body">
				<div class="row">
					<div class="col-sm-6 col-md-6" style="text-align: left;">
							<div class="form-group" style="text-align: left;">
								<label for="platform" class="col-sm-3 control-label">未选择列表</label>
								<div class="col-sm-5">
									<input class="search-form-control" type="text" name="rightInput" id="rightInput"/>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6" style="text-align: right;">
							<div class="form-group" style="text-align: right;">
								<label for="platform" class="col-sm-6 control-label" >已选择列表</label>
								<div class="col-sm-5">
									<input class="search-form-control" type="text" name="leftInput" id="leftInput"/>
								</div>
							</div>
						</div>
				</div>
				<div class="row">
					<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<div class="col-sm-12">
									<select multiple class="form-control" name="unSelected" id="unSelected" style="height: 300px;">
								<jdf:selectCollection items="notHaveRoles" optionValue="objectId" optionText="name" />
							</select>
								</div>
							</div>
						</div>
						<div class="col-sm-2 col-md-2">
							<div class="form-group" style="text-align: center;margin-top: 100px; ">
								<div class="glyphicon glyphicon-backward" id="leftToRight"></div>
							</div>
						</div>
						<div class="col-sm-2 col-md-2">
							<div class="form-group" style="text-align: center;margin-top: 100px; ">
								<div class="glyphicon glyphicon-forward" id="rightToLeft"></div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<div class="col-sm-12">
									<select multiple class="form-control" name="roleIds" id="selected" style="height: 300px;">
								<jdf:selectCollection items="haveRoles" optionValue="objectId" optionText="name" />
							</select>
								</div>
							</div>
						</div>
				</div>
				<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">保存</button>
                                <a href="${dynamicDomain}/user/page" class="btn btn-primary">返回</a>
							</div>

						</div>
					</div>
			</div>
		</form>
	</div>
	<script type="text/javascript">
	function prepare() {
		var theform = document.UserRole;
		var userIdSelected = theform.selected;
		for (var i = userIdSelected.options.length - 1; i >= 0; i--) {
			userIdSelected.options[i].selected = true;
		}
//			$("#unSelected").empty();
	}
		$(document).ready(
				function() {
					filterMultSelect("selected", "unSelected", "rightToLeft",
							"leftToRight", "leftInput", "rightInput",
							"leftFilter", "rightFilter");
					refreshParentPage(false);
				});
	</script>
</body>
</html>