<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>系统参数设置</title>
<style>
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				 系统参数设置
			</h4>
		</div>
            
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/systemParameter/save" method="post" id="SystemParameter" onsubmit="return checkParam();"  class="form-horizontal">
			 		<div class="box-body">
				   
				   <c:choose>
					   <c:when test="${systemParameters ne null and fn:length(systemParameters) != 0}">
                           <c:forEach items="${systemParameters}"  var="systemParameter">
				               <div class="row">
						          <div  class="col-sm-10 col-md-10">
						              <input type="hidden" name="objectId" value="${systemParameter.objectId}" >
						              <input type="hidden" name="name" value="${systemParameter.name}" >
						              
						               <div class="form-group">
										
									    <c:choose>  
											<c:when test="${systemParameter.name == 'hrOrderTimeOutLimit'}"  > 
											  <label for="platform" class="col-sm-6 control-label">HR订单支付超时上限：</label>
											
											  <div class="col-sm-3">
				                                    <input class="form-control integer" type="text" name="value"  value="${systemParameter.value}" maxlength="9" >
											  </div>  
											  
											   <label for="platform" class="col-sm-3">小时</label> 
											</c:when> 
											
											<c:when test="${systemParameter.name == 'staffOrderTimeOutLimit'}"  > 
											      <label for="platform" class="col-sm-6 control-label">员工订单支付超时上限：</label>
												  <div class="col-sm-3">
					                                    <input class="form-control integer" type="text" name="value"  value="${systemParameter.value}" maxlength="9" >
												  </div>  
												  
												   <label for="platform" class="col-sm-3">小时</label> 
											</c:when> 
											 
											 <c:when test="${systemParameter.name == 'transActionLimit'}" > 
											      <label for="platform" class="col-sm-6 control-label">订单发货后自动为交易成功：</label>
												  <div class="col-sm-3">
					                                    <input class="form-control integer" type="text" name="value"  value="${systemParameter.value}" maxlength="9" >
												  </div>  
												  
												   <label for="platform" class="col-sm-3">小时</label> 
											</c:when> 
											
											<c:when test="${systemParameter.name == 'advanceBeSpeakTimeCancel'}" > 
											   <label for="platform" class="col-sm-6 control-label">体检在预约时间提前：</label>
										
											    <div class="col-sm-3">
				                                    <input class="form-control integer" type="text" name="value"  value="${systemParameter.value}" maxlength="9" >
											    </div>  
											   <label for="platform" class="col-sm-3">小时  可取消预约</label> 
											</c:when> 
											
											<c:when test="${systemParameter.name == 'advanceBeSpeakTimeChange'}" > 
											   <label for="platform" class="col-sm-6 control-label">体检在预约时间提前：</label>
										
											  <div class="col-sm-3">
				                                    <input class="form-control integer" type="text" name="value"  value="${systemParameter.value}" maxlength="9"  >
											  </div>  
											  
											   <label for="platform" class="col-sm-3">小时 可改期</label>
											</c:when>
											
										</c:choose>   
								      </div>
						              
						          </div>
						       </div>
				           </c:forEach>
					   </c:when>
				   </c:choose>
				    
		            <div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary"> 保存
								</button>
							</div>
                              
						</div>
					</div>
				</div><!-- box-body  -->
                
			</form>
		</jdf:form>
	  <!-- 系统参数设置 -->
	 
 </div>
	<jdf:bootstrapDomainValidate domain="SystemParameter" />
	<script type="text/javascript">
	var trim = /\s/g;
	 function checkParam(){
		   result = true;
		   
		  $("input[name='value']").each(function(){
			  value = $(this).val();
			  value = value.replace(trim, '');
			  
			  if (null == value || '' == value) {
				  alert('请输入值');
				  result = false;
				  return result;
			  }
			  
			  if (Number(value) < 0) {
				  alert('值不能小于0');
				  result = false;
				  return result;
			  }

		  });
		  
		  
		  return result;
	 }
	</script>
</body>
</html>