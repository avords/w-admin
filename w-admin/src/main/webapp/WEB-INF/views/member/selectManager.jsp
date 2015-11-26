<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业跟进</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				客户经理列表
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/callOn?ajax=1" method="post" class="form-horizontal">
				<div class="box-body">
					<input type="hidden" name="ids" id="ids">
				</div>
				<div class="box-footer">
					<div class="row">
						<table align="center"><tr>
						<td><b>姓名：</b></td>
						<td style="padding-left: 10px;"><input type="text" class="search-form-control" name="search_LIKES_userName"></td>
						<td style="padding-left: 10px;"><button type="submit" class="btn btn-primary">
							<span class="glyphicon glyphicon-search"></span>
							<jdf:message code="common.button.query" />
						</button></td>
						</tr></table>						
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="callOn?ajax=1">
			<jdf:export view="csv" fileName="manager.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="manager.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='hidden'>" headerStyle="width:1%;"  >
				<input type="hidden" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" id="c_${currentRowObject.objectId}"/>
					<script>
						$("#c_${currentRowObject.objectId}").parent().parent().css("cursor","pointer").bind("dblclick",function(){selectManager(${currentRowObject.objectId})});
					</script>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 30%" style="text-align:center" sortable="false" />
				<jdf:column property="userName" title="姓名" headerStyle="width:30%;" />
				<jdf:column property="loginName" title="账户" headerStyle="width:39%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	 function selectManager(userId){
		 $.ajax({  
		    url:"${dynamicDomain}/company/saveManager2Company",
			type : 'post',
			data : "ids=${param.ids}&userId="+userId+'&data='+ (new Date().getDate()),
			dataType : 'json',
			success : function(msg) {
				if(msg.result==true){
					window.parent.location.reload();
				}
			}
		});
	 }
	</script>
</body>
</html>