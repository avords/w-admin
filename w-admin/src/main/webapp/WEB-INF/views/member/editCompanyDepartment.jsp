<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业组织架构设置</title>
<style>
.upView{
	margin:7px 0 0 0;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">企业组织架构设置</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/companyDepartment/saveToPage" id="CompanyDepartment"  class="form-horizontal">
				<input type="hidden" name="objectId" id="objectId">
				<input type="hidden" name="search_EQL_companyId" id="search_EQL_companyId" value="${company.objectId}">
				<input type="hidden" name="headCount">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="companyId" class="col-sm-2 control-label">所属企业</label>
								<div class="col-sm-8 upView">
									<span class="label-span">${company.companyName }</span>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="parentId" class="col-sm-2 control-label">所属部门</label>
								<div class="col-sm-8">
								<c:if test="${ empty departments}">
									<select name="parentId" id="parentId" class="search-form-control">
										<option value="-1">—请选择—</option>
									</select>
								</c:if>
								<c:if test="${not empty departments}">
									<select name="parentId" id="parentId" class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:selectCollection items="departments" optionText="name" optionValue="objectId"/>
									</select>
								</c:if>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">部门名称</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="name" id="name">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">排序</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control {sortNoVerify:true}" name="sortNo" id="sortNo">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="headCount" class="col-sm-2 control-label">部门人数</label>
								<div class="col-sm-8 upView">
									${entity.headCount}
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="remark" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-8">
									<textarea rows="5" cols="36" name="remark" class="search-form-control"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button"  id="saveDPT"  class="btn btn-primary"> 保存
								</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="CompanyDepartment" />
	<script type="text/javascript">
	$(function(){
		//地址
		$("#saveDPT").bind("click",function(){
			//验证部门名称
			var companyId = $("#search_EQL_companyId").val();
			var parentId = $("#parentId").val();
			var name = $("#name").val();
			var objectId = '${entity.objectId}';
			$.ajax({
	            url:"${dynamicDomain}/companyDepartment/checkDepartmentName/",
	            type : 'post',
	            data : {'companyId':companyId,'objectId':objectId,'parentId':parentId,'name':name},
	            dataType : 'json',
	            success : function(json) {
	            	var data = json.ret;
	            	if (!data) {
	            		alert("部门名称已存在");
	            		return false;
	            	}else{
	            		$("#CompanyDepartment").submit();
	            	}
	            }
	        });
		});
	});
	</script>
</body>
</html>