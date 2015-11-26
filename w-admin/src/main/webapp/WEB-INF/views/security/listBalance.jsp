<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>积分异常管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				积分异常管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/balance/index" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label for="search_LIKES_userName" class="col-sm-4 control-label">用户姓名：</label>
									<div class="col-sm-8">
										<input type="text" class="search-form-control" name="search_LIKES_userName">
									</div>
								</div>
							</div>
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label for="search_LIKES_loginName" class="col-sm-4 control-label">登录名：</label>
									<div class="col-sm-8">
										<input type="text" class="search-form-control" name="search_LIKES_loginName">
									</div>
								</div>
							</div>
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label for="search_LIKES_loginName" class="col-sm-4 control-label">查询范围：</label>
									<div class="col-sm-8">
										<label><input type="radio" name="search_EQI_notAll" value="">全部</label>
										<label><input type="radio" name="search_EQI_notAll" value="1">异常数据</label>
									</div>
								</div>
							</div>
						</div>
					<div class="box-footer">
						<a href="javascript:updateBalance();" class="pull-left btn btn-primary">
							强制更新帐户积分
						</a>
						<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
							<button type="submit" class="btn btn-primary">查询</button>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
		<div id="tableDiv">
			<jdf:table items="items" action="index" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit">
				<jdf:export view="csv" fileName="异常积分.csv" tooltip="Export CSV" imageName="csv" />
				<jdf:export view="xls" fileName="异常积分.xls" tooltip="Export EXCEL" imageName="xls" />
				<jdf:row>
					<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
						<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
					</jdf:column>
					<jdf:column alias="积分调整" title="积分调整" sortable="false" viewsAllowed="html" style="width: 10%;">
						<input type="text" name="balance" id="balance${currentRowObject.objectId}" value="" class="order-form-control" style="width: 100px;">
					</jdf:column>
					<jdf:column property="userName" title="姓名" sortable="false" style="width:10%;"/>
					<jdf:column property="loginName" title="登录名" sortable="false" style="width:10%;"/>
					<jdf:column property="type" title="用户类型" sortable="false" style="width:10%;">
						<jdf:columnValue dictionaryId="1111" value="${currentRowObject.type}" />
					</jdf:column>
					<jdf:column property="accountBalance" title="当前积分" sortable="false" style="width:20%;" cell="currency"/>
					<jdf:column property="password" title="校正积分" sortable="false" style="width:20%;">
						<a href="${dynamicDomain}/balance/detail/${currentRowObject.objectId}?ajax=1" class="colorbox-double-template">${currentRowObject.password }</a>
					</jdf:column>
					<jdf:column property="remark" title="发放积分" sortable="false" style="width:20%;">
						<a href="${dynamicDomain}/balance/grantDetail/${currentRowObject.objectId}?ajax=1" class="colorbox-double-template">${currentRowObject.remark }</a>
					</jdf:column>
				</jdf:row>
			</jdf:table>
		</div>
	</div>
<script type="text/javascript">
function updateBalance(){
	var balances = getUpdateColumnString("balance");
	var userIds = getCheckedValuesString($("[name='schk']"));
	if(userIds==null){
		winAlert("请至少选择一条记录");
		return false;
	}
	window.location="${dynamicDomain}/balance/update?userIds=" + userIds + "&balances=" + balances;
}

function getUpdateColumnString(elementName, split) {
	var checkItem = document.getElementsByName("schk");
	if (split == null) {
		split = ",";
	}
	str = "";
	for (var i = 0; i < checkItem.length; i++) {
		if (checkItem[i].checked == true) {
			str = appendSplit(str, $("#" +elementName + $(checkItem[i]).val()).val(), split);
		}
	}
	if (str == ""){
		return null;
	}
	return str;
}

</script>
</body>
</html>