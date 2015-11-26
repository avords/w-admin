<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>积分操作记录</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				积分操作记录(${user.userName})
			</h4>
		</div>
		<div id="tableDiv">
			<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${user.objectId}?ajax=1">
				<jdf:export view="csv" fileName="积分操作历史.csv" tooltip="Export CSV" imageName="csv" />
				<jdf:export view="xls" fileName="积分操作历史.xls" tooltip="Export EXCEL" imageName="xls" />
				<jdf:export view="xls" fileName="积分操作历史.xls" tooltip="Export EXCEL" text="ALL" imageName="xls" />
				<jdf:row>
					<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false" viewsAllowed="html"/>
					<jdf:column property="objectId" title="ID" style="width:10%;" viewsDenied="html"/>
					<jdf:column property="createDate" title="操作时间" cell="date" format="yyyy-MM-dd HH:mm:ss" style="width:15%;"/>
					<jdf:column property="balance" title="余额" style="width:10%;" cell="currency"/>
					<jdf:column property="amount" title="操作分数" style="width:10%;" cell="currency"/>
					<jdf:column property="type" title="操作类型" style="width:10%;">
						<jdf:columnValue dictionaryId="2001" value="${currentRowObject.type}" />
					</jdf:column>
					<jdf:column property="reason" title="搞要" style="width:30%;"/>
					<jdf:column property="linkId" title="关联ID" style="width:10%;"/>
					<jdf:column property="operateUserId" title="操作帐号ID" style="width:10%;" viewsDenied="html"/>
					<jdf:column property="status" title="状态" style="width:10%;">
						<c:if test="${currentRowObject.status ==1}">成功</c:if>
						<c:if test="${currentRowObject.status ==0}">取消</c:if>
					</jdf:column>
				</jdf:row>
			</jdf:table>
		</div>
	</div>
</body>
</html>