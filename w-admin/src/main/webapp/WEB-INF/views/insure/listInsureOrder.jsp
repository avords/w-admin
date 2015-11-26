<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="核保单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
       	核保单查询
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/insureOrder/page" method="post" class="form-horizontal" id="form1">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">提交时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_createdOn\')}'})" 
                  name="search_GED_createdOn" id="search_GED_createdOn" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_createdOn\')}'})" class="search-form-control" 
                  name="search_LED_createdOn" id="search_LED_createdOn" >
                </div>
              </div>
            </div>
              <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_userName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_paymentDate\')}'})" 
                  name="search_GED_paymentDate" id="search_GED_paymentDate" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_paymentDate\')}'})" class="search-form-control" 
                  name="search_LED_paymentDate" id="search_LED_paymentDate" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_payUserName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">企业名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_companyName">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">保险商品：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_proName">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">合同号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_contractNo">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_generalOrderNo">
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
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">状态：</label>
                <div class="col-sm-8">
                  <select name="search_LIKEI_status" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1620" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
           	<button type="button" class="btn btn-primary" id="exc">
				<span class="glyphicon glyphicon-export"></span>导出
			</button>
			<button type="button" class="btn btn-primary" id="del">
				删除
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
      <jdf:export view="csv" fileName="insureOrder.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="insureOrder.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="contractNo" title="合同号" headerStyle="width:8%;" />
        <jdf:column property="generalOrderNo" title="订单号" headerStyle="width:10%;" />
        <jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" />
        <jdf:column property="proName" title="保险商品" headerStyle="width:8%;" />
        <jdf:column property="attributeValue1" title="商品规格" headerStyle="width:9%;">
          <a href="${dynamicDomain}/insureOrder/view/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.attributeValue1}</font></a>
        </jdf:column>
        <jdf:column property="allNum" title="参保人数" headerStyle="width:7%;" />
        <jdf:column property="passNum" title="通过人数" headerStyle="width:7%;" />
        <jdf:column property="notPassNum" title="不通过人数" headerStyle="width:7%;" />
        <jdf:column property="insureDate" title="投保时间" headerStyle="width:8%;" />
        <jdf:column property="actuallyAmount" title="付款金额" headerStyle="width:8%;" />
        <jdf:column property="actuallyIntegral" title="付款积分" headerStyle="width:8%;" />
        <jdf:column property="userName" title="付款操作人" headerStyle="width:10%;"/>
        <jdf:column property="status" title="状态" headerStyle="width:6%;" >
        	<jdf:columnValue dictionaryId="1620" value="${currentRowObject.status}" />
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