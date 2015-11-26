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
      <form method="post" action="" class="form-horizontal" id="editForm">
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
                <c:if test="${ActuallyIntegral!=null &&ActuallyIntegral!=0 && (ActuallyAmount==0.0 || ActuallyAmount==null) }">
                ${ActuallyIntegral}积分
                </c:if>   
                 <c:if test="${(ActuallyIntegral==null ||ActuallyIntegral==0) && ActuallyAmount!=null && ActuallyAmount!=0.0}">
                 ${ActuallyAmount}元   
                 </c:if>     
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
                   <c:when  test="${order.subOrderList[0].orderType==3}">
                                                                  福利兑换
                  </c:when>
                  <c:when  test="${order.subOrderList[0].orderType==4}">
                                                                  现金购买
                  </c:when>
                  <c:when  test="${order.subOrderList[0].orderType==5}">
                                                             年度福利
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
                  <span class="lable-span"> 
                  <input type="hidden" name="totalRepport" id="totalRepport">
                  <a id="uploadFileName" href=""  style="text-decoration:underline;">${entity.totalFileName }</a>
                  <input type="file" class="form-control" name="uploadFile" id="uploadFile" style="width:200px;display:inline;">
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
          <br>
          <br> <br>
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
                    <td width="10%">${suborder.subOrderNo}</td>
                    <td width="10%">应付总积分：</td>
                    <td width="10%">
                      ${suborder.payableAmount}
                    </td>
                    <td width="10%">实付总积分：</td>
                    <td width="10%">                    
                    <%-- <c:if test="${suborder.actuallyIntegral!=null && suborder.actuallyAmount !=null}">
                     ${suborder.actuallyAmount}元+${suborder.actuallyIntegral}积分
                    </c:if> --%>
                    <c:if test="${suborder.actuallyAmount==0.0 && suborder.actuallyIntegral !=null}">
                       ${suborder.actuallyIntegral}积分
                    </c:if>
                    <c:if test="${suborder.actuallyIntegral==0.0 && suborder.actuallyAmount !=null}">
                       ${suborder.actuallyAmount}元
                    </c:if>
                   
                    </td>
                    <td width="10%">状&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;态：</td>
                    <td width="10%">
                  <jdf:dictionaryName dictionaryId="1409" value="${suborder.subOrderState}" />
                 </td>
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
                  	<th width="10%">商品名称</th>
                  	<c:choose>
                  	 <c:when  test="${orderproduct.lifeType==1}">
                        <th width="10%">手机号码</th>
                     </c:when>
                  	 <c:when  test="${orderproduct.lifeType==7}">
                        <th width="10%">QQ号码</th>
                     </c:when>
                     <c:when  test="${orderproduct.lifeType==3}">
                        <th width="10%">开户银行</th>
                        <th width="10%">户主姓名</th>
                     </c:when>
                  	 <c:when  test="${orderproduct.lifeType==8}">
                        <th width="10%">支付宝账户</th>
                     </c:when>
                     <c:otherwise>
                     	<th width="10%">空账户</th>
                     </c:otherwise>                                          
                  	</c:choose>
                    <th width="10%">商品类型</th>
                    <th width="8%">付款积分</th>
                    <th width="8%">付款时间</th>
                    <th width="8%">付款操作人</th>                    
                    <th width="8%">数量</th>
                    <th width="8%">单价</th>
                    <th width="8%">小计</th>
					<th width="8%">实付积分</th>
                  </tr>
                </thead>                
                  <tbody> 
                    <tr style="">
                      <td>${orderproduct.name}</td>
                  	<c:choose>
                  	 <c:when  test="${orderproduct.lifeType==1}">
                        <td>${orderproduct.remark1}</td>
                     </c:when>
                  	 <c:when  test="${orderproduct.lifeType==7}">
                        <td>${orderproduct.remark1}</td>
                     </c:when>
                     <c:when  test="${orderproduct.lifeType==3}">
                        <td>${orderproduct.remark3}</td>
                        <td>${orderproduct.remark2}</td>
                     </c:when>
                  	 <c:when  test="${orderproduct.lifeType==8}">
                        <td>${orderproduct.remark1}</td>
                     </c:when>                                          
                  	</c:choose>
                      <td>
                      		生活服务
                      </td>
                      <td>
							${suborder.actuallyIntegral}                     
                      </td>
                      <td>
							<fmt:formatDate value="${suborder.paymentDate}" pattern="yyyy-MM-dd hh:mm"/>                       
                      </td>
                      <td>
							 ${suborder.payUserName}                     
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
                      <td>
                       <c:if test="${orderproduct.productPrice!=null}">
                         ${orderproduct.productPrice}元
                       </c:if>
                      </td>
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
                      <td>
                      	${suborder.actuallyIntegral}
                      </td>                      
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
              <a href="javascript:void(0)" class="btn btn-primary" onclick="fanhui()">返回</a>      
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
			function fanhui(){
				window.history.back(-1); 
			}
		    function ajaxFileUpload() {
		        $.ajaxFileUpload(  
		        {  
		            url: '${dynamicDomain}/order/picture/uploadFile?ajax=1&objectId='+objectId,  
		            secureuri: false,  
		            fileElementId: 'uploadFile',  
		            dataType: 'json',  
		            success: function(json, status) {
		                if(json.result){
		                    var filePath = json.filePath;
		                    var fileName = json.fileName;
		                    $('#totalRepport').val(filePath);
		                    $('#uploadFileName').attr('href','${dynamicDomain}'+filePath);
		                    $('#uploadFileName').text(fileName);
		                }
		            },error: function (data, status, e)//服务器响应失败处理函数
		            {
		                alert(e);
		            }
		        }  
		    );
		        return false;  
		    } 
		</script>
</body>
</html>