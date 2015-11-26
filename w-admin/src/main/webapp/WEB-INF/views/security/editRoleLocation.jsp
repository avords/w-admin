<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="contentBody contentborder">
		<div class="tab-pane" id="tabPane">
			<div id="message"><%=message %></div>
			<div class="tab-page" id="tabPage1">
				<h1 class="tab">角色属地权限配置</h1>
				<div class="contentborder tableForm">
					<jdf:form bean="entity" scope="request">
						<form action="${dynamicDomain}/role/saveRoleLocation" method="post" onsubmit="prepare();">
							<input type="hidden" name="roleId" value="${role.objectId}">
							<table class="inputTable">
							    <tr>
									<td nowrap class="label cancelBorderLeft cancelBorderRight" colspan="3" style="width: 100%">
										<div style="width: 49%;text-align: center;float: left;">已拥有属地权限：</div>
										<div style="width: 49%;text-align: center;float: left;">待赋予属地权限：</div>
									</td>
								</tr>
								<tr height="height: 300px;">
									<td nowrap class="content" style="width: 48%;padding: 15px;">
										<select name="menuId" id="selected" multiple="multiple" size="20" style="width: 100%">
											<jdf:selectCollection items="haveMenus" optionValue="objectId" optionText="fullName"/>
										</select>
									</td>
									<td class="content" style="width: 20px;text-align: center;vertical-align: middle;">
											<img title="添加选中" src="<jdf:theme/>img/oneLeft.gif" id="rightToLeft" class="moveButton">
											<img title="添加全部" src="<jdf:theme/>img/allLeft.gif" id="allRightToLeft" class="moveButton">
											<img title="删除选中" src="<jdf:theme/>img/oneRight.gif" id="leftToRight" class="moveButton">
											<img title="删除全部" src="<jdf:theme/>img/allRight.gif" id="allLeftToRight" class="moveButton">
									</td>
									<td nowrap class="content" style="width: 48%;padding: 15px;">
										<select name="unSelected" id="unSelected" multiple="multiple" size="20" style="width:100%;">
											<jdf:selectCollection items="notHaveMenus" optionValue="objectId" optionText="fullName"/>
										</select>
									</td>
								</tr>
								<tr>
									<td class="bottomLabel" nowrap colspan="3">
										<div class="right">
											<button type="submit">保存</button>
											<button type="button" onclick="toUrl('${dynamicDomain}/role/page')">返回</button>
										</div>
									</td>
								</tr>
							</table>
						</form>
					</jdf:form>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		new selectMove();
		function prepare() {
			var theform = document.RoleMenu;
			var userIdSelected = theform.selected;
			for(var i = userIdSelected.options.length-1; i >= 0; i--){
				userIdSelected.options[i].selected = true;
			}
			$("#unSelected").empty();
		}
	</script>
</body>
</html>