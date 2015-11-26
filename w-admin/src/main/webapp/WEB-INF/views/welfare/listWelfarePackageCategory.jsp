<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>套餐类型管理</title>


</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				套餐类型管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfarePackageCategory/page" method="post"  class="form-horizontal"  id="welfarePackageCategoryList">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐类型：</label>
								<div class="col-sm-8">
									<select name="search_EQI_packageType" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1602" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-5 col-md-5">
							<div class="form-group">
								<label class="col-sm-4 control-label">预算等级：</label>
								<div class="col-sm-3">
									 <select name="search_GEI_packageBudget" class="search-form-control">
									 <option value="">—全部—</option>
										<jdf:select dictionaryId="1603" />
									 </select>
								</div>
								<div class="col-sm-2 " ><span class="lable-span">—</span></div>
								<div class="col-sm-3">
									 <select name="search_LEI_packageBudget" class="search-form-control">
									 <option value="">—全部—</option>
										<jdf:select dictionaryId="1603" />
									 </select>
								</div>
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/welfarePackageCategory/create?ajax=1" class="colorbox-mini-iframe  pull-left btn btn-primary">
						<span class="glyphicon glyphicon-plus"></span>
					</a> 
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="invalid();">置为无效</button>
					</div> 
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
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="welfareItem.csv" tooltip="Export CSV" imageName="csv" />
			<jdf:export view="xls" fileName="welfareItem.xls" tooltip="Export EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate"  title="操作" sortable="false" viewsAllowed="html"  style="width: 10%;text-align: center;">
					<a
						href="${dynamicDomain}/welfarePackageCategory/edit/${currentRowObject.objectId}?ajax=1"
						class="btn btn-primary colorbox-mini-iframe "> <i  class="glyphicon glyphicon-pencil"></i> 
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="packageNo" title="套餐类型编号"  style="width:25%" />
				<jdf:column property="packageType" title="套餐类型"  style="width:15%" >
					<jdf:columnValue dictionaryId="1602"	value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="packageBudget" title="预算等级"	style="width:15%" >
					<jdf:columnValue dictionaryId="1603"	value="${currentRowObject.packageBudget}" />
				</jdf:column>		
				<jdf:column property="firstParameter" title="属性"	style="width:10%" >
					${currentRowObject.firstParameter } 选 ${currentRowObject.secondParameter }
				</jdf:column>
				<jdf:column property="status" title="状态"	style="width:10%">
					<jdf:columnValue dictionaryId="111"	value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
<script type="text/javascript">
	function invalid(){
		$("#welfarePackageCategoryList").attr("action","${dynamicDomain}/welfarePackageCategory/updateToPage?parentItemId=${parentItemId}&invalid=1") ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#welfarePackageCategoryList").submit();
	}
</script>
</body>
</html>