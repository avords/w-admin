<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="jquery.colorbox.js" />
<jdf:themeFile file="css/colorbox.css" />
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>新增&编辑</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">项目分类-新增</h4>
		</div>
			<form method="post" action=""   id="WelfareItem" class="form-horizontal">
				<input type="hidden" name="objectId">
				<input type="hidden" name="itemNo">
				<input type="hidden" name="parentItemId"  value="${parentItemId}">
				<input type="hidden" name="createUser">
				<input type="hidden" name="createTime">
				<input type="hidden" name="itemType"  value="${itemType}">
				<input type="hidden" name="itemGrade" value="2" >
				<input type="hidden" name="benefitImg" id="benefitImg" >
				<input type="hidden" name="bannerImg"  id="bannerImg">
				
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label for="itemNo" class="col-sm-3 control-label">项目分类编号</label>
										<span class="lable-span">${entity.itemNo }</span> 
									</div>
						</div>
					</div>
						
					<div class="row">
							<div class="col-sm-12 col-md-12">
									<div class="form-group">
											<label  for="itemName"  class="col-sm-3 control-label">项目分类名称</label>
											<div class="col-sm-5">
												<input type="text" class="search-form-control" name="itemName">
											</div>
											<label  for="sortNo"  class="col-sm-2 control-label">排序</label>
											<div class="col-sm-2">
												<input type="text"  class="form-control  sortNoVerify"  name="sortNo"  id="sortNo" >
											</div>	
									</div>
							</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
									<div class="form-group">
										<label for="status" class="col-sm-3 control-label">状态</label>
										<div class="col-sm-9">
											<input type="radio"   name="status"  id="status1" value=1>有效
											<input type="radio"   name="status"  id="status2" value=2>失效
										</div>
									</div>
						</div>
					</div>
								<div class="row">
									<div class="col-sm-12 col-md-12">
												<div class="form-group">
													<label  class="col-sm-3 control-label">福利券图片：<br>(推荐尺寸（43*42 ）px)</label>
													<div class="col-sm-9">
														<img   id="showbenefitImg" width="250px" height="150px" src="${dynamicDomain}${entity.benefitImg}">
					                                    <input type="file" name="uploadFile"  id="uploadFile1"  style="display: inline;">
					                                    <input type="button" value="上传" onclick="ajaxFileUpload1();" id="uploadButton1">
													</div>
												</div>
								</div>
							
								<div class="row">
									<div class="col-sm-12 col-md-12">
												<div class="form-group">
													<label  class="col-sm-3 control-label">主题banner：<br>(推荐尺寸（1200*330 ）px)</label>
													<div class="col-sm-9">
														<img  id="showbannerImg" width="250px" height="150px" src="${dynamicDomain}${entity.bannerImg}">
					                                    <input type="file" name="uploadFile" id="uploadFile2" style="display: inline;">
					                                    <input type="button" value="上传" onclick="ajaxFileUpload2();" id="uploadButton2">
													</div>
												</div>
									</div>
								</div>
					<div class="row">
						<div class="editPageButton">
							<button type="submit" class="btn btn-primary"  onclick="closeBox();">保存</button>
						</div>
					</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="WelfareItem" />
<script type="text/javascript">
	$(document).ready(function () {
			if("${entity.status}"==1){
				$("#status1").attr("checked","checked");
			}else if("${entity.status}"==2){
				$("#status2").attr("checked","checked");
			}
	});
	
		function ajaxFileUpload1(){ 
			var filePath = $('#uploadFile1').val();
	    	if(!filePath) {
	            alert('请选择图片！');
	            return ;
	        }
		    $.ajaxFileUpload( {  
		        url: '${dynamicDomain}/welfare/picture/uploadPicture?ajax=1',  
		        secureuri: false,  
		        fileElementId: "uploadFile1",  
		        dataType: 'json',  
		        success: function(json, status) {
		            if(json.result){
		                var filePath = json.filePath;
		                var width = json.width;
		                var height = json.height;
		                $("#showbenefitImg").attr('src','${dynamicDomain}'+filePath);
		                $("#benefitImg").val(filePath);
		                alert("上传成功！");
		            }
		            //$('#logo').val(path);
		            //$('#showLogo').attr('src','${dynamicDomain}'+path);
		        },error: function (data, status, e)//服务器响应失败处理函数
		        {
		            alert(e);
		        }
		    }  
		);
		    return false;  
		}
		function ajaxFileUpload2(){  
			var filePath = $('#uploadFile2').val();
	    	if(!filePath) {
	            alert('请选择图片！');
	            return ;
	        }
		    $.ajaxFileUpload( {  
		        url: '${dynamicDomain}/welfare/picture/uploadPicture?ajax=1',  
		        secureuri: false,  
		        fileElementId: "uploadFile2",  
		        dataType: 'json',  
		        success: function(json, status) {
		            if(json.result){
		                var filePath = json.filePath;
		                var width = json.width;
		                var height = json.height;
		                $("#showbannerImg").attr('src','${dynamicDomain}'+filePath);
		                $("#bannerImg").val(filePath);
		                alert("上传成功！");
		            }
		            //$('#logo').val(path);
		            //$('#showLogo').attr('src','${dynamicDomain}'+path);
		        },error: function (data, status, e)//服务器响应失败处理函数
		        {
		            alert(e);
		        }
		    }  
		);
		    return false;  
		}
		function closeBox(){
			$.ajax({
				url:"${dynamicDomain}/welfare/save?ajax=1",
				type : 'post',
				data:$('#WelfareItem').serialize(),
				dataType : 'json',
				success : function(res) {
					if (res=='success') {
						alert("操作成功！");
						window.parent.$.colorbox.close();
						window.parent.location.reload();
					} else {
						alert("操作失败！");
					}
				}
			})
		}
</script>
</body>
</html>