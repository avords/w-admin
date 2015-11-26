<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title><jdf:message code="异常订单处理" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        异常订单处理
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/exceptionOrder/page" method="post" class="form-horizontal">
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
                <label class="col-sm-4 control-label">订单类型：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_orderType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1402" valid="true" />
                  </select>
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
                <label class="col-sm-4 control-label">订单状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_subOrderState" id="statusType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1400" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">登陆用户名：</label>
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
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人手机：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptMoblie">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">收货人姓名：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptContacts">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">配送地址：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_receiptAddress">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
            <!-- 
            <a href="#" class="pull-left" > 
	           	<button type="button" class="btn btn-primary">
					<span class="glyphicon glyphicon-export"></span>导出
				</button>
            </a> -->
            <button type="button" class="btn btn-primary" onclick="doChange();">已处理</button>
            <button type="button" class="btn btn-primary" onclick="doResetSend();">异常处理</button>
            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
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
        <jdf:column property="objectId" title="<input type='checkbox' name='checkall' id='checkall' />"
			style="text-align: center;" headerStyle="width: 2%;text-align: center;" viewsAllowed="html" sortable="false">
			<c:choose>
				<c:when test="${currentRowObject.exceptionStatus==2 || currentRowObject.exceptionStatus==3 || currentRowObject.exceptionStatus==4}">
					<input type="checkbox" class="option" name="checkId" value="${currentRowObject.objectId}" />
				</c:when>
				<c:otherwise>
					&nbsp;
				</c:otherwise>
			</c:choose>
		</jdf:column>
        <jdf:column property="exceptionStatus" title="异常状态" headerStyle="width:7%;" >
        	<jdf:columnValue dictionaryId="1411" value="${currentRowObject.exceptionStatus}" />
        </jdf:column>
        <jdf:column property="exceptionReason" title="异常原因" headerStyle="width:7%;" />
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:8%;">
          <a href="${dynamicDomain}/exceptionOrder/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>
        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:5%;">
          <a href="${dynamicDomain}/exceptionOrder/viewBySubOrder/${currentRowObject.subOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.subOrderNo}</font></a>
        </jdf:column>
        <%--
        <jdf:column property="orderStatus" title="订单状态" headerStyle="width:7%;">
			<jdf:columnValue dictionaryId="1400" value="${currentRowObject.orderStatus}" />
		</jdf:column>
		 --%>
        <jdf:column property="orderSource" title="订单来源" headerStyle="width:7%;">
            <jdf:columnValue dictionaryId="1401" value="${currentRowObject.orderSource}" />
        </jdf:column>
        <jdf:column property="orderType" title="订单类型" headerStyle="width:7%;">
            <jdf:columnValue dictionaryId="1402" value="${currentRowObject.orderType}" />
        </jdf:column>
        <jdf:column property="bookingDate" cell="date" format="yyyy-MM-dd HH:mm:ss" title="下单时间" headerStyle="width:7%;" />
        <jdf:column property="userName" title="下单账户" headerStyle="width:7%;">
        </jdf:column>
        <jdf:column property="paymentWay" title="支付方式" headerStyle="width:7%;">
            <jdf:columnValue dictionaryId="1403" value="${currentRowObject.paymentWay}" />
        </jdf:column>
        <jdf:column property="supplierName" title="供应商名称" headerStyle="width:6%;" />
        <jdf:column property="paymentAmount" title="付款金额" headerStyle="width:6%;" />
        <jdf:column property="paymentIntegral" title="付款积分" headerStyle="width:5%;" />
        <jdf:column property="paymentDate" cell="date" format="yyyy-MM-dd HH:mm:ss" title="付款时间" headerStyle="width:7%;" />
        <jdf:column property="userName" title="付款操作人" headerStyle="width:7%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
<script type="text/javascript">
$("#checkall").click( 
	function(){ 
		if(this.checked){ 
			$("input[name='checkId']").each(function(){this.checked=true;}); 
		}else{ 
			$("input[name='checkId']").each(function(){this.checked=false;}); 
		} 
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

function doResetSend(){
	var ids = getIds();
	if (ids=="" || ids==null) {
		alert("请选择数据");
		return false;
	}
	$.ajax({
		url : "${dynamicDomain}/exceptionOrder/resetSends/" + ids,
		type : 'post',
		dataType : 'json',
		success : function(msg) {
			var data = msg.msg;
			if(data != null ||data!=null) {
				var res = "";
				for (var i=0;i<data.length;i++) {
					res =res+parseInt(i+1)+"、"+data[i]+"\n";
				}
				alert(res);
				window.location.reload();
			}else{
				alert("失败");
			}
		}

	});
}

function doChange(){
	var ids = getIds();
	if (ids=="" || ids==null) {
		alert("请选择数据");
		return false;
	}
	$.ajax({
		url : "${dynamicDomain}/exceptionOrder/doChange/" + ids,
		type : 'post',
		dataType : 'json',
		success : function(msg) {
			var data = msg.msg;
			if(data != null ||data!=null) {
				var res = "";
				for (var i=0;i<data.length;i++) {
					res =res+parseInt(i+1)+"、"+data[i]+"\n";
				}
				alert(res);
				window.location.reload();
			}else{
				alert("失败");
			}
		}

	});
}
</script>
</body>
</html>