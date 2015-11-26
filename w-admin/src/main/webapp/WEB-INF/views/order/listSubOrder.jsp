<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="子订单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
              子订单查询
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/subOrder/page" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="search_GED_bookingDate" class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-4">
                  <input class="search-form-control" type="text" name="search_GED_bookingDate" id="search_GED_bookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_bookingDate\')}'})">
                </div>
                <div class="col-sm-4">
                  <input type="text" class="search-form-control" name="search_LED_bookingDate" id="search_LED_bookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_bookingDate\')}'})">
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
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">兑换卡号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_cashCard">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
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
                <label class="col-sm-4 control-label">子订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
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
                <label class="col-sm-4 control-label">子订单状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_subOrderState" id="subOrderState" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1400" valid="true" />
                  </select>
                </div>
              </div>
            </div>    
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_userName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
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
          <div class="box-footer">
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
      <jdf:export view="xls" text="ALL" fileName="order.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
        
         <jdf:column property="2" title="总订单号" headerStyle="width:5%;" viewsDenied="html">
           ${currentRowObject.generalOrderNo}
        </jdf:column>
        
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:8%;" viewsAllowed="html">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>
        
        <jdf:column property="3" title="子订单号" headerStyle="width:5%;" viewsDenied="html">
           ${currentRowObject.subOrderNo}
        </jdf:column>
        
        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:5%;" styleClass="con"  viewsAllowed="html">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;" class="conn"> ${currentRowObject.subOrderNo}</font></a>
        </jdf:column>
        <jdf:column property="subOrderState" title="子订单状态" headerStyle="width:7%;">
          <jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
        </jdf:column>
        <jdf:column property="orderSource" title="订单来源" headerStyle="width:7%;">
          <jdf:columnValue dictionaryId="1401" value="${currentRowObject.orderSource}" />

        </jdf:column>
        <jdf:column property="orderType" title="订单类型" headerStyle="width:7%;">
          <jdf:columnValue dictionaryId="1402" value="${currentRowObject.orderType}" />
        </jdf:column>
        <jdf:column property="bookingDate"  title="下单时间" headerStyle="width:7%;">
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
        <jdf:column property="cashCard" title="兑换卡号" headerStyle="width:8%;" />
        <jdf:column property="actuallyAmount" title="付款金额" headerStyle="width:6%;" />
        <jdf:column property="actuallyIntegral" title="付款积分" headerStyle="width:6%;" />
        <jdf:column property="paymentDate"  title="付款时间" headerStyle="width:8%;" >
         <fmt:formatDate value="${currentRowObject.paymentDate}"
            pattern=" yyyy-MM-dd HH:mm:ss" />
        </jdf:column>
        <jdf:column property="payUserName" title="付款操作人" headerStyle="width:9%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
  <script type="text/javascript">
      
    </script>
</body>
</html>