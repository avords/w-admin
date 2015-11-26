<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增&编辑</title>
<style>
.col-sm-7{
	white-space:nowrap; 
}
label {
	*display:inline;
	*zoom:1;
}
</style>
<script>
	function closeBox(){
		if($("#WelfareItem").valid()){
			window.parent.$.colorbox.close();
		}
	}
</script>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message}</div>
				<h4 class="modal-title">项目设置
                <c:choose>
	                <c:when test="${entity.objectId eq null}">新增 </c:when>
	                <c:otherwise>编辑</c:otherwise>                      
           		</c:choose>
              </h4>
			</div>	
			<form method="post" action="${dynamicDomain}/welfare/saveToPage" id="WelfareItem" class="form-horizontal">
				<input type="hidden" name="objectId">
				<input type="hidden" name="itemGrade"  value=1>
				<input type="hidden" name="itemNo">
				<div class="box-body">				
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="itemType" class="col-sm-5 control-label">项目类型</label>
								<div class="col-sm-7">
									<select name="itemType"  id="itemType" class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1600" />
									</select>
								</div>
							</div>
						</div>	
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label  class="col-sm-5 control-label">项目大类编号：</label>
						 		<span class="col-sm-5  lable-span">${entity.itemNo }</span>
							</div>
						</div>
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="itemName" class="col-sm-5 control-label">项目大类名称</label>
									<div class="col-sm-7">
										<input type="text" class="search-form-control required {maxlength:50}" name="itemName">
									</div>
								</div>
							</div>	
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="sortNo" class="col-sm-5 control-label">排序</label>
									<div class="col-sm-7">
										<input type="text"  class="form-control  sortNoVerify"  name="sortNo" id="sortNo" ">
									</div>
								</div>	
						</div>
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="status" class="col-sm-5 control-label">状态</label>
									<div class="col-sm-7">
										<input type="radio" name="status"  id="status1" value="1" checked="checked"/>
										<label for="status1">有效</label>
										<input type="radio" name="status"  id="status2" value="2"/>
										<label for="status2">失效</label>
									</div>
								</div>
							</div>
					</div>
					
				
<!-- 		<div class="box-footer"> -->
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary" onclick="closeBox();">保存</button>
						</div>
					</div>
<!-- 		</div> -->
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfareItem" />
	
	<script type="text/javascript">
			$(document).ready(function(){
				if("${entity.status}"==1){
					$("#status1").attr("checked","checked");
				}else if("${entity.status}"==2){
					$("#status2").attr("checked","checked");
				}
			})
	</script>
</body>
</html>