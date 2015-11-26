<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>员工等级设置</title>
<style>
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				员工等级设置 
			</h4>
		</div>
		<div>
			<!-- 等级分值设置 -->
			<div class="panel panel-default" style="min-height: 0px; width: 80%;">
				<div class="panel-heading">
					<h3 class="panel-title" style="padding: 6px;">
						等级分值设置 <small><font color="red">等级分值=年资分+奖励获得权重分</font></small>
					</h3>
				</div>
				<div class="alert alert-warning alert-dismissible"
					style="display: none" role="alert" id="gradeScoreError"></div>

				<jdf:form bean="request" scope="request">
					<form action="${dynamicDomain}/staffLevel/saveGradeScore" method="post" id="StaffGradeScore" onsubmit="return checkGradeScore();" class="form-horizontal">
						<div class="box-body">
							<c:choose>
								<c:when test="${staffGradeScores eq null or fn:length(staffGradeScores) == 0}">
									<c:set var="count" value="0" />
								</c:when>
								<c:otherwise>
									<c:set var="count" value="${fn:length(staffGradeScores)}" />
								</c:otherwise>
							</c:choose>
							<c:choose>
								<c:when test="${staffGradeScores ne null}">
									<c:forEach items="${staffGradeScores}" var="item" varStatus="status">
										<div class="row">
											<div class="col-sm-10 col-md-10">
												<div class="form-group">
													<div class="col-sm-6 col-md-6">
														<input type="hidden" name="objectId1" value="${item.objectId }" /> 
														<label for="platform" class="col-sm-2 control-label">等级名称</label>
														<div class="col-sm-4">
															<input class="form-control" type="text" name="name" value="${item.name }">
														</div>
														<label for="platform" class="col-sm-2 control-label">值</label>
														<div class="col-sm-2">
															<input class="form-control" type="text" name="value" value="${item.value}">
														</div>
													</div>
													<div class="col-sm-6 col-md-6">
														<label for="platform" class="col-sm-2 control-label">分值</label>
														<div class="col-sm-3">
														  <c:choose>
														     <c:when test="${status.index == 0}">
														        <input class="form-control integer" type="text" name="startScore" value="${item.startScore }" maxlength="9"  readonly>
														     </c:when>
														     <c:otherwise>
														         <input class="form-control integer" type="text" name="startScore" value="${item.startScore }" maxlength="9" >
														     </c:otherwise>
														  </c:choose>
														</div>
														<div class="col-sm-2">
                                                            <span class="lable-span">——</span>
                                                         </div>
														<div class="col-sm-3">
															<input class="form-control integer" type="text" name="endScore" value="${item.endScore }" maxlength="9"  >
														</div>
														<label for="platform" class="col-sm-1 control-label">分 </label>
													</div>
												</div>
											</div>
										</div>
									</c:forEach>
								</c:when>
							</c:choose>
							<c:forEach var="item" begin="${count+1}" end="5">
							<div class="row">
								<div class="col-sm-10 col-md-10">
									<div class="form-group">
										<input type="hidden" name="objectId1" value="" />
										<div class="col-sm-6 col-md-6">
											<label for="platform" class="col-sm-2 control-label">等级名称</label>
											<div class="col-sm-4">
												<input class="form-control" type="text" name="name" value="">
											</div>
											<label for="platform" class="col-sm-2 control-label">值</label>
											<div class="col-sm-2">
												<input class="form-control" type="text" name="value" value="">
											</div>
										</div>
										<div class="col-sm-6 col-md-6">
											<label for="platform" class="col-sm-2 control-label">分值</label>
											<div class="col-sm-3">
												<input class="form-control integer" type="text" name="startScore" value="" maxlength="9" >
											</div>
											<div class="col-sm-2">
                                                    <span class="lable-span">——</span>
                                               </div>
											<div class="col-sm-3">
												<input class="form-control integer" type="text" name="endScore" value="" maxlength="9" >
											</div>
											<label for="platform" class="col-sm-1 control-label">分
											</label>
										</div>
									</div>
								</div>
							</div>
							</c:forEach>
							<div class="box-footer">
								<div class="row">
									<div class="editPageButton">
										<button type="submit" class="btn btn-primary" validateMethod="checkGradeScore()">保存</button>
									</div>
								</div>
							</div>
						</div>

					</form>
				</jdf:form>
			</div>

		</div>
		<!-- 等级分值设置 -->

		<div> <!-- 年资分值设置 -->
			<div class="panel panel-default" style="min-height: 0px; width: 80%;">
				<div class="panel-heading">
					<h3 class="panel-title" style="padding: 6px;">年资分值设置</h3>
				</div>
				<div class="alert alert-warning alert-dismissible" style="display: none" role="alert" id="yearScoreError">
				</div>

				<jdf:form bean="request" scope="request">
					<form action="${dynamicDomain}/staffLevel/saveYearScore" id="StaffYearScore"  method="post" onsubmit="return checkYearScore();" class="form-horizontal">
						<div class="box-body">

							<c:choose>
								<c:when test="${staffYearScores ne null }">
									<c:forEach items="${staffYearScores }" var="staffYear">

										<div class="row">

											<div class="col-sm-10 col-md-10">

												<input type="hidden" name="objectIdYear"
													value="${staffYear.objectId}">
												<div class="form-group">

													<div class="col-sm-8 col-md-8">

														<label for="platform" class="col-sm-5 control-label">年资</label>

														<div class="col-sm-2">
															<input class="form-control integer required" type="text" name="startYear"
																value="${staffYear.startYear}" maxlength="2"  >
														</div>

														<div class="col-sm-2">
                                                            <span class="lable-span">——</span>
                                                         </div>

														<div class="col-sm-2">
															<input class="form-control integer required" type="text" name="endYear"
																value="${staffYear.endYear}" maxlength="2" >
														</div>

														<label for="platform" class="col-sm-1 control-label">年
														</label>

													</div>

													<div class="col-sm-3 col-md-3">

														<label for="platform" class="col-sm-4 control-label">分值</label>
														<div class="col-sm-6">
															<input class="form-control integer required" type="text" name="yearScore"
																value="${staffYear.score}" maxlength="12" >
														</div>
													</div>
												</div>
											</div>
										</div>

									</c:forEach>
								</c:when>
							</c:choose>


							<div class="box-footer" id="yearFooter">
								<div class="row">
									<div class="editPageButton">
										<button type="submit" class="btn btn-primary" validateMethod="checkYearScore()">保存</button>
										<button type="button" id="addYear" class="btn create-value1">添加</button>
									</div>

								</div>
							</div>
						</div>
						<!-- box-body  -->

					</form>
				</jdf:form>
			</div>

       </div><!-- 年资分值设置 -->

      
		<div>
			<!-- 贡献度分值设置 -->
			<div class="panel panel-default"
				style="min-height: 0px; width: 80%;">
				<div class="panel-heading">
					<h3 class="panel-title" style="padding: 6px;">贡献度分值设置</h3>
				</div>
				<div class="alert alert-warning alert-dismissible"
					style="display: none" role="alert" id="contributeScoreError"></div>


				<jdf:form bean="request" scope="request">
					<form action="${dynamicDomain}/staffLevel/saveContributeScore" id="StaffContributeScore" method="post" onsubmit="return checkContributeScore();" class="form-horizontal">
						<div class="box-body">

							<c:choose>
								<c:when test="${staffContributeScores ne null }">
									<c:forEach items="${staffContributeScores }"
										var="staffContribute">

										<div class="row">
											<div class="col-sm-10 col-md-10">
												<input type="hidden" name="objectIdContribute"
													value="${staffContribute.objectId}" />

												<div class="form-group">
													<div class="col-sm-8 col-md-8">

														<label for="platform" class="col-sm-5 control-label">百分比</label>
														<div class="col-sm-2">
															<input class="form-control integer required" type="text"
																name="startPercent"
																value="${staffContribute.startPercent}" maxlength="9" >
														</div>
                                                         <div class="col-sm-2">
                                                            <span class="lable-span">——</span>
                                                         </div>

														<div class="col-sm-2">
															<input class="form-control integer required" type="text" name="endPercent"
																value="${staffContribute.endPercent}" maxlength="9"
																 >
														</div>
														<label for="platform" class="col-sm-1 control-label">%
														</label>
													</div>

													<div class="col-sm-3 col-md-3">
														<label for="platform" class="col-sm-4 control-label">分值</label>
														<div class="col-sm-6">
															<input class="form-control integer required" type="text"
																name="contributeScore" value="${staffContribute.score}"
																maxlength="12"
																 >
														</div>
													</div>

												</div>

											</div>
										</div>

									</c:forEach>
								</c:when>
							</c:choose>

							<div class="box-footer" id="contributeFooter">
								<div class="row">
									<div class="editPageButton">
										<button type="submit" class="btn btn-primary" validateMethod="checkContributeScore()">保存</button>
										<button type="button" id="addContribute" class="btn create-value1">添加</button>
									</div>

								</div>
							</div>
						</div>
						<!-- box-body  -->

					</form>
				</jdf:form>
			</div>

		</div>
		
		<div>
			<!-- 等级更新设置（系统自动更新） -->
			<div class="panel panel-default"
				style="min-height: 0px; width: 80%;">
				<div class="panel-heading">
					<h3 class="panel-title" style="padding: 6px;">等级更新设置（系统自动更新）</h3>
				</div>
				
				<div class="alert alert-warning alert-dismissible"
					style="display: none" role="alert" id="updateCycleError"></div>


				<jdf:form bean="request" scope="request">
					<form action="${dynamicDomain}/staffLevel/saveUpdateCycle" id="SystemParameter" method="post" onsubmit="return checkUpdateCycle();" class="form-horizontal">
						<div class="box-body">

							<c:choose>
								<c:when test="${systemParameter ne null }">
								 
										<div class="row">
											<div class="col-sm-10 col-md-10">
												<input type="hidden" name="objectId"
													value="${systemParameter.objectId}" />
                                                 <input type="hidden" name="name"
													value="${systemParameter.name}" />
													
												<div class="form-group">
													<div class="col-sm-8 col-md-8">

														<label for="platform" class="col-sm-5 control-label">更新周期</label>
														<div class="col-sm-2">
															<input class="form-control integer required" type="text"
																name="value" id="updateCycle"
																value="${systemParameter.value}" maxlength="9" >
														</div>
														<label for="platform" class="col-sm-1 control-label">天</label>
														 
													</div>
												</div>

											</div>
										</div>
 
								</c:when>
							</c:choose>

							<div class="box-footer" id="UpdateCycleFooter">
								<div class="row">
									<div class="editPageButton">
										<button type="submit" class="btn btn-primary" validateMethod="checkUpdateCycle()">保存</button>
									</div>

								</div>
							</div>
						</div>
						<!-- box-body  -->

					</form>
				</jdf:form>
			</div>

		</div>
		
	</div>
	<jdf:bootstrapDomainValidate domain="SystemParameter" />
	<jdf:bootstrapDomainValidate domain="StaffGradeScore" />
	<jdf:bootstrapDomainValidate domain="StaffYearScore" />
	<jdf:bootstrapDomainValidate domain="StaffContributeScore" />
	
	<script type="text/javascript">
	function checkGradeScore() {
	   return checkGradeScoreParam('startScore', 'endScore', 'gradeScoreError');
	}
	
	function checkYearScore() {
		return checkYearParam('startYear', 'endYear','yearScore', 'yearScoreError');
	}
	
	function checkContributeScore(){
		return checkParam('startPercent', 'endPercent','contributeScore', 'contributeScoreError');
	}
	
	function checkGradeScoreParam(startName, endName, errorId) {
		   var startScores = new Array();
		   var endScores = new Array();
		   var END_SCORE = -1;
		   var result = true;
		   
		    $("#StaffGradeScore input[name='name']").each(function(){
			   var name = $(this).val();
			   var startDom = $(this).parent().parent().next();
			  
			   var startValue = startDom.find("input[name='" + startName +"']").val()
			   var endValue =  startDom.find("input[name='" + endName + "']").val();
			   
			   name = name.trim();
			   if(startValue){
				   startValue = startValue.trim();
			   }
			   if(endValue){
				   endValue= endValue.trim();
			   }
			   
			   if (null != name && '' != name ) {
			   
			     if (null == startValue || '' == startValue 
				    || null == endValue || '' == endValue ) {
					    $("#" +errorId+ "").text('请输入分值');
				        $("#" +errorId+ "").css('display','block');
					   result = false;
				       return false;
					}
					
			   } else {
			   
			     if((null != startValue && '' != startValue )
				        || (null != endValue && '' != endValue )) {
						
				        $("#" +errorId+ "").text('请输入等级名');
				        $("#" +errorId+ "").css('display','block');
					   result = false;
				       return false;		
				}
			   }
			   
			   if( (null != name && ''!= name) 
			       && (null != startValue && '' != startValue)
				   && (null != endValue && '' != endValue) ) {
			   
			       if (Number(END_SCORE) != -1 && Number(startValue) != Number(END_SCORE)) {
				   
						$("#" +errorId+ "").text('值区间不连续');
						$("#" +errorId+ "").css('display','block');
					   result = false;
					   return false;
					}
					
					if (Number(endValue) > Number(startValue)){
			    
						END_SCORE=endValue;
						startScores.push(startValue);
						endScores.push(endValue);
				   } else {
					  
					    $("#" +errorId+ "").text('请输正确的值区间');
						$("#" +errorId+ "").css('display','block');
					   result = false;
					   return false;
				   }	
			   }
			    
			});
			 
		   if (!result) {
		     return result;
		   }
		    
		  var count = startScores.length;
		  
		  for (var i=0; i<count; i++) {
		  
		     if(Number(startScores[i]) > Number(endScores[i])) {
			     $("#" +errorId+ "").text('输入的值区间错误！');
				 $("#" +errorId+ "").css('display','block');
				 
				startScores = null;
				endScores = null;
			    return false;
			 }
		  
		     for (var j=0;j<count; j++) {
			 
			    if (i!=j) {
			    	if( (Number(startScores[i]) >= Number(startScores[j]) && Number(startScores[i]) < Number(endScores[j]) )
							||(Number(endScores[i]) > Number(startScores[j]) && Number(endScores[i]) <= Number(endScores[j]) )) {
				       
					   $("#" +errorId+ "").text('输入的值区间错误！');
					   $("#" +errorId+ "").css('display','block');
					    
					   startScores = null;
				       endScores = null;
			           return false;
				   }
				}
				
			 }
		  }
		  
		  return true;
		}
	
	function checkYearParam(startName, endName, scoreName, errorId) {
		   var startScores = new Array();
		   var endScores = new Array();
		   var END_SCORE = -1;
		   var result = true;
		   
		   
		   $("#StaffYearScore input[name='" + startName +"']").each(function(){
		     startValue = $(this).val();
			 startDom = $(this).parent();
			 
			 endValue = startDom.next().next().find("input[name='" + endName + "']").val();
			 score = startDom.parent().next().find("input[name='" + scoreName + "']").val();
			   
			  startValue = startValue.trim();
			  endValue = endValue.trim();
			  score = score.trim();
				
			  if (null == startValue || '' == startValue
			      || null == endValue || '' == endValue
				  || null == score || '' == score) {
				  
			      $("#" +errorId+ "").text('请输入值');
				  $("#" +errorId+ "").css('display','block');
			      result = false;
				  return false;
			  }
			   
			    if (Number(END_SCORE) != -1 && Number(startValue) != Number(END_SCORE)) {
				  $("#" +errorId+ "").text('值区间不连续');
				  $("#" +errorId+ "").css('display','block');
				  result = false;
				  return false;
			    } 
			   
			   if (Number(endValue) <= Number(startValue) ){
			    
				  $("#" +errorId+ "").text('请输正确的值区间');
				  $("#" +errorId+ "").css('display','block');
				  result = false;
				  return false;
			   }  
			   
				 END_SCORE=endValue;
				 startScores.push(startValue);
				 endScores.push(endValue);
			  
		   });
		   
		   if (!result) {
		     return result;
		   }
		   
		  var count = startScores.length;
		  
		  for (var i=0; i<count; i++) {
		  
		     if(Number(startScores[i]) >= Number(endScores[i])) {
			     $("#" +errorId+ "").text('输入的值区间错误');
				 $("#" +errorId+ "").css('display','block');
				 
				startScores = null;
				endScores = null;
			    return false;
			 }
		  
		     for (var j=0;j<count; j++) {
			 
			    if (i!=j) {
			    	if( (Number(startScores[i]) >= Number(startScores[j]) && Number(startScores[i]) < Number(endScores[j]) )
							||(Number(endScores[i]) > Number(startScores[j]) && Number(endScores[i]) <= Number(endScores[j]) )) {
				       
					   $("#" +errorId+ "").text('输入的值区间错误');
					   $("#" +errorId+ "").css('display','block');
					    
					   startScores = null;
				       endScores = null;
			           return false;
				   }
				}
				
			 }
		  }
		  
		  return true;
		}
		
	
	function checkParam(startName, endName, scoreName, errorId) {
		   var startScores = new Array();
		   var endScores = new Array();
		   var END_SCORE = -1;
		   var result = true;
		   
		   
		   $("#StaffContributeScore input[name='" + startName +"']").each(function(){
		     startValue = $(this).val();
			 startDom = $(this).parent();
			 
			 endValue = startDom.next().next().find("input[name='" + endName + "']").val();
			 score = startDom.parent().next().find("input[name='" + scoreName + "']").val();
			   if(startValue){
				   startValue = startValue.trim();
			   }
			  
			  score = score.trim();
				
			  if (null == startValue || '' == startValue || null == score || '' == score) {
			      $("#" +errorId+ "").text('请输入值');
				  $("#" +errorId+ "").css('display','block');
			      result = false;
				  return false;
			  }
			   
			   if (Number(END_SCORE) != -1 && Number(startValue) != Number(END_SCORE)) {
				  $("#" +errorId+ "").text('值区间不连续');
				  $("#" +errorId+ "").css('display','block');
				  result = false;
				  return false;
			    }
			   
			   if (Number(endValue) < Number(startValue) ){
			    
				  $("#" +errorId+ "").text('请输正确的值区间');
				  $("#" +errorId+ "").css('display','block');
				  result = false;
				  return false;
			   }  
			   
				 END_SCORE=endValue;
				 startScores.push(startValue);
				 endScores.push(endValue);
			  
		   });
		   
		   if (!result) {
		     return result;
		   }
		   
		  var count = startScores.length;
		  
		  for (var i=0; i<count; i++) {
		  
		     if(Number(startScores[i]) > Number(endScores[i])) {
			     $("#" +errorId+ "").text('输入的值区间错误');
				 $("#" +errorId+ "").css('display','block');
				 
				startScores = null;
				endScores = null;
			    return false;
			 }
		  
		     for (var j=0;j<count; j++) {
			 
			    if (i!=j) {
			    		if( (Number(startScores[i]) >= Number(startScores[j]) && Number(startScores[i]) < Number(endScores[j]) )
							||(Number(endScores[i]) > Number(startScores[j]) && Number(endScores[i]) <= Number(endScores[j]) )) {

				       
					   $("#" +errorId+ "").text('输入的值区间错误');
					   $("#" +errorId+ "").css('display','block');
					    
					   startScores = null;
				       endScores = null;
			           return false;
				   }
				}
				
			 }
		  }
		  
		  return true;
		}
		
	 
	function deleteRow() {
        $(".delete-value").click(function(){
		  $(this).parent().parent().parent().parent().parent().remove();
		});
    }
	
	$(function() {
	
		$(".alert, .alert-warning, .alert-dismissible").click(function(){ $(this).css('display','none');});
		deleteRow();
		//增加年资分值设置
	$("#addYear").click(function(){
		 var addYear = '<div class="row">' +
		   ' <div  class="col-sm-10 col-md-10">' +
		   '      <input type="hidden" name="objectIdYear" value="" >' +
         '        <div class="form-group">' +
		   ' 	    <div  class="col-sm-8 col-md-8">' +
		  ' 	    <label for="platform" class="col-sm-5 control-label">年资</label>' +
		' 		 <div class="col-sm-2"> ' +
		' 		 <input class="form-control integer required" type="text" name="startYear"  value="" maxlength="2"  >' +
		' 			</div>  ' +
		' 				  <div class="col-sm-2">'+
        '                      <span class="lable-span">——</span>'+
        '                  </div>' +
			' 			 <div class="col-sm-2">' +
            '           <input class="form-control integer required" type="text" name="endYear" value="" maxlength="2"  >' +
			' 			 </div>' +
			' 			<label for="platform" class="col-sm-1 control-label">年 </label>' +
			' 		</div>' +
			' 		<div  class="col-sm-3 col-md-3">' +
			' 		    <label for="platform" class="col-sm-4 control-label">分值</label>' +
			' 			<div class="col-sm-6">' +
          '                  <input class="form-control integer required" type="text" name="yearScore" value="" maxlength="12"  >' +
			' 			</div>' +
			 '           <div class="col-sm-2">' +
				'		     <button type="button" class="btn delete-value" >删除</button>' +
				'		  </div>' +
			' 		</div>' +
			' 	 </div>' +
			' </div>' +
     '  </div>';
     
		 $("#yearFooter").before(addYear);  
		 deleteRow();
		});
		
		//贡献度分值设置
		$("#addContribute").click(function(){
			var contribute = '<div class="row">'+
			     ' <div class="col-sm-10 col-md-10">'+
	         '<input type="hidden" name="objectIdContribute" value="" />'+
              '<div class="form-group">'+
               ' <div  class="col-sm-8 col-md-8">'+
				'	<label for="platform" class="col-sm-5 control-label">百分比</label>'+
				'	<div class="col-sm-2">'+
                 '          <input  class="form-control integer required" type="text" name="startPercent" value="" maxlength="9"  >'+
					'  </div>  '+
                 '    <div class="col-sm-2">'+
                 '                      <span class="lable-span">——</span>'+
                 '        </div>' +
					'	<div class="col-sm-2">'+
                   '           <input  class="form-control integer required" type="text" name="endPercent" value="" maxlength="9"  >'+
					'	</div>'+
					'	<label for="platform" class="col-sm-1 control-label">% </label>'+
				'</div>'+
				'	<div  class="col-sm-3 col-md-3">'+
				'		<label for="platform" class="col-sm-4 control-label">分值</label>'+
				'		<div class="col-sm-6">'+
                 '           <input class="form-control integer required" type="text" name="contributeScore" value="" maxlength="12" >'+
				'		</div>'+
				 '           <div class="col-sm-2">' +
					'		     <button type="button" class="btn delete-value" >删除</button>' +
					'		   	</div>' +
				'	</div>'+
			  ' </div>'+
			'</div>'+
		'</div>';
			
		$("#contributeFooter").before(contribute);
		 deleteRow();
		});
	});
	
	function checkUpdateCycle(){
		   result = true;
		     value =  $("input[name='value']").val();
			 value = value.trim();
			  if (null == value || '' == value) {
				  $("#updateCycleError").text('请输入值');
				   $("#updateCycleError").css('display','block'); 
				  result = false;
				  return result;
			  }
			  
			  if (Number(value) < 0) {
				  $("#updateCycleError").text('值不能小于0');
				   $("#updateCycleError").css('display','block'); 
				 
				  result = false;
			  }
		  
		  return result;
	 }
	</script>
</body>
</html>