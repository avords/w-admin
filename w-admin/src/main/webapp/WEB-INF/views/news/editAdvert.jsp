<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>广告管理</title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">广告管理</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/advert/save"
				class="form-horizontal" id="Advert" >
				<input type="hidden" name="objectId"> <input type="hidden"
					name="picturePath" id="picturePath"> 
				<input type="hidden"
					name="verifyInput" id="verifyInput" value="0">
				<div class="box-body">
					<div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label" >区域：</label>
                                    <div class="col-sm-6">
                                   	 <c:if test="${empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled" placeholder="广告推荐平台为官网时，区域默认不选！">全国</textarea>
                                    </c:if>
                                     <c:if test="${not empty sellAreaNames}">
                                   		<textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled" placeholder="广告推荐平台为官网时，区域默认不选！">${sellAreaNames}</textarea>
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
								<label for="noticeNature" class="col-sm-4 control-label">广告性质</label>
								<div class="col-sm-8">
									<select name="noticeNature" class="form-control"
										id="noticeNature">
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
									<select name="noticeType" class="form-control" id="noticeType">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1201" />
									</select>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPlatform" class="col-sm-6 control-label">推荐平台</label>
								<div class="col-sm-6">
									<select name="recommendPlatform" class="form-control"
										id="recommendPlatform">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1202" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPage" class="col-sm-6 control-label">推荐页面</label>
								<div class="col-sm-6">
									<select name="recommendPage" class="form-control"
										id="recommendPage">
										<option value=""></option>
										<jdf:selectCollection items="secondCategory"
											optionValue="pageCode" optionText="pageName" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPosition" class="col-sm-6 control-label">推荐位置</label>
								<div class="col-sm-6">
									<select name="recommendPosition" class="form-control"
										id="recommendPosition">
										<option value=""></option>
										<jdf:selectCollection items="thirdCategory"
											optionValue="positionCode" optionText="positionName" />
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


					<!-- 广告图片、广告内容 -->
					<div class="row">
						<div class="col-sm-12 col-md-12" id="picture">
							<div class="form-group">
								<label for="picture" class="col-sm-2 control-label">广告图片</label>
								<div class="col-sm-10">
									<img id="showLogo" width="100px" height="100px" src="${dynamicDomain}${entity.picturePath}">
									<input type="file" name="uploadFile" id="uploadFile" style="display: inline;"> 
									<input type="button" value="裁剪图片" onclick="ajaxFileUpload();" id="uploadButton">
									<input type="button" value="默认上传" onclick="ajaxFileUpload1();" id="uploadButton">
								</div>
							</div>
						</div>
					</div>

					<div class="row" id="content">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label class="col-sm-2 control-label" for="content">广告内容</label>
								<div class="col-sm-10">
									<textarea style="width: 330px; height: 100px;" name="content"></textarea>
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="url" class="col-sm-4 control-label">点击跳转链接</label>
								<div class="col-sm-8">
								<input type="text" class="form-control" name="url" id="url">(请以http开头)
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="priority" class="col-sm-4 control-label">优先级</label>
								<div class="col-sm-8">
									<input type="text" class="form-control sortNoVerify" name="priority"
										id="priority" >
								</div>
							</div>
						</div>
					</div>

					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="startDate" class="col-sm-2 control-label">有效期</label>
								<div class="col-sm-10">
									<input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="startDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:false})">~
                                    <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="endDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:false})">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							
							<button type="button" class="btn btn-primary progressBtn"
								onclick="javascript:setFormAction(0);" id="saveButton">保存</button>

							<button type="button" class="btn btn-primary progressBtn"
								onclick="javascript:setFormAction(1);" id="verifyButton">提交审核</button>
							<button type="button" class="btn btn-primary progressBtn" id="backButton" onclick="comeBack();">返回</button>
						</div>
					</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Advert" />
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
			 var platForm = $("#recommendPlatform").val();
			 if(platForm != 2 && area == ""){
				 alert("请选择区域！");
				 return false;
				}
			 else{
				 $("#verifyInput").val(val);
				 $("#Advert").submit();
			 } 
			
		}
		
		function ajaxFileUpload() {
			var uploadFileImg = $('#uploadFile').val();
			if(!uploadFileImg){
				alert('请选择图片');
				return false;
			}
			var position = $("#recommendPosition").val();
			$.ajaxFileUpload({
				url : '${dynamicDomain}/advert/picture/uploadAdvert?ajax=1&position=' + position,
				secureuri : false,
				fileElementId : 'uploadFile',
				dataType : 'json',
				success : function(json, status) {
					if (json.result) {
						var filePath = json.filePath;
						var width = json.width;
						var height = json.height;
						var Swidth = json.Swidth;
						var Sheight = json.Sheight;
						var url = '${dynamicDomain}/advert/picture/advertCrop?ajax=1&filePath='
								+ filePath
								+ "&width="
								+ width
								+ "&height="
								+ height
								+ "&Sheight="
								+ Sheight + "&Swidth=" + Swidth;
						$.colorbox({
							opacity : 0.2,
							href : url,
							fixed : true,
							width : "90%",
							height : "85%",
							iframe : true,
							onClosed : function() {
								if (false) {
									location.reload(true);
								}
							},
							overlayClose : false
						});
					}
				},
				error : function(data, status, e){
					alert(e);
				}
			});
			return false;
		}
		
		function ajaxFileUpload1() { 
			var uploadFileImg = $('#uploadFile').val();
			if(!uploadFileImg){
				alert('请选择图片');
				return false;
			}
			$.ajaxFileUpload({  
	            url: '${dynamicDomain}/advert/picture/directUploadAdvert?ajax=1',  
	            secureuri: false,  
	            fileElementId: 'uploadFile',  
	            dataType: 'json',  
	            success: function(json, status) {
	                if(json.result){
	                    var filePath = json.filePath;
	                    $('input[name="picturePath"]').val(filePath);
	                    $('#showLogo').attr('src','${dynamicDomain}'+filePath);
	                  /*   $('#uploadButton1').val('重新上传'); */
	                }else{
	                	alert(json.msg);
	                }
  		        },error: function (data, status, e){//服务器响应失败处理函数
  		           	alert(e);
  		        }
	        });
			
	  	} 
	</script>
	<script type="text/javascript">
		$(function() {
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
			$("#recommendPlatform")
					.bind(
							"change",
							function() {
								if ($(this).val()) {
									$
											.ajax({
												url : "${dynamicDomain}/advert/category/secondCategory/"
														+ $(this).val()+"?type=1",
												type : 'post',
												dataType : 'json',
												success : function(json) {
													$("#recommendPage")
															.children()
															.remove();
													$("#recommendPage")
															.append(
																	"<option value=''></option>");
													for ( var i = 0; i < json.secondCategory.length; i++) {
														$("#recommendPage")
																.append(
																		"<option value='" + json.secondCategory[i].pageCode + "'>"
																				+ json.secondCategory[i].pageName
																				+ "</option>");
													}

													$("#recommendPage")
															.val(
																	"${entity.recommendPage}");

												}
											});
								}
							}).change();

			$("#recommendPage")
					.bind(
							"change",
							function() {
								var page = $("#recommendPage").val();

								var page1 = "${entity.recommendPage}";
								if (page == "") {
									page = page1;
								}
								$
										.ajax({
											url : "${dynamicDomain}/advert/category/thirdCategory/"
													+ page+"?type=1",
											type : 'post',
											dataType : 'json',
											success : function(json) {
												$("#recommendPosition")
														.children().remove();
												$("#recommendPosition")
														.append(
																"<option value=''></option>");
												for ( var i = 0; i < json.thirdCategory.length; i++) {
													$("#recommendPosition")
															.append(
																	"<option value='" + json.thirdCategory[i].positionCode + "'>"
																			+ json.thirdCategory[i].positionName
																			+ "</option>");
												}
												$("#recommendPosition")
														.val(
																"${entity.recommendPosition}");
											}
										});

							}).change();

			/*  $('#recommendPosition').change(function(){
			    $("#categoryId").val($(this).val());
			 }); */

		});
	</script>
	<script type="text/javascript">
		$(function() {
			if($("#noticeNature").val() == ""){
				$("#noticeNature").val(1);
			}
			var sel = document.getElementById("noticeNature");
			var index = sel.selectedIndex;
			if (index == '1') {
				$("#content").hide();
				$("#picture").show();
			}
			else if (index == '2') {
				/* $("#picture").css("display", "none"); */
				$("#picture").hide();
				$("#content").show();
			}
			else{
				$("#picture").show();
				$("#content").show();
			}
			$("#noticeNature").change(function() {
				/* var obj = $("#noticeNature").val(); */
				var sel = document.getElementById("noticeNature");
				var index = sel.selectedIndex;
				if (index == '1') {
					$("#content").hide();
					$("#picture").show();
				}
				if (index == '2') {
					/* $("#picture").css("display", "none"); */
					$("#picture").hide();
					$("#content").show();
				}
			});
			
			 $("#country").bind("click",function(){
		          	if($("#country").is(':checked')){
		          		$("#areaNames").val('全国');
		          	}
		          	else{
		          		$("#areaNames").val('');
		          	}
		        });
		});
	</script>

	<script type="text/javascript">
		function chooseArea() {
			window.location.href = '${dynamicDomain}/area/searchMultipleCity';
		}
		function comeBack(){
			$("#saveButton").attr("disabled",true);
			$("#verifyButton").attr("disabled",true);
			window.location.href = '${dynamicDomain}/advert/page';
		}
	</script>
</body>
</html>