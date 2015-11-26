<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="客服订单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
              客服订单查询
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/serviceSubOrder/page" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">兑换卡号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_cashCard">
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
                <label class="col-sm-4 control-label">手机号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQL_telephone">
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
</body>
</html>