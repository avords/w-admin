<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>广告详情</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">广告详情</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/advert/save" class="form-horizontal" id="Advert">
					<input type="hidden" name="objectId">
					<input type="hidden" name="verifyInput" id="verifyInput" value="0">
					<div class="box-body">
					
					 <div class="row">
                             <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="status"  class="col-sm-4 control-label">状态</label>
                                        <div class="col-sm-8">
                                               <select name="status" class="form-control" id="status" disabled="disabled">
	                                               <option value="">—请选择—</option>
													<jdf:select dictionaryId="1203"/>
                                                </select>
                                        </div>
                                </div>
                            </div>
                        </div>
                      <c:if test="${entity.status eq 4 }">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input type="hidden" name="sellAreas" value="${remark}" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label">审核不通过原因：</label>
                                    <div class="col-sm-6">
                                      <textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled">${remark}</textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
         			</c:if>               
                        
                       <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label">区域：</label>
                                    <div class="col-sm-6">
                                       <c:if test="${empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled" placeholder="广告推荐平台为官网时，区域默认不选！">全国</textarea>
                                    </c:if>
                                     <c:if test="${not empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled" placeholder="广告推荐平台为官网时，区域默认不选！">${sellAreaNames}</textarea>
                                    </c:if>
                                    </div>
                                    <div class="col-sm-2">
                                      <%-- <a href="${dynamicDomain}/area/searchMultipleCity?selectedIds=${sellAreas }&areaIds=areaIds&areaNames=areaNames&ajax=1" class="colorbox-define">
                                          <button type="button" >选择</button>
                                      </a> --%>
                                    </div>
                                </div>
                            </div>
                        </div>
					
						
						<div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="noticeNature"  class="col-sm-4 control-label">广告性质</label>
                                        <div class="col-sm-8">
                                               <select name="noticeNature" class="form-control" id="noticeNature" disabled="disabled">
	                                               <option value="">—请选择—</option>
													<jdf:select dictionaryId="1200"/>
                                                </select>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="noticeType" class="col-sm-4 control-label">广告类型</label>
                                    <div class="col-sm-8">
	                                    <select name="noticeType" class="form-control" id="noticeType" disabled="disabled">
	                                        <option value="">—请选择—</option>
											<jdf:select dictionaryId="1201"/>
	                                     </select>
                                     </div>
                                </div>
                            </div>
                        </div>
				<div class="row">
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                        <label for="recommendPlatform"  class="col-sm-6 control-label">推荐平台</label>
                                        <div class="col-sm-6">
                                               <select name="recommendPlatform" class="form-control" id="recommendPlatform" disabled="disabled">
	                                               <option value="">—请选择—</option>
													<jdf:select dictionaryId="1202"/>
                                                </select>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                        <label for="recommendPage" class="col-sm-6 control-label">推荐页面</label>
                                    <div class="col-sm-6">
	                                    <select name="recommendPage" class="form-control" id="recommendPage" disabled="disabled">
	                                     	<option value=""></option>
											<jdf:selectCollection items="thirdCategory" optionValue="pageCode"  optionText="pageName" />
	                                     </select>
                                     </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                        <label for="recommendPosition" class="col-sm-6 control-label">推荐位置</label>
                                    <div class="col-sm-6">
	                                    <select name="recommendPosition" class="form-control" id="recommendPosition" disabled="disabled">
	                                     	<option value=""></option>
											<jdf:selectCollection items="thirdCategory" optionValue="positionCode"  optionText="positionName" />
	                                     </select>
                                     </div>
                                </div>
                            </div>
                        </div>
					
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="title" class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-10">
                                      <input type="text" class="form-control" name="title" id="title" disabled="disabled">
                                    </div>
                                </div>
                            </div>   
                        </div>
                  <c:if test="${not empty entity.picturePath }">
					<div class="row">
							<div class="col-sm-12 col-md-12" id="picture">
								<div class="form-group">
									<label for="picture" class="col-sm-2 control-label">
											广告图片</label>
									 <div class="col-sm-10">
                                    	<img id="showLogo" width="100px" height="100px" src="${dynamicDomain}${entity.picturePath}">
                                    </div>
								</div>
							</div> 
						</div>
				</c:if>
				
				 <c:if test="${not empty entity.content }">
					<div class="row" id="content" >
	                            <div class="col-sm-12 col-md-12">
	                                <div class="form-group">
	                                        <label class="col-sm-2 control-label" for="content">广告内容</label>
	                                    <div class="col-sm-10">
	                                        <textarea style="width:330px;height: 100px;" name="content" disabled="disabled"></textarea>
	                                    </div>
	                                </div>
	                            </div>
	                </div>
                 </c:if>     
					<div class="row">
                             <!-- <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="releaseNow"  class="col-sm-4 control-label">立即发布</label>
                                        <div class="col-sm-8">
                                              <input type="radio" name="releaseNow" value="1" checked="checked">是&nbsp;&nbsp;&nbsp;&nbsp;
                                       		<input type="radio" name="releaseNow" value="2">否&nbsp;&nbsp;&nbsp;&nbsp;
                                        </div>
                                </div>
                            </div>
                        </div>	 -->
						<div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="url" class="col-sm-4 control-label">点击跳转链接</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control" name="url" id="url" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="priority" class="col-sm-4 control-label">优先级</label>
                                     <div class="col-sm-8">
                                        <input type="text" class="form-control" name="priority" id="priority" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                        </div>
						 <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="logo"  class="col-sm-2 control-label">有效期：</label>
                                    <div class="col-sm-10">
                                        <input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})" disabled="disabled">——
                                        <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:if test="${ not empty entity.createUserId }">
						<div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="createUserId" class="col-sm-4 control-label">创建人</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control" name="createUser" id="createUser"   readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="createDate" class="col-sm-4 control-label">创建时间</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="createDate" name="createDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'createDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${not empty entity.updateUserId }">
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="updateUserId" class="col-sm-4 control-label">更新人</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control"  name="updateUser" id="updateUser" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="updateDate" class="col-sm-4 control-label">更新时间</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="updateDate" name="updateDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'updateDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        
                        <c:if test="${ not empty entity.checkPerson }">
                         <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="checkPerson" class="col-sm-4 control-label">审核人</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control"  name="checkPersonName" id="checkPersonName" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="checkDate" class="col-sm-4 control-label">审核时间</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="checkDate" name="checkDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'checkDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<c:if test="${entity.status eq 1}">
									<button type="button" class="btn btn-primary progressBtn" onclick="javascript:setFormAction(1);">提交审核</button>
								</c:if>
								<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">返回</button>
							</div>
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Advert"/>
	<script type="text/javascript">
	function setFormAction(val) {
		$("#verifyInput").val(val);
		$("#Advert").submit();
	}
	
$(function(){
	$('.group-pass').click(function(){
	var obj = $("input[type='radio']:checked").val();
   	 $.ajax({
            url:'${dynamicDomain}/advert/check?objectId=${objectId}&check=1&release='+obj,
            type : 'post',
            dataType : 'json',
            success : function(json) {
                if(json.result){
               	 window.location.reload();
                }
            }
        });
   });
	$(".colorbox-define").colorbox({
        opacity : 0.2,
        fixed : true,
        width : "35%",
        height : "75%",
        iframe : true,
        onClosed : function() {
            if (reloadParent) {
                location.reload(true);
            }
        },
        overlayClose : false
    });	 
		
    });
    
	
    </script>
	<script type="text/javascript">
		function checkNotPass(){
			var obj = $("input[type='radio']:checked").val();
			window.location.href='${dynamicDomain}/advert/check?objectId=${objectId}&check=2&release='+obj;
		}
		function comeBack(){
			window.location.href = '${dynamicDomain}/advert/page';
		}
	</script>
	
	<script type="text/javascript">
$(function(){
		 $("#recommendPlatform").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/advert/category/secondCategory/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#recommendPage").children().remove();
                        $("#recommendPage").append("<option value=''></option>");
                        for ( var i = 0; i < json.secondCategory.length; i++) {
                            $("#recommendPage").append("<option value='" + json.secondCategory[i].pageCode + "'>" + json.secondCategory[i].pageName + "</option>");
                        }
                        
                  		$("#recommendPage").val("${entity.recommendPage}"); 
                  		
                    }
                });
            }
         }).change();
		 
		 $("#recommendPage").bind("change",function(){
			 		var page = $("#recommendPage").val();
			 		var page1 = "${entity.recommendPage}";
			 		if(page == ""){
			 			page  = page1;
			 		}
	                $.ajax({
	                    url:"${dynamicDomain}/advert/category/thirdCategory/"+page,
	                    type : 'post',
	                    dataType : 'json',
	                    success : function(json) {
	                        $("#recommendPosition").children().remove();
	                        $("#recommendPosition").append("<option value=''></option>");
	                        for ( var i = 0; i < json.thirdCategory.length; i++) {
	                            $("#recommendPosition").append("<option value='" + json.thirdCategory[i].positionCode + "'>" + json.thirdCategory[i].positionName + "</option>");
	                        }
	                      $("#recommendPosition").val("${entity.recommendPosition}"); 
	                    }
	                });
	           
	         }).change();
        
    });
    
	
    </script>
    
    
</body>
</html>