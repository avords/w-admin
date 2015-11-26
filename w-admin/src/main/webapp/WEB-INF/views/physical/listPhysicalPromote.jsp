<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检套餐升级包管理</title>
<script type="text/javascript">
	function del(){
		$("#physicalpromote").attr("action","${dynamicDomain}/physicalPromote/deletephysicalpromote") ;
		var ret  = document.getElementsByName("schk");
		var chck = getCheckedValuesString(ret);
		if(!chck){
			alert('请选择！');
			return false ;
		}
		if(!window.confirm('确定删除？'))
			return false;
		$("#promoteCodeArray").val(chck);
		$("#physicalpromote").submit();
	}
	
	function select(){
		$("#physicalpromote").attr("action","${dynamicDomain}/physicalPromote/page");
		$("#physicalpromote").submit();
	}
	
	function setStatus(status){
		$("#physicalpromote").attr("action","${dynamicDomain}/physicalPromote/updateToPage?status="+status);
		var ret  = document.getElementsByName("schk");
		var chck = getCheckedValuesString(ret);
		if(!chck){
			alert("请选择！");
			return false ;
		}
		$("#promoteCodeArray").val(chck);
		$("#physicalpromote").submit();
	}
</script>

</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐升级包管理
			</h4>
		</div>		
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physicalPromote/page" method="post"  id="physicalpromote" class="form-horizontal">
				<input type="hidden" name="promoteCodeArray" id="promoteCodeArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_companyName" class="search-form-control"  id="companyName">
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">主套餐名称：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_mainPackageName" class="search-form-control"  id="mainPackageName">
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>						
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<a href="${dynamicDomain}/physicalPromote/createPhysicalPromote" class="btn btn-primary pull-left">
							<span class="glyphicon glyphicon-plus"></span>
						</a>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="del();">删除</button>
					</div> 
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="setStatus(2);">置为无效</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="setStatus(1);">置为有效</button>
					</div>
					<div class="pull-right">
						<button type="button" class="btn btn-primary" onclick="select();">查询</button>
					   <button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
					</div>

				</div>
			</form>
		</jdf:form>		
	</div>
	
	<div>
		<jdf:table items="items"  var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="physicalItem.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicalItem.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 3%;text-align: center;" headerStyle="width: 3%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.promoteCode}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column alias="common.lable.operate" title="操作" sortable="false" viewsAllowed="html" style="width: 3%;text-align:center">
					<a href="${dynamicDomain}/physicalPromote/edit/${currentRowObject.promoteCode}"
						class="btn btn-primary "> <i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:15%;"  >
				    <c:if  test="${currentRowObject.companyId == 0}">
				            全部企业
				   </c:if>
				</jdf:column>
				<jdf:column property="mainPackageNo" title="主套餐编号" headerStyle="width:8%;" />
				<jdf:column property="mainPackageName" title="主套餐名称" headerStyle="width:15%;" />
				 
				<jdf:column property="promotePackageNo" title="升级套餐编号" headerStyle="width:8%;" />
				<jdf:column property="promotePackageName" title="升级套餐名称" headerStyle="width:15%;" />
				 
				<jdf:column property="promotePrice" title="升级价格" headerStyle="width:8%;" />
				<jdf:column property="status" title="状态"  style="width:16%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
</body>
</html>