<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>角色管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				角色管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/role/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_platform" class="col-sm-4 control-label">所属平台：</label>
								<div class="col-sm-8">
									<select name="search_EQI_platform" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1112" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_companyName"
									class="col-sm-4 control-label">公司名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_name" class="col-sm-4 control-label">角色名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_name">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/role/create"
						class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
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
		<div id="tableDiv">
			<jdf:table items="items" retrieveRowsCallback="limit" var="currentRowObject" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
				<jdf:export view="csv" fileName="Role.csv" tooltip="Export CSV" imageName="csv" />
				<jdf:export view="xls" fileName="Role.xls" tooltip="Export EXCEL" imageName="xls" />
				<jdf:row>
					<jdf:column alias="操作" title="操作" sortable="false" viewsAllowed="html" style="width: 30%;">
						<a href="${dynamicDomain}/role/edit/${currentRowObject.objectId}"
                          class="btn btn-primary btn-mini"> 
                          <i class="glyphicon glyphicon-pencil"></i>
                        </a>
                        <a href="javascript:deleteRole('${currentRowObject.objectId }');"
                          class="btn btn-danger btn-mini"><i class="glyphicon glyphicon-trash"></i>
                        </a>
                        <a href="${dynamicDomain}/role/editRoleMenu/${currentRowObject.objectId}"
							class="btn btn-primary btn-mini">分配权限
						</a>
            
						<a href="${dynamicDomain}/role/editRoleUser/${currentRowObject.objectId}"
							class="btn btn-primary btn-mini">分配用户
						</a>
					</jdf:column>
					<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:4%;text-align:center" sortable="false"/>
					<jdf:column property="type" title="所属平台" style="width:10%;">
						<jdf:columnValue dictionaryId="1112" value="${currentRowObject.platform}" />
					</jdf:column>
					<jdf:column property="companyName" title="公司名称" style="width:10%;">
          <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">${currentRowObject.companyName }</div>
                    </jdf:column>
					<jdf:column property="roleCode" title="角色代码" style="width:10%;">
          <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.roleCode}">${currentRowObject.roleCode }</div>
                    </jdf:column>
					<jdf:column property="name" title="角色名称" style="width:10%;">
          <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.name}">${currentRowObject.name }</div>
              </jdf:column>
					<jdf:column property="remark" title="备注" style="width:20%;">
          <div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.remark}">${currentRowObject.remark }</div>
              </jdf:column>
				</jdf:row>
			</jdf:table>
		</div>
	</div>
<script type="text/javascript">
function deleteRole(roleId){
	if(confirm("您确认删除？")){
	$.ajax({
		url : "${dynamicDomain}/role/deleteRole/" + roleId + "?timstamp=" + (new Date()).valueOf(),
		type : 'post',
		dataType : 'json',
		success : function(msg) {
			if (msg.result) {
				ec.submit();
			}else{
				alert("此角色下有使用用户，不可删除");
			}
		}
	});
	}
}
</script>
</body>
</html>