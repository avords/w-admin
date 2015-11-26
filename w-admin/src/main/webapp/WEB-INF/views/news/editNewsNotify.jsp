<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新闻公告管理</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">新闻公告管理</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/newsnotify/save" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">
					<input type="hidden" name="verify" id="verify">
					<div class="box-body">
						<div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label">区域：</label>
                                    <div class="col-sm-6">
                                      <c:if test="${empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" readonly="readonly" >全国</textarea>
                                    </c:if>
                                     <c:if test="${not empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" readonly="readonly" >${sellAreaNames}</textarea>
                                    </c:if>
                                    </div>
                                    <div class="col-sm-2">
                                    <input type="checkbox" name="country" id="country" >全国 &nbsp;&nbsp;
                                      <a href="${dynamicDomain}/area/searchMultipleCity?selectedIds=${sellAreas }&areaIds=areaIds&areaNames=areaNames&ajax=1" class="colorbox-define">
                                          <button type="button" >选择</button>
                                      </a>
                                    </div>
                                </div>
                            </div>
                        </div>
						<div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="noticeType" class="col-sm-4 control-label">新闻公告类型</label>
                                    <div class="col-sm-8">
	                                    <select name="noticeType" class="form-control" id="noticeType">
	                                        <option value="">—请选择—</option>
											<jdf:select dictionaryId="1206"/>
	                                     </select>
                                     </div>
                                </div>
                            </div>
                        </div>
						<div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="title" class="col-sm-2 control-label">标题</label>
                                    <div class="col-sm-10">
                                      <input type="text" class="form-control" name="title" id="title">
                                    </div>
                                </div>
                            </div>   
                        </div>
                        
                        
                        
                        
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="startDate"  class="col-sm-2 control-label">有效期</label>
                                    <div class="col-sm-10">
                                       <input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:false})">~
                                    	<input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:false})">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="priority" class="col-sm-4 control-label">优先级</label>
                                     <div class="col-sm-8">
                                        <input type="text" class="form-control sortNoVerify" name="priority" id="priority">
                                    </div>
                                </div>
                            </div>
                        </div>
                      <div class="row" id="content" >
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label class="col-sm-2 control-label" for="content">新闻公告内容</label>
                                    <div class="col-sm-10">
                                        <textarea style="width:10px;height: 10px;" name="content" id="txt"></textarea>
	                                    <script type="text/javascript">
                                     	window.onload = function(){
                                     		try{
                                     			CKEDITOR.replace( 'txt',{
                                     				height:200,
             	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadNewsNotify?ajax=1"
             	                                });
                                     		}catch(ex){
                                     			//window.console && console.log(ex);
                                     		}
         	                                
         	                            };
                               		 	</script>
                                    </div>
                                </div>
                            </div>
                        </div>
					</div>
          			
         				
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" id="saveButton" onclick="javascript:setFormAction(0);">
									保存
								</button>
								
								<button type="button" class="btn btn-primary progressBtn" id="verifyButton"  onclick="javascript:setFormAction(1);">
									 提交审核
								</button>
								<button type="button" class="btn btn-primary progressBtn" id="backButton" onclick="comeBack();">返回</button>
							</div>
								
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="NewsNotify"/>
	<script type="text/javascript">
	function setFormAction(val) {
	
		if(val == 0){
			$("#verifyButton").attr("disabled",true);
			$("#backButton").attr("disabled",true);
		}else{
			$("#saveButton").attr("disabled",true);
			$("#backButton").attr("disabled",true);
		}
		var area  = $("#areaNames").val();
		if(area == ""){
			alert("请选择区域！");
			return false;
		}
		else{
			$("#verify").val(val);
			$("#editForm").submit();
		}
	}
		$(function() {
			 $("#country").bind("click",function(){
		          	if($("#country").is(':checked')){
		          		$("#areaNames").val('全国');
		          	}
		          	else{
		          		$("#areaNames").val('');
		          	}
		        });
			$(".colorbox-define").colorbox({
                opacity : 0.2,
                fixed : true,
                width : "65%",
                height : "90%",
                iframe : true,
                onClosed : function() {
                    if (false) {
                        location.reload(true);
                    }
                },
                overlayClose : false
            });
		});
		function comeBack(){
			$("#saveButton").attr("disabled",true);
			$("#verifyButton").attr("disabled",true);
			window.location.href = '${dynamicDomain}/newsnotify/page';
		}
		
	</script>
</body>
</html>