<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="福利计划订单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
       	福利计划订单查询
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/welfarePlanOrder/page" method="post" class="form-horizontal" id="form1">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_bookingDate\')}'})" 
                  name="search_GED_bookingDate" id="search_GED_bookingDate" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_bookingDate\')}'})" class="search-form-control" 
                  name="search_LED_bookingDate" id="search_LED_bookingDate" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付方式：</label>
                <div class="col-sm-8">
                  <select name="search_LIKES_paymentWayId" class="search-form-control">
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
                <label class="col-sm-4 control-label">计划状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_status" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1610" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">福利计划名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_name">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">企业名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_companyName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">操作账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_userName">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
           	<button type="button" class="btn btn-primary" id="exc">
				<span class="glyphicon glyphicon-export"></span>导出
			</button>
            <div class="pull-right">
              <button type="button" class="btn btn-primary" id="btn">查询</button>
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
        <jdf:column property="status" title="计划状态" headerStyle="width:8%;" >
        	<jdf:columnValue dictionaryId="1610" value="${currentRowObject.status}" />
        </jdf:column>
        <jdf:column property="companyName" title="企业名称" headerStyle="width:14%;" />
        <jdf:column property="year" title="年份" headerStyle="width:8%;" />
        <jdf:column property="1" title="计划名称" headerStyle="width:12%;" viewsDenied="html">
         	${currentRowObject.name}
        </jdf:column>
        <jdf:column property="name" title="计划名称" headerStyle="width:12%;" viewsAllowed="html">
          <a href="${dynamicDomain}/welfarePlanOrder/view/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.name}</font></a>
        </jdf:column>
        <jdf:column property="paymentWay" title="支付方式" headerStyle="width:8%;">
            <jdf:columnValue dictionaryId="1403" value="${currentRowObject.paymentWay}" />
        </jdf:column>
        <jdf:column property="actuallyAmount" title="付款金额" headerStyle="width:10%;" />
        <jdf:column property="actuallyIntegral" title="付款积分" headerStyle="width:10%;" />
        <jdf:column property="userName" title="付款操作人" headerStyle="width:10%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
<script type="text/javascript">
$(function(){
	$("#btn").bind("click",function(){
		$("#form1").attr("action","${dynamicDomain}/welfarePlanOrder/page");
		$("#form1").submit();
		
	});
	$("#exc").bind("click",function(){
		$("#form1").attr("action","${dynamicDomain}/welfarePlanOrder/exportAll");
		$("#form1").submit();
		
	});
});

</script>
</body>
</html>