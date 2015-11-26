<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增&编辑</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">
           <c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                   <c:otherwise>
                                                                编辑
                </c:otherwise>                      
           </c:choose>
             </h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/physical/saveToPage"  onsubmit="return chckFiled()" id="PhysicalItem" class="form-horizontal">
				<input type="hidden" name="objectId">
				<input type="hidden" name="itemType"  value=1>
				<input type="hidden" name="itemNo" >
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
									<label for="itemNo" class="col-sm-5 control-label">一级项目编号</label>
									<span class="lable-span">${entity.itemNo }</span>
							</div>
						</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="firstItemName" class="col-sm-5 control-label">一级项目名称</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control" name="firstItemName">
								</div>
								</div>
							</div>	
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
								<div class="form-group">
										<label for="sortNo" class="col-sm-5 control-label">排序</label>
									<div class="col-sm-7">
										<input type="text" class="search-form-control sortNoVerify" name="sortNo" id="sortNo">
									</div>
								</div>	
						</div>
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
										<label for="status" class="col-sm-5 control-label">状态</label>
									<div class="col-sm-7">
										<c:choose>
							                <c:when test="${hasValidSubItem eq true }">
							                		<input type="radio" name="status"  id="status1" value=1 checked="checked">有效
													<input type="radio" name="status"  id="status2" value=2 disabled>失效
							                </c:when>
							                <c:otherwise>
							                        <input type="radio" name="status"  id="status1" value=1 checked="checked">有效
													<input type="radio" name="status"  id="status2" value=2>失效
							                </c:otherwise>                      
							            </c:choose>
           
										 
									</div>
								</div>
							</div>
					</div>
					
				
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary">保存</button>
							<a href="${dynamicDomain}/physical/page" class="btn btn-primary">取消</a>
						</div>
					</div>
			</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalItem" />
	<script type="text/javascript">
		
		function chckFiled(){
			var radio = $('input[type="radio"][name="status"]:checked').length;
			if(!radio){
				alert('请选择状态');
				return false;
			}
			
			return true;
			
		}
			$(document).ready(function(){
				if("${entity.status}"==1){
					$("#status1").attr("checked","checked");
				}else if("${entity.status}"==2){
					$("#status2").attr("checked","checked");
					$("#status1").attr("checked",false);
				}
			})
	</script>
</body>
</html>