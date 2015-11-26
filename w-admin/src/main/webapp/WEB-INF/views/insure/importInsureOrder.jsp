<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="上传核保结果" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		    <jdf:form bean="entity" scope="request">
		     <form method="post" action="${dynamicDomain}/insureOrder/impInsureInfo/${insureOrderId}?ajax=1" class="form-horizontal" id="editForm" enctype="multipart/form-data">
			        <input type="hidden" name="insureOrderId" value="${insureOrderId}">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="上传核保结果" />
			            </h4>
			        </div>
                    <div class="box-body">
                        <div class="row" id="template" >
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <div class="col-sm-8">
                                        <div class="checkbox-lineh" style="margin-top:8px;">
                                            <label><input type="file" name="uploadFile" id="uploadFile" style="display: inline;"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
							<div class="col-sm-6 col-md-6">
								<div id="loadingDiv" class="col-sm-8" style="margin: 20px; display: none;">
									<font style="font-color: red; font-weight: bold;">正在上传...<br>请勿关闭窗口</font>
								</div>
							</div>
						</div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="button" class="btn btn-primary" id="submitButton">
                                	上传
                                </button>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
     <script type="text/javascript">  
        $(function(){
        	if('${param.result}'=='true'){
                parent.winAlertReload("${param.message}");
                parent.$.colorbox.close();
            }
        	$('#submitButton').click(function(){
        		var fileName = $("input[name='uploadFile']").val();
        		fileSuffix=/.[^.]+$/.exec(fileName);
        		if(fileName==""){
        			winAlert("请选择Excel表");
        			return false;
        		}else{
        			if(fileSuffix == ".xlsx" || fileSuffix == ".xls"){
        				document.getElementById("loadingDiv").style.display="";
        				$('#editForm').submit();
        			}else{
        				winAlert("请选择正确格式的Excel表，如：a.xls和a.xlsx");
        				return false;
        			}
        		}
        		//$('#editForm').submit();
        	});
        }); 
    </script>  
</body>
</html>