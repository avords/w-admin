<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商订单查询</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message}</div>
                        供应商订单查询
      </h4>
    </div>
    <br>
    <br>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/supplierOrder/query" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款时间 ：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker()" name="search_GED_paymentDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker()" class="search-form-control" name="search_LED_paymentDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单编号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_subOrderState" id="statusType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1406" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          </div>
        </div>
        <br>
        <br>
        <br>
        <br>
        <div class="box-footer">
          <div class="pull-left">
            <button type="button" class="btn btn-primary" id="exportAll">导出</button>
          </div>
          <div class="pull-right">
            <button type="button" class="btn" onclick="clearForm(this)">
              <i class="icon-remove icon-white"></i>重置
            </button>
            <button type="submit" class="btn btn-primary">查询</button>
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
  <div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
      <jdf:export view="csv" fileName="order.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="order.xls" tooltip="导出EXCEL" imageName="xls" />
        
      <jdf:row>
          <c:if test="${currentRowObject.orChageAddr==1}">
          <c:set var="styleClass" value ="color:red"/>
          </c:if>
        <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width:8%;" styleClass="${styleClass}">
          <a href="${dynamicDomain}/supplierOrder/view/${currentRowObject.objectId}" class="btn btn-primary btn-mini">查看</a>
        </jdf:column>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center;" styleClass="${styleClass}"/>      
        <jdf:column property="subOrderState" title="订单状态" headerStyle="width:10%;" styleClass="${styleClass }">        
        <jdf:columnValue dictionaryId="1406" value="${currentRowObject.subOrderState}"/>         
        </jdf:column>       
        <jdf:column property="subOrderNo" title="订单编号" headerStyle="width:15%;" styleClass="${styleClass }">         
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.subOrderNo }</font></a>       
        </jdf:column>
        <jdf:column property="bookingDate" cell="date" title="订单创建时间" headerStyle="width:13%;" styleClass="${styleClass }">                  
        </jdf:column>
        <jdf:column property="paymentDate" cell="date" title="订单支付时间" headerStyle="width:13%;" styleClass="${styleClass }">        
        </jdf:column>
        <jdf:column property="actuallyAmount" title="订单支付金额" headerStyle="width:13%;" styleClass="${styleClass }">           
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
  <script type="text/javascript">
			$(function() {
				$("#search_GED_createDate").datepicker({
					format : 'yyyy-mm-dd'
				});
			});
		</script>
</body>
</html>