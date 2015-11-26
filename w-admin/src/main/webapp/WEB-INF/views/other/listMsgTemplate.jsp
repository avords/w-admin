<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>
<jdf:message code="短信通知模版">
</jdf:message>
</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<jdf:message code="短信通知模版" />
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/other/msgTemplate/queryMsgList"
				method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label type="button" class="form-lable">模版名称：</label>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_messageName">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label type="button" class="form-lable">状态：</label>
								</div>
								<select name="search_EQI_status" class="search-form-control">
									<option value="">—全部—</option>
									<jdf:select dictionaryId="1110" valid="true" />
								</select>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
                    <a href="${dynamicDomain}/other/msgTemplate/createMsg" class="btn btn-primary">
                            <span class="glyphicon glyphicon-plus"></span>
                    </a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="queryMsgList">
			<jdf:export view="csv" fileName="brand.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="brand.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 6%">
					<a href="${dynamicDomain}/other/msgTemplate/edit/${currentRowObject.objectId}?str=editMsg" class="btn btn-primary btn-mini"><i class="glyphicon glyphicon-pencil"></i></a>
					<a href="javascript:toDeleteUrl('${dynamicDomain}/other/msgTemplate/deleteMsg/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
					 <i class="glyphicon glyphicon-trash"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
				<jdf:column property="messageName" title="模版名称" headerStyle="width:8%;">
				    <div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.messageName}">${currentRowObject.messageName}</div>
			    </jdf:column>
				<jdf:column property="messageContent" title="短信内容" headerStyle="width:8%;" sortable="false">
					<div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.messageContent}">${currentRowObject.messageContent}</div>
				</jdf:column>
				<jdf:column property="status" title="是否有效" headerStyle="width:5%;">
					<jdf:columnValue dictionaryId="1110"
						value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="updatedUser" title="更新人" headerStyle="width:8%;"/>
		        <jdf:column property="updatedOn" title="更新时间" headerStyle="width:8%;">
		            <fmt:formatDate value="${currentRowObject.updatedOn}" pattern="yyyy-MM-dd HH:mm:ss"/>
		        </jdf:column>
		        <jdf:column property="createdUser" title="创建人" headerStyle="width:8%;"/>
		        <jdf:column property="createdOn" title="创建时间" headerStyle="width:8%;">
		        	<fmt:formatDate value="${currentRowObject.createdOn}" pattern="yyyy-MM-dd HH:mm:ss"/>
		        </jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>