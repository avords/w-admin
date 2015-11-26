<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检项目发布报价查询</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检项目发布报价查询
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalPricePublished/page" method="post"  id="PhysicalPricePublished" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="supplierPriceArray" id="supplierPriceArray">
				<input type="hidden" name="marketPriceArray" id="marketPriceArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									<select name="search_EQI_supplierId" class="search-form-control"  id="supplierName">
										<option value=""></option>
										<jdf:selectCollection items="supplierList" optionValue="objectId"  optionText="supplierName" />
									</select>
									<!-- 
									<input type="text"  name="search_LIKES_supplierName" class="search-form-control"  id="supplierName">
									-->
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">一级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_firstItemName" class="search-form-control"  id="firstItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">二级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_secondItemName" class="search-form-control"  id="secondItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="status" class="search-form-control">
										<option value="">全部</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="physicalPricePublished.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicalPricePublished.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<%-- <jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column> --%>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="supplierName" title="供应商" style="width:15%" />
				<jdf:column property="firstItemName" title="一级项目" style="width:10%" >
					${currentRowObject.firstItemName}
				</jdf:column>
				<jdf:column property="secondItemName" title="二级项目" style="width:10%" />
				<jdf:column property="supplierPrice" title="供货价" style="width:5%" >
				</jdf:column>
				<jdf:column property="marketPrice" title="门市价" style="width:5%" >
				</jdf:column>
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="auditStatus" title="审核状态"  style="width:10%">
					<jdf:columnValue dictionaryId="1605" value="${currentRowObject.auditStatus}" />
				</jdf:column>
				<jdf:column property="updatedBy" title="修改人"  style="width:10%">
					<jdf:columnValue dictionaryId="1605" value="${currentRowObject.updatedBy}" />
				</jdf:column>
				<jdf:column property="updatedOn" title="修改时间"  style="width:10%"  >
					<fmt:formatDate value="${currentRowObject.updatedOn }" pattern=" yyyy-MM-dd  HH:mm"/>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>