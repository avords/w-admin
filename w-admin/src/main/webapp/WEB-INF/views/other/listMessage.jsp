<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>
<jdf:message code="短信推送中心"></jdf:message>
</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">
					<c:if test="${message != 'null'}">
						${message}
					</c:if>
				</div>
				<jdf:message code="短信推送中心" />
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/other/page?message" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_GED_createdOn" class="col-sm-4 control-label">创建时间：</label>
								<div class="col-sm-4">
									<input name="search_GET_createdOn" class="search-form-control" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly/>
								</div>
								<div class="col-sm-4">
									<input name="search_LET_createdOn" class="search-form-control" type="text" onFocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly/>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_GED_sendTime" class="col-sm-4 control-label">发送时间：</label>
								<div class="col-sm-4">
									<input name="search_GET_sendTime" class="search-form-control" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly/>
								</div>
								<div class="col-sm-4">
									<input name="search_LET_sendTime" class="search-form-control" type="text" onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" readonly/>
								</div>
							</div>
						</div>
						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_msgContent" class="col-sm-4 control-label">短信内容：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_msgContent">
								</div>
							</div>
						</div>
					</div>
						
						
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_msgStatus" class="col-sm-4 control-label">发送状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_msgStatus" class="search-form-control">
										<jdf:select dictionaryId="1700" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_sendType" class="col-sm-4 control-label">推送类型：</label>
								<div class="col-sm-8">
									<select name="search_EQI_sendType" class="search-form-control">
										<jdf:select dictionaryId="1800" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
                    <a href="${dynamicDomain}/other/create?ajax=1&message" class="btn btn-primary pull-left colorbox-mini">
                        <span class="glyphicon glyphicon-plus"></span>
                    </a>
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="brand.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="brand.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 5%">
					<a href="${dynamicDomain}/other/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-mini">
					 <i class="glyphicon glyphicon-pencil"></i>
					</a>
					<a href="javascript:toDeleteUrl('${dynamicDomain}/other/deleteSendMsg/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
					 <i class="glyphicon glyphicon-trash"></i>
					</a>
				</jdf:column>
				<jdf:column property="sendType" title="推送类型" headerStyle="width:8%;">
					<jdf:columnValue dictionaryId="1800" value="${currentRowObject.sendType}" />
				</jdf:column>
                <jdf:column property="msgStatus" title="发送状态" headerStyle="width:5%;">
               		<jdf:columnValue dictionaryId="1700" value="${currentRowObject.msgStatus}" />
                </jdf:column>
                <jdf:column property="msgContent" title="短信内容" headerStyle="width:5%;" >
                	<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.msgContent}">
						<a href="javascript:void(0);">
							<font style="font-size: 14px;">${currentRowObject.msgContent}</font>
						</a>
					</div>
                </jdf:column>
                
                <jdf:column property="sendTime" title="发送时间"  headerStyle="width:5%;">
               		<fmt:formatDate value="${currentRowObject.sendTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
                </jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>