<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="订单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        订单查询
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/order/orderChange" method="post" class="form-horizontal">
        <div class="box-body">
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
                <label class="col-sm-4 control-label">操作人账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_userName">
                </div>
              </div>
            </div>
            
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">手机号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQL_receiptMoblie">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">卡号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_cashCard">
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
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="orderChange" style="width:100%;">
      <jdf:row>
        <jdf:column property="objectId" sortable="false" title="操作" headerStyle="width:8%;text-align:center">
	     <c:choose>
         <c:when test="${currentRowObject.orderStatus eq 17}"> 
          <a href="${dynamicDomain}/order/changeOrderAddress/${currentRowObject.objectId}" class="btn btn-primary btn-mini">更改收货地址</a>
        </c:when> 
         <c:otherwise>
           &nbsp;
         </c:otherwise>
         </c:choose>
        </jdf:column>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" headerStyle="width:8%;text-align:center" />
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:6%;">
          <a href="${dynamicDomain}/order/view/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>
        <jdf:column property="subOrderNos" title="子订单号" headerStyle="width:10%;" styleClass="con">
          <a href="${dynamicDomain}/order/view/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;" class="conn"> ${currentRowObject.subOrderNos}</font></a>
        </jdf:column>
        <jdf:column property="orderStatus" title="订单状态" headerStyle="width:5%;">
          <jdf:columnValue dictionaryId="1400" value="${currentRowObject.orderStatus}" />
        </jdf:column>
        <jdf:column property="receiptContacts" title="收货人" headerStyle="width:11%;">
          <div class="text-ellipsis" style="width: 110px;" title="${currentRowObject.receiptContacts}">${currentRowObject.receiptContacts}</div>
        </jdf:column>
        <jdf:column property="receiptAddress" title="收货地址" headerStyle="width:10%;">
          <div class="text-ellipsis" style="width: 150px;" title="${currentRowObject.receiptAddress}">${currentRowObject.receiptAddress}</div>
        </jdf:column>
        <jdf:column property="orderEditState" title="更改状态" headerStyle="width:5%;">
         <c:if test="${currentRowObject.orderEditState==1}">
                               已更改
         </c:if>
         <c:if test="${currentRowObject.orderEditState==2}">
                               无
         </c:if>
        </jdf:column>
        <jdf:column property="editOrderName" title="操作人" headerStyle="width:8%;"/>
        <jdf:column property="cashCard" title="卡号" headerStyle="width:8%;"/>
        <jdf:column property="receiptMoblie" title="手机号" headerStyle="width:8%;"/>
        <jdf:column property="orderEditTime" cell="date" title="操作时间" headerStyle="width:8%;">
        <fmt:formatDate value="${currentRowObject.orderEditTime}"
            pattern=" yyyy-MM-dd HH:mm:ss" />
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
</body>
</html>