<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>生活服务类订单</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
                          生活服务类订单
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/lifeserviceoderstatusupdate/page" method="post" class="form-horizontal" id="lifeseviceoderform">
        <div class="box-body">
          <div class="row">          
           <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="search_GED_bookingDate" class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-4">
                  <input class="search-form-control" type="text" name="search_GED_bookingDate" id="startbookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endbookingDate\')}'})">
                </div>
                <div class="col-sm-4">
                  <input type="text" class="search-form-control" name="search_LED_bookingDate" id="endbookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'startbookingDate\')}'})">
                </div>
              </div>
            </div>
           <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">订单编号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo" id="subOrderNo">
              </div>
            </div>
          </div>
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">订单状态：</label>
              <div class="col-sm-8">
                <select name="search_EQI_subOrderState" class="search-form-control" id="subOrderState">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1409" valid="true" />
                </select>
              </div>
            </div>
          </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">下单账户：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_userName" id="userName">
              </div>
            </div>
          </div>
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">供应商编号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_supplierId" id="supplierId">
              </div>
            </div>
          </div>
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">供应商名称：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_supplierName" id="supplierName">
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">生活服务类型：</label>
              <div class="col-sm-8">
                <select name="search_EQI_lifeType" class="search-form-control" id="lifeType">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1115" valid="true" />
                </select>
              </div>
            </div>
          </div>
        </div>
   <div class="box-footer">
    <div class="pull-left">
      <a href="${dynamicDomain}/lifeserviceoderstatusupdate/importOrder?ajax=1"class="colorbox btn btn-primary">订单导入</a>
      <a href="${dynamicDomain}/lifeserviceoderstatusupdate/exportChoice?ajax=1"class="colorbox btn btn-primary">订单导出</a>
      </div>
      <div class="pull-right">
      <button type="submit" class="btn btn-primary">查询</button>
      </div>
  </div>
  </form>
  </jdf:form>
  </div>
  <div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
      <jdf:export view="xls" text="ALL" fileName="order.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
		<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 8%">        
		      <c:if test="${currentRowObject.subOrderState==23}">
				<a onclick="returnIntegral('${currentRowObject.subOrderNo}')" class="btn btn-primary btn-mini">退积分</a>
		      </c:if>
		</jdf:column>
        <jdf:column property="generalOrderNo" title="订单编号" headerStyle="width:12%;" viewsAllowed="html">
          <a href="${dynamicDomain}/lifeserviceoderstatusupdate/lifeOrderInfo?objectId=${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.subOrderNo} </font></a>
        </jdf:column>
        <jdf:column property="订单编号" title="" headerStyle="width:8%;"  viewsDenied="html" >
        ${currentRowObject.subOrderNo}
        </jdf:column>
        
        <jdf:column property="subOrderState" title="订单状态" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="1409" value="${currentRowObject.subOrderState}" />
        </jdf:column>
        <jdf:column property="orderSource" title="订单来源" headerStyle="width:7%;">
          <jdf:columnValue dictionaryId="1401" value="${currentRowObject.orderSource}" />
        </jdf:column>
        <jdf:column property="orderType" title="订单类型" headerStyle="width:7%;">
          <jdf:columnValue dictionaryId="1402" value="${currentRowObject.orderType}" />
        </jdf:column>
        <jdf:column property="bookingDate" title="客户下单时间" headerStyle="width:10%;" cell="date" format="yyyy-MM-dd HH:mm:ss">
        </jdf:column>
        <jdf:column property="userName" title="下单账户" headerStyle="width:8%;"/>
		<jdf:column property="paymentWay" title="支付方式" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="1403" value="${currentRowObject.paymentWay}" />
        </jdf:column>
		<jdf:column property="actuallyIntegral" title="付款积分" headerStyle="width:8%;">
			<fmt:formatNumber type="number" value="${currentRowObject.actuallyIntegral }" pattern="0.00" maxFractionDigits="2"/>
		</jdf:column>
		<jdf:column property="paymentDate" title="付款时间" headerStyle="width:8%;" cell="date" format="yyyy-MM-dd HH:mm:ss"/>
		<jdf:column property="payUserName" title="付款操作人" headerStyle="width:8%;"/>
      </jdf:row>
    </jdf:table>
  </div>
  <script type="text/javascript">
			$(function() {

			});
			
			function returnIntegral(suborderno){
				if(suborderno != ""){
					$.ajax({
					    url : "${dynamicDomain}/lifeserviceoderstatusupdate/returnIntegral",
						type: "post",
						cache : false,
						data: {'suborderno':suborderno},
						dataType : 'json',
						success:function(msg){
							if(msg.result=="0"){
								alert("操作成功！");
								$("#lifeseviceoderform").submit();
							}else if(msg.result=="1"){
								alert("退还积分，更新状态失败！");
							}else{
								alert("订单不存在或订单不处于处理失败状态！");
							}
				  		}
				});
				}
			}
  </script>
</body>
</html>