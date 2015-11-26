<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<base target="_self"/>
</head>
<body>
	<div class="editForm">
		<h3>列表</h3>
		<div class="content" id="order">
			<jdf:form bean="request" scope="request">
				<form action="${dynamicDomain}/baseFile/page" method="post">
					<ul>
						<li>
							<label for="search_LIKES_fileId">文件ID：</label>
							<input type="text" name="search_LIKES_fileId" size="12"/>
						</li>
						<li>
							<label for="search_GED_createDate">上传时间：</label>
							<input type="text" name="search_GED_createDate" size="10" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" style="width: 80px;">－<input class="text" type="text" name="search_LED_createDate" size="10" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',readOnly:true})" style="width: 80px;">
						</li>
						<li>
							<label for="search_EQI_fileSize">文件大小：</label>
							<input type="text" name="search_EQI_fileSize" size="12"/>
						</li>
						<li>
							<label for="search_LIKES_name">文件名称：</label>
							<input type="text" name="search_LIKES_name" size="12"/>
						</li>
						<li>
							<label for="search_EQI_status">文件状态：</label>
							<select name="search_EQI_status">
								<option value="">—请选择—</option>
								<jdf:select dictionaryId="123"/>
							</select>
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
		<a href="${dynamicDomain}/baseFile/create" class="button">增加</a>
	</div>
	<div id="tableDiv">
		<jdf:table items="items"  retrieveRowsCallback="limit" var="baseFile" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export fileName=".csv" tooltip="导出CSV" />
			<jdf:export fileName=".xls" tooltip="导出EXCEL"/>
			<jdf:row>
				<jdf:column property="fileId" title="文件ID" style="width: 10%">
				</jdf:column>
				<jdf:column property="createDate" title="上传时间" style="width: 15%" cell="date"/>
				<jdf:column property="fileSize" title="文件大小" style="width: 10%" />
				<jdf:column property="name" title="文件名称" style="width: 10%">
					<a href="download/${baseFile.fileId}">${baseFile.name }</a>
				</jdf:column>
				<jdf:column property="status" title="文件状态" style="width: 10%">
					<jdf:columnValue dictionaryId="123" value="${baseFile.status}"/>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>
