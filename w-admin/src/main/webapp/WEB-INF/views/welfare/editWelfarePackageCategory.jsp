<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增/修改套餐类型</title>
<script>
 
  function saveWelfarePckCate(){
	  var ty = $('#packageType').val();
	  var first = $('#firstParameter').val();
	  var second =  $('#secondParameter').val();
	  first = $.trim(first);
	  second = $.trim(second);
	  if(!first || !second){
		  alert('属性值不能为空');
		  return false;
	  }
	  if(ty == 2){
		  if(first != second){
			  alert('固定套餐商品数目与商品选择数目应相等！');
			  return false;
		  }
	  }else{		  
		  if(first<=second){
			  alert('弹性套餐商品选择数目不能大于商品数目！');
			  return false;
		  }
	  }
	  window.parent.$.colorbox.close();
  }
</script>
</head>
<body>
	<div>
	<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">
				套餐类型
        <c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                   <c:otherwise>
                                                                编辑
                </c:otherwise>                      
           </c:choose>
			</h4>
		</div>
			<form method="post" action="${dynamicDomain}/welfarePackageCategory/saveToPage" class="form-horizontal" id="WelfarePackageCategory"  onsubmit="javascript:return saveWelfarePckCate();">
				<input type="hidden" name="objectId">
				<input type="hidden" name="packageNo">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐类型编号：</label>
								<span class="lable-span">${entity.packageNo }</span>
							</div>
						</div>
					</div>	
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="packageType" class="col-sm-4 control-label">套餐类型</label>
								<div class="col-sm-8">	
									<select name="packageType"  id="packageType" class="form-control">
										<jdf:select dictionaryId="1602" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="packageBudget" class="col-sm-4 control-label">预算</label>
									<div class="col-sm-8">	
										<select name="packageBudget"  id="packageBudget" class="form-control">
											<jdf:select dictionaryId="1603" />
										</select>
									</div>
								</div>
						</div>
					</div>
					
					<div class="row">	
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="firstParameter" class="col-sm-4 control-label">属性</label>
								<div class="col-sm-3">
									<input type="text" class="form-control" name="firstParameter"  id="firstParameter" >
								</div>
								<div  class="col-sm-2">
									<span class="lable-span">选</span>
								</div>
								<div class="col-sm-3">	
									<input type="text" class="form-control" name="secondParameter"  id="secondParameter"  >	
								</div>		
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="status"  class="col-sm-4 control-label">立即生效</label>
								<div class="col-sm-8">
										<input type="radio" name="status" checked id="status1" value=1>是
										<input type="radio" name="status" id="status2" value=2>否
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="submit"  class="btn btn-primary">保存</button>
						</div>
					</div>
				</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfarePackageCategory" />
	<script type="text/javascript">
		$(document).ready(function () {
				if("${entity.status}"==1){
					$("#status1").attr("checked","checked");
				}else if("${entity.status}"==2){
					$("#status2").attr("checked","checked");
				}
		});
	</script>
</body>
</html>