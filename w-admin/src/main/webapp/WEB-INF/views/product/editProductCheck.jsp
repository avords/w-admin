<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品审核管理" /></title>
<style>
.product-standard{
height: 50px;
}
.attribute-remark{
 width: 50px;
}
.attribute-value span{
margin-right: 0px;
}
.attribute-value .attValItem{
margin-right: 10px;
}
table th{
text-align: center;
}
table tbody tr td input{
width: 60px;
}
.detail-picture img{
margin-right: 10px;
}
.attValue{
width: 20px;
margin-right: 0px;
}
.noBorder{
border-left: 0;
border-right: 0;
border-top: 0;
border-bottom: 0;
}
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
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
</head>
<body>
    <div>
		<jdf:form bean="entity" scope="request">
			        <form method="post" action="${dynamicDomain}/product/save" class="form-horizontal" id="editForm">
			        <script type="text/javascript">
			        objectId = '${entity.objectId}';
			        </script>
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="商品审核管理" />
			            <c:choose>
			                <c:when test="${entity.objectId eq null }">—审核</c:when>
			                <c:otherwise>—审核</c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
                    <input type="hidden" name="objectId">
                    <input type="hidden" name="releaseType" value="${entity.releaseType}">
                    <input type="hidden" name="checkStatus" id="checkStatus">
                    <div class="box-body">
                          <div class="row">
                                <div class="col-sm-12 col-md-12">
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label">创建人：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt">${entity.createUserName}</span>
                                         </div>
                                         <label class="col-sm-1 control-label">创建时间：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt"><fmt:formatDate value="${entity.createdOn}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                         </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-sm-12 col-md-12">
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label">更新人：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt">${entity.updateUserName}</span>
                                         </div>
                                         <label class="col-sm-1 control-label">更新时间：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt"><fmt:formatDate value="${entity.updatedOn}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                         </div>
                                    </div>
                                </div>
                            </div>
                          <c:if test="${skuCheck!=null }">
                            <div class="row">
                                <div class="col-sm-12 col-md-12">
                                    <div class="form-group">
                                       <label class="col-sm-2 control-label">审核人：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt">${skuCheck.userName }</span>
                                         </div>
                                         <label class="col-sm-1 control-label">审核时间：</label>
                                        <div class="col-sm-2">
                                        <span class="span-txt"><fmt:formatDate value="${skuCheck.examineDate }" type="both" pattern="yyyy-MM-dd"/></span>
                                         </div>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                            <div class="row">
                            <div class="col-sm-6 col-md-6">
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <div class="col-sm-2">
                                               <a href="${dynamicDomain}/product/detail/${entity.objectId}?ajax=1" target="_blank" class="check-not-pass" style="color: black;">
                                                   <button type="button">前端预览</button>
                                               </a>
                                        </div>
                                        <div class="col-sm-3">
                                               <button type="button" class="group-pass">整组审核通过</button>
                                        </div>
                                        <div class="col-sm-3">
                                               <a href="${dynamicDomain}/product/checkNotPass/${entity.objectId}?ajax=1" class="colorbox-define check-not-pass" style="color: black;">
                                               <button type="button">整组审核不通过</button>
                                               </a>
                                        </div>
                                        <div class="col-sm-2">
                                               <button type="button" class="return-check">返回</button>
                                        </div>
                                </div>
                            </div>
                        </div>
                            <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="supplierId"  class="col-sm-4 control-label">供应商名称</label>
                                        <div class="col-sm-8">
                                            <input type="hidden" class="form-control" name="supplierId">
                                            <input type="text" class="form-control" name="supplierName" readonly="readonly" value="${supplierName }">
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="brandId" class="col-sm-4 control-label">品牌</label>
                                    <div class="col-sm-8">
                                        <select name="brandId" class="form-control" id="brandId">
                                             <option value="">—请选择—</option>
                                             <jdf:selectCollection items="brands" optionValue="objectId" optionText="chineseName"/>
                                         </select>
                                     </div>
                                </div>
                            </div>
                        </div>
                          <div class="row">
                            <input name="categoryId" type="hidden" id="categoryId" value="${entity.categoryId }">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">商品分类：</label>
		                            <div class="col-sm-2 col-md-2">
		                                <div>
		                                    <select name="category1" id="category1" class="form-control" style="width: 100%;">
		                                        <option value="">—一级分类—</option>
		                                        <jdf:selectCollection items="firstCategory" optionValue="firstId" optionText="name"/>
		                                    </select>
		                                </div>
		                            </div>
		                            <div class="col-sm-2 col-md-2">
		                                <div>
		                                     <select name="category2" id="category2" class="form-control" style="width: 100%;">
		                                    </select>
		                                </div>
		                            </div>
		                            <div class="col-sm-2 col-md-2">
		                                <div>
		                                    <select name="category3" id="category3" class="form-control" style="width: 100%;">
		                                    </select>
		                                </div>
		                            </div>
		                            <div class="col-sm-2 col-md-2">
                                        <div >
                                            <div class="form-group-btn">
                                                <button type="button" onclick="viewFront();">查看对应前端分类</button>
                                            </div>
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
                                      <input type="text" class="form-control" name="name" id="name">
                                    </div>
                                </div>
                            </div>   
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                               <input type="hidden" name="welfareIds" id="welfareIds" value="${welfareIds}">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">相关福利主题：</label>
                                    <div class="col-sm-10">
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
                                           <input type="text" class="form-control" name="keywords">
                                        </div>
                                </div>
                            </div>   
                        </div>
                         <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="productNo"  class="col-sm-4 control-label">商品货号</label>
                                        <div class="col-sm-8">
                                            <input type="text" class="form-control" name="productNo" id="productNo">
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="productModel" class="col-sm-4 control-label">商品型号</label>
                                     <div class="col-sm-8">
                                        <input type="text" class="form-control" name="productModel" id="productModel">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-8 col-md-8">
                                <div class="form-group">
                                     <label for="productTypes"  class="col-sm-2 control-label">商品类型：</label>
                                     <div class="col-sm-10">
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
                                                           <input type="checkbox" name="productTypes" checked="checked" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:when>
                                                       <c:otherwise>
                                                           <input type="checkbox" name="productTypes" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:otherwise>
                                                    </c:choose>
	                                        </c:forEach>
	                                    </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                        <label for="distributionWay" class="col-sm-4 control-label">配送方式</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control" id="distributionWay" name="distributionWay" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="supplyPrice" class="col-sm-4 control-label">供货价格</label>
                                    <div class="col-sm-8">
                                    <input type="text" class="form-control" name="supplyPrice" id="supplyPrice">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="marketPrice" class="col-sm-4 control-label">市场价格</label>
                                     <div class="col-sm-8">
                                        <input type="text" class="form-control" name="marketPrice" id="marketPrice">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label for="sellPrice" class="col-sm-4 control-label">销售价格</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" name="sellPrice" id="sellPrice">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label for="safetyStock" class="col-sm-4 control-label">安全库存</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" name="safetyStock" id="safetyStock">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label for="ifInvoice"  class="col-sm-4 control-label">是否提供发票</label>
                                    <div class="col-sm-8">
	                                    <div class="checkbox-lineh">
	                                        <input type="radio" name="ifInvoice" value="1">是&nbsp;&nbsp;&nbsp;&nbsp;
	                                        <input type="radio" name="ifInvoice" value="0">否&nbsp;&nbsp;&nbsp;&nbsp;
	                                    </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">商品规格：</label>
                                    <div class="col-sm-10" id="product-attrs">
                                       <c:forEach items="${attrs }" var="item" varStatus="status">
	                                        <div class="product-standard">
	                                            <span>${item.name }：</span>
	                                            <span class="attribute-value">
	                                               <c:forEach items="${item.attributeValues }" var="it" varStatus="st">
		                                               <span><input type="checkbox" name="attributeValue${status.count }" class="attributeValue atr" value="${it.objectId }"><span class="attValue">${it.attributeValue }</span><input type="text" class="attribute-remark"></span>
		                                            </c:forEach>
	                                            </span>
	                                            <c:choose>
                                                       <c:when test="${!empty item.isTogeter &&item.isTogeter==1 }">
                                                           <span>聚合展示：<input type="radio" value="1" name="attribute${status.count }Show" checked="checked">是&nbsp;<input type="radio" value="0" name="attribute${status.count }Show">否</span>
                                                       </c:when>
                                                       <c:otherwise>
                                                           <span>聚合展示：<input type="radio" value="1" name="attribute${status.count }Show">是&nbsp;<input type="radio" value="0" name="attribute${status.count }Show" checked="checked">否</span>
                                                       </c:otherwise>
                                               </c:choose>
	                                        </div>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <c:choose>
	                            <c:when test="${entity.objectId eq null }"></c:when>
	                            <c:otherwise>
	                                <script>
		                                $('.attribute-value input:checkbox').each(function(){
		                                    $(this).attr('disabled','disabled');
		                                });
                                    </script>
	                            </c:otherwise>
                           </c:choose>
                           
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <table border="1" style="width: 100%;">
                                  <thead>
                                     <tr>
                                         <th>审核通过</th><th>商品状态</th><th>商品类型</th><th>属性1</th><th>属性2</th><th>商品标题</th><th>商品货号</th><th>商品型号</th>
                                         <th>供货价</th><th>市场价</th><th>销售价</th><th>库存</th><th>安全库存</th><th width="5%">是否提供纸质发票</th>
                                     </tr>
                                  </thead>
                                  <tbody id="skuBody">
                                     <c:forEach items="${skus }" var="item" varStatus="status">
		                                  <tr>
		                                     <td>
                                                <button type="button" class="sku-pass" data-id="${item.objectId }">审核通过</button>
                                                <a href="${dynamicDomain}/sku/checkNotPass/${item.objectId}?ajax=1" class="colorbox-define sku-not-pass" style="color: black;">
                                               <button type="button">审核不通过</button>
                                               </a>
                                            </td>
		                                    <td>
		                                    	<input type="hidden" name="stockSource" value="${item.stockSource }"/>
		                                        <input type="hidden" name="skuReturnGoods" value="${item.returnGoods }"/>
			                                    <input type="hidden" name="skuObjectId" value="${item.objectId }"/>
			                                    <input type="hidden" name="skuNo" value="${item.skuNo }"/>
			                                    <input type="hidden" name="skuCheckStatus" value="${item.checkStatus }"/><jdf:columnValue dictionaryId="1108" value="${item.checkStatus}" />
		                                    </td>
		                                    <td><input type="hidden" name="skuProductType" value="${item.type }"/><jdf:columnValue dictionaryId="1103" value="${item.type}" /></td>
		                                    <td><input type="hidden" name="attributeValueId1" value="${item.attributeId1 }"/><input class="noBorder" readonly="readonly" name="attributeValue1" value="${item.attributeValue1 }"/></td>
		                                    <td><input type="hidden" name="attributeValueId2" value="${item.attributeId2 }"/><input class="noBorder" readonly="readonly" name="attributeValue2" value="${item.attributeValue2 }"/></td>
		                                    <td><input required="required" name="skuName" value="${item.name }" style="width:100%;"></td>
		                                    <td><input required="required" name="skuProductNo" value="${item.productNo }"></td>
		                                    <td><input required="required" name="skuProductModel" value="${item.productModel }"></td>
		                                    <td><input required="required" name="skuSupplyPrice" value="${item.supplyPrice }"></td>
		                                    <td><input required="required" name="skuMarketPrice" value="${item.marketPrice }"></td>
		                                    <td><input required="required" name="skuSellPrice" value="${item.sellPrice }"></td>
		                                    <td><input required="required" name="skuStock" value="${item.stock }"></td>
		                                    <td><input required="required" name="skuSafetyStock" type="text" value="${item.safetyStock }"></td>
		                                    <td>
			                                    <select name="skuIfInvoice" id="ifInvoice_${status.count }">
				                                    <option value="1">是</option>
				                                    <option value="0">否</option>
			                                    </select>
			                                    <script>
                                                  <c:choose>
                                                     <c:when test="${item.ifInvoice==1}">
                                                         $('#ifInvoice_${status.count }').val(1);
                                                     </c:when>
                                                     <c:otherwise>
                                                         $('#ifInvoice_${status.count }').val(0);
                                                     </c:otherwise>
                                                  </c:choose>
                                                </script>
		                                    </td>
		                                </tr>
	                                </c:forEach>
                                  </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label class="col-sm-2 control-label" for="packinglist">包装清单</label>
                                    <div class="col-sm-10">
                                        <textarea style="width:600px;height: 200px;" name="packinglist"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label class="col-sm-2 control-label">重量体积：</label>
                                    <div class="col-sm-10">
				                            <div class="row">
				                               <label for="form-lable" class="form-lable" style="background-color: white;">商品重量：</label>
				                               <input type="text" name="weight">g
				                            </div>
				                            <div class="row">
				                                <label class="form-lable" style="background-color: white;">商品体积：</label>
				                                <input type="text" name="length">cm&nbsp;&nbsp;X
				                                <input type="text" name="width">cm&nbsp;&nbsp;X
				                                <input type="text" name="height">cm
				                            </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input type="hidden" name="sellAreas" value="${sellAreas }" id="areaIds">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label">可销售区域：</label>
                                    <div class="col-sm-6">
                                      <textarea class="form-control" name="areaNames" id="areaNames" style="width:100%;height:100px;display: inline;" disabled="disabled">${sellAreaNames}</textarea>
                                    </div>
<!--                                     <div class="col-sm-2"> -->
<%--                                       <a href="${dynamicDomain}/area/searchMultipleCity?selectedIds=${sellAreas }&areaIds=areaIds&areaNames=areaNames&ajax=1" class="colorbox-define"> --%>
<!--                                           <button type="button" >选择</button> -->
<!--                                       </a> -->
<!--                                     </div> -->
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="mainPicture"  class="col-sm-2 control-label">主图图片</label>
                                    <div class="col-sm-10">
                                    <input name="mainPicture" type="hidden" id="mainPicture">
                                    <div id="mainImg">
                                      <img alt="" src="${dynamicDomain}${entity.mainPicture}" width="100px" height="100px;">
                                    </div>
                                    <input type="file" name="uploadFile" id="uploadFile1" style="display: inline;">
                                    <input type="button" value="上传" onclick="ajaxFileUpload1();" id="uploadButton1">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input name="subPicture" type="hidden" id="subPicture" value="${subPicture }">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">细节图片：</label>
                                    <div class="col-sm-10">
	                                    <span class="detail-picture" id="subImg">
	                                      <c:forEach items="${selectedProductPicture }" var="item" varStatus="status">
                                              <img alt="" src="${dynamicDomain}${item}" width="100px" height="100px;">
                                            </c:forEach>
	                                    </span>
	                                    <span>
		                                    <input type="file" name="uploadFile" id="uploadFile2" style="display: inline;">
		                                    <input type="button" value="上传" onclick="ajaxFileUpload2();" id="uploadButton2">
	                                    </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label  class="col-sm-2 control-label"></label>
                                    <div class="col-sm-10">
                                        <p style="background-color:#FAFAD2;width:93%;padding:5px;font-size:13px;">为保证商品的网站展示效果，请务必提供画质清晰、具美感、有助于提升购物欲望的图片信息。所有图片信息会经招行审核，严禁上传涉嫌反动、淫秽内容的图片信息。<br>
具体要求：<br>
1.图片分辨率必须为1500*1500；<br>
2.图片格式支持JPG；<br>
3.所有的图片应该是白色背景且没有阴影；<br>
4.最多可以在一个产品创建中上传10张图片，单张图片的体积不能超过5M；<br>
5.若同组商品的不同子商品外观或者颜色存在差异，请提供所有子商品的图片资料。</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                                        <div class="row">
                    <div class="col-sm-12 col-md-12">
                        <div class="form-group">
                            <label for="description" class="col-sm-2 control-label">内容</label>
                            <div class="col-sm-10" >
                                <textarea name="description" id="txt"></textarea> 
		                         <script type="text/javascript">
                                  	window.onload = function(){
      	                                CKEDITOR.replace( 'txt',{
      	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadProduct?ajax=1"
      	                                });
      	                            };
                            	 </script>
                            </div>
                        </div>
                    </div>
                </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="immediateRelease"  class="col-sm-4 control-label">是否立即发布</label>
                                    <div>
                                    <div class="col-sm-8">
                                    <select name="immediateRelease" id="immediateRelease" class="form-control">
                                        <option value="">—请选择—</option>
                                        <jdf:select dictionaryId="109"/>
                                    </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label for="staffGradeId"  class="col-sm-4 control-label">员工等级</label>
                                    <div class="col-sm-8">
                                    <select name="staffGradeId" id="staffGradeId" class="form-control">
                                        <option value="">—请选择—</option>
                                        <jdf:selectCollection items="staffGrades" optionValue="objectId" optionText="name"/>
                                    </select>
                                    </div>
                                </div>
                         </div>
                        <div class="row" id="upDate">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                     <label for="logo"  class="col-sm-2 control-label">指定上架时间段：</label>
                                    <div class="col-sm-10">
                                        <input value="<fmt:formatDate value="${entity.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="effectiveDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'%y-%M-%d',maxDate:'#F{$dp.$D(\'expireDate\')}',readOnly:true})">~
                                        <input value="<fmt:formatDate value="${entity.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="text" style="width:180px;height:33px;" id="expireDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'effectiveDate\')}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <div class="col-sm-2">
                                               <a href="${dynamicDomain}/product/detail/${entity.objectId}?ajax=1" target="_blank" class="check-not-pass" style="color: black;">
                                                   <button type="button">前端预览</button>
                                               </a>
                                        </div>
                                        <div class="col-sm-3">
                                               <button type="button" class="group-pass">整组审核通过</button>
                                        </div>
                                        <div class="col-sm-3">
                                               <a href="${dynamicDomain}/product/checkNotPass/${entity.objectId}?ajax=1" class="colorbox-define check-not-pass" style="color: black;">
                                               <button type="button">整组审核不通过</button>
                                               </a>
                                        </div>
                                        <div class="col-sm-2">
                                               <button type="button" class="return-check">返回</button>
                                        </div>
                                </div>
                            </div>
                        </div>
                    <div class="box-footer">
<!--                         <div class="row"> -->
<!--                             <div class="editPageButton"> -->
<!--                                 <button type="button" class="btn btn-primary" onclick="saveProduct();"> -->
<%--                                         <jdf:message code="common.button.save"/> --%>
<!--                                 </button> -->
<!--                                  <button type="button" class="btn btn-primary" onclick="submitProduct();">提交 -->
<!--                                 </button> -->
<%--                                 <a href="${dynamicDomain}/brand/page" class="back-btn">返回</a> --%>
<!--                             </div> -->
                                
<!--                         </div> -->
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="Product"/>
    <script type="text/javascript">
    function saveProduct(){
        $('#checkStatus').val(1);//草稿
        $('#editForm').submit();
    }
    function submitProduct(){
        $('#checkStatus').val(2);//待审核
        $('#editForm').submit();
    }
    function ajaxFileUpload1() {  
        $.ajaxFileUpload( {  
            url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
            secureuri: false,  
            fileElementId: 'uploadFile1',  
            dataType: 'json',  
            success: function(json, status) {
                if(json.result){
                    var filePath = json.filePath;
                    var width = json.width;
                    var height = json.height;
                    var url = '${dynamicDomain}/productScreenshot/productCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height+"&type=main";
                    $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"85%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
                }
            },error: function (data, status, e)//服务器响应失败处理函数
            {
                winAlert(e);
            }
        }  
    );
        return false;  
    } 
        //副图图片上传
      function ajaxFileUpload2() {  
            $.ajaxFileUpload(  
            {  
                url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
                secureuri: false,  
                fileElementId: 'uploadFile2',  
                dataType: 'json',  
                success: function(json, status) {
                    if(json.result){
                        var filePath = json.filePath;
                        var width = json.width;
                        var height = json.height;
                        var url = '${dynamicDomain}/productScreenshot/productCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height+"&type=sub";
                        $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"85%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
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
    <script type="text/javascript">
        function generateSk(){
            $('#skuBody').html('');
            var attrivuteValueId1 = new Array();
            var attrivuteValueId2 = new Array();
            var attrivuteValue1 = new Array();
            var attrivuteValue2 = new Array();
            $('.attributeValue1:checked').each(function(){
                   var valueId = $(this).val();
                   attrivuteValueId1.push(valueId);
                   var value = $(this).next().text();
                   var alias = $(this).next().next().val();
                   if(alias==''){
                       attrivuteValue1.push(value);
                   }else{
                       attrivuteValue1.push(alias);
                   }
            });
            $('.attributeValue2:checked').each(function(){
                   var valueId = $(this).val();
                   attrivuteValueId2.push(valueId);
                   var value = $(this).next().text();
                   var alias = $(this).next().next().val();
                   if(alias==''){
                       attrivuteValue2.push(value);
                   }else{
                       attrivuteValue2.push(alias);
                   }
            });
            if(attrivuteValueId1.length==0){
                attrivuteValue1.push('');
            }
            if(attrivuteValueId2.length==0){
                attrivuteValue2.push('');
            }
            //得到商品类型
             var productTypes = new Array();
             var productTypeValues = new Array();
             $('.productTypes:checked').each(function(){
                 var type = $(this).val();
                 productTypes.push(type);
                 productTypeValues.push($(this).next().text());
              });
             var ifInvoice = $('input[name="ifInvoice"]:checked').val();
             var invoiceSelect='';
             if(ifInvoice=='1'){
                 invoiceSelect = '<select name="skuIfInvoice" id="supplierId">'+
                 '<option value="1" selected = "selected">是</option>'+
                 '<option value="0">否</option>'+
                 '</select>';
             }else{
                 invoiceSelect = '<select name="skuIfInvoice" id="supplierId">'+
                 '<option value="1">是</option>'+
                 '<option value="0" selected = "selected">否</option>'+
                 '</select>';
             }
            if(attrivuteValue1[0]==''&&attrivuteValue2[0]==''){
            
            }else{
                for(var g=0;g<productTypes.length;g++){
                    for(var i=0;i<attrivuteValue1.length;i++){
                        for(var j=0;j<attrivuteValue2.length;j++){
                            var str = '<tr>'+
                                '<td><input type="hidden" name="skuReturnGoods"/><input type="hidden" name="skuObjectId"/><input type="hidden" name="skuNo"/><input type="hidden" name="skuCheckStatus" value="1"/>草稿</td>'+
                                '<td><input type="hidden" name="skuProductType" value="'+productTypes[g]+'"/>'+productTypeValues[g]+'</td>'+
                                '<td><input type="hidden" name="attributeValueId1" value="'+(typeof(attrivuteValueId1[i]) == "undefined"?'':attrivuteValueId1[i])+'"/><input class="noBorder" readonly="readonly" name="attributeValue1" value="'+(attrivuteValue1[i]==''?'':attrivuteValue1[i])+'"/></td>'+
                                '<td><input type="hidden" name="attributeValueId2" value="'+(typeof(attrivuteValueId2[j]) == "undefined"?'':attrivuteValueId2[j])+'"/><input class="noBorder" readonly="readonly" name="attributeValue2" value="'+(attrivuteValue2[j]==''?'':attrivuteValue2[j])+'"/></td>'+
                                '<td><input style="width:100%;" required="required" name="skuName" value="'+$('#name').val()+'"></td>'+
                                '<td><input required="required" name="skuProductNo" value="'+$('#productNo').val()+'"></td>'+
                                '<td><input required="required" name="skuProductModel" value="'+$('#productModel').val()+'"></td>'+
                                '<td><input required="required" name="skuSupplyPrice" value="'+$('#supplyPrice').val()+'"></td>'+
                                '<td><input required="required" name="skuMarketPrice" value="'+$('#marketPrice').val()+'"></td>'+
                                '<td><input required="required" name="skuSellPrice" value="'+$('#sellPrice').val()+'"></td>'+
                                '<td><input required="required" name="skuStock"></td>'+
                                '<td><input required="required" name="skuSafetyStock" type="text" value="'+$('#safetyStock').val()+'"></td>'+
                                '<td>'+invoiceSelect+'</td>'+
                            '</tr>';
                            $('#skuBody').append(str);
                        }
                      }
                }
            }
         }
        function generateSku(){
            $('.atr').click(function(){
                generateSk();
            });
            
        }
        $(function(){
//             $('.atr').each(function(){
//                 $(this).prop("checked"); 
//             });
             generateSku();
            $('.productTypes').click(function(){
                var  content1 = '';
                var  content2 = '';
                var content = '';
                $('.productTypes:checked').each(function(){
                    var value = $(this).val();
                    if(value=='3'||value=='5'){
                        content2 = '发送电子凭证';
                    }else{
                        content1 = '物流配送';
                    }
                });
                if(content1!=''&&content2!=''){
                    content = content1+","+content2;
                }else if(content1!=''){
                    content = content1;
                }else if(content2!=''){
                    content = content2;
                }
                $('#distributionWay').val(content);
                if(objectId){
                }else{
                    generateSk();
                }
            });

            $("#category1").val('${category.firstId}').change();
            $("#category1").bind("change",function(){
                if($(this).val()){
                    $.ajax({
                        url:"${dynamicDomain}/productCategory/secondCategory/" + $(this).val(),
                        type : 'post',
                        dataType : 'json',
                        success : function(json) {
                            $("#category2").children().remove();
                            $("#category2").append("<option value=''>—二级分类—</option>");
                            for ( var i = 0; i < json.secondCategory.length; i++) {
                                $("#category2").append("<option value='" + json.secondCategory[i].secondId + "'>" + json.secondCategory[i].name + "</option>");
                            }
                            $("#category2").val('${category.secondId}').change();
                        }
                    });
                }
             }).change();

            $("#category2").bind("change",function(){
                if($(this).val()){
                    $.ajax({
                        url:"${dynamicDomain}/productCategory/thirdCategory/" + $(this).val(),
                        type : 'post',
                        dataType : 'json',
                        success : function(json) {
                            $("#category3").children().remove();
                            $("#category3").append("<option value=''>—三级分类—</option>");
                            for ( var i = 0; i < json.thirdCategory.length; i++) {
                                $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
                            }
                            $("#category3").val('${category.objectId}');
                        }
                    });
                }
             }).change();
            
            $('#category3').change(function(){
               $("#categoryId").val($(this).val());
               //ajax获取远程的分类属性通过objectId
               $.ajax({
                   url:"${dynamicDomain}/attribute/getAttrs/" + $(this).val(),
                   type : 'post',
                   dataType : 'json',
                   success : function(json) {
                       $('#product-attrs').html('');
                       var content ='';
                       for ( var i = 0; i < json.attributes.length; i++) {
                           content = content+'<div class="product-standard"><input type="hidden" name="attributeId'+(i+1)+'" value="'+json.attributes[i].objectId+'"/><span>'+json.attributes[i].name+'：</span><span class="attribute-value">';
                           for ( var j = 0; j < json.attributes[i].attributeValues.length; j++) {
                               content = content+'<span class="attValItem"><input type="checkbox" name="attributeValue'+(i+1)+'" class="attributeValue'+(i+1)+' atr" value="'+json.attributes[i].attributeValues[j].objectId+'"><span class="attValue">'+
                               json.attributes[i].attributeValues[j].attributeValue+'</span><input type="text" class="attribute-remark"></span>';
                           }
                           content = content+'</span><span>聚合展示：<input type="radio" value="1" name="attribute'+(i+1)+'Show">是&nbsp;<input type="radio" value="0" name="attribute'+(i+1)+'Show">否</span></div>';
                       }
                       $('#product-attrs').html(content);
                       generateSku();
                   }
               });
            });

            $('.welfare-tag').click(function(){
                if($(this).hasClass('welfare-tag-border')){
                    $(this).removeClass('welfare-tag-border');
                }else{
                    $(this).addClass('welfare-tag-border');
                }
                var content = '';
                var count = 0;
                $('.welfare-tag').each(function(index,element){
                    if($(this).hasClass('welfare-tag-border')){
                        var value = $(this).data('id');
                        content = content+value+',';
                        count = index;
                    }
                });
                if(count>0){
                    content = content.substring(0,content.length-1);
                }
                $('#welfareIds').val(content);
            });
            $('input').each(function(){
                $(this).attr('disabled','disabled');
            });
            $('select').each(function(){
                $(this).attr('disabled','disabled');
            });
            $('.front-scan').click(function(){
            	
            });
             $('.group-pass').click(function(){
            	 $.ajax({
                     url:"${dynamicDomain}/product/checkPass/"+objectId,
                     type : 'post',
                     dataType : 'json',
                     success : function(json) {
                         winAlert(json.message);
                         if(json.result){
                        	 var url = '${dynamicDomain}/sku/checkPage';
                        	 window.location.href=url;
                         }
                     }
                 });
            });
             $('.return-check').click(function(){
                 var url = '${dynamicDomain}/sku/checkPage';
                 window.location.href = url;
             });
             $('.sku-pass').click(function(){
                 var id = $(this).data('id');
                 $.ajax({
                     url:"${dynamicDomain}/sku/checkPass/"+id,
                     type : 'post',
                     dataType : 'json',
                     success : function(json) {
                    	 winAlert(json.message);
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
                     if (false) {
                         location.reload(true);
                     }
                 },
                 overlayClose : false
             });
             
        });
        function viewFront(){
            //得到三级分类
            var categoryId = $('#categoryId').val();
            if(categoryId==''){
                winAlert('请选择所属分类！');
                return;
            }
            var url = "${dynamicDomain}/product/viewMallCategory/"+categoryId+"?ajax=1";
            $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"85%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
        }
    </script>
</body>
</html>