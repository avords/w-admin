<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="运营端-礼券兑换" /></title>
</head>
<body>
<div>
	<form action="${dynamicDomain}/giftExchange/cancelOrder" id="orderForm" name="orderForm" method="post">
		<div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${msg }</div>
                <jdf:message code="运营端-礼券兑换-订单详情" />
            </h4>
        </div>
		
		<div class="box-body">
			<div class="panel panel-default" style="width: 100%; min-height: 100px;">
				<div class="panel-heading">
					订单详情
					<c:if test="${isAllWaitSend=='1' && iscancel=='1'}">
						<button type="button" id="cancelOrder" class="btn btn-primary">取消兑换 </button>
						<input type="hidden" name="orderId" id="orderId" value="${order.objectId}"/>
					</c:if>
					<button type="button" class="btn btn-primary j-btn-back">返回 </button>
				</div>
	        
	          
	          
	          <!-- 卡号信息 -->
	          <c:forEach items="${cardInfoList}" var="cardInfo">
		          <div class="row">
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">卡号:</label>
		                <div class="col-sm-8 upView">
		                	${cardInfo.cardNo}
		                </div>
		              </div>
		            </div>
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">状态:</label>
		                <div class="col-sm-8 upView">
		                	<jdf:columnValue dictionaryId="1604" value="${cardInfo.cardStatus}" />
		                </div>
		              </div>
		            </div>
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">卡号有效截止日期:</label>
		                <div class="col-sm-8 upView">
		                	<fmt:formatDate value="${cardInfo.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
		                </div>
		              </div>
		            </div>
		          </div>
		          
		          <div class="row">
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">兑换操作人：</label>
		                <div class="col-sm-8 upView">
		                	${cardInfo.updateUser}
		                </div>
		              </div>
		            </div>
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">操作时间：</label>
		                <div class="col-sm-8 upView">
		                	<fmt:formatDate value="${cardInfo.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="row">
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">卡号类型：</label>
		                <div class="col-sm-8 upView">
		                	${cardInfo.itemName}
		                </div>
		              </div>
		            </div>
		          </div>
		          <div class="row">
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label">卡号说明：</label>
		                <div class="col-sm-8 upView">
		                	${cardInfo.packageExplain}
		                </div>
		              </div>
		            </div>
		          </div>
		          
	          </c:forEach>
	          </div>  
	          
	          
	          </br> </br>
	          
	          <!-- 订单信息 -->
	          <c:forEach items="${subOrderes}" var="subOrder">
	          <div class="panel panel-default" style="width: 100%; min-height: 100px;">
	          		<div class="panel-heading">
						订单编号：${subOrder.subOrderNo}
					</div>
					
					
		          <div class="row">
		            <div class="col-sm-3 col-md-3 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label"><h4>收货信息</h4></label>
		              </div>
		            </div>
		          </div>
		          
		          <!-- 子订单类型 1:实物 ;2:虚拟-->
		          <c:choose>
		          	<c:when test="${subOrder.subOrderType == 1}">
		          		<div class="row">
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">收货联系人：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptContacts}
				                </div>
				              </div>
				            </div>
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">联系方式：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptMoblie}
				                </div>
				              </div>
				            </div>
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">邮编：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptZipcode}
				                </div>
				              </div>
				            </div>
				          </div>
				           <div class="row">
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">地址：</label>
				                <div class="col-sm-8 upView">
				                	${subOrder.receiptAddress}
				                </div>
				              </div>
				            </div>
				          </div>
			           	<div class="row">
				            <div class="col-sm-3 col-md-3 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label"><h4>物流信息</h4></label>
				              </div>
				            </div>
				          </div>
				          <div class="row">
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">物流公司：</label>
				                <div class="col-sm-4 upView">
				                	<c:choose>
				                		<c:when test="${subOrder.companyName ==null || subOrder.companyName==''}">
				                			暂无物流信息
				                		</c:when>
				                		<c:otherwise>
				                			${subOrder.companyName}
				                		</c:otherwise>
				                	</c:choose>
				                </div>
				              </div>
				            </div>
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">运单号：</label>
				                <div class="col-sm-4 upView">
				                	<c:choose>
				                		<c:when test="${subOrder.logisticsNo ==null || subOrder.logisticsNo==''}">
				                			暂无物流信息
				                		</c:when>
				                		<c:otherwise>
				                			${subOrder.logisticsNo}
				                		</c:otherwise>
				                	</c:choose>
				                </div>
				              </div>
				            </div>
				          </div>
		          	</c:when>
		          	<c:otherwise>
		          		<div class="row">
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">收货联系人：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptContacts}
				                </div>
				              </div>
				            </div>
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">联系方式：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptMoblie}
				                </div>
				              </div>
				            </div>
				            <div class="col-sm-4 col-md-4 ">
				              <div class="form-group">
				                <label for="platform" class="col-sm-4 control-label">邮箱：</label>
				                <div class="col-sm-4 upView">
				                	${subOrder.receiptEmail}
				                </div>
				              </div>
				            </div>
				          </div>
		          	</c:otherwise>
		          	
		          </c:choose>
		          
		          
		          
		          
		          
		          <div class="row">
		            <div class="col-sm-4 col-md-4 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label"> 套餐名称：</label>
		                <div class="col-sm-4 upView">
		                	${subOrder.packageName}
		                </div>
		              </div>
		            </div>
		          </div>
		          
		          
		          <div class="row">
		            <div class="col-sm-3 col-md-3 ">
		              <div class="form-group">
		                <label for="platform" class="col-sm-4 control-label"><h4>商品清单</h4></label>
		              </div>
		            </div>
		          </div>



					<table class="table table-bordered table-hover">
						<thead>
							<tr>
								<th>商品</th>
								<th>市场参考价</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${subOrder.skuPublishs}" var="skuPublish">
						    	<tr>
									<td>
										<a href="${dynamicDomain}/product/view/${skuPublish.productId}" target="_blank">
											<img style="height: 80px; width: 80px;" src="${adminStaticDomain}${skuPublish.mainPicture}"></a>
										</a>
										<a href="${dynamicDomain}/product/view/${skuPublish.productId}" target="_blank">${skuPublish.name}</a>
									</td>
									<td>￥<fmt:formatNumber type="number" value="${skuPublish.productPrice }" pattern="0.00" maxFractionDigits="2"/></td>
								</tr>
							</c:forEach>
						</tbody>
						
						<tfoot>
							<tr><th></th><th></th></tr>
						</tfoot>
					</table>
				</div>
	          </c:forEach>
	          
	          
		</div>
	
		</div>
	</form>
</div>	
	<script type="text/javascript">
		$(function() {
			
			// 判断是否选择
			$('#cancelOrder').click(function() {
				
				if(confirm("您确认取消兑换吗？\n提示：取消后卡密可重新兑换。")){
					$("#orderForm").submit();
				}
			});
			
			$(".j-btn-back").click(function(){
				$("#orderForm").attr("action","${dynamicDomain}/giftExchange/index");
				$("#orderForm").submit();
			});
			
			
			
		});
	
	</script>
	
	


</body>
</html>