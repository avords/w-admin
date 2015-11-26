<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="contentBody contentborder">
		<div class="tab-pane" id="tabPane">
			<div id="message"><%=message %></div>
			<div class="tab-page" id="tabPage1">
				<h1 class="tab">属地配置详情</h1>
				<div class="contentborder tableForm">
					<jdf:form bean="entity" scope="request">
						<form action="${dynamicDomain}/dimLocation/save" method="post">
							<input type="hidden" name="id">
							<input type="hidden" name="objectId" id="objectId">
							<table class="inputTable">
							    <tr class="BorderBottom">
									<td nowrap class="label cancelBorderLeft">
										<label for="fullCode">属地全路径编码：</label>
									</td>
									<td class="content">
										<input type="text" name="fullCode" size="20"/>
									</td>
									<td nowrap class="label">
										<label for="fullName">属地全路径名称：</label>
									</td>
									<td class="content">
										<input type="text" name="fullName" size="20"/>
									</td>
								</tr>
								<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="category">类别：</label>
									</td>
									<td class="content" colspan="3">
										<select name="category">
											<option value=""></option>
											<jdf:select dictionaryId="125"/>
										</select>
									</td>
								</tr>
								<tr>
									<td class="bottomLabel" nowrap colspan="6">
										<div class="right">
											<button type="submit">提交</button>
											<c:if test="${not empty message}">
											<button type="button" onclick="toUrl('${dynamicDomain}/dimLocation/create')">继续增加</button>
											</c:if>
											<button type="button" id="delete" onclick="toDeleteUrl('${dynamicDomain}/dimLocation/delete/${entity.id}')">删除</button>
											<button type="button" onclick="toUrl('${dynamicDomain}/dimLocation/page')">返回</button>
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
	<jdf:tableLabelValidate domain="DimLocation"/>
	<script language = "javascript">
		if($("#objectId").val()==''){
			$("#delete").attr("disabled",true);
		}
	</script>
</body>
</html>