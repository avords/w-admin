<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="供应商商品发布" /></title>
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
			        <form method="post" action="${dynamicDomain}/product/save" class="form-horizontal" id="editForm" onsubmit="return customeValid();">
			        <script type="text/javascript">
			        objectId = '${entity.objectId}';
			        </script>
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="供应商商品发布" />
			            <c:choose>
			                <c:when test="${entity.objectId eq null }">—新增</c:when>
			                <c:otherwise>
			                  <c:choose>
			                      <c:when test="${view==1 }">
			                      —详情
			                      </c:when>
			                      <c:otherwise>
			                      —修改
			                      </c:otherwise>
			                  </c:choose>
			                </c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
                    <input type="hidden" name="objectId">
                    <c:choose>
                        <c:when test="${entity.objectId eq null }">
                            <input type="hidden" name="releaseType" value="1">
                        </c:when>
                        <c:otherwise>
                            <input type="hidden" name="releaseType" value="${entity.releaseType}">
                        </c:otherwise>
                    </c:choose>
                    <input type="hidden" name="checkStatus" id="checkStatus">
                    <div class="box-body">
                    <c:if test="${entity.objectId != null }">
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label  class="col-sm-4 control-label">创建人：</label>
                                        <div class="col-sm-8">
                                            <span class="span-txt">${entity.createUserName}</span>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label  class="col-sm-4 control-label">创建时间：</label>
                                        <div class="col-sm-8">
                                            <span class="span-txt"><fmt:formatDate value="${entity.createdOn}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label  class="col-sm-4 control-label">更新人：</label>
                                        <div class="col-sm-8">
                                            <span class="span-txt">${entity.updateUserName}</span>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label  class="col-sm-4 control-label">更新时间：</label>
                                        <div class="col-sm-8">
                                            <span class="span-txt"><fmt:formatDate value="${entity.updatedOn}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></span>
                                        </div>
                                </div>
                            </div>
                            <c:if test="${skuCheck!=null }">
                                <div class="col-sm-6 col-md-6">
	                                <div class="form-group">
	                                        <label  class="col-sm-4 control-label">审核人：</label>
	                                        <div class="col-sm-8">
	                                            <span class="span-txt">${skuCheck.userName}</span>
	                                        </div>
	                                </div>
	                            </div>
	                            <div class="col-sm-6 col-md-6">
	                                <div class="form-group">
	                                        <label  class="col-sm-4 control-label">审核时间：</label>
	                                        <div class="col-sm-8">
	                                            <span class="span-txt"><fmt:formatDate value="${skuCheck.examineDate}" type="both" pattern="yyyy-MM-dd HH:mm:ss"/></span>
	                                        </div>
	                                </div>
	                            </div>
	                        </c:if>
                            <c:if test="${!isPass}">
	                            <div class="col-sm-12 col-md-12">
	                                <div class="form-group">
	                                        <label class="col-sm-2 control-label">审核不通过原因：</label>
	                                        <div class="col-sm-8">
	                                            <span class="span-txt">${skuCheck.checkReason}</span>
	                                        </div>
	                                </div>
	                            </div>
                            </c:if>
                        </div>
                       </c:if>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="supplierId"  class="col-sm-4 control-label">供应商名称</label>
                                        <div class="col-sm-8">
		                                    <input type="hidden" class="form-control" name="supplierId" id="supplierId">
		                                    <input type="text" class="form-control" name="supplierName" style="width: 80%;display: inline;" readonly="readonly" value="${supplierName }">
		                                    <a href="${dynamicDomain}/supplier/supplierTemplate?ajax=1&inputName=supplier&functionName=supplierAgent" class="pull-right btn btn-primary colorbox-double-template">选择
                                        </a>
                                        </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="brandId" class="col-sm-4 control-label">品牌<span style="color:#dd4b39;">*：</span></label>
                                    <div class="col-sm-8">
	                                    <select name="brandId" style="width:300px;" id="brandId">
	                                         <option value="">—请选择—</option>
	                                         <jdf:selectCollection items="brands" optionValue="objectId" optionText="chineseName"/>
	                                     </select>
                                     </div>
                                </div>
                            </div>
                        </div>
                          <div class="row">
<%--                             <input name="categoryId" type="hidden" id="categoryId" value="${entity.categoryId }"> --%>
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                    <label for="categoryId"  class="col-sm-2 control-label">商品分类</label>  
		                            <div class="col-sm-6 col-md-6">
		                                <div>
		                                    <select name="categoryId" id="category3" class="form-control" style="width: 100%;">
		                                    </select>
		                                </div>
		                            </div>
		                            <div class="col-sm-2 col-md-2">
                                        <div >
                                            <div class="form-group-btn">
                                                <button type="button" class="btn btn-primary"  onclick="viewFront();">查看对应前端分类</button>
                                            </div>
                                        </div>
                                    </div>
		                           </div>
		                            </div>
                        </div>
                         <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                	<label class="col-sm-2 control-label"></label>
                                        <div class="col-sm-8">
                                            <span class="span-txt error">商品品牌和商品分类，在信息提交后，不允许修改</span>
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
                                    <div class="col-sm-1">
                                      <input type="button" value="全选" id="allWelfare">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="keywords" class="col-sm-2 control-label">商品关键字</label>
                                        <div class="col-sm-10">
                                           <input type="text" class="form-control" name="keywords" id="keywords">
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
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                     <label for="productTypes"  class="col-sm-4 control-label">商品类型<span style="color:#dd4b39;">*：</span></label>
                                     <div class="col-sm-8">
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
			                                                  <input type="hidden" name="productTypes" value="${item.value }">
			                                              </c:if>
                                                           <input type="checkbox" name="productTypes" checked="checked" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:when>
                                                       <c:otherwise>
                                                           <input type="checkbox" name="productTypes" class="productTypes" value="${item.value }"><span>${item.name }</span>&nbsp;
                                                       </c:otherwise>
                                                    </c:choose>
	                                        </c:forEach>
	                                        <span style="color:red;font-size:10px;">（ICS卡券需填写货号）</span>
	                                    </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
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
	                                        <label><input type="radio" name="ifInvoice" value="1">是&nbsp;&nbsp;&nbsp;&nbsp;</label>
	                                        <c:choose>
	                                            <c:when test="${entity.objectId eq null }">
	                                                <label><input type="radio" name="ifInvoice" value="0" checked="checked">否&nbsp;&nbsp;&nbsp;&nbsp;</label>
	                                            </c:when>
	                                            <c:otherwise>
	                                                <label><input type="radio" name="ifInvoice" value="0">否&nbsp;&nbsp;&nbsp;&nbsp;</label>
	                                            </c:otherwise>
	                                        </c:choose>       
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
                                            <input type="hidden" name="attributeId${status.count }" value="${item.objectId }">
	                                        <div class="product-standard">
	                                            <span>${item.name }：</span>
	                                            <span class="attribute-value">
	                                               <c:forEach items="${item.attributeValues }" var="it" varStatus="st">
		                                               <span><input type="checkbox" class="attributeValue atr" value="${it.objectId }"><span class="attValue">${it.attributeValue }</span><input type="text" class="attribute-remark"></span>
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
		                                $("input[type='checkbox'][name='productTypes']").each(function(){
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
                                         <th>商品状态</th><th>商品类型</th><th>属性1</th><th>属性2</th><th>商品标题</th><th>商品货号</th><th>商品型号</th>
                                         <th>供货价</th><th>市场价</th><th>销售价</th><th>库存</th><th>安全库存</th><th width="5%">是否提供纸质发票</th>
                                     </tr>
                                  </thead>
                                  <tbody id="skuBody">
                                     <c:forEach items="${skus }" var="item" varStatus="status">
                                       <c:choose>
                                       <c:when test="${item.checkStatus!=5&&item.checkStatus!=2 }">
                                          <tr>
                                            <td>
                                                <input type="hidden" name="skuReturnGoods" value="${item.returnGoods }"/>
                                                <input type="hidden" name="skuObjectId" value="${item.objectId }"/>
                                                <input type="hidden" name="skuNo" value="${item.skuNo }"/>
                                                <input type="hidden" name="skuCheckStatus" value="${item.checkStatus }"/><jdf:columnValue dictionaryId="1108" value="${item.checkStatus}" />
                                            </td>
                                            <td><input type="hidden" name="skuProductType" value="${item.type }"/><jdf:columnValue dictionaryId="1101" value="${item.type}" /></td>
                                            <td><input type="hidden" name="attributeValueId1" value="${item.attributeId1 }"/><input class="noBorder" readonly="readonly" name="attributeValue1" value="${item.attributeValue1 }"/></td>
                                            <td><input type="hidden" name="attributeValueId2" value="${item.attributeId2 }"/><input class="noBorder" readonly="readonly" name="attributeValue2" value="${item.attributeValue2 }"/></td>
                                            <td><input maxlength="50" required="required" name="skuName" value="${item.name }" style="width:100%;"></td>
                                            <td><input maxlength="50" name="skuProductNo" value="${item.productNo }"></td>
                                            <td><input maxlength="50" name="skuProductModel" value="${item.productModel }"></td>
                                            <td><input name="skuSupplyPrice" value="${item.supplyPrice }"></td>
                                            <td><input name="skuMarketPrice" value="${item.marketPrice }"></td>
                                            <td><input name="skuSellPrice" value="${item.sellPrice }"></td>
                                            <c:choose>
                                               <c:when test="${item.type==3 }">
                                                  <td><input class="noBorder" name="skuStock" value="${item.stock }" readonly="readonly"></td>
                                               </c:when>
                                               <c:otherwise>
                                                  <td><input name="skuStock" value="${item.stock }"></td>
                                               </c:otherwise>
                                            </c:choose>
                                            <td><input name="skuSafetyStock" type="text" value="${item.safetyStock }"></td>
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
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                            <td>
                                                <input type="hidden" name="skuReturnGoods" value="${item.returnGoods }"/>
                                                <input type="hidden" name="skuObjectId" value="${item.objectId }"/>
                                                <input type="hidden" name="skuNo" value="${item.skuNo }"/>
                                                <input type="hidden" name="skuCheckStatus" value="${item.checkStatus }"/><jdf:columnValue dictionaryId="1108" value="${item.checkStatus}" />
                                            </td>
                                            <td><input type="hidden" name="skuProductType" value="${item.type }"/><jdf:columnValue dictionaryId="1101" value="${item.type}" /></td>
                                            <td><input type="hidden" name="attributeValueId1" value="${item.attributeId1 }"/><input class="noBorder" readonly="readonly" name="attributeValue1" value="${item.attributeValue1 }"/></td>
                                            <td><input type="hidden" name="attributeValueId2" value="${item.attributeId2 }"/><input class="noBorder" readonly="readonly" name="attributeValue2" value="${item.attributeValue2 }"/></td>
                                            <td><input maxlength="50" class="noBorder" readonly="readonly" required="required" name="skuName" value="${item.name }"></td>
                                            <td><input maxlength="50" class="noBorder" readonly="readonly" name="skuProductNo" value="${item.productNo }"></td>
                                            <td><input maxlength="50" class="noBorder" readonly="readonly" name="skuProductModel" value="${item.productModel }"></td>
                                            <td><input class="noBorder" readonly="readonly" name="skuSupplyPrice" value="${item.supplyPrice }"></td>
                                            <td><input class="noBorder" readonly="readonly" name="skuMarketPrice" value="${item.marketPrice }"></td>
                                            <td><input class="noBorder" readonly="readonly" name="skuSellPrice" value="${item.sellPrice }"></td>
                                            <c:choose>
                                               <c:when test="${item.type==3 }">
                                                  <td><input class="noBorder" name="skuStock" value="${item.stock }" readonly="readonly"></td>
                                               </c:when>
                                               <c:otherwise>
                                                  <td><input class="noBorder" name="skuStock" value="${item.stock }"></td>
                                               </c:otherwise>
                                            </c:choose>
                                            <td><input class="noBorder" readonly="readonly" name="skuSafetyStock" type="text" value="${item.safetyStock }"></td>
                                            <td>
                                                <input name="skuIfInvoice" type="hidden" value="${item.ifInvoice }">
                                                <jdf:columnValue dictionaryId="109" value="${item.ifInvoice }"/>
                                            </td>
                                        </tr>
                                        </c:otherwise>
                                        </c:choose>
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
				                               <input type="text" name="weight" id="weight">g
				                            </div>
				                            <div class="row">
				                                <label class="form-lable" style="background-color: white;">商品体积：</label>
				                                <input type="text" name="length" id="length">cm&nbsp;&nbsp;X
				                                <input type="text" name="width" id="width">cm&nbsp;&nbsp;X
				                                <input type="text" name="height" id="height">cm
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
                                    <div class="col-sm-2">
                                      <a href="javascript:void(0);" class="colorbox-define" id="selectSellArea">
                                          <input type="button" value="选择"/>
                                      </a>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                        <label for="logo"  class="col-sm-2 control-label"></label>
                                    <div class="col-sm-6" id="countrywide">
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
	                                    <c:if test="${view!=1 }">
	                                      <a style="float: right;cursor: pointer;" id="mainDelete" data-path="${entity.mainPicture }">删除</a>
	                                    </c:if>
	                                      <img alt="" src="${dynamicDomain}${entity.mainPicture}" width="100px" height="100px;">
                                    </c:if>
                                    </div>
                                    <input type="file" name="uploadFile" id="uploadFile1" style="display: inline;">
                                    <input type="button" value="裁剪图片" onclick="ajaxFileUpload1();" id="uploadButton1">
                                    <input type="button" value="默认上传" onclick="ajaxFileUpload11();" id="uploadButton11">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                            <input name="subPicture" type="hidden" id="subPicture">
                                <div class="form-group">
                                    <label for="logo"  class="col-sm-2 control-label">细节图片：</label>
                                    <div class="col-sm-10">
	                                    <span class="detail-picture" id="subImg">
	                                      <c:forEach items="${selectedProductPicture }" var="item" varStatus="status">
	                                        <div style="width: 100px;display: inline-block;">
	                                         <c:if test="${view!=1 }">
	                                           <a style="cursor: pointer;display: block;margin-left: 65px;" class="subDelete" data-path="${item }">删除</a>
                                             </c:if>
                                              <img alt="" src="${dynamicDomain}${item}" width="100px" height="100px;">
                                            </div>
                                            </c:forEach>
	                                    </span>
	                                    <span>
		                                    <input type="file" name="uploadFile" id="uploadFile2" style="display: inline;">
		                                    <input type="button" value="裁剪图片" onclick="ajaxFileUpload2();" id="uploadButton2">
		                                    <input type="button" value="默认上传" onclick="ajaxFileUpload22();" id="uploadButton22">
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
		                            	try{
		                            		CKEDITOR.replace( 'txt',{
			                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadProduct?ajax=1&type=image"
			                                });
		                            	}catch(ex){
		                            		//window.console&&console.error(ex);
		                            	}
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
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
	                            <c:if test="${view!=1 }">
	                                <button type="button" class="btn btn-primary progressBtn operation" onclick="saveProduct();">
	                                        <jdf:message code="保存"/>
	                                </button>
	                                 <button type="button" class="btn btn-primary progressBtn operation" onclick="submitProduct();">提交
	                                </button>
	                            </c:if>
	                            <a href="${dynamicDomain}${action}" class="back-btn">返回</a>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="Product"/>
    <script type="text/javascript">
    $('#brandId').select2();
    <c:if test="${view==1 }">
    $('input').each(function(){
        $(this).attr('disabled','disabled');
    });
    $('select').each(function(){
        $(this).attr('disabled','disabled');
    });
    </c:if>
    function bindPictureDelete(){
	    //主图删除
	    $('#mainDelete').click(function(){
	        var mainPicture = $(this).data('path');
	        var obj = $(this);
	        $.ajax({
	            url:"${dynamicDomain}/productScreenshot/deleteProduct",
	            type : 'post',
	            dataType : 'json',
	            data:{'filePath':mainPicture},
	            success : function(json) {
	                    obj.parent().html('');
	                     $('#mainPicture').val('');
	            }
	        });
	        
	    });
	    //子图删除
	    $('.subDelete').click(function(){
	        var subPicture = $(this).data('path');
	        var obj = $(this);
	        $.ajax({
	            url:"${dynamicDomain}/productScreenshot/deleteProduct",
	            type : 'post',
	            dataType : 'json',
	            data:{'filePath':subPicture},
	            success : function(json) {
	                    obj.parent().remove();
	                    //更新子图路径
	                    var paths = '';
	                    $('.subDelete').each(function(){
	                    	var path = $(this).data('path');
	                    	if(paths==''){
	                    		paths = path;
	                    	}else{
	                    		paths = paths+','+path;
	                    	}
	                    });
	                    $('#subPicture').val(paths);
	            }
	        });
	    });
    }
    function saveProduct(){
        $('#checkStatus').val(1);//草稿
        $('#editForm').submit();
    }
    function submitProduct(){
        $('#checkStatus').val(2);//待审核
        $('#editForm').submit();
    }
    function ajaxFileUpload1() {  
    	if($("#uploadFile1").val()==''){
    		winAlert('请选择上传文件');
    		return false;
    	}
        $.ajaxFileUpload({  
            url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
            secureuri: false,  
            fileElementId: 'uploadFile1',  
            dataType: 'json',  
            success: function(json, status) {
                if(json.result=='true'){
                    var filePath = json.filePath;
                    var width = json.width;
                    var height = json.height;
                    var url = '${dynamicDomain}/productScreenshot/productCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height+"&type=main";
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
    
    function ajaxFileUpload11() {  
        if($("#uploadFile1").val()==''){
            winAlert('请选择上传文件');
            return false;
        }
        $.ajaxFileUpload({  
            url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
            secureuri: false,  
            fileElementId: 'uploadFile1',  
            dataType: 'json',  
            success: function(json, status) {
                if(json.result=='true'){
                    var filePath = json.filePath;
                    var img = '<a style="float: right;cursor: pointer;" id="mainDelete" data-path="'+filePath+'">删除</a>'+
                    '<img alt="" src="${dynamicDomain}'+filePath+'" width="100px" height="100px;">';
                	$("#mainPicture").val(filePath);
                	$("#mainImg").html(img);
                	bindPictureDelete();
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
        //副图图片上传
      function ajaxFileUpload2() { 
    	  if($("#uploadFile2").val()==''){
              winAlert('请选择上传文件');
              return false;
          }
        	var subPicture = $('#subPicture').val();
        	var array = new Array();
        	array = subPicture.split(",");
        	if(array.length>=10){
        		winAlert("细节图片不能大于10张");
        		return false;
        	}
            $.ajaxFileUpload( {  
                url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
                secureuri: false,  
                fileElementId: 'uploadFile2',  
                dataType: 'json',  
                success: function(json, status) {
                    if(json.result=='true'){
                        var filePath = json.filePath;
                        var width = json.width;
                        var height = json.height;
                        var url = '${dynamicDomain}/productScreenshot/productCrop?ajax=1&filePath='+filePath+"&width="+width+"&height="+height+"&type=sub";
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
      function ajaxFileUpload22() { 
          if($("#uploadFile2").val()==''){
              winAlert('请选择上传文件');
              return false;
          }
            var subPicture = $('#subPicture').val();
            var array = new Array();
            array = subPicture.split(",");
            if(array.length>=10){
                winAlert("细节图片不能大于10张");
                return false;
            }
            $.ajaxFileUpload({  
                url: '${dynamicDomain}/productScreenshot/uploadProduct?ajax=1',  
                secureuri: false,  
                fileElementId: 'uploadFile2',  
                dataType: 'json',  
                success: function(json, status) {
                    if(json.result=='true'){
                        var filePath = json.filePath;
                        var img = '<div style="width: 100px;display: inline-block;">'+
                        '<a style="cursor: pointer;display: block;margin-left: 65px;" class="subDelete" data-path="'+filePath+'">删除</a>'+
                        '<img alt="" src="${dynamicDomain}'+filePath+'" width="100px" height="100px;"></div>';
                        var subPath = $("#subPicture").val();
                        if(subPath==''){
                            $("#subPicture").val(filePath);
                        }else{
                            $("#subPicture").val(subPath+','+filePath);
                        }
                        $("#subImg").append(img);
                        bindPictureDelete();
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
                        	var skuStockStr = '<td><input name="skuStock"></td>';
                        	if(productTypes[g]=='3'){
                        		skuStockStr = '<td><input class="noBorder" name="skuStock" readonly="readonly"></td>';
                        	}
                            var str = '<tr>'+
                                '<td><input type="hidden" name="skuReturnGoods"/><input type="hidden" name="skuObjectId"/><input type="hidden" name="skuNo"/><input type="hidden" name="skuCheckStatus" value="1"/>草稿</td>'+
                                '<td><input type="hidden" name="skuProductType" value="'+productTypes[g]+'"/>'+productTypeValues[g]+'</td>'+
                                '<td><input type="hidden" name="attributeValueId1" value="'+(typeof(attrivuteValueId1[i]) == "undefined"?'':attrivuteValueId1[i])+'"/><input class="noBorder" readonly="readonly" name="attributeValue1" value="'+(attrivuteValue1[i]==''?'':attrivuteValue1[i])+'"/></td>'+
                                '<td><input type="hidden" name="attributeValueId2" value="'+(typeof(attrivuteValueId2[j]) == "undefined"?'':attrivuteValueId2[j])+'"/><input class="noBorder" readonly="readonly" name="attributeValue2" value="'+(attrivuteValue2[j]==''?'':attrivuteValue2[j])+'"/></td>'+
                                '<td><input style="width:100%;" required="required" name="skuName" value="'+$('#name').val()+'"></td>'+
                                '<td><input name="skuProductNo" value="'+$('#productNo').val()+'"></td>'+
                                '<td><input name="skuProductModel" value="'+$('#productModel').val()+'"></td>'+
                                '<td><input name="skuSupplyPrice" value="'+$('#supplyPrice').val()+'"></td>'+
                                '<td><input name="skuMarketPrice" value="'+$('#marketPrice').val()+'"></td>'+
                                '<td><input name="skuSellPrice" value="'+$('#sellPrice').val()+'"></td>'+
                                skuStockStr+
                                '<td><input name="skuSafetyStock" type="text" value="'+$('#safetyStock').val()+'"></td>'+
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
        	$('#selectSellArea').click(function(){
        		var supplierId = $('#supplierId').val();
        		if(supplierId == ''){
        			winAlert('请先选择供应商'); 
        			return false;
        		}
        	});
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
                               content = content+'<span class="attValItem"><input type="checkbox" class="attributeValue'+(i+1)+' atr" value="'+json.attributes[i].attributeValues[j].objectId+'"><span class="attValue">'+
                               json.attributes[i].attributeValues[j].attributeValue+'</span><input type="text" class="attribute-remark"></span>';
                           }
                           content = content+'</span><span>聚合展示：<input type="radio" value="1" name="attribute'+(i+1)+'Show" checked="checked">是&nbsp;<input type="radio" value="0" name="attribute'+(i+1)+'Show">否</span></div>';
                       }
                       $('#product-attrs').html(content);
                       generateSku();
                   }
               });
            });

            function generateWelfareIds(){
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
            }
            $('.welfare-tag').click(function(){
                if($(this).hasClass('welfare-tag-border')){
                    $(this).removeClass('welfare-tag-border');
                }else{
                    $(this).addClass('welfare-tag-border');
                }
                generateWelfareIds();
            });
            $('#allWelfare').click(function(){
            	$('.welfare-tag').each(function(){
            		if($(this).hasClass('welfare-tag-border')){
                    }else{
                        $(this).addClass('welfare-tag-border');
                    }
            	});
            	generateWelfareIds();
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
            
            $('#brandId').change(function(){
                //ajax获取远程的分类属性通过objectId
                var supplierId = $('#supplierId').val();
                var brandId = $('#brandId').val();
                if(supplierId==''||brandId==''){
                	$("#category3").children().remove();
                	return false;
                }
                $.ajax({
                    url:"${dynamicDomain}/product/getThirdCategory",
                    type : 'post',
                    dataType : 'json',
                    data:{'supplierId':supplierId,'brandId':brandId},
                    success : function(json) {
                    	if(json.result){
	                    	$("#category3").children().remove();
	                        $("#category3").append("<option value=''>—一级分类>>二级分类>>三级分类—</option>");
	                        for ( var i = 0; i < json.thirdCategory.length; i++) {
	                            $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
	                        }
	                        $("#category3").val('${category.objectId}');
                    	}else{
                    		$("#category3").children().remove();
                    	}
                    }
                });
             }).change();

            bindPictureDelete();
            supplierAgent();
            $('.operation').click(function(){
            	var form = $(this).closest("form");
                var valid = true;
                if(form){
                    try{
                        valid = form.valid();
                    }catch(e){
                    }
                }
                if(valid){
                    try{
                        valid = customeValid();
                    }catch(e){
                    }
                }
                if(valid){
                    var method =  $(this).attr("validateMethod");
                    if(method){
                        try{
                            valid = eval(method);
                        }catch(e){
                        }
                    }
                }
                if(valid){
                	$('.operation').attr('disabled','disabled');
                }
            });
        });
        
        function viewFront(){
            //得到三级分类
            var categoryId = $('#category3').val();
            if(categoryId==''||categoryId==null){
            	winAlert('请选择所属分类！');
            	return;
            }
            var url = "${dynamicDomain}/product/viewMallCategory/"+categoryId+"?ajax=1";
            $.colorbox({opacity:0.2,href:url,fixed:true,width:"65%", height:"85%", iframe:true,onClosed:function(){ if(false){location.reload(true);}},overlayClose:false});
        }
        
        function verifiProductNumber(){
        	var supplyPrice = $('#supplyPrice').val();
        	if(!/^\d+\.?\d{0,2}$/.test(supplyPrice)){
                winAlert('供货价格最多两位小数');
                return false;
              }
        	var marketPrice = $('#marketPrice').val();
        	if(!/^\d+\.?\d{0,2}$/.test(marketPrice)){
                winAlert('市场价格最多两位小数');
                return false;
              }
        	var sellPrice = $('#sellPrice').val();
        	if(!/^\d+\.?\d{0,2}$/.test(sellPrice)){
                winAlert('销售价格最多两位小数');
                return false;
              }
        	var safetyStock = $('#safetyStock').val();
        	if(!/^\d+$/.test(safetyStock)){
                winAlert('安全库存必须必须是整数');
                return false;
              }
        	return true;
        }
        function verifiSkuNumber(){
        	var skuSup = new Array();
            $("input[name='skuSupplyPrice']").each(function(){
            	skuSup.push($(this).val());
            });
            var skuMar = new Array();
            $("input[name='skuMarketPrice']").each(function(){
                skuMar.push($(this).val());
            });
            var skuSel = new Array();
            $("input[name='skuSellPrice']").each(function(){
                skuSel.push($(this).val());
            });
            var skuSto = new Array();
            $("input[name='skuStock']").each(function(){
                skuSto.push($(this).val());
            });
            var skuSaf = new Array();
            $("input[name='skuSafetyStock']").each(function(){
                skuSaf.push($(this).val());
            });
            for(var i=0;i<skuSup.length;i++){
            	if(!/^\d+\.?\d{0,2}$/.test(skuSup[i])){
                    winAlert('sku供货价格最多两位小数');
                    return false;
                }
            }
            for(var i=0;i<skuMar.length;i++){
                if(!/^\d+\.?\d{0,2}$/.test(skuMar[i])){
                    winAlert('sku市场价格最多两位小数');
                    return false;
                }
            }
            for(var i=0;i<skuSel.length;i++){
                if(!/^\d+\.?\d{0,2}$/.test(skuSel[i])){
                    winAlert('sku销售价格最多两位小数');
                    return false;
                }
            }
            for(var i=0;i<skuSto.length;i++){
                if(!/^\d*$/.test(skuSto[i])){
                    winAlert('sku库存必须为整数');
                    return false;
                }
            }
            for(var i=0;i<skuSaf.length;i++){
                if(!/^\d+$/.test(skuSaf[i])){
                    winAlert('sku安全库存必须为整数');
                    return false;
                }
            }
            return true;
        }
        function verifiSkuMainPicture(){
        	var mainPicture = $('#mainPicture').val();
        	if(mainPicture==''){
        		winAlert('主图图片不能为空');
                return false;
        	}
        	return true;
        }
        function verifiKeywords(){
            var keywords = $('#keywords').val();
            if(keywords!=''){
            	var array = keywords.split(",");
            	for(var i=0;i<array.length;i++){
            		if(array[i].length>50){
            			winAlert('单个关键字不能超过50个字符！');
            			return false;
            		}
            	}
            }
            return true;
        }
        function verifiShape(){
            var weight = $('#weight').val();
            var length = $('#length').val();
            var width = $('#width').val();
            var height = $('#height').val();
            if(weight!=''&&!/^\d+\.?\d{0,2}$/.test(weight)){
                winAlert('商品重量必须为两位小数');
                return false;
            }
            if(length!=''&&!/^\d+\.?\d{0,2}$/.test(length)){
                winAlert('商品长度必须为两位小数');
                return false;
            }
            if(width!=''&&!/^\d+\.?\d{0,2}$/.test(width)){
                winAlert('商品宽度必须为两位小数');
                return false;
            }
            if(height!=''&&!/^\d+\.?\d{0,2}$/.test(height)){
                winAlert('商品高度必须为两位小数');
                return false;
            }
            return true;
        }
        function verifyContent(){
        	var content = CKEDITOR.instances.txt.getData();
        	if(content.length<1){
        		winAlert('商品内容不能为空！');
        		return false;
        	}
        	var skuBody = $('#skuBody').html();
        	if(/^\s*$/.test(skuBody)){
        		winAlert('必须创建一个分类属性并且构造一个sku');
        		return false;
        	}
        	return true;
        }
        function customeValid(){
            var flag = verifiProductNumber()&&verifiSkuNumber()&&verifiSkuMainPicture()&&verifiKeywords()&&verifiShape()&&verifyContent();
            return flag;
        }
        
        function supplierAgent(){
        	//得到对应供应商的代理品牌
        	var supplierId = $('#supplierId').val();
        	var brandId = $('#brandId').val();
        	$('#brandId').html('');
        	$.ajax({
                url:"${dynamicDomain}/product/getBrand",
                type : 'post',
                dataType : 'json',
                data:{'supplierId':supplierId},
                success : function(json) {
                	if(json.result){
                		var content = '<option value="">—请选择—</option>';
                		for(var i=0;i<json.brands.length;i++){
                			content = content+'<option value="'+json.brands[i].objectId+'">'+json.brands[i].chineseName+'</option>';
                		}
                		$('#brandId').html(content);
                		$('#brandId').val(brandId);
                	}
                }
            });
        	//得到供应商的代理销售区域
        	$('#selectSellArea').attr('href','javascript:void(0);');
        	$.ajax({
                url:"${dynamicDomain}/product/getSellArea",
                type : 'post',
                dataType : 'json',
                data:{'supplierId':supplierId},
                success : function(json) {
                    if(json.result){
                    	$('#countrywide').html('');
                    	if(json.isHaveCountrywide){
                    		//显示全国框
                    		var content = '';
                    		<c:choose>
	                    		<c:when test="${entity.objectId!=null}">
	                    		   <c:choose>
		                    		   <c:when test="${entity.isCountrywide==1}">
		                    		       content = '全国<input type="checkbox" name="isCountrywide" value="1" checked="checked">';
		                    		   </c:when>
		                    		   <c:otherwise>
		                    		       content = '全国<input type="checkbox" name="isCountrywide" value="1">';
		                    		   </c:otherwise>
	                    		   </c:choose>
	                    		</c:when>
	                    		<c:otherwise>
	                    		   content = '全国<input type="checkbox" name="isCountrywide" value="1">';
	                    		</c:otherwise>
                    		</c:choose>
                    		$('#countrywide').html(content);
                    	}
                    	var url = '${dynamicDomain}/area/searchMultipleGivenCity?givenIds='+json.areaIds+'&selectedIds=${sellAreas }&areaIds=areaIds&areaNames=areaNames&ajax=1';
                        $('#selectSellArea').attr('href',url);
                    }
                }
            });
        }
        
    </script>
</body>
</html>