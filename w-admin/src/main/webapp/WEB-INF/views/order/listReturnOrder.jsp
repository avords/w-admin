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
      <form action="${dynamicDomain}/changeOrder/return" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="search_GED_changeDate" class="col-sm-4 control-label">退换货时间：</label>
                <div class="col-sm-4">
                  <input class="search-form-control" type="text" name="search_GED_changeDate" id="search_GED_changeDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_changeDate\')}'})">
                </div>
                <div class="col-sm-4">
                  <input type="text" class="search-form-control" name="search_LED_changeDate" id="search_LED_changeDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_changeDate\')}',})">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">退换货单号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_changeNo">
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
                <select name="search_EQI_orderSource" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1401" valid="true" />
                </select>
              </div>
            </div>
          </div>
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">退货单状态： </label>
              <div class="col-sm-8">
                <select name="search_EQI_orderStatus" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1404" valid="true" />
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
          </div>
          <div class="row">
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
              <label class="col-sm-4 control-label">总订单号：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_generalOrderNo">
              </div>
            </div>
          </div>          
          <div class="col-sm-4 col-md-4">
            <div class="form-group">
              <label class="col-sm-4 control-label">申请账户：</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="search_LIKES_userName">
              </div>
            </div>
          </div>
        </div>
  <div class="box-footer">
    <div class="pull-right">
      <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
      <button type="submit" class="btn btn-primary">查询</button>
    </div>
  </div>
  </form>
  </jdf:form>
  </div>
  <div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="return">
      <jdf:export view="csv" fileName="changeOrder.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="changeOrder.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:export view="xls" text="ALL" fileName="退换货订单.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>      
        <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width:8%">
        <c:if test="${currentRowObject.changeType==1}">
         <c:choose>         
         <c:when test="${currentRowObject.orderStatus==2 && (currentRowObject.productType==22 || currentRowObject.productType==32)}">
          <a href="javascript:void(0);" onclick="confirmQ('${dynamicDomain}/changeOrder/confirm/${currentRowObject.objectId}')" class="btn btn-primary btn-mini" id="">确认退款 </a>
            <input type="hidden" id="changeId" name="changeId" value="${currentRowObject.objectId}" />  
         </c:when>
          <c:when test="${currentRowObject.orderStatus==6 && (currentRowObject.productType==1 || currentRowObject.productType==21 || currentRowObject.productType==31)}">
          <a href="javascript:void(0);" onclick="confirmQ('${dynamicDomain}/changeOrder/confirm/${currentRowObject.objectId}')"  class="btn btn-primary btn-mini">确认退款 </a>
            <input input type="hidden" id="changeId" name="changeId" value="${currentRowObject.objectId}" />     
         </c:when> 
         <c:when test="${currentRowObject.orderStatus==2 && currentRowObject.subOrderState==2 && (currentRowObject.productType==1 || currentRowObject.productType==21 || currentRowObject.productType==31)}">
          <a href="javascript:void(0);" onclick="confirmQ('${dynamicDomain}/changeOrder/confirm/${currentRowObject.objectId}')" class="btn btn-primary btn-mini" id="">确认退款 </a>
            <input input type="hidden" id="changeId" name="changeId" value="${currentRowObject.objectId}" />         
         </c:when>              
       <c:otherwise>
          &nbsp;
       </c:otherwise> 
         </c:choose>
       </c:if>
        </jdf:column>
          <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
          <jdf:column property="changeNo" title="退换货单号 " headerStyle="width:8%;">
          <a href="${dynamicDomain}/changeOrder/return/${currentRowObject.objectId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.changeNo} </font></a>
          </jdf:column>
          
         <jdf:column property="2" title="总订单号" headerStyle="width:5%;" viewsDenied="html">
           ${currentRowObject.generalOrderNo}
        </jdf:column>
        
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:8%;" viewsAllowed="html">
          <a href="${dynamicDomain}/order/view/${currentRowObject.genneralId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>
        
        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:8%;">
          <a href="${dynamicDomain}/order/view/${currentRowObject.genneralId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.subOrderNo}</font></a>
        </jdf:column>
        
        <jdf:column property="changeType" title="退换货类型" headerStyle="width:8%;">
           <jdf:columnValue dictionaryId="1408" value="${currentRowObject.changeType}" />
        </jdf:column>
        <jdf:column property="orderStatus" title="退货单状态" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="1404" value="${currentRowObject.orderStatus}" />
        </jdf:column>
        <jdf:column property="supplierContacts" title="供应商联系人" headerStyle="width:10%;">
        </jdf:column>

        <jdf:column property="supplierTelephone" title="供应商电话" headerStyle="width:8%;" />
        <jdf:column property="userName" title="申请账户" headerStyle="width:8%;" >
        </jdf:column>        
        <jdf:column property="actuallyAmount" cell="date" title="实付金额" headerStyle="width:7%;" />
        <jdf:column property="actuallyIntegral" title="实付积分" headerStyle="width:7%;">
        </jdf:column>
        <jdf:column property="refundaMount" title="退款金额" headerStyle="width:7%;">
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

      function confirmQ(url){
    	  var changeId=$('#changeId').val();
    	  $.ajax({
				url: "${dynamicDomain}/changeOrder/getChangeOrderStatus?changeId="+changeId,
				type : 'post',
				dataType : 'json',
				success :function (data){
				 	if(data.result == true){
				 		 if(confirm("确定要执行退款操作吗！")){
				  			   window.location.href=url;
				  	     }
				 	}
				 	else{
				 		alert("该退货单已经退款，不能再确认退款！");
				 	}
				}
			});
	  
  		  
     }
      
      
    /*   function confirmQ(url){
   		   if(confirm("确定要执行退款操作吗！")){
   			   window.location.href=url;
   	       }
      }
       */
    </script>
</body>
</html>