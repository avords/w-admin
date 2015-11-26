<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>订单明细</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">订单明细</h4>
    </div>
    <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">总订单号：</label> 
                <span class="">${order.generalOrderNo}</span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-5 col-md-5">
              <div class="form-group">
                <label class="col-sm-4 control-label">总金额：</label> 
                <span class="">
                ${alllActuallyAmount}元
                </span>
              </div>
            </div>
            <div class="col-sm-5 col-md-5">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label> 
                <span class=""> <fmt:formatDate value="${order.bookingDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-5 col-md-5">
              <div class="form-group">
                <label class="col-sm-4 control-label">登录名：</label> 
                <span class=""> 
                	${loginName}
                </span>
              </div>
            </div>
            <div class="col-sm-5 col-md-5">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款方式：</label> 
                <span class=""> 
                	<c:if test="${order.paymentWay==1}">
                                                                 线下支付
                  </c:if>
                  <c:if test="${order.paymentWay==2}">
                                                                 线上支付
                  </c:if>
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-5 col-md-5">
              <div class="form-group">
                <label class="col-sm-4 control-label">是否开发票：</label> 
                <span class=""> 
                	是
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12 ">
              <table class="table">
              	<thead>
              	<tr>
              		<th width="100%" colspan="6">收货信息</th>
              	</tr>
              	</thead>
              	<tbody>
              	<tr>
              		<td width="15%">收货联系人：</td>
              		<td width="18%">${order.receiptContacts}</td>
              		<td width="15%">联系方式：</td>
              		<td width="19%">${order.receiptMoblie}</td>
              		<td width="15%">邮编：</td>
              		<td width="18%">${order.receiptZipcode}</td>
              	</tr>
              	<tr>
              		<td width="15%">地址：</td>
              		<td colspan="5" width="85%">${order.receiptAddress}</td>
              	</tr>
              	</tbody>
              </table>
            </div>
          </div>
          <div class="row" >
            <div class="col-sm-12 col-md-12 ">
            <c:forEach items="${order.subOrderList}" var="suborder">
              <table class="table">
                <thead>
                  <tr >
                  <th width="100%" colspan="8">供应商信息</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td width="12%">供应商编号：</td>
                    <td width="12%">${suborder.suppliers.supplierNo }</td>
                    <td width="12%">供应商名称：</td>
                    <td width="19%">${suborder.suppliers.supplierName }</td>
                    <td width="10%">联系人：</td>
                    <td width="10%">${suborder.suppliers.commissioned}</td>
                    <td width="12%">联系电话：</td>
                    <td width="13%">${suborder.suppliers.telephone}</td>
                  </tr>
                 </tbody>
                 <thead>
                  <tr >
                  <th width="100%" colspan="8">子订单信息</th>
                  </tr>
                 </thead>
                 <tbody>
                  <tr>
                    <td width="12%">订单编号：</td>
                    <td width="12%">${suborder.subOrderNo}</td>
                    <td width="12%">应付总金额：</td>
                    <td width="19%">${suborder.actuallyAmount}</td>
                    <td width="10%">实付金额：</td>
                    <td width="10%">
                    <c:if test="${subOrder.actuallyAmount!=null && subOrder.actuallyIntegral!=null}">
		               ${subOrder.actuallyAmount}元 +${subOrder.actuallyIntegral}积分
	                </c:if>
                    <c:if test="${suborder.actuallyAmount==null && suborder.actuallyIntegral !=null}">
                       ${suborder.actuallyIntegral}积分
                    </c:if>
                    <c:if test="${suborder.actuallyIntegral==null && suborder.actuallyAmount !=null}">
                       ${suborder.actuallyAmount}元
                    </c:if>
                    </td>
                    <td width="12%">状态：</td>
                    <td width="13%">
	                    <jdf:dictionaryName dictionaryId="1400" value="${suborder.subOrderState}" />
                    </td>
                  </tr>
                  <tr>
                    <td width="12%">配送方式：</td>
                    <td width="12%">${suborder.distributionMode}</td>
                    <td width="12%">物流公司：</td>
                    <td width="19%">${suborder.logisticsCompany}</td>
                    <td width="10%">物流编号：</td>
                    <td width="10%">${suborder.logisticsNo}</td>
                    <td width="12%">订单类型：</td>
                    <td width="13%"><jdf:dictionaryName dictionaryId="1402" value="${suborder.orderType}" /></td>
                  </tr>
                 </tbody>
              </table>
              </div>
              <table class="table table-bordered" >
                <thead>
                  <tr>
                    <th width="15%">商品系统编号</th>
                    <th width="15%">商品ID</th>
                    <th width="10%">数量</th>
                    <th width="10%">单价</th>
                    <th width="10%">小计</th>
                    <th width="12%">实付积分</th>
                    <th width="13%">实付金额</th>
                    <th width="15%">操作</th>
                  </tr>
                </thead>
                <c:forEach items="${suborder.orderProductList}" var="orderproduct">
                  <tbody>
                    <tr >
                      <td>
                       <c:if test="${orderproduct.productType==1 || orderproduct.productType==2 || orderproduct.productType==3 }">
                        <a href="${dynamicDomain}/order/productDetails/?productId=${orderproduct.productId}&objectId=${objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>
                      </c:if>
                      <c:if test="${orderproduct.productType==31 || orderproduct.productType==32}">
                        <a href="${dynamicDomain}/CardExchange/packageDetail/${orderproduct.productId}"><font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>                        
                      </c:if>
                      <c:if test="${orderproduct.productType==21 || orderproduct.productType==22}">
                         <a href="${dynamicDomain}/welfarePackage/view/${orderproduct.productId}"><font style="font-size: 14px; color: blue; text-decoration: underline;"> ${orderproduct.productNo}</font></a>                        
                      </c:if>
                      </td>
                      <td>${orderproduct.productId}</td>	
                      <td>
                      ${orderproduct.productCount} 
                      </td>
                      <td>
                      <c:if test="${orderproduct.productPrice!=null}">
                         ${orderproduct.productPrice}元
                       </c:if></td>
                      <td>
						<c:choose>
                      <c:when test="${orderproduct.productCount!=0 && orderproduct.productCount!=null}">
                      ${orderproduct.productCount*orderproduct.productPrice}
                      </c:when>
                      <c:otherwise>
                        ${orderproduct.productPrice}
                      </c:otherwise>
                      </c:choose>
					  </td>
                      <c:set var="pCount" scope="request" value="${fn:length(suborder.orderProductList)}"/>
                      <td>
                      <c:if test="${pCount>0}">
                      <c:if test="${suborder.actuallyIntegral!=null }">
                      ${suborder.actuallyIntegral/pCount}
                      </c:if>
                      </c:if>
                      </td>
                      <td>
                      <c:if test="${pCount>0}">
                      <c:if test="${suborder.actuallyAmount!=null }">
                       ${suborder.actuallyAmount/pCount}
                       </c:if>
                       </c:if>
                      </td>
                      <td>
                      	<c:if test="${exceptionOrder.exceptionStatus!=1}">
			            </c:if>
			            <c:choose>
							<c:when test="${exceptionOrder.exceptionStatus==2 || exceptionOrder.exceptionStatus==3 || exceptionOrder.exceptionStatus==4}">
		                     	<a href="#" class="pull-left" onclick="doResetSend('${suborder.objectId}','${orderproduct.productId}');"> 
						           	<button type="button" class="btn btn-primary">
										补发电子凭证
									</button>
					            </a>
							</c:when>
							<c:otherwise>
								&nbsp;
							</c:otherwise>
						</c:choose>
                      </td>
                    </tr>
                  </tbody>
                </c:forEach>
              </table>
              <br>
            </c:forEach>
          </div>
          <div class="row">
            <div class="editPageButton">
              <a href="${dynamicDomain}/exceptionOrder/page" class="btn btn-primary">返回 </a>
            </div>
          </div>
  </div>
  <jdf:bootstrapDomainValidate domain="Order" />
  <script type="text/javascript">

	function doResetSend(objectId,productId){
		$.ajax({
			url : "${dynamicDomain}/exceptionOrder/replacement/" +objectId+"/"+ productId,
			type : 'post',
			dataType : 'json',
			success : function(msg) {
				var data = msg.msg;
				alert(data);
				window.location.reload();
			}

		});
	}

</script>
</body>
</html>