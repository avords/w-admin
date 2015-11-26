<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>订单详情</title>
<jdf:themeFile file="ajaxfileupload.js" />
<style>
.upView {
	margin: 7px 0 0 0;
}
</style>

</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">订单详情</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/order/save?ajax=1" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <script type="text/javascript">
									objectId = '${entity.objectId}';
								</script>
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">总订单号：</label>
                <div class="col-sm-8 upView">${order.generalOrderNo}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">总金额：</label>
                <div class="col-sm-8 upView">
           
                   <fmt:formatNumber type="number" value=" ${alllActuallyAmount}" pattern="0.00" maxFractionDigits="2"/> 元
                   
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-8 upView">
                  <fmt:formatDate value="${order.bookingDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">登录名：</label>
                <div class="col-sm-8 upView">${loginName}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款方式：</label>
                <div class="col-sm-8 upView">
                  <c:if test="${order.paymentWay==1}">
                                                                 线下支付
                  </c:if>
                  <c:if test="${order.paymentWay==2}">
                                                                 线上支付
                  </c:if>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单类型：</label>
                <div class="col-sm-8 upView">
                  <c:choose>
                    <c:when test="${order.subOrderList[0].orderType==1}">
                                                                 购买积分
                  </c:when>
                    <c:when test="${order.subOrderList[0].orderType==2}">
                                                                 积分购买
                  </c:when>
                    <c:when test="${order.subOrderList[0].orderType==3}">
                                                                  福利兑换
                  </c:when>
                    <c:when test="${order.subOrderList[0].orderType==4}">
                                                                  现金购买
                  </c:when>
                  <c:when test="${order.subOrderList[0].orderType==5}">
                                                             年度福利
                  </c:when>
                  <c:when test="${order.subOrderList[0].orderType==7}">
                                                                体检预约
                  </c:when>
                  </c:choose>
                </div>
              </div>
            </div>
            <c:forEach items="${order.subOrderList}" var="suborder">
              <c:if test="${ suborder.orderType==3}">
                <c:forEach items="${suborder.orderProductList}" var="orderPro">
                  <c:if test="${orderPro.orderProductType==2||orderPro.orderProductType==1}">
                    <div class="col-sm-4 col-md-4">
                      <div class="form-group">
                        <label class="col-sm-4 control-label">兑换卡号：</label>
                        <div class="col-sm-8 upView">${order.cashCard}</div>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </c:forEach>
          </div>
          <c:if test="${order.subOrderList[0].orderProdType==2}">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检变更：</label>
                 <div class="col-sm-8 upView">
                      <c:if test="${packageId !=null}"> 
                      <a href="${dynamicDomain}/CardExchange/packageDetail/${packageId}">主套餐</a>
                      </c:if>
                      <c:if test="${addPackageId !=null}"> 
                      <a href="${dynamicDomain}/CardExchange/getaddtionPackage/${addPackageId}">--加项套餐</a>
                       </c:if>
                       <c:if test="${upPackageId !=null}"> 
                      <a href="${dynamicDomain}/CardExchange/packageDetail/${upPackageId}">--升级套餐</a>
                      </c:if>
                 </div>
              </div>
            </div>
          </div>
          </c:if>
          <c:if test="${order.orderSource==1}">
            <c:forEach items="${order.subOrderList}" var="suborder">
              <c:if test="${suborder.orderType!=3}">
                <c:forEach items="${suborder.orderProductList}" var="orderPro">
                  <c:if test="${orderPro.orderProductType==2}">
                    <div class="row">
                      <div class="col-sm-8 col-md-8">
                        <div class="form-group">
                          <label for="loginName" class="col-sm-2 control-label">上传总检报告：</label>
                          <div class="col-sm-10">
                            <span class="lable-span"> <input type="hidden" name="totalRepport" id="totalRepport"> <a id="uploadFileName" href="" style="text-decoration: underline;">${entity.totalFileName }</a> <input type="file" class="form-control" name="uploadFile" id="uploadFile"
                              style="width: 200px; display: inline;">
                              <button type="button" onclick="ajaxFileUpload();">上传</button>
                            </span>
                          </div>
                        </div>
                      </div>
                    </div>
                  </c:if>
                </c:forEach>
              </c:if>
            </c:forEach>
          </c:if>
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">收货信息</label>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货联系人：</label>
                <div class="col-sm-8 upView">${order.receiptContacts}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">联系方式：</label>
                <div class="col-sm-8 upView">${order.receiptMoblie}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">邮编：</label>
                <div class="col-sm-8 upView">${order.receiptZipcode}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">地址：</label>
                <div class="col-sm-8 upView">${order.receiptAddress}</div>
              </div>
            </div>
          </div>
          <br> <br> <br>
          <div class="row" style="margin-left: 20px;">
            <c:forEach items="${order.subOrderList}" var="suborder">
              <table class="tableAttr">
                <thead>
                  <tr>
                    <th width="10%">供应商信息</th>
                    <td width="10%">供应商编号：</td>
                    <td width="10%">${suborder.suppliers.supplierNo }</td>
                    <td width="10%">供应商名称：</td>
                    <td width="15%">${suborder.suppliers.supplierName }</td>
                    <td width="10%">联系人：</td>
                    <td width="10%">${suborder.suppliers.commissioned}</td>
                    <td width="10%">联系电话：</td>
                    <td width="10%">${suborder.suppliers.telephone}</td>
                    <th></th>
                  </tr>
                  <tr>
                    <th width="10%">&nbsp;</th>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="15%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <th></th>
                  </tr>
                  <tr>
                    <th width="10%">子订单信息</th>
                    <td width="10%">订单编号：</td>
                    <td width="12%">${suborder.subOrderNo}</td>
                    <td width="10%">应付金额：</td>
                    <td width="10%">
                     <c:if test="${suborder.payableAmount!=0.0 && suborder.payableAmount!=null}">
                     <fmt:formatNumber type="number" value="${suborder.payableAmount}" pattern="0.00" maxFractionDigits="2"/>元
                     </c:if>
                    </td>
                    <td width="10%">实付金额：</td>
                    <td width="10%">      
                    <c:if test="${(suborder.orderType==2) && suborder.subOrderState!=1 && suborder.subOrderState!=6 && suborder.subOrderState!=7}">             
                    <c:if test="${(suborder.actuallyAmount==0.0||suborder.actuallyAmount==null) && suborder.actuallyIntegral !=null}">
                       <fmt:formatNumber type="number" value="${suborder.actuallyIntegral}" pattern="0.00" maxFractionDigits="2"/>积分
                    </c:if> 
                    </c:if>
                    
                    <c:if test="${(suborder.orderType==4||suborder.orderType==1) && suborder.subOrderState!=1 && suborder.subOrderState!=6 && suborder.subOrderState!=7}">
                     <c:if test="${(suborder.actuallyIntegral==0.0||suborder.actuallyIntegral==null) && suborder.actuallyAmount !=null}">                     
                       <fmt:formatNumber type="number" value=" ${suborder.actuallyAmount}" pattern="0.00" maxFractionDigits="2"/> 元
                     </c:if>  
                    </c:if>       
                    </td>
                    <td width="10%">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
                    <td width="10%"><jdf:dictionaryName dictionaryId="1400" value="${suborder.subOrderState}" /></td>
                    <th></th>
                  </tr>
                  <tr>
                    <th width="10%"></th>
                    <td width="10%">配送方式：</td>
                    <td width="10%"><jdf:dictionaryName dictionaryId="1416" value="${suborder.distributionMode}" /></td>
                    <td width="10%">物流公司：</td>
                    <td width="10%">${suborder.companyName}</td>
                    <td width="10%">物流编号：</td>
                    <td width="10%">${suborder.logisticsNo}</td>
                    <td width="10%">发票总金额：</td>
                    <td width="10%"><c:if test="${suborder.invoiceAmount!=0.0 && suborder.invoiceAmount!=null}">
                    <fmt:formatNumber type="number" value="${suborder.invoiceAmount}" pattern="0.00" maxFractionDigits="2"/>元
                    </c:if></td>
                  </tr>
                  <tr>
                    <th width="10%">&nbsp;</th>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="15%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <td width="10%"></td>
                    <th></th>
                  </tr>
                  <tr>
                    <th width="10%">发票信息</th>
                    <td width="10%">发票抬头：</td>
                    <td width="10%">${suborder.invoiceUp}</td>
                    <td width="10%">寄送地址：</td>
                    <td width="15%">${suborder.invoiceAddress}</td>
                    <td width="10%">联系人：</td>
                    <td width="10%">${suborder.invoiceContacts}</td>
                    <td width="10%">联系方式：</td>
                    <td width="10%">${suborder.invoiceTelephone}</td>
                    <th></th>
                  </tr>

                </thead>
                <tbody>
                </tbody>
              </table>
              <br>
              <c:forEach items="${suborder.orderProductList}" var="orderproduct">
                <table class="table table-bordered table-hover">
                  <thead>
                    <tr>
                      <th width="10%">商品编号</th>
                      <th width="8%">商品ID</th>
                      <th width="10%">商品名称</th>
                      <th width="10%">商品类型</th>
                      <th width="10%">规格属性</th>
                      <th width="8%">数量</th>
                      <th width="8%">单价</th>
                      <th width="8%">小计</th>
                      <th width="10%">实付金额</th>
                      <th width="10%">实付积分</th>
                      <th width="10%">开票金额</th>
                    </tr>
                  </thead>
                  <tbody>
                    <tr style="">
                      <td>
                      <c:if test="${orderproduct.productType==1 || orderproduct.productType==2 || orderproduct.productType==3 }">
                        <a href="${dynamicDomain}/order/productDetails/?productId=${orderproduct.productId}&objectId=${objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>
                      </c:if>
                      <c:if test="${orderproduct.productType==31 || orderproduct.productType==32}">
                        <a href="${dynamicDomain}/CardExchange/packageDetail/${packageId}"><font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>                        
                      </c:if>
                      <c:if test="${orderproduct.productType==21 || orderproduct.productType==22}">
                         <a href="${dynamicDomain}/welfarePackage/view/${packageId}"><font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>                        
                      </c:if>
                      </td>
                      <td>${orderproduct.productId}</td>
                      <td>${orderproduct.name}</td>
                      <td><c:choose>
                          <c:when test="${orderproduct.productType==1}">
                                                                实物商品
                     </c:when>
                          <c:when test="${orderproduct.productType==2}">
                                                                 实体卡券
                     </c:when>
                          <c:when test="${orderproduct.productType==3}">
                                                                电子卡券
                     </c:when>
                          <c:when test="${orderproduct.productType==21}">
                                                                福利实体兑换券
                     </c:when>
                          <c:when test="${orderproduct.productType==22}">
                                                                福利电子兑换券
                     </c:when>
                          <c:when test="${orderproduct.productType==31}">
                                                               体检实体兑换券
                     </c:when>
                          <c:when test="${orderproduct.productType==32}">
                                                               体检电子兑换券
                     </c:when>
                        </c:choose></td>
                      <td>
                      <c:if test="${orderproduct.attribute2!=null && orderproduct.attribute1!=null }">
                                                                         颜色：${orderproduct.attribute2}，尺寸：${orderproduct.attribute1}
                      </c:if>
                      </td>
                      <td>
                      <c:choose>
                          <c:when test="${(orderproduct.productType==22||orderproduct.productType==32) && order.orderSource==1}">
                            <a href="${dynamicDomain}/order/cardInfo/?productId=${orderproduct.productId}&subOrderId=${orderproduct.subOrderId}&ajax=1" class="colorbox-big pull-left"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productCount} </font>
                            </a>
                          </c:when>
                          <c:otherwise>
                              ${orderproduct.productCount} 
                          </c:otherwise>
                        </c:choose>
                        </td>
                      <td><c:if test="${orderproduct.productPrice!=null}">
                         ${orderproduct.productPrice}元
                       </c:if></td>
                      <td><c:choose>
                          <c:when test="${orderproduct.productCount!=0 && orderproduct.productCount!=null}">
                        <fmt:formatNumber type="number" value="${orderproduct.productPrice*orderproduct.productCount}" pattern="0.00" maxFractionDigits="2"/>元
                      </c:when>
                          <c:otherwise>
                        ${orderproduct.productPrice}
                      </c:otherwise>
                        </c:choose></td>
                      <td><%-- <c:set var="pCount" scope="request" value="${fn:length(suborder.orderProductList)}" /> <c:if test="${pCount>0}"> --%>
                       <c:if test="${(suborder.orderType==4 || suborder.orderType==1) && suborder.subOrderState!=1 && suborder.subOrderState!=6 && suborder.subOrderState!=7 }">                                            
                         <fmt:formatNumber type="number" value="${orderproduct.productCount*orderproduct.productPrice}" pattern="0.00" maxFractionDigits="2"/>元                       
                        </c:if>
                      </td>
                      <td>
                       <c:if test="${suborder.orderType==2 && suborder.subOrderState!=1 && suborder.subOrderState!=6 && suborder.subOrderState!=7 }">                                   
                          <fmt:formatNumber type="number" value="${orderproduct.productCount*orderproduct.productPrice}" pattern="0.00" maxFractionDigits="2"/>积分                               
                        </c:if>
                        </td>
                      <td><c:if test="${order.ifInVoice==1}">                    
                        <fmt:formatNumber type="number" value="${orderproduct.productPrice*orderproduct.productCount}" pattern="0.00" maxFractionDigits="2"/>元
                      </c:if></td>
                    </tr>
                  </tbody>
                </table>
              </c:forEach>
              <br>
              <br>
              <br>
            </c:forEach>
          </div>
          <div class="row">
            <div class="editPageButton">
              <a href="javascript:void(0)" class="btn btn-primary" onclick="goBack();">返回</a>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Order" />
  <script type="text/javascript">
			$(function() {
				$(".datestyle").datepicker({
					format : 'yyyy-mm-dd'
				});
			});

			function ajaxFileUpload() {
				$.ajaxFileUpload({
							url : '${dynamicDomain}/order/picture/uploadFile?ajax=1&objectId=' + objectId,
							secureuri : false,
							fileElementId : 'uploadFile',
							dataType : 'json',
							success : function(json, status) {
								if (json.result) {
									var filePath = json.filePath;
									var fileName = json.fileName;
									$('#totalRepport').val(filePath);
									$('#uploadFileName').attr('href',
											'${dynamicDomain}' + filePath);
									$('#uploadFileName').text(fileName);
								}
							},
							error : function(data, status, e)//服务器响应失败处理函数
							{
								alert(e);
							}
						});
				return false;
			}
			
			function goBack(){
				history.go(-1);
			}
		</script>
</body>
</html>