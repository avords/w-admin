<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>退换货单详情</title>

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
        <h4 class="modal-title">
          退换货单详情         
        </h4>
      </div>
       <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/vendorChangeOrder/save?ajax=1" id="ChangeOrder" class="form-horizontal">
        <input type="hidden" name="objectId" value="${changeOrder.objectId }">
        <input type="hidden" name="orderStatus" value="5">
        <input type="hidden" name="subOrderId" value="${changeOrder.subOrderId }">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="details" class="col-sm-5 control-label">退换货单详情</label>
              </div>
            </div>     
          </div>
         <hr>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="changeNo" class="col-sm-5 control-label">退换货单号：</label>
                 <div class="col-sm-7 upView">${changeOrder.changeNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="orderStatus" class="col-sm-5 control-label">订单状态：</label>
                <div class="col-sm-7 upView">
               <jdf:dictionaryName dictionaryId="1404" value="${changeOrder.orderStatus }" />
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="changeNo" class="col-sm-5 control-label">退换货类型：</label>
                 <div class="col-sm-7 upView">
               <c:choose>
                 <c:when test=" ${changeOrder.changeType==1}">
                                                               退货
                  </c:when>
                   <c:otherwise>
                                                              换货
                   </c:otherwise>   
                </c:choose>
                
                 </div>
              </div>
            </div>           
          </div>
       <div class="row">
            <div class="col-sm-8 col-md-8">
              <div class="form-group">
                <label for="logo" class="col-sm-2 control-label">上&nbsp;传&nbsp;图&nbsp;证：</label>               
                <div class="col-sm-10">
                  <span class="detail-picture" id="subImg"> 
                  <c:forEach items="${changeOrderExplas}" var="item" varStatus="status">
                      <img alt="" src="${dynamicDomain}${item.imagId}" width="100px" height="100px;">
                    </c:forEach>                   
                  </span>             
              </div>
            </div>           
          </div>  
          </div>        
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="changeNo" class="col-sm-5 control-label">退换货说明：</label>
                 <div class="col-sm-7 upView">${changeOrder.returnInfo}</div>
              </div>
            </div>           
          </div>

          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="changeNo" class="col-sm-5 control-label">退换货商品</label>
                 <div class="col-sm-7 upView"></div>
              </div>
            </div>           
          </div>
          
            <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="changeNo" class="col-sm-5 control-label">订单编号：</label>
                 <div class="col-sm-7 upView">${subOrder.subOrderNo}</div>
              </div>
            </div>  
          </div>
          
          <div class="row">
            <div class="col-sm-12 col-md-12">
            <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>商品系统编号</th>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>商品类型</th>
                    <th>规格属性</th>
                    <th>数量</th>
                    <th>单价</th>
                    <th>小计</th>
                    <th>实付积分</th>
                    <th>实付金额</th>
                    <th>开票金额</th>
                    <th>退换货数量</th>
                    <th>退款金额</th>
                  </tr>
                </thead>
             <c:forEach items="${changeOrderSkus}" var="ordersku" varStatus="num">            
               <tbody>
               <tr>
               <td>${ordersku.productNo}</td>
               <td>${ordersku.skuId}</td>
               <td>${ordersku.name}</td>
               <td><jdf:dictionaryName dictionaryId="1101" value="${ordersku.productType }" /></td>
               <td>${ordersku.attribute}</td>
               <td>${ordersku.productCount}</td>
               <td>${ordersku.productPrice}</td>
               <td>${ordersku.productCount*ordersku.productPrice}</td>
               <td></td>
               <td>${ordersku.productCount*ordersku.productPrice}</td>
               <td>${ordersku.productCount*ordersku.productPrice}</td>
               <td>${ordersku.changeNum}</td>
               <td>${ordersku.changeMount}</td>                          
               </tr>
               </tbody>
               </c:forEach>
          </table>
            </div>
           </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">收货信息</label>    
                <div class="col-sm-8 upView"></div>          
              </div>
            </div>        
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">收货联系人：</label>
                <div class="col-sm-8 upView">${order.receiptContacts}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">联系方式：</label>
                <div class="col-sm-8 upView">${order.receiptTelephone}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">邮编：</label>
                <div class="col-sm-8 upView">${order.receiptZipcode}</div>
              </div>
            </div>
          </div>
            <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">地址：</label>
                <div class="col-sm-8 upView">${order.receiptAddress}</div>
              </div>
            </div>          
          </div>
          <br><br>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">供应商信息</label>    
                <div class="col-sm-8 upView"></div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">供应商编号：</label>
                <div class="col-sm-8 upView">${supplier.supplierNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">供应商名称：</label>
                <div class="col-sm-8 upView">${supplier.supplierName}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">联系人：</label>
                <div class="col-sm-8 upView">${supplier.commissioned}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">联系电话：</label>    
                <div class="col-sm-8 upView">${supplier.telephone}</div>          
              </div>
            </div>        
          </div>
          <br>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">申请时间：</label>    
                <div class="col-sm-8 upView"><fmt:formatDate value="${changeOrder.changeDate}" pattern="yyyy-MM-dd HH:mm:ss" /></div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">申请账户：</label>    
                <div class="col-sm-8 upView">${user.userName}</div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">支付方式：</label>    
                <div class="col-sm-8 upView"></div>          
              </div>
            </div>        
          </div>
          <br>
          <c:if test="${changeOrder.orderStatus!='1' }">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-5 control-label">供应商审核信息</label>    
                <div class="col-sm-7 upView"></div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">审核时间：</label>    
                <div class="col-sm-8 upView">${changeOrder.auditCheckTime}</div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">审核账户：</label>    
                <div class="col-sm-8 upView">${changeOrder.auditAccount}</div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">拒绝原因：</label>    
                <div class="col-sm-8 upView">${changeOrder.refuseReason}</div>          
              </div>
            </div>        
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-5 control-label">供应商退货地址</label>    
                <div class="col-sm-7 upView"></div>          
              </div>
            </div>        
          </div>
          <div class="row">
          <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">收货联系人：</label>    
                <div class="col-sm-8 upView">${changeOrder.receiptContacts}</div>          
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">联系方式：</label>    
                <div class="col-sm-8 upView">${changeOrder.receiptTelephone}</div>          
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">地址：</label>    
                <div class="col-sm-8 upView">${changeOrder.receiptAddress}</div>          
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">邮编：</label>    
                <div class="col-sm-8 upView">${changeOrder.receiptZope}</div>          
              </div>
            </div>        
          </div>
          </c:if>
          <c:if test="${changeOrder.orderStatus=='6'}">
          	<div class="row">
	            <div class="col-sm-4 col-md-4">
	              <div class="form-group">
	                <label for="platform" class="col-sm-4 control-label">物流信息</label>    
	              </div>
	            </div>
	            </div>
	            <div class="row">    
	            <div class="col-sm-4 col-md-4">
	              <div class="form-group">
	                <label for="platform" class="col-sm-4 control-label">物流公司：</label>    
	                <div class="col-sm-8 upView">
	                	<select name="logisticsCompany" class="search-form-control">
		                  <jdf:select dictionaryId="1413" valid="true" />
		                </select>
	                </div>          
	              </div>
	            </div>
	            <div class="col-sm-4 col-md-4">
	              <div class="form-group">
	                <label for="platform" class="col-sm-4 control-label">物流编号：</label>    
	                <div class="col-sm-8 upView">
	                	<input type="text" class="search-form-control" name="logisticsNO">
	                </div>          
	              </div>
	            </div>        
	          </div>
          </c:if>
          <div class="box-footer">
            <div class="row">
              <div class="editPageButton">
	          <c:if test="${changeOrder.orderStatus=='1' }">
	               <a href="${dynamicDomain}/vendorChangeOrder/addSupplier/${changeOrder.objectId }?ajax=1" class="colorbox-mini">
		              <button type="button" class="btn btn-primary ">同意</button>
		            </a>
	               <a href="${dynamicDomain}/vendorChangeOrder/refuse/${changeOrder.objectId }?ajax=1" class="colorbox-mini">
		              <button type="button" class="btn btn-primary">拒绝</button>
		            </a>
	          </c:if>
	          <c:if test="${changeOrder.orderStatus=='4' }">
	               <a href="${dynamicDomain}/vendorChangeOrder/confirmReceipt/${changeOrder.objectId }?ajax=1" class="colorbox-mini">
		              <button type="button" class="btn btn-primary">确认收货</button>
		            </a>
	               <a href="${dynamicDomain}/vendorChangeOrder/refuseReceipt/${changeOrder.objectId }?ajax=1" class="colorbox-mini">
		              <button type="button" class="btn btn-primary">拒绝收货</button>
		            </a>
	          </c:if>
	          <c:if test="${changeOrder.orderStatus=='6'}">
	          	<a href="#" id="confirmShipped">
		              <button type="button" class="btn btn-primary">确认发货</button>
		            </a>
	          </c:if>
               <a href="${dynamicDomain}/vendorChangeOrder/list?search_EQI_changeOrderStatusType=1">
	              <button type="button" class="btn btn-primary">返回</button>
	            </a>
              </div>
            </div>
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
    <jdf:bootstrapDomainValidate domain="ChangeOrder" />
<script type="text/javascript">
$(function() {
	$("#confirmShipped").click(function(){
		$("#ChangeOrder").submit();
	})
});
</script>
</body>
</html>