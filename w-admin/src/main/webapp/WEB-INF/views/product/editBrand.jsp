<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品品牌管理" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		    <jdf:form bean="entity" scope="request">
		     <form method="post" action="${dynamicDomain}/brand/save?ajax=1" class="form-horizontal" id="editForm" enctype="multipart/form-data">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="商品品牌管理" />
			            <c:choose>
			                <c:when test="${entity.objectId eq null }">—新增</c:when>
			                <c:otherwise>—修改</c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
                    <input type="hidden" name="objectId">
                    <input type="hidden" name="brandNo">
                    <input type="hidden" name="logo" id="logo">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="logo"  class="col-sm-2 control-label">品牌商标</label>
                                   <div class="col-sm-8">
	                                   <img id="showLogo" width="100px" height="100px" src="${dynamicDomain}${entity.logo}">
	                                    <input type="file" name="uploadFile" id="uploadFile" style="display: inline;">
	                                    <input type="button" value="上传" onclick="ajaxFileUpload();" id="uploadButton">
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="status" class="col-sm-4 control-label">
                                        <jdf:message code="状态"/>：</label>
	                                   <div class="col-sm-8">
		                                    <select name="status" id="status" class="form-control">
		                                        <option value="">—请选择—</option>
		                                        <jdf:select dictionaryId="1110"/>
		                                    </select>
	                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                      <label for="chineseName" class="col-sm-4 control-label">品牌中文名称</label>
                                      <div class="col-sm-8">
                                          <input type="text" class="form-control" name="chineseName">
                                      </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="englishName" class="col-sm-4 control-label">品牌英文名称</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="englishName">
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="description" class="col-sm-2 control-label">品牌描述</label>
                                    <div class="col-sm-10">
                                        <textarea style="width:100%;height: 200px;" name="description"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="submit" class="btn btn-primary">
                                        <jdf:message code="common.button.save"/>
                                </button>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="Brand"/>
     <script type="text/javascript">  
        function ajaxFileUpload() {  
        	if($("#uploadFile").val()==''){
        		winAlert('请选择上传文件');
        		return false;
        	}
            $.ajaxFileUpload({ 
            	url: '${dynamicDomain}/productScreenshot/uploadBrand?ajax=1',  
                secureuri: false,  
                fileElementId: 'uploadFile',  
                dataType: 'json',  
                success: function(json, status) {
                    if(json.result=='true'){
	                    var filePath = json.filePath;
	                    $('#logo').val(filePath);
	                    $('#showLogo').attr('src','${dynamicDomain}'+filePath);
                    }else{
                    	winAlert("上传的图片不能大于500KB");
                    }
                },error: function (data, status, e)//服务器响应失败处理函数
                {
                    winAlert(e);
                }
            }  
        );
            return false;  
        }  
        $(function(){
        	if('${param.result}'=='true'){
        		parent.success();
        		parent.$.colorbox.close();
        	}
        });
    </script>  
</body>
</html>