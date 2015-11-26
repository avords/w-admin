<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title><jdf:message code="快捷发货" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        快捷发货
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/fastOrder/page" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker()" name="search_GED_paymentDate" id="startDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker()" class="search-form-control" name="search_LED_paymentDate" id="endDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startDate\')}',readOnly:true})">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单编号：</label>
                <div class="col-sm-8">
                  	<input type="text" class="search-form-control" name="search_LIKES_subOrderNo" id="orderNo">
                </div>
              </div>
            </div>
          </div>
          
          
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付方式：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_paymentWay" class="search-form-control" id="paymentWay">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1403" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单来源：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_orderSource" class="search-form-control" id="orderSource">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1401" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_userName" id="userName">
                </div>
              </div>
            </div>
          </div>
           
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人手机：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptMobile" id="receiptMobile">
                </div>
              </div>
            </div>
            
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人姓名：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptContacts" id="receiptContacts">
                </div>
              </div>
            </div>
            
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">配送地址：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptAddress" id="receiptAddress">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
              <a href="javascript:void(0);" class="btn btn-primary pull-left" onclick="exportFast();">
                   	导出
              </a>
              <a href="javascript:void(0);" class="btn btn-primary pull-left" onclick="printFast();">
                                                                  打印发货单
              </a>
              <a href="${dynamicDomain}/fastOrder/importOrderDialog?ajax=1" class="colorbox btn btn-primary">
                                                              导入已发货单号
              </a>

            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
              <button type="submit" class="btn btn-primary">查询</button>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  
   
  <div>
  <jdf:table items="items" var="subOrder"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="fastOrder.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="fastOrder.xls" tooltip="导出EXCEL"
				imageName="xls" />
				
			<jdf:row>
				<jdf:column alias=""  title="" sortable="false" viewsAllowed="html" headerStyle="width:50%;">
				<table style="width: 100%">
					<tr>
						<td colspan="2" bgcolor="#BEBEBE">订单编号:${subOrder.subOrderNo}  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 下单时间：<fmt:formatDate value="${subOrder.paymentDate}" pattern=" yyyy-MM-dd HH:mm:ss" />
						</td>
					</tr>
					
					<tr>
						<td style="width: 50%">
							<div id="leftDiv${subOrder.objectId}">
								 <table style="width: 100%">
				  					<c:forEach items="${subOrder.orderProductList}" var="sku"  varStatus="status1">
				  						 <tr><td><img src="${dynamicDomain}${sku.product.mainPicture}" width="80px" height="80px"/>${sku.name} <%-- ${sku.product.name} --%>
				  						 			<br>${sku.attribute1} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;${sku.attribute2} &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ${sku.productPrice}元*${sku.productCount}件</td></tr>   
				  						<!-- <img src="${dynamicDomain}/static/1.jpg" width="80px" height="80px"/>  -->
				  					</c:forEach>
				        		 </table>
							</div>
						</td>
						
						<td>
							<div id="rightDiv${subOrder.objectId}">
								<table>
				        				<tr>
				        					<td><b>收货信息&nbsp;&nbsp;</b></td>
				        					<td>收货联系人：${subOrder.receiptContacts}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;联系方式：${subOrder.receiptMobile}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;邮编:${subOrder.receiptZipcode}  </td>
				        				</tr>
				        				<tr>
				        					<td>&nbsp;&nbsp;</td>
				        					<td>地址: ${subOrder.receiptAddress} </td>
				        				</tr>
				        				<tr>
				        					<td><b>物流信息&nbsp;&nbsp; </b></td>	
											<td>
												<nobr><div id="companyUpdate${subOrder.objectId}" style="display: none"></div>
												   <c:choose>
														<c:when test="${subOrder.subOrderState==2}">
														   <div id="companyDiv${subOrder.objectId}">
															 	物流公司：  <select id="wuliuCompany_${subOrder.objectId}" >
												                       		<option value="">—请选择—</option>
												                   			<jdf:select dictionaryId="1413" valid="true" />
												                  	   </select>
											                </div>	
													    </c:when>
														<c:otherwise>
															物流公司： <jdf:dictionaryName value="${subOrder.logisticsCompany }" dictionaryId="1413"/>
														</c:otherwise>
												   </c:choose>
									         	 </nobr>
									        </td>	        					
				        				</tr>

				        				
				        				<c:choose>
														<c:when test="${subOrder.subOrderState==2}">
														 	    <c:choose>
																	<c:when test="${subOrder.orderProductList != null  and fn:length(subOrder.orderProductList)>1}">
																				     <tr>
																        				<td>&nbsp;&nbsp;</td>
																        				<td>
																	        				<div id="orderDiv${subOrder.objectId}">物流编号：  <input type="text" id="wuliuOrder_${subOrder.objectId}"></div>
																	        				<div id="orderUpdate${subOrder.objectId}" style="display: none"></div>
																        				</td>
																        			 </tr>
																				     
																				     <tr>
															        					<td>&nbsp;&nbsp;</td>
															        					<td>																						
																							<div id="remarkDiv${subOrder.objectId}">
																								备注：<textarea id="remark_${subOrder.objectId}" rows="3" cols="30"></textarea>
																								 <button type="button" id="button_${subOrder.objectId}"  class="btn btn-primary"  onclick="comfirmDelivery('${subOrder.objectId}','1')">确认发货</button>
																							</div>
																							<div id="remarkUpdate${subOrder.objectId}" style="display: none">
																							</div>
																						</td>
												        							</tr>
																		</c:when>
																		<c:otherwise>
																					 <tr>
																        				<td>&nbsp;&nbsp;</td>
																        				<td>
																        					<div id="orderDiv${subOrder.objectId}">
																        						物流编号：  <input type="text" id="wuliuOrder_${subOrder.objectId}">
																        						<button type="button" id="button_${subOrder.objectId}"  class="btn btn-primary"  onclick="comfirmDelivery('${subOrder.objectId}','1')">确认发货</button>
																        					</div>
																	        				<div id="orderUpdate${subOrder.objectId}" style="display: none"></div>
																        				</td>
																        			 </tr>
																		</c:otherwise>
																</c:choose>
													    </c:when>
														<c:otherwise>
																<c:choose>
																			<c:when test="${subOrder.orderProductList != null  and fn:length(subOrder.orderProductList)>1}">
																					     <tr>
																	        				<td>&nbsp;&nbsp;</td>
																	        				<td>物流编号：  ${subOrder.logisticsNo}</td>
																	        			 </tr>
																					     
																					     <tr>
																        					<td>&nbsp;&nbsp;</td>
																        					<td>备注：${subOrder.logisticsRemark}
																							</td>
													        							</tr>
																			</c:when>
																			<c:otherwise>
																						 <tr>
																	        				<td>&nbsp;&nbsp;</td>
																	        				<td>物流编号：  ${subOrder.logisticsNo}</td>
																	        			 </tr>
																			</c:otherwise>
																	</c:choose>
														</c:otherwise>
										</c:choose>
				        		</table>
							</div>
						</td>
					</tr>
				</table>
				</jdf:column>
			</jdf:row>	
		</jdf:table>
   </div>
 
 

  <script type="text/javascript">
	function exportFast(){
		 var startDate = $.trim($("#startDate").val()) ; 
		 var endDate = $.trim($("#endDate").val()) ; 
		 var orderNo = $.trim($("#orderNo").val()) ; 
		 var paymentWay = $("#paymentWay option:selected").val() ;
		 var orderSource = $("#orderSource option:selected").val() ;
		 var userName =  $.trim($("#userName").val()) ; 
		 var receiptMobile =  $.trim($("#receiptMobile").val()) ; 
		 var receiptContacts =  $.trim($("#receiptContacts").val()) ; 
		 var receiptAddress =  $.trim($("#receiptAddress").val()) ; 
	     var url = "${dynamicDomain}/fastOrder/exportFast?search_GED_paymentDate="+startDate+
	    		 "&search_LED_paymentDate="+endDate+
	    		 "&search_LIKES_subOrderNo="+orderNo+
	    		 "&search_EQI_paymentWay="+paymentWay+
	    		 "&search_EQI_orderSource="+orderSource+
	    		 "&search_EQS_userName="+userName+
	    		 "&search_LIKES_receiptMobile="+receiptMobile+
	    		 "&search_LIKES_receiptContacts="+receiptContacts+
	    		 "&search_LIKES_receiptAddress="+receiptAddress;
	     document.location.href = url;
	}
	
	
	function comfirmDelivery(subOrderId, flag){
		//alert(subOrderId) ;
		var logisticsCompany = $.trim($("#wuliuCompany_"+subOrderId+" option:selected").val()) ;//物流公司
		var logisticsCompanyStr = $.trim($("#wuliuCompany_"+subOrderId+" option:selected").text()) ;//物流公司选中文字 
		var logisticsNo = $.trim($("#wuliuOrder_"+subOrderId).val()) ; //物流编号
		var remark = "" ;
		if(flag!=null && flag=="1"){
			remark =  $.trim($("#remark_"+subOrderId).val()) ; //备注
		}
		
		if(logisticsCompany==null || logisticsCompany==""){
			alert("请选择物流公司") ;
			return false ;
		}
		
		if(logisticsNo==null || logisticsNo==""){
			alert("请输入物流编号") ;
			return false ;
		}
		

				$.ajax({
				    url : "${dynamicDomain}/fastOrder/updateLogisticsInfo",
					type: "post",
					cache : false,
					data: {'logisticsCompany':logisticsCompany,'logisticsNo':logisticsNo, 'remark':remark, 'subOrderId':subOrderId},
					dataType : 'json',
					success:function(msg){
						if(msg.result=="1"){
							alert("操作成功！");
							window.location.href="${dynamicDomain}/fastOrder/page" ;
							
						/* 	//物流公司 
							$("#companyDiv"+subOrderId).hide() ;
							document.getElementById("companyUpdate"+subOrderId).style.display="block";
							$("#companyUpdate"+subOrderId).html("物流公司：  "+logisticsCompanyStr) ;
							
							//物流编号 
							$("#orderDiv"+subOrderId).hide() ;
							document.getElementById("orderUpdate"+subOrderId).style.display="block";
							$("#orderUpdate"+subOrderId).html("物流编号：  "+logisticsNo) ;
							
							if(flag!=null && flag=="1"){
								//备注
								$("#remarkDiv"+subOrderId).hide() ;
								document.getElementById("remarkUpdate"+subOrderId).style.display="block";
								$("#remarkUpdate"+subOrderId).html("备注：  "+remark) ;
							} */
	
						}else{
							alert("操作失败！");
						}
			  		},
			  		error:function(){
			  			alert("数据获取失败！");
		  		  	}
			});

	}
	
	
	function printFast(){
		
	}
	
	function importFast(){
		document.location.href = "${dynamicDomain}/fastOrder/importOrderDialog?ajax=1" ;
	}
	
	jQuery(document).ready(function(){
		//div以xx开头的id
		 //$('div[id^="leftDiv"]').find("td").css("border","0");
		 $('div[id^="rightDiv"]').find("td").css("border","0");
	});

</script>
</body>
</html>