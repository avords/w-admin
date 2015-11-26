
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>线下付款订单核对</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        线下付款订单核对
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/order/linePay" method="post" class="form-horizontal">
        <input type="hidden" name="orderStatus" id="orderStatus"> <input type="hidden" name="objectIdArray" id="objectIdArray">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="search_GED_paymentDate" class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-4">
                  <input class="search-form-control" type="text" name="search_GED_paymentDate" id="search_GED_paymentDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_paymentDate\')}'})">
                </div>
                <div class="col-sm-4">
                  <input type="text" class="search-form-control" name="search_LED_paymentDate" id="search_LED_paymentDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_paymentDate\')}'})">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">总订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_generalOrderNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单类型：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_orderType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1402" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">子订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单来源：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_orderSource" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1401" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付方式：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_paymentWay" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1403" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">子订单状态： </label>
                <div class="col-sm-8">
                  <select name="search_EQI_subOrderState" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1400" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">供应商编号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_supplierNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">供应商名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_supplierName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_userName">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人手机：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptTelephone">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人姓名：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptContacts">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">配送地址：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptAddress">
                </div>
              </div>
            </div>
            
          </div>
        </div>
        <div class="box-footer">
<!--           <button type="button" id="update" class="btn btn-primary">更新为已付款</button>
 -->          <div class="pull-right">
            <button type="button" class="btn" onclick="clearForm(this)">重置</button>
            <button type="submit" class="btn btn-primary">查询</button>
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
  <div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="linePay">
      <jdf:export view="csv" fileName="order.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="order.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:export view="xls" text="ALL" fileName="线下付款订单列表.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>        
        <jdf:column  alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width:8%">
     
          <c:if test="${currentRowObject.subOrderState eq 1}">
           <a href="${dynamicDomain}/order/underLinePay/${currentRowObject.objectId}?ajax=1"  class="btn btn-primary btn-mini colorbox-big">更新为已付款</a> 
          </c:if>
        </jdf:column>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
        <jdf:column property="orderStatus" title="子订单状态" headerStyle="width:7%;" styleClass="con">
        <jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
        </jdf:column>
        <jdf:column property="2" title="总订单号" headerStyle="width:5%;" viewsDenied="html">
           ${currentRowObject.generalOrderNo}
        </jdf:column>
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:8%;" viewsAllowed="html">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>    
        <jdf:column property="3" title="子订单号" headerStyle="width:5%;" viewsDenied="html">
           ${currentRowObject.subOrderNo}
        </jdf:column>
        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:8%;" styleClass="con" viewsAllowed="html">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.subOrderNo}</font></a>
        </jdf:column>
        <jdf:column property="orderSource" title="订单来源" headerStyle="width:7%;">
        <jdf:columnValue dictionaryId="1401" value="${currentRowObject.orderSource}" />
        </jdf:column>
        <jdf:column property="bookingDate"  title="下单时间" headerStyle="width:8%;" >
        <fmt:formatDate value="${currentRowObject.bookingDate}"
                pattern=" yyyy-MM-dd HH:mm:ss" />
        </jdf:column>
        <jdf:column property="userName" title="下单账户" headerStyle="width:8%;">
        </jdf:column>
        <jdf:column property="paymentWay" title="支付方式" headerStyle="width:8%;">
          <c:if test="${currentRowObject.paymentWay==1}">
            <jdf:columnValue dictionaryId="1403" value="线下支付" />
          </c:if>
          <c:if test="${currentRowObject.paymentWay==2}">
            <jdf:columnValue dictionaryId="1403" value="线上支付" />
          </c:if>
        </jdf:column>
        <jdf:column property="receiptContacts" title="收货人姓名" headerStyle="width:8%;" />
        <jdf:column property="paymentAmount" title="付款金额" headerStyle="width:8%;" >
        <c:if test="${currentRowObject.actuallyAmount !=null &&  currentRowObject.actuallyAmount!=0.0}">
        <fmt:formatNumber type="number" value="${currentRowObject.actuallyAmount}" pattern="0.00" maxFractionDigits="2"/>元                    
        </c:if>
        <c:if test="${currentRowObject.actuallyIntegral !=null &&  currentRowObject.actuallyIntegral!=0.0}">
        <fmt:formatNumber type="number" value="${currentRowObject.actuallyIntegral}" pattern="0.00" maxFractionDigits="2"/>积分                   
        </c:if>
        </jdf:column>
        <jdf:column property="paymentDate" title="付款时间" headerStyle="width:8%;" >
           <fmt:formatDate value="${currentRowObject.paymentDate}"
                pattern=" yyyy-MM-dd HH:mm:ss" />
        </jdf:column>
        
        <jdf:column property="payUserName" title="付款操作人" headerStyle="width:8%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
  <script type="text/javascript">
  $(function() {
		//$("#search_GED_createDate").datetimepicker({pickTime: false});

		$(".conn").each(function() {
			var maxwidth = 20;
			if ($(this).text().length > maxwidth) {
				$(this).text($(this).text().substring(0, maxwidth));
				$(this).html($(this).text() + '...');
			}
		  });
	   });
   
  
</script>
  <script type="text/javascript">
			$("#checkall").click(function() {
				if (this.checked) {
					$("input[name='checkid']").each(function() {
						this.checked = true;
					});
				} else {
					$("input[name='checkid']").each(function() {
						this.checked = false;
					});
				}
			});
			
			$("#update").click(function() {
				var id = "";
				if ($("input[type='checkbox']").is(':checked')) {
					$("input[name='checkid']:checked").each(function() {
						id += this.value + ",";
					});
					ids = id.substring(0, id.lastIndexOf(","));
					$.ajax({
						url : "${dynamicDomain}/order/updateToPage/" + ids,
						type : 'post',
						dataType : 'json',
						success : function(msg) {
							if (msg.result == true) {
								window.location.reload();
								}else{
									window.location.reload();
									alert(msg.resultReason);
								}
						}
					});
				}
			});
		</script>

</body>
</html>