<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>投诉详情</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        新增投诉
      </h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form action="${dynamicDomain}/complaint/saveToPage" method="post" id="Complaint" class="form-horizontal">
        <input type="hidden" name="objectId">
        <input type="hidden" name="orderId">
        <input type="hidden" name="supplierId" id="supplierId">
        <input type="hidden" name="generalOrderId">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="complaintType" class="col-sm-4 control-label">投诉类型</label>
                <div class="col-sm-8">
                  <select name="complaintType" class="search-form-control">
                    <jdf:select dictionaryId="1117" valid="true" />
                  </select>
<%--                   <jdf:radio dictionaryId="1117" name="complaintType" /> --%>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="complaintSource" class="col-sm-4 control-label">投诉来源</label>
                <div class="col-sm-8">
                   <select name="complaintSource" class="search-form-control">
                    <jdf:select dictionaryId="1107" valid="true" />
                  </select>
<%--                   <jdf:radio dictionaryId="1107" name="complaintSource" /> --%>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="subOrderNo" type="button" class="col-sm-4 control-label">所属订单</label>
                <div class="col-sm-5">
                  <input type="text" name="subOrderNo" class="search-form-control">
                </div>
                <div class="col-sm-3">
                  <button type="button" class="btn btn-primary" id="getSubOrderDetail">获取订单信息</button>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-12 col-md-12">
            <div class="form-group">
              <div class="col-sm-2 col-md-2"></div>
              <div class="col-sm-10 col-md-10">
                <div class="panel panel-default" style="width: 60%; min-height: 100px;">
                  <div class="panel-heading">订单信息</div>
                  <table class="table table-bordered table-hover">
                    <thead>
                      <tr>
                        <th>订单号</th>
                        <th>商品ID</th>
                        <th>商品名称</th>
                        <th>商品数量</th>
                      </tr>
                    </thead>
                    <tbody id="orderSkus">
                    </tbody>
                    <tfoot>
                      <tr>
                        <th></th>
                        <th></th>
                        <th></th>
                        <th></th>
                      </tr>
                    </tfoot>
                  </table>
                </div>
              </div>
            </div>
          </div>
          <div class="col-sm-12 col-md-12">
            <div class="form-group">
              <label for="complaintContent" class="col-sm-2 control-label">投诉内容</label>
              <div class="col-sm-10">
                <textarea rows="5" class="search-form-control {maxlength:2000}" cols="20"  style="width: 360px" name="complaintContent" id="complaintContent"></textarea>
              </div>
            </div>
          </div>
          <div class="row">
          <div class="col-sm-6 col-md-6">
            <div class="form-group">
              <label for="complaintPerson" class="col-sm-4 control-label">投诉人</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="complaintPerson">
              </div>
            </div>
          </div>
          </div>
          <div class="row">
          <div class="col-sm-6 col-md-6">
            <div class="form-group">
              <label for="complaintMobile" class="col-sm-4 control-label">投诉人电话</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="complaintMobile">
              </div>
            </div>
          </div>
          </div>
          <div class="row">
          <div class="col-sm-6 col-md-6">
            <div class="form-group">
              <label for="complaintEmail" class="col-sm-4 control-label">投诉人邮箱</label>
              <div class="col-sm-8">
                <input type="text" class="search-form-control" name="complaintEmail">
              </div>
            </div>
          </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="editPageButton">
                <button type="button" class="btn btn-primary" onclick="checkOrderNo();">保存</button>
                <button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary">返回</button>
              </div>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Complaint"/>
  <script type="text/javascript">
$("#getSubOrderDetail").click(function(){
  var subOrderNo = $("input[name='subOrderNo']").val();
  if((typeof (subOrderNo) === 'undefined' || subOrderNo == '') ? true : false){
	  winAlert("请填写正确的订单号");
	  return;
  }
  $.ajax({
    url : "${dynamicDomain}/orderSku/getOrderSkusBySubOrderNo/" + subOrderNo,
    type : 'post',
    dataType : 'json',
    success : function(msg) {
      if (msg.result) {
        $("input[name='orderId']").val(msg.orderId);
        $("input[name='supplierId']").val(msg.supplierId);
        $("input[name='generalOrderId']").val(msg.generalOrderId);
        $("#orderSkus").html("");
        for(var i = 0 ; i < msg.orderSkus.length;i++){
          $("#orderSkus").html($("#orderSkus").html()+
              "<tr><td>"+msg.orderSkus[i].subOrderId+"</td>"+
              "<td>"+msg.orderSkus[i].productId+"</td><td>"+msg.orderSkus[i].name+"</td>"+
              "<td>"+msg.orderSkus[i].productCount+"</td></tr>");
        }
      }else{
    	  winAlert(msg.message);
      }
    }
  });
});

function checkOrderNo(){
	var theSubOrderNo = $("input[name='subOrderNo']").val();
	if(theSubOrderNo == ''){
		$('#Complaint').submit();
	}else{
		if($("#supplierId").val()==''){
			alert("请获取订单信息");
			return false;
		}
	  $.ajax({
		    url : "${dynamicDomain}/orderSku/getOrderSkusBySubOrderNo/" + theSubOrderNo,
		    type : 'post',
		    dataType : 'json',
		    success : function(msg) {
		      if (msg.result) {
		    	  $("#supplierId").val(msg.supplierId);
		    	  $('#Complaint').submit();
		      }else{
		    	 alert("请填写正确订单号或不填写订单号！");
		    	 return false;
		      }
		    }
		  });
	}

}
</script>
</body>
</html>