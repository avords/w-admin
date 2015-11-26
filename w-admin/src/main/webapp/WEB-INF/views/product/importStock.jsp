<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="电子卡券库存配置" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		    <jdf:form bean="entity" scope="request">
		     <form method="post" action="${dynamicDomain}/product/importStock?ajax=1" class="form-horizontal" id="editForm" enctype="multipart/form-data">
			        <input type="hidden" name="skuId" value="${param.skuId}">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="电子卡券库存配置" />
			            </h4>
			        </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="ifInvoice"  class="col-sm-2 control-label">来源</label>
                                    <div class="col-sm-8">
                                        <div class="checkbox-lineh">
                                          <c:choose>
                                             <c:when test="${stockSource==2}">
                                                 <label><input type="radio" name="source" value="1">ICS&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                 <label><input type="radio" name="source" value="2" checked="checked">第三方平台&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                             </c:when>
                                             <c:when test="${stockSource!=2}">
                                                 <label><input type="radio" name="source" value="1" checked="checked">ICS&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                                 <label><input type="radio" name="source" value="2">第三方平台&nbsp;&nbsp;&nbsp;&nbsp;</label>
                                             </c:when>
                                          </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="template" style="display:none;">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="ifInvoice"  class="col-sm-2 control-label"><a href="${staticDomain}/download/import_stock_template.xls">模板下载</a></label>
                                    <div class="col-sm-8">
                                        <div class="checkbox-lineh" style="margin-top:8px;">
                                            <label><input type="file" name="uploadFile" id="uploadFile" style="display: inline;"></label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="button" class="btn btn-primary" id="submitButton">
                                        <jdf:message code="common.button.save"/>
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
        	showTemplate();
        	$("input[name='source']").click(function(){
        		showTemplate();
        	});
        	if('${param.result}'=='true'){
                parent.winAlertReload("${param.message}");
                parent.$.colorbox.close();
            }
        	$('#submitButton').click(function(){
        		var srouce = $("input[name='source']:checked").val();
        		var fileName = $("input[name='uploadFile']").val();
                if(srouce=='2'&&fileName==''){
                	winAlert('请选择文件');
                	return false;
                }
        		$('#editForm').submit();
        	});
        }); 
        function showTemplate(){
        	var srouce = $("input[name='source']:checked").val();
            if(srouce=='2'){
                $('#template').show();
            }else{
                $('#template').hide();
            }
        }
    </script>  
</body>
</html>