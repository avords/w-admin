<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>退换货订单管理</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
                          退换货订单管理
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/vendorChangeOrder/list" method="post" class="form-horizontal" id="ChangeOrder">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">退换货时间 ：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker()" name="search_GED_changeDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker()" class="search-form-control" name="search_LED_changeDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
	            <div class="form-group">
	              <label class="col-sm-4 control-label">申请账户：</label>
	              <div class="col-sm-8">
	                <input type="text" class="search-form-control" name="search_EQS_userName">
	              </div>
	            </div>
	          </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">订单编号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
          </div>
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">退还货单号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_changeNo">
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
        </div>
        <div class="row">
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">订单状态： </label>
              <div class="col-sm-8">
                <select name="search_EQI_orderStatus" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1404" valid="true" />
                </select>
              </div>
            </div>
        </div>
	</div>
  <div class="box-footer">
    <div class="pull-right">
      <input type="hidden" id="platform" name="search_EQI_changeOrderStatusType" value="${platform}">
      <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
      <button type="submit" class="btn btn-primary">查询</button>
    </div>
  </div>
  </form>
  </jdf:form>
  </div>
  <div>
	<div class="panel-heading">
		<h3 class="panel-title">
			<jdf:radio dictionaryId="1414" name="order_platform" />
		</h3>
	</div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
      <jdf:export view="csv" fileName="order.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="order.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width:6%">
         <c:choose>
         <c:when test="${currentRowObject.orderStatus==1}">
          <a href="${dynamicDomain}/vendorChangeOrder/return/${currentRowObject.objectId}" class="btn btn-primary btn-mini">审核 </a>
         </c:when>
         <c:when test="${currentRowObject.orderStatus==4}">
          <a href="${dynamicDomain}/vendorChangeOrder/return/${currentRowObject.objectId}" class="btn btn-primary btn-mini">收货 </a>
         </c:when>
         <c:when test="${currentRowObject.orderStatus==6}">
          <a href="${dynamicDomain}/vendorChangeOrder/return/${currentRowObject.objectId}" class="btn btn-primary btn-mini">发货 </a>
         </c:when>
         <c:when test="${currentRowObject.orderStatus==7 || currentRowObject.orderStatus==8 || currentRowObject.orderStatus==2 || currentRowObject.orderStatus==3 || currentRowObject.orderStatus==5 }">
          <a href="${dynamicDomain}/vendorChangeOrder/return/${currentRowObject.objectId}" class="btn btn-primary btn-mini">查看详情</a>
         </c:when>
         <c:otherwise>
       &nbsp;
       </c:otherwise> 
         </c:choose>
        </jdf:column>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
        <jdf:column property="changeNo" title="退换货单号 " headerStyle="width:8%;">
          <a href="${dynamicDomain}/vendorChangeOrder/return/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.changeNo} </font></a>
          </jdf:column>
        <jdf:column property="subOrderNos" title="订单编号" headerStyle="width:8%;">
          <a href="${dynamicDomain}/order/view/${currentRowObject.genneralId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.subOrderNos}</font></a>
        </jdf:column>
        <jdf:column property="changeType" title="退换货类型" headerStyle="width:8%;">
           <jdf:columnValue dictionaryId="1408" value="${currentRowObject.changeType}" />
        </jdf:column>
        <jdf:column property="orderStatus" title="订单状态" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="1404" value="${currentRowObject.orderStatus}" />
        </jdf:column>
        <jdf:column property="supplierContacts" title="供应商联系人" headerStyle="width:10%;">
        </jdf:column>

        <jdf:column property="supplierTelephone" title="供应商联系方式" headerStyle="width:8%;" />
        <jdf:column property="userName" title="申请账户" headerStyle="width:8%;" >
        <jdf:columnCollectionValue items="users"  nameProperty="userName" value="${currentRowObject.userId}"/>       
        </jdf:column>        
        <jdf:column property="actuallyAmount" cell="date" title="付款金额" headerStyle="width:7%;" />
        <jdf:column property="refundaMount" title="退款金额" headerStyle="width:7%;">
        </jdf:column>
        
      </jdf:row>
    </jdf:table>
  </div>
<script type="text/javascript">
$(function() {
	$(":radio[name=order_platform][value='${platform}']").attr("checked","true");
	$("input[name='order_platform']").change(function(){
		var platform = $('input[name="order_platform"]:checked').val();
		$("#platform").val(platform);
		$("#ChangeOrder").submit();
		//window.location.href = "${dynamicDomain}/vendorChangeOrder/list/"+ platform;
	});
});
</script>
</body>
</html>