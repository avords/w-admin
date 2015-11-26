<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品补充信息" /></title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<style>
.welfare-div{
margin-top: 10px;
}
.welfare-tag{
background-color: white;
border: 1px solid black;
outline:none;
}
.welfare-tag-border{
border: 1px solid red;
}
.span-txt{
  line-height: 33px;
}
</style>
</head>
<body>
    <div>
        <jdf:form bean="entity" scope="request">
                    <form method="post" action="${dynamicDomain}/product/save" class="form-horizontal" id="editForm" onsubmit="return customeValid();">
                    <script type="text/javascript">
                    objectId = '${entity.objectId}';
                    </script>
                    <div class="callout callout-info">
                        <div class="message-right">${message }</div>
                        <h4 class="modal-title"><jdf:message code="商品补充信息修改" /></h4>
                    </div>
                    <input type="hidden" name="${entity.objectId }">
                    <input type="hidden" name="checkStatus" id="checkStatus">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="supplierId"  class="col-sm-4 control-label">供应商名称</label>
                                        <div class="col-sm-8">
                                            <span class="span-txt">${supplierName}</span>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="brandId" class="col-sm-4 control-label">品牌</label>
                                    <div class="col-sm-8">
                                        <span class="span-txt">${brand.chineseName}</span>
                                     </div>
                                </div>
                            </div>
                        </div>
                          <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="categoryId"  class="col-sm-2 control-label">商品分类</label>  
                                    <div class="col-sm-6 col-md-6">
                                        <div>
                                            <input type="hidden" name="categoryId" id="category3" value="${entity.categoryId }">
                                            <span class="span-txt" id="categoryName">${category.firstName }>>${category.secondName }>>${category.name }</span>
                                        </div>
                                    </div>
                                   </div>
                                    </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="name" class="col-sm-2 control-label">商品名称</label>
                                    <div class="col-sm-10">
                                      <span class="span-txt">${entity.name}</span>
                                    </div>
                                </div>
                            </div>   
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                               <input type="hidden" name="welfareIds" id="welfareIds" value="${welfareIds}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">相关福利主题</label>
                                    <div class="col-sm-9">
                                        <c:forEach items="${welfareItems }" var="item" varStatus="status1">
                                          <div class="welfare-div">
                                           ${item.itemName }&nbsp;
                                            <c:forEach items="${item.subWelfareItem }" var="ite" varStatus="status2">
                                             <c:set value="0" var="isHaveWelfare" scope="request"/>
                                              <c:forEach items="${selectedWelfare }" var="selectId" varStatus="status3">
                                                 <c:if test="${selectId==ite.objectId }">
                                                     <c:set var="isHaveWelfare" value="1" scope="request"/>  
                                                 </c:if>
                                              </c:forEach>
                                              <c:choose>
                                                   <c:when test="${isHaveWelfare==1 }">
                                                       <input class="welfare-tag welfare-tag-border" type="button" value="${ite.itemName}" data-id="${ite.objectId }"/>
                                                   </c:when>
                                                   <c:otherwise>
                                                       <input class="welfare-tag" type="button" value="${ite.itemName}" data-id="${ite.objectId }"/>
                                                   </c:otherwise>
                                              </c:choose>
                                            </c:forEach>
                                           </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="keywords" class="col-sm-2 control-label">商品关键字</label>
                                        <div class="col-sm-10">
                                           <span class="span-txt">${entity.keywords}</span>
                                        </div>
                                </div>
                            </div>   
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="productTypes"  class="col-sm-4 control-label">商品类型</label>
                                     <div class="col-sm-8">
                                        <span class="span-txt"><jdf:columnValue dictionaryId="1106" value="${currentRowObject.product.releaseType}" /></span>
                                        <div class="checkbox-lineh">
                                            <c:forEach items="${productTypeList }" var="item" varStatus="status">
                                              <c:set value="0" var="isHaveType" scope="request"/>
                                                 <c:forEach items="${selectedProductType }" var="selectId" varStatus="status">
                                                     <c:if test="${selectId==item.value }">
                                                        <c:set value="1" var="isHaveType" scope="request"/>
                                                     </c:if>
                                                  </c:forEach>
                                                  <c:choose>
                                                       <c:when test="${isHaveType==1 }">
                                                           <c:if test="${entity.objectId != null }">
                                                              <input type="hidden" name="productTypes" disabled="disabled" value="${item.value }">
                                                          </c:if>
                                                           <input type="checkbox" name="productTypes" disabled="disabled" checked="checked" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:when>
                                                       <c:otherwise>
                                                           <input type="checkbox" name="productTypes" disabled="disabled" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:otherwise>
                                                    </c:choose>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="marketPrice" class="col-sm-4 control-label">市场价格</label>
                                     <div class="col-sm-8">
                                        <span class="span-txt">${entity.marketPrice}</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label for="sellPrice" class="col-sm-4 control-label">销售价格</label>
                                    <div class="col-sm-8">
                                        <span class="span-txt">${entity.sellPrice}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="mainPicture"  class="col-sm-2 control-label">主图图片</label>
                                    <div class="col-sm-10">
                                    <input name="mainPicture" type="hidden" id="mainPicture">
                                    <div id="mainImg" style="width: 100px;">
                                    <c:if test="${entity.objectId != null&& entity.mainPicture!=null }">
                                          <img alt="" src="${dynamicDomain}${entity.mainPicture}" width="100px" height="100px;">
                                    </c:if>
                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input name="subPicture" type="hidden" id="subPicture">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">细节图片</label>
                                    <div class="col-sm-10">
                                        <span class="detail-picture" id="subImg">
                                          <c:forEach items="${selectedProductPicture }" var="item" varStatus="status">
                                            <div style="width: 100px;display: inline-block;">
                                              <img alt="" src="${dynamicDomain}${item}" width="100px" height="100px;">
                                            </div>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <c:forEach items="${attributes }" var="item" varStatus="status">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input name="subPicture" type="hidden" id="subPicture">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">${item.name }</label>
                                    <div class="col-sm-10">
                                        <span class="detail-picture" id="subImg">
                                          <c:forEach items="${item.attributeValues }" var="ite" varStatus="status">
	                                            <div style="width: 100px;display: inline-block;margin-right:20px;">
	                                              <span style="text-align:center;">${ite.attributeValue }</span>
	                                              <a style="cursor: pointer;display: block;margin-left: 65px;" class="subDelete" onclick="deleteSpecPic(${ite.objectId});">删除</a>
	                                              <img alt="" src="${dynamicDomain }${ite.specPicUrl}" width="100px" height="100px;" id="attValImg${ite.objectId}">
	                                              <span>
		                                            <input type="file" name="uploadFile" id="uploadFile${ite.objectId}" style="display: inline;">
		                                            <input type="button" value="裁剪图片" onclick="ajaxFileUpload2(${ite.objectId});">
		                                            <input type="button" value="默认上传" onclick="ajaxFileUpload22(${ite.objectId});">
		                                         </span>
	                                            </div>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        </c:forEach>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">商品附件</label>
                                    <div class="col-sm-10">
                                        <input type="file" name="uploadFile" id="uploadFile" style="display: inline;">
                                        <a href="${dynamicDomain}/productScreenshot/downloadFile?filePath=${entity.enclosure}" id="enclosure">${entity.enclosureName}</a>
                                        <input type="button" value="上传" onclick="ajaxFileUpload();" style="display: inline;">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <c:if test="${view!=1 }">
<!--                                     <button type="button" class="btn btn-primary progressBtn operation" onclick="saveProduct();"> -->
<%--                                             <jdf:message code="保存"/> --%>
<!--                                     </button> -->
<!--                                      <button type="button" class="btn btn-primary progressBtn operation" onclick="submitProduct();">提交 -->
<!--                                     </button> -->
                                </c:if>
                                <a href="${dynamicDomain}${action}" class="back-btn">返回</a>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <script type="text/javascript">
    function ajaxFileUpload2(attrValId) { 
        if($("#uploadFile"+attrValId).val()==''){
            winAlert('请选择上传文件');
            return false;
        }
          $.ajaxFileUpload( {  
              url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
              secureuri: false,  
              fileElementId: 'uploadFile'+attrValId,  
              dataType: 'json',  
              success: function(json, status) {
                  if(json.result=='true'){
                      var filePath = json.filePath;
                      var width = json.width;
                      var height = json.height;
                      var url = '${dynamicDomain}/productScreenshot/productSpecCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height+"&type=sub&attrValId="+attrValId+"&productId=${entity.objectId}";
                      $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"85%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
                  }else{
                      winAlert(json.message);
                  }
              },error: function (data, status, e)//服务器响应失败处理函数
              {
                  winAlert(e);
              }
          }  
      );
          return false;  
      } 
    function ajaxFileUpload22(attrValId) { 
        if($("#uploadFile"+attrValId).val()==''){
            winAlert('请选择上传文件');
            return false;
        }
          $.ajaxFileUpload({  
              url: '${dynamicDomain}/productScreenshot/uploadSpecPic?ajax=1&attrValId='+attrValId+'&productId=${entity.objectId}',  
              secureuri: false,  
              fileElementId: 'uploadFile'+attrValId,  
              dataType: 'json',  
              success: function(json, status) {
                  if(json.result=='true'){
                      var filePath = json.filePath;
                      $('#attValImg'+attrValId).attr('src','${dynamicDomain}'+filePath);
                  }else{
                      winAlert(json.message);
                  }
              },error: function (data, status, e)//服务器响应失败处理函数
              {
                  winAlert(e);
              }
          }  
      );
          return false;  
      }
    
    function deleteSpecPic(attrValId){
        $.ajax({
            url:"${dynamicDomain}/product/deleteSpecPic",
            type : 'post',
            dataType : 'json',
            data:{'productId':'${entity.objectId}','attrValId':attrValId},
            success : function(json) {
                if(json.result){
                	$('#attValImg'+attrValId).attr('src','${dynamicDomain}');
                }else{
                    winAlert(json.message);
                }
            }
        });
    }
    
    function ajaxFileUpload() { 
        if($("#uploadFile").val()==''){
            winAlert('请选择上传文件');
            return false;
        }
          $.ajaxFileUpload( {  
              url: '${dynamicDomain}/product/uploadEnclosure?ajax=1&productId=${entity.objectId}',  
              secureuri: false,  
              fileElementId: 'uploadFile',  
              dataType: 'json',  
              success: function(json, status) {
                  if(json.result=='true'){
                      var filePath = json.filePath;
                      var fileName = json.fileName;
                      $('#enclosure').text(fileName);
                      $('#enclosure').attr('href','${dynamicDomain}/productScreenshot/downloadFile?filePath='+filePath);
                  }else{
                      winAlert(json.message);
                  }
              },error: function (data, status, e)//服务器响应失败处理函数
              {
                  winAlert(e);
              }
          }  
      );
          return false;  
      }
    </script>
</body>
</html>