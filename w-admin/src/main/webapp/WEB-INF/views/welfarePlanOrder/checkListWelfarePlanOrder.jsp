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
       	福利计划付款订单核对
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/welfarePlanOrder/list" method="post" class="form-horizontal" id="form1">
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
            <!-- 
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">子订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
                </div>
              </div>
            </div>
             -->
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_status" class="search-form-control">
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
                  <input type="text" class="search-form-control" name="search_LIKES_userName">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            
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
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">子计划名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subName">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
           	<button type="button" class="btn btn-primary" id="updatePlayed">
				更新为已付款
			</button>
            <div class="pull-right">
              <button type="submit" class="btn btn-primary" id="btn">查询</button>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <div>
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/welfarePlanOrder/list">
      <jdf:export view="csv" fileName="welfarePlanOrder.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="welfarePlanOrder.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="subOrderId" title="操作" headerStyle="width: 4%;" viewsAllowed="html" sortable="false">
			<c:choose>
				<c:when test="${currentRowObject.subOrderState eq 1}">
					<input type="radio" class="option" name="checkId" value="${currentRowObject.orderId}" />
				</c:when>
				<c:otherwise>
					&nbsp;
				</c:otherwise>
			</c:choose>
		</jdf:column>
        <jdf:column property="subOrderState" title="订单状态" headerStyle="width:7%;" >
        	<jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
        </jdf:column>
        <jdf:column property="1" title="总订单号" headerStyle="width:7%;" viewsDenied="html">
        		${currentRowObject.generalOrderNo}
        </jdf:column>
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:7%;" viewsAllowed="html">
        <c:if test="${currentRowObject.subName!='剩余额度转积分'}">
        <a href="${dynamicDomain}/welfarePlanOrder/subDetial/${currentRowObject.orderId}"> 
        	<font style="font-size: 14px; color: blue; text-decoration: underline;"> 
        		${currentRowObject.generalOrderNo}
        	</font>
        </a>
        </c:if>
        </jdf:column>
        <jdf:column property="companyName" title="企业名称" headerStyle="width:9%;" />
        <jdf:column property="year" title="年份" headerStyle="width:4%;" />
        <jdf:column property="name" title="计划名称" headerStyle="width:9%;" />
        <jdf:column property="subName" title="子计划名称" headerStyle="width:9%;" />
        <jdf:column property="bookingDate" cell="date" title="下单时间" headerStyle="width:8%;" />
        <jdf:column property="userName" title="下单账号" headerStyle="width:7%;" />
        <jdf:column property="payableAmount" title="付款金额" headerStyle="width:7%;" >
        <fmt:formatNumber value="${currentRowObject.payableAmount}" type="pattern" pattern="0.00"/> 
        </jdf:column>
        <%--
        <jdf:column property="paymentDate" cell="date" title="付款时间" headerStyle="width:8%;" />
         --%>
        <jdf:column property="payUserName" title="付款操作人" headerStyle="width:7%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
<script type="text/javascript">
$(function(){
	$("#updatePlayed").bind("click",function(){
		var ids = getIds();
		if (ids=="" || ids==null) {
			winAlert("请选择数据");
			return false;
		}
		var url = "${dynamicDomain}/order/underLinePayByOrder/"+ids+"?ajax=1";
		$.colorbox({
			href:url,
			opacity:0.2,
			fixed:true,
			width:"40%",
			height:"75%", 
			iframe:true,
			onClosed:function(){ 
				if(true){
					parent.location.reload(true);
				}
			},
			close:"",
			overlayClose:false
		});
	});
});

function getIds(){
    var content = '';
    $(".option:checked").each(function(){
        content =content+$(this).val()+",";
    });
    if(content.indexOf(",")>0){
        content =content.substring(0,content.length-1);
    }
    return content;
}
</script>
</body>
</html>