<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>用户管理</title>
</head>
<body>
	<div>
	<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				用户管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/user/page" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_type" class="col-sm-4 control-label">用户类型：</label>
								<div class="col-sm-8">
									<select name="search_EQI_type" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1111" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_userName" class="col-sm-4 control-label">用户姓名：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_userName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_mobilePhone" class="col-sm-4 control-label">联系方式：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_mobilePhone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户邮箱：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_email">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户帐户：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_loginName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">公司名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
					</div>
          
					<div class="row">
                        <div class="col-sm-4 col-md-4">
                          <div class="form-group">
                            <label for="search_ICI_isAgency" class="col-sm-4 control-label">是否代理：</label>
                            <div class="col-sm-8">
                              <jdf:checkBox dictionaryId="1124" name="search_ICI_isAgency" />
                            </div>
                          </div>
                        </div>
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="search_ICI_status" class="col-sm-2 control-label">用户状态：</label>
								<div class="col-sm-6">
									<jdf:checkBox dictionaryId="1109" name="search_ICI_status"/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/user/create"
						class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					<a href="javascript:initUserPassword();" class="pull-left btn btn-primary">
						密码初始化
					</a>
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
						<button type="submit" class="btn btn-primary">查询
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="user.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
            <c:choose> 
                     <c:when test="${currentRowObject.status!=3 }">
      				    <jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" style="width: 4%;text-align: center;"
      					headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
      					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
            	       </jdf:column>
                    </c:when>
                    <c:otherwise>
                    <jdf:column property="objectId">&nbsp;</jdf:column>
                    </c:otherwise>
             </c:choose>
				<jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 22%;">
					<c:if test="${currentRowObject.status!=3 }">
					 <a href="${dynamicDomain}/user/edit/${currentRowObject.objectId}"
                      class="btn btn-primary btn-mini"><i class="glyphicon glyphicon-pencil"></i>
                    </a>
                    <a href="javascript:deleteUser('${currentRowObject.objectId }');"
						class="btn btn-danger btn-mini"><i class="glyphicon glyphicon-trash"></i>
					</a>
					<a href="${dynamicDomain}/user/editUserRole/${currentRowObject.objectId}" class="btn btn-primary btn-mini">分配角色
						</a>
						<c:choose>
							<c:when test="${currentRowObject.status==2 }">
								<a href="javascript:unLockUser('${currentRowObject.objectId }');" class="btn btn-primary btn-mini">解除冻结
								</a>
							</c:when>
							<c:when test="${currentRowObject.status!=0 }">
								<a href="javascript:lockUser('${currentRowObject.objectId }');" class="btn btn-primary btn-mini">冻结
								</a>
							</c:when>
						</c:choose>
						</c:if>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="type" title="用户类型" headerStyle="width:6%;">
					<div class="text-ellipsis" style="width: 80px;"><jdf:columnValue dictionaryId="1111" value="${currentRowObject.type}" /></div>
				</jdf:column>
				<jdf:column property="userResources" title="用户来源" headerStyle="width:6%;">
					<jdf:columnValue dictionaryId="1113" value="${currentRowObject.userResources}" />
				</jdf:column>
				<jdf:column property="loginName" title="用户帐户" headerStyle="width:8%;" />
				<jdf:column property="companyName" title="公司名称" headerStyle="width:8%;">
					<div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.companyName}">${currentRowObject.companyName}</div>
				</jdf:column>
				<jdf:column property="userName" title="用户姓名" headerStyle="width:8%;">
				<div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.userName}">${currentRowObject.userName}</div>
				</jdf:column>
				<jdf:column property="mobilePhone" title="联系方式" headerStyle="width:8%;" />
				<jdf:column property="email" title="用户邮箱" headerStyle="width:8%;">
				<div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.email}">${currentRowObject.email}</div>
				</jdf:column>
				<jdf:column property="status" title="状态" headerStyle="width:6%;">
					<jdf:columnValue dictionaryId="1109" value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		function unlock(loginName) {
			$(".unlock").attr("disabled", true);
			$.ajax({
				url : "${dynamicDomain}/user/unlock/" + loginName
						+ "?timstamp=" + (new Date()).valueOf(),
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						showMessage("解锁成功", 60000);
					}
					$(".unlock").attr("disabled", false);
				}
			});
		}
		
		function lockUser(userId){
			if(confirm("您确认冻结该账户吗？")){
			$.ajax({
				url : "${dynamicDomain}/user/lockUser/" + userId + "?timstamp=" + (new Date()).valueOf(),
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						ec.submit();
					}
				}
			});
			}
		}
		
		function unLockUser(userId){
			$.ajax({
				url : "${dynamicDomain}/user/unLockUser/" + userId + "?timstamp=" + (new Date()).valueOf(),
				type : 'post',
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						ec.submit();
					}
				}
			});
		}
		
		function deleteUser(userId){
			if(confirm("您确认删除？")){
				$.ajax({
					url : "${dynamicDomain}/user/deleteUser/" + userId + "?timstamp=" + (new Date()).valueOf(),
					type : 'post',
					dataType : 'json',
					success : function(msg) {
						if (msg.result) {
							ec.submit();
						}else{
							winAlert(msg.message);
						}
					}
				});
			}
			
		}

		function initUserPassword()
		{
			
			var userIds;
			try{
				userIds = getCheckedValuesString($("input[name='schk']")).split(",");
			}catch(e){
				winAlert("请选择需要初始化的用户");
				return;
			}
			if(confirm("您确认进行初始化吗？")){
			$.ajax(
			{
				url : "${dynamicDomain}/user/initUserPassword",
				type : 'post',
				dataType : 'json',
				data : "ids=" + userIds + "&timstamp=" + (new Date()).valueOf(),
				success : function(msg)
				{
						alert(msg.result);
				},error: function(XMLHttpRequest, textStatus, errorThrown) {
              alert("系统异常，请联系管理员");
          	}
			});
		}}
	</script>
</body>
</html>