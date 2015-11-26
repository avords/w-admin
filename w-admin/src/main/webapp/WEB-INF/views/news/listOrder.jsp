<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.order" /></title>
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
      <form action="${dynamicDomain}/order/page" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-10 col-md-8">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">下单时间&nbsp;&nbsp;&nbsp;&nbsp;：</Lable>
                </div>
                <div>
                  <input type="text" size="17" style="height: 33px" onClick="WdatePicker()" name="search_GED_bookingDate">-- <input type="text" size="17" style="height: 33px" onClick="WdatePicker()" name="search_LED_bookingDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">订单类型：</Lable>
                </div>
                <select name="search_EQI_orderType" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="104" valid="true" />
                </select>
              </div>
            </div>

          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">总订单号&nbsp;&nbsp;&nbsp;&nbsp;：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_generalOrderNo">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">子订单号&nbsp;&nbsp;&nbsp;&nbsp;：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">支付方式：</Lable>
                </div>
                <select name="search_EQI_orderType" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="104" valid="true" />
                </select>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">订单来源&nbsp;&nbsp;&nbsp;&nbsp;：</Lable>
                </div>
                <select name="search_EQI_orderType" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="104" valid="true" />
                </select>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">订单状态 &nbsp;&nbsp;&nbsp;&nbsp;：</Lable>
                </div>
                <select name="search_EQI_orderType" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="104" valid="true" />
                </select>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">下单账户：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">供应商编号：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">供应商名称：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label class="form-lable">兑换卡号：</Lable>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
          </div>
          <div class="box-footer">
            <a href="${dynamicDomain}/order/create" class="pull-left"> <Lable type="Lable" class="btn btn-primary"> <span class="glyphicon glyphicon-plus"></span>新增 </Lable>
            </a> <a href="#" class="pull-left"> <Lable type="Lable" class="btn btn-primary"> <span class="glyphicon glyphicon-export"></span>导出 </Lable>
            </a>
            <div class="pull-right">
              <!--            <Lable type="Lable" class="btn" onclick="clearForm(this)"> -->
              <!--              <span class="glyphicon glyphicon-remove"></span> -->
              <%--              <jdf:message code="common.Lable.clear" /> --%>
              <!--            </Lable> -->
              <Lable type="submit" class="btn btn-primary"> <span class="glyphicon glyphicon-search"></span> <jdf:message code="common.button.query" /> </Lable>
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
        <%--    <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 20%">
          <a href="${dynamicDomain}/order/edit/${currentRowObject.objectId}" class="btn btn-primary btn-mini colorbox"> <i class="glyphicon glyphicon-pencil"></i> <jdf:message code="common.Lable.edit" />
          </a>
          <a href="javascript:toDeleteUrl('${dynamicDomain}/order/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini"> <i class="glyphicon glyphicon-trash"></i> <jdf:message code="common.Lable.delete" />
          </a>

        </jdf:column> --%>
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:8%;" />
        <jdf:column property="generalOrderNo" title="子订单号" headerStyle="width:8%;" />
        <jdf:column property="generalOrderNo" title="订单状态" headerStyle="width:7%;" />
        <jdf:column property="generalOrderNo" title="订单来源" headerStyle="width:7%;" />
        <jdf:column property="generalOrderNo" title="订单类型" headerStyle="width:7%;" />
        <jdf:column property="subOrderNo" title="客户下单时间" headerStyle="width:8%;" />
        <jdf:column property="orderStatus" title="下单账户" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="104" value="${currentRowObject.orderStatus}" />
        </jdf:column>
        <jdf:column property="bookingDate" title="支付方式" headerStyle="width:8%;">
        </jdf:column>
        <jdf:column property="orderStatus" title="兑换卡号" headerStyle="width:8%;" />
        <jdf:column property="orderStatus" title="付款金额" headerStyle="width:8%;" />
        <jdf:column property="orderStatus" title="付款积分" headerStyle="width:8%;" />
        <jdf:column property="orderStatus" title="付款时间" headerStyle="width:8%;" />
        <jdf:column property="orderStatus" title="付款操作人" headerStyle="width:8%;" />

      </jdf:row>
    </jdf:table>
  </div>
  <script type="text/javascript">
			function unlock(loginName) {
				$(".unlock").attr("disabled", true);
				$.ajax({
					url : "${dynamicDomain}/user/unlock/" + loginName
							+ "?timstamp=" + (new Date()).valueOf(),
					type : 'post',
					dataType : 'json',
					success : function(msg) {
						if (msg.result) {
							showMessage("解锁成功", 60000);
						}
						$(".unlock").attr("disabled", false);
					}
				});
			}
		</script>
</body>
</html>