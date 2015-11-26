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
			<jdf:table items="items" action="${user.objectId}?ajax=1">
				<jdf:export view="csv" fileName="积分发放历史.csv" tooltip="Export CSV" imageName="csv" />
				<jdf:export view="xls" fileName="积分发放历史.xls" tooltip="Export EXCEL" imageName="xls" />
				<jdf:row>
					<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false" viewsAllowed="html"/>
					<jdf:column property="objectId" title="ID" style="width:10%;" sortable="false"/>
					<jdf:column property="distributeId" title="发放ID" style="width:10%;" sortable="false"/>
					<jdf:column property="receiveDate" title="领取时间" cell="date" format="yyyy-MM-dd HH:mm:ss" style="width:15%;" sortable="false"/>
					<jdf:column property="point" title="发放积分" style="width:10%;" cell="currency" sortable="false"/>
					<jdf:column property="rewardId" title="奖励ID" style="width:10%;" sortable="false"/>
					<jdf:column property="status" title="状态" style="width:10%;" sortable="false">
						<c:if test="${currentRowObject.status ==1}">已领取</c:if>
						<c:if test="${currentRowObject.status ==0}">未领取</c:if>
						<c:if test="${currentRowObject.status ==2}">待确认</c:if>
					</jdf:column>
				</jdf:row>
			</jdf:table>
		</div>
	</div>
</body>
</html>