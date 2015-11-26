<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<base target="_self"/>
</head>
<body>
	<div class="editForm">
		<h3>文件策略列表</h3>
		<div class="content" id="order">
			<jdf:form bean="request" scope="request">
				<form action="${dynamicDomain}/fileStrategy/page" method="post">
					<ul>
						<li>
							<label for="search_LIKES_appName">应用名称：</label>
							<input type="text" name="search_LIKES_appName" size="12"/>
						</li>
						<li>
							<label for="search_EQI_catalogType">目录分类：</label>
							<select name="search_EQI_catalogType" style="width: 150px;">
								<option value=""></option>
								<jdf:select dictionaryId="122"/>
							</select>
						</li>
						<li>
							<label for="search_EQI_compressType">压缩类型：</label>
							<select name="search_EQI_compressType">
								<option value=""></option>
								<jdf:select dictionaryId="120"/>
							</select>
						</li>
						<li>
							<label for="search_EQI_storeType">存储方式：</label>
							<select name="search_EQI_storeType">
								<option value=""></option>
								<jdf:select dictionaryId="121"/>
							</select>
						</li>
						<li>
							<label for="search_LIKES_storagePath">存储路径：</label>
							<input type="text" name="search_LIKES_storagePath" size="12"/>
						</li>
					</ul>
					<div class="btns">
						<button type="reset">重置</button><button type="submit">	查询</button>
					</div>
				</form>
			</jdf:form>
		</div>
	</div>
	<div class="message"><%=message %></div>
	<div class="rightToolBar">
		<a href="${dynamicDomain}/fileStrategy/create" class="button">增加</a>
	</div>
	<div id="tableDiv">
		<jdf:table items="items"  retrieveRowsCallback="limit" var="fileStrategy" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export fileName="文件策略.csv" tooltip="导出CSV" />
			<jdf:export fileName="文件策略.xls" tooltip="导出EXCEL"/>
			<jdf:row>
				<jdf:column property="appName" title="应用名称" style="width: 10%" />
				<jdf:column property="catalogType" title="目录分类" style="width: 10%">
					<jdf:columnValue dictionaryId="122" value="${fileStrategy.catalogType}"/>
				</jdf:column>
				<jdf:column property="compressType" title="压缩类型" style="width: 10%" >
					<jdf:columnValue dictionaryId="120" value="${fileStrategy.compressType}"/>
				</jdf:column>
				<jdf:column property="storagePath" title="存储路径" style="width: 10%" />
				<jdf:column property="storeType" title="存储方式" style="width: 10%">
					<jdf:columnValue dictionaryId="121" value="${fileStrategy.storeType}"/>
				</jdf:column>
				<jdf:column alias="操作" sortable="false" viewsAllowed="html" style="width: 10%">
					<a href="${dynamicDomain}/fileStrategy/edit/${fileStrategy.objectId}">修改</a>
					<a href="#" onclick="toDeleteUrl('${dynamicDomain}/fileStrategy/delete/${fileStrategy.objectId}')">删除</a>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>
