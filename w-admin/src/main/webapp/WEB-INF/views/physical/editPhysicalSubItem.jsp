<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>新增&编辑</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">二级项目
			<c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                   <c:otherwise>
                                                                编辑
                </c:otherwise>                      
           </c:choose>
			</h4>
		</div>
			<form method="post" action="${dynamicDomain}/physical/saveToSubItemPage"  onsubmit="return checkFiled();" id="PhysicalItem" class="form-horizontal">
				<input type="hidden" name="objectId">
				<input type="hidden" name="parentItemId"  value="${parentItemId}">
				<input type="hidden" name="itemType"  value="2">
				<input type="hidden" name="itemNo" >
				
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label for="itemNo" class="col-sm-3 control-label">二类项目编号</label>
										<span class="lable-span">${entity.itemNo }</span>
									</div>
						</div>
					</div>
						
					<div class="row">
							<div class="col-sm-12 col-md-12">
									<div class="form-group">
											<label  for="secondItemName1" class="col-sm-3 control-label">二类项目名称<span class="not-null">*：</span></label>
											<div class="col-sm-8">
												<input type="text" class="search-form-control" name="secondItemName">
											</div>
									</div>
							</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label class="col-sm-3 control-label">指标意义<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<textarea  name="targetExplain"   class="search-form-control"  rows="10"  cols="100"></textarea>
								</div>	
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label class="col-sm-3 control-label">属性：</label>
										<div class="col-sm-9">
											<input type="checkbox"   name="isMan"  id="isMan"  value="1" checked="checked">男
											<input type="checkbox"   name="isWomanUnmarried"  id="isWomanUnmarried" value="1"  checked="checked">女未婚
											<input type="checkbox"   name="isWomanMarried"  id="isWomanMarried"  value="1"  checked="checked">女已婚
										</div>
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label  for="sortNo" class="col-sm-3 control-label">排序</label>
										<div class="col-sm-2">
											<input type="text"  class="search-form-control sortNoVerify"  name="sortNo"  id="sortNo">
										</div>	
									</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label for="status"  class="col-sm-3 control-label">状态：</label>
										<div class="col-sm-9">
											<input type="radio"   name="status"  id="status1" value=1 checked="checked">有效
											<input type="radio"   name="status"  id="status2" value=2>失效
										</div>
									</div>
						</div>
					</div>
								
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary">保存</button>
						</div>
					</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalItem" />
<script type="text/javascript">

	function checkFiled(){
		var secondItemName = $('input[name="secondItemName"]').val();
		secondItemName = $.trim(secondItemName);
		if(secondItemName.length<1){
			alert('二类项目名称不能为空！');
			return false;
		}
		var targetExplain = $('textarea[name="targetExplain"]').val();
		if(targetExplain.length<1){
			alert('指标意义不能为空！');
			return false;
		}
		var sort = $.trim($('#sortNo').val());
		if(!sort || sort.length<1){
			alert('排序不能为空！');
			return false;
		}
		 
		var stat = $('input[type="radio"][name="status"]:checked');
		if(!stat.length){
			alert('状态不能为空！');
			return false;
		}
		return true;
	}
	$(document).ready(function () {
		 if("${entity.objectId}"!=""){
			 if ("${entity.isMan}"!=1){
				$("#isMan").attr("checked",false);
			 }
			 if ("${entity.isWomanUnmarried}"!=1){
					$("#isWomanUnmarried").attr("checked",false);
			 }
			 if ("${entity.isWomanMarried}"!=1){
					$("#isWomanMarried").attr("checked",false);
			 }
		 }
		 
		 if("${entity.status}"==1){
				$("#status1").attr("checked","checked");
			}else if("${entity.status}"==2){
				$("#status2").attr("checked","checked");
				$("#status1").attr("checked",false);
			}
			 
	});

		
</script>
</body>
</html>