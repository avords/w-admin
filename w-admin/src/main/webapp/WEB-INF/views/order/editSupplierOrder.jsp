<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>订单详情</title>


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
      <form method="post" action="${dynamicDomain}/" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <input type="hidden" name="subOrderId" id="subOrderId" value="${suborder.objectId}">  
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单编号：</label>
                <div class="col-sm-8 upView">${suborder.subOrderNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单状态：</label>
                <div class="col-sm-8 upView">
                
                <c:if test="${suborder.subOrderState==1}">
                                                    已发货               
                </c:if>
                <c:if test="${suborder.subOrderState==2}">
                                                    待发货               
                </c:if>
                <c:if test="${suborder.subOrderState==3}">
                                                  待付款           
                </c:if>
                <c:if test="${suborder.subOrderState==4}">
                                                    已完成          
                </c:if>
                <c:if test="${suborder.subOrderState==5}">
                                                    已取消              
                </c:if>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
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
                <label class="col-sm-4 control-label">下单账户：</label>
                <div class="col-sm-8 upView">${order.userName }</div>
              </div>
            </div>
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
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款时间：</label>
                <div class="col-sm-8 upView">
                  <fmt:formatDate value="${order.bookingDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
              </div>
            </div>
          </div>
          <br>
          <br>
          <br>
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">收&nbsp;货&nbsp;信&nbsp;息</label>
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
          <br>
          <br>
          <c:if test="${not empty  orderChaAddr }">
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label" style="color:red">更改收货信息</label>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label" style="color:red">收货联系人：</label>
                <div class="col-sm-8 upView" style="color:red">${orderChaAddr.finalReceiptContacts}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label" style="color:red">联系方式：</label>
                <div class="col-sm-8 upView" style="color:red">${orderChaAddr.finalReceiptTelephone}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label" style="color:red">邮编：</label>
                <div class="col-sm-8 upView" style="color:red">${orderChaAddr.finalreceiptZipcode}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label" style="color:red">地址：</label>
                <div class="col-sm-8 upView" style="color:red">${orderChaAddr.finalreceiptAddress}</div>
              </div>
            </div>
          </div>
          </c:if>         
          <br><br><br>
          
          <div class="row" style="margin-left: 20px;">

            <table class="tableAttr">
              <thead>
                <tr>
                  <th width="10%">物流信息</th>
                  <th width="10%">配送方式：</th>
                  <td width="10%">${suborder.distributionMode}</td>
                  <th width="10%">物流公司：</th>
                  <td width="10%">${suborder.logisticsCompany}</td>
                  <th width="10%">物流编号：</th>
                  <td width="10%">${suborder.logisticsNo}</td>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
            <br>

            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th width="8%">商品ID</th>
                  <th width="10%">商品名称</th>
                  <th width="10%">规格属性</th>
                  <th width="8%">数量</th>
                  <th width="8%">单价</th>
                  <th width="8%">小计</th>
                  <th width="10%">实付金额</th>
                  <th width="10%">实付积分</th>
                  <th width="10%">开票金额</th>
                </tr>
              </thead>
              <c:forEach items="${orderSkus}" var="orderSku">
                <tbody>
                  <tr style="">

                    <td>${orderSku.productId}</td>
                    <td>${orderSku.name}</td>
                    <td>${orderSku.attribute}</td>
                    <td>${orderSku.productCount}</td>
                    <td>${orderSku.productPrice}</td>
                    <td>${orderSku.productCount*orderSku.productPrice}</td>
                    <td>${orderSku.productCount*orderSku.productPrice}</td>
                    <td>${orderSku.productCount*orderSku.intergral}</td>
                    <td>${orderSku.productPrice}</td>
                  </tr>
                </tbody>
              </c:forEach>
            </table>
            <br> <br> <br>
          </div>
          <div class="row" style="margin-left: 200px;">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label"></label>
                <div class="col-sm-8 upView"></div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">实付金额：</label>
                <div class="col-sm-8 upView">${suborder.actuallyAmount+suborder.actuallyIntegral}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">开票金额： </label>
                <div class="col-sm-8 upView">${suborder.invoiceAmount}</div>
              </div>
            </div>
          </div>
          <br>
          <br>
          <br>
          <br>
          
          <c:if test="${suborder.subOrderState==2}">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">物流信息</label>
                <div class="col-sm-8 upView"></div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">物流公司：</label>
                <div class="col-sm-8">
                  <select name="logisticsCompany" id="logisticsCompany" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1413" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">物流编号： </label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" id="logisticsNo" name="logisticsNo" >
                </div>
              </div>
            </div>
          </div>
          </c:if>
          <br>
          <br>
          <div class="row">
            <div class="editPageButton">

              
                <button type="button" class="btn" onclick="return handleChangeOrder();">已处理改单</button>
              
                <button type="button" class="btn" onclick="return verifySuccess();">确认发货</button>
                  <a href="${dynamicDomain}/supplierOrder/query">
                <button type="button" class="btn">返回</button>
              </a>

            </div>
          </div>
          <br>
          <br>
          <br>
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
			
			
			function verifySuccess(){				
			var logisticsNo =$("#logisticsNo").val();
			var logisticsCompany=$("#logisticsCompany").val();
			var subOrderId=$("#subOrderId").val();
				 $.ajax({  
				    url:"${dynamicDomain}/supplierOrder/saveOrder",
					type : 'post',
					data : "logisticsNo="+logisticsNo+"&logisticsCompany="+logisticsCompany+"&subOrderId="+subOrderId,
					dataType : 'json',
					success : function(msg) {
						if(msg.result==true){
							window.location.reload(true);
						}
					}
				});
			 }
			
			
			function handleChangeOrder(){								
				var subOrderId=$("#subOrderId").val();
					 $.ajax({  
					    url:"${dynamicDomain}/supplierOrder/handleChangeOrder",
						type : 'post',
						data : "subOrderId="+subOrderId,
						dataType : 'json',
						success : function(msg) {
							if(msg.result==true){
								window.location.reload(true);
							}
						}
					});
				 }
		</script>
</body>
</html>