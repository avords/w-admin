<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>合同管理</title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				合同管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/contract/page" method="post"
				class="form-horizontal">
				<div class="box-body">
				
				<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_type" class="col-sm-4 control-label">签订对象：</label>
								<div class="col-sm-8">
									<select name="search_EQI_customerType" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1204" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">合同编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_contractNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">

								<label class="col-sm-4 control-label">对方名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_customerName">
								</div>
							</div>
						</div>
					</div>
			<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">对方编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_customerNo">
								</div>
							</div>
						</div>
					</div>
				
				
				<div class="box-footer">
					<a href="${dynamicDomain}/contract/create" class="btn btn-primary progressBtn" >
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					
					<c:if test="${not empty filePath}">
					<a href='${dynamicDomain}/contract/downloadFile?filePath=${filePath}' class="btn btn-primary progressBtn">下载模板</a>
					</c:if>
					<c:if test="${empty filePath}">
						请先上传模板！
					</c:if>
					<a href="${dynamicDomain}/contract/importTemplate?ajax=1"class="colorbox btn btn-primary progressBtn">上传模板</a>
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
			<jdf:export view="csv" fileName="合同列表.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="合同列表.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 13%">
					<a href="${dynamicDomain}/contract/edit/${currentRowObject.objectId}" class="btn btn-primary"> 
						<i class="glyphicon glyphicon-pencil"> </i> 
					</a>
					<a
						href="javascript:toDeleteUrl('${dynamicDomain}/contract/delete/${currentRowObject.objectId}')"
						class="btn btn-danger btn-mini"><i class="glyphicon glyphicon-trash"></i>
					</a>
					 <a href='${dynamicDomain}/contract/downloadFile?filePath=${currentRowObject.attachmentNo}' class="btn btn-primary" > 
					 	下载
					</a> 
					
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
				<%-- <jdf:column property="contractNo" title="合同编号" headerStyle="width:8%;" >
					<div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.contractNo}">${currentRowObject.contractNo}</div>
				</jdf:column> --%>
				
				  <jdf:column property="1" title="合同编号"  headerStyle="width:8%;" viewsDenied="xls" >
		                <div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.contractNo}">${currentRowObject.contractNo}</div>
			       </jdf:column>
			       <jdf:column property="contractNo" title="合同编号"  headerStyle="width:8%;" viewsDenied="html">
		                  <div class="text-ellipsis" style="width: 80px;" title="${currentRowObject.contractNo}">${currentRowObject.contractNo}</div>
			       </jdf:column>
			      
				<jdf:column property="customerName" title="对方名称" headerStyle="width:10%;" >
					<div class="text-ellipsis" style="width: 100px;" title="${currentRowObject.customerName}">${currentRowObject.customerName}</div>
				</jdf:column>
				<jdf:column property="customerType" title="合同签订对象" headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="1204" value="${currentRowObject.customerType}" />
				</jdf:column>
				<jdf:column property="managerId" title="客户经理" headerStyle="width:6%;" />
				<jdf:column property="startDate" title="有效期" style="width:15%" >
					<fmt:formatDate value="${currentRowObject.startDate}" pattern=" yyyy-MM-dd "/>
						~
					<fmt:formatDate value="${currentRowObject.endDate}" pattern=" yyyy-MM-dd "/>
				</jdf:column>
				<jdf:column property="uploadUserId" title="上传人" headerStyle="width:6%;" />
				<jdf:column property="uploadDate" title="上传时间"  style="width:10%" >
					<fmt:formatDate value="${currentRowObject.uploadDate}" pattern=" yyyy-MM-dd HH:mm:ss"/>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>