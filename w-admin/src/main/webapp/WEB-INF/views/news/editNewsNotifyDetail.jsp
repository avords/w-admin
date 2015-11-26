<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新闻公告详情</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">新闻公告详情</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/newsnotify/save" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">
					<input type="hidden" name="verify" id="verify">
					<div class="box-body">
						<div class="row">
                             <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="status"  class="col-sm-4 control-label">状态：</label>
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
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" readonly="readonly" >全国</textarea>
                                    </c:if>
                                     <c:if test="${not empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" readonly="readonly" >${sellAreaNames}</textarea>
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
                                        <label for="noticeType" class="col-sm-4 control-label">新闻公告类型：</label>
                                    <div class="col-sm-8">
	                                    <select name="noticeType" class="form-control" id="noticeType" disabled="disabled">
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
                                        <label for="title" class="col-sm-2 control-label">标题：</label>
                                    <div class="col-sm-10">
                                      <input type="text" class="form-control" name="title" id="title" disabled="disabled">
                                    </div>
                                </div>
                            </div>   
                        </div>
                        
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="startDate"  class="col-sm-2 control-label">有效期：</label>
                                    <div class="col-sm-10">
                                        <input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:155px;height:33px;" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})" disabled="disabled">——
                                        <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" startDate type="text" style="width:155px;height:33px;" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="priority" class="col-sm-4 control-label">优先级：</label>
                                     <div class="col-sm-8">
                                        <input type="text" class="form-control" name="priority" id="priority" disabled="disabled">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- <div class="row">
                             <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="releaseNow"  class="col-sm-4 control-label">立即发布：</label>
                                        <div class="col-sm-8">
                                              <input type="radio" checked="checked" name="releaseNow" value="1" disabled="disabled">是&nbsp;&nbsp;&nbsp;&nbsp;
                                       		<input type="radio" name="releaseNow" value="2" disabled="disabled">否&nbsp;&nbsp;&nbsp;&nbsp;
                                        </div>
                                </div>
                            </div>
                        </div>	 -->
                      <div class="row" id="content" >
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label class="col-sm-2 control-label" for="content">新闻公告内容</label>
                                    <div class="col-sm-10">
                                        <textarea  name="content" id="txt" disabled="disabled"></textarea>
	                                    <script type="text/javascript">
                                     	window.onload = function(){
         	                                CKEDITOR.replace( 'txt',{
         	                                	height:200,
         	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadNewsNotify?ajax=1"
         	                                });
         	                            };
                               		 	</script>
                                    </div>
                                </div>
                            </div>
                        </div>
          			
						 
                        <c:if test="${ not empty entity.createUserId }">
						<div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="createUserId" class="col-sm-4 control-label">创建人：</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control" name="createUserId" id="createUserId"   readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="createDate" class="col-sm-4 control-label">创建时间：</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.createDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="createDate" name="createDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'createDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        <c:if test="${not empty entity.updateUserId }">
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="updateUserId" class="col-sm-4 control-label">更新人：</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control"  name="updateUserId" id="updateUserId" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="updateDate" class="col-sm-4 control-label">更新时间：</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="updateDate" name="updateDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'updateDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
                        
                        <c:if test="${ not empty entity.checkPerson }">
                         <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="checkPerson" class="col-sm-4 control-label">审核人：</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control"  name="checkPerson" id="checkPerson" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="checkDate" class="col-sm-4 control-label">审核时间：</label>
                                     <div class="col-sm-8">
                                        <input value="<fmt:formatDate value="${entity.checkDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text"  disabled="disabled" style="width:280px;height:33px;" id="checkDate" name="checkDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'checkDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:if>
         				
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">返回</button>
							</div>
								
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="NewsNotify"/>
	<script type="text/javascript">
		function checkPass(){
			var obj = $("input[type='radio']:checked").val();
			window.location.href='${dynamicDomain}/newsnotify/check?objectId=${objectId}&check=1&release='+obj; 
		}
		function checkNotPass(){
			var obj = $("input[type='radio']:checked").val();
			window.location.href='${dynamicDomain}/newsnotify/check?objectId=${objectId}&check=2&release='+obj;
		}
		function comeBack(){
			window.location.href = '${dynamicDomain}/newsnotify/page';
		}
	</script>
</body>
</html>