<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="contentBody contentborder">
		<div class="tab-pane" id="tabPane">
			<div id="message"><%=message %></div>
			<div class="tab-page" id="tabPage1">
				<h1 class="tab">文件策略详情</h1>
				<div class="contentborder tableForm">
					<jdf:form bean="entity" scope="request">
						<form action="${dynamicDomain}/fileStrategy/save" method="post">
							<input type="hidden" name="id">
							<input type="hidden" name="objectId" id="objectId">
							<table class="inputTable">
							    <tr class="BorderBottom">
									<td nowrap class="label cancelBorderLeft">
										<label for="appName">应用名称：</label>
									</td>
									<td class="content">
										<input type="text" name="appName" size="20"/>
									</td>
									<td nowrap class="label">
										<label for="catalogType">目录分类：</label>
									</td>
									<td class="content">
										<select name="catalogType" style="width: 150px;">
											<option value=""></option>
											<jdf:select dictionaryId="122"/>
										</select>
									</td>
								</tr>
								<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="compressType">压缩类型：</label>
									</td>
									<td class="content">
										<select name="compressType">
											<option value=""></option>
											<jdf:select dictionaryId="120"/>
										</select>
									</td>
									<td nowrap class="label">
										<label for="storeType">存储方式：</label>
									</td>
									<td class="content">
										<select name="storeType">
											<option value=""></option>
											<jdf:select dictionaryId="121"/>
										</select>
									</td>
								</tr>
								<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="ftpIp">主机：</label>
									</td>
									<td class="content">
										<input type="text" name="ftpIp" size="20"/>
									</td>
									<td nowrap class="label">
										<label for="ftpPort">端口：</label>
									</td>
									<td class="content">
										<input type="text" name="ftpPort" size="20"/>
									</td>
								</tr>
								<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="ftpUser">帐号：</label>
									</td>
									<td class="content">
										<input type="text" name="ftpUser" size="20"/>
									</td>
									<td nowrap class="label">
										<label for="ftpPassword">密码：</label>
									</td>
									<td class="content">
										<input type="text" name="ftpPassword" size="20"/>
									</td>
								</tr>
								<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="storagePath">存储路径：</label>
									</td>
									<td class="content" colspan="3">
										<input type="text" name="storagePath" size="20"/>
									</td>
 								</tr>
								<tr>
									<td class="bottomLabel" nowrap colspan="4">
										<div class="right">
											<button type="submit">提交</button>
											<c:if test="${not empty message}">
											<button type="button" onclick="toUrl('${dynamicDomain}/fileStrategy/create')">继续增加</button>
											</c:if>
											<button type="button" id="delete" onclick="toDeleteUrl('${dynamicDomain}/fileStrategy/delete/${entity.objectId}')">删除</button>
											<button type="button" onclick="toUrl('${dynamicDomain}/fileStrategy/page')">返回</button>
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
	<script language = "javascript">
		if($("#objectId").val()==''){
			$("#delete").attr("disabled",true);
		}
	</script>
</body>
</html>