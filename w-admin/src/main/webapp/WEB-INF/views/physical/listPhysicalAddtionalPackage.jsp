<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检套餐加项包</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐加项包
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalAddtional/page" method="post"  id="PhysicalAddtionalPackage" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_companyName" class="search-form-control"  id="companyName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-6 control-label">主套餐名称：</label>
								<div class="col-sm-6">
									<input type="text"  name="search_LIKES_mainPackageNames" class="search-form-control"  id="mainPackageNames">
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
				   <div class="pull-left">
				    <button type="button" class="btn btn-primary" onclick="create()">
						<span class="glyphicon glyphicon-plus"></span>
					</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary"  onclick="del()">删除</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary"  onclick="putAway(2)">置为无效</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary"  onclick="putAway(1)">置为有效</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary"  onclick="maintainPackageNo()">维护套餐编号</button>
					</div>
					
					
					<div class="pull-right">
						 
						<button type="submit" class="btn btn-primary">查询</button>
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
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
				
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				
				<jdf:column property="companyName" title="企业名称" style="width:10%"  >
				   <c:if  test="${currentRowObject.companyId == 0}">
				            全部企业
				   </c:if>
				</jdf:column>
				
				<jdf:column property="mainPackageNos" title="主套餐编号" style="width:10%" >
				</jdf:column>
				
				<jdf:column property="mainPackageNames" title="主套餐名称" style="width:10%" >
				
				</jdf:column>
				  
				<jdf:column property="addPackageNo" title="加项套餐编号" style="width:10%" >
				</jdf:column>
				
				<jdf:column property="addPackageName" title="加项套餐名称" style="width:10%" >
				</jdf:column>
				
				<jdf:column property="addPackagePrice" title="销售价"  style="width:5%">
				</jdf:column>
				 
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
				 
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function create(){
		window.location.href = "${dynamicDomain}/physicalAddtional/create";
	}
	function del() {
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		
		if(!window.confirm('确定删除？'))
			return false;
		
		$("#PhysicalAddtionalPackage").attr("action","${dynamicDomain}/physicalAddtional/delAddtional") ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#PhysicalAddtionalPackage").submit();
	}
	
	function putAway(status){
		
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		$("#PhysicalAddtionalPackage").attr("action","${dynamicDomain}/physicalAddtional/updateToPage?status="+status) ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#PhysicalAddtionalPackage").submit();
	}
	
	function maintainPackageNo() {
		window.location.href = "${dynamicDomain}/physicalMainAddtional/page";
	}
	
	</script>
</body>
</html>