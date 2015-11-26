<%@ page language="java" contentType="text/html; charset=utf-8"
  pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>订单核对</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="select2.js"/>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">订单核对</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="" class="form-horizontal" id="CompanyAccount" >
        <input type="hidden" name="objectId">
        <input type="hidden" name="orderId"  id="orderId" value="${subOrder.objectId}">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label   class="col-sm-4 control-label"> 总订单编号：</label>
                <div class="col-sm-6"  id="lable" style="padding-top:6px;">
                  ${order.generalOrderNo}
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="subOrderNo" class="col-sm-4 control-label" >子订单号：</label>
                <div class="col-sm-6" id="lable" style="padding-top:6px;">
                  ${subOrderNos}
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="allPayableMount" class="col-sm-4 control-label">应付金额：</label>
                <div class="col-sm-2"  id="lable" style="padding-top:6px;">
                <input type="hidden" id="allPayableMount" name="allPayableMount" value="${allPayableMount}"/>
                 <fmt:formatNumber type="number" value="${allPayableMount}" pattern="0.00" maxFractionDigits="2"/>元                
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-4 control-label">实付金额：</label>
                <div class="col-sm-2">
                  <input type="text" class="search-form-control" name="paymentAmount" id="paymentAmount">
                </div>
                <div class="col-sm-1"><span class="lable-span">元</span></div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="linePayRemark1" class="col-sm-4 control-label"><p>备注：</p>
                </label>
                <div class="col-sm-4">
                  <textarea onkeyup="checkLen(this)" style="width: 400px; height: 100px;" id="linePayRemark" name="linePayRemark"></textarea>
                   <span style="color: red">(备注字段最多输入200个字符, 您还可以输入 <span id="count">200</span> 个)
                  </span>
                </div>              
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="editPageButton">
            <button type="button" class="btn btn-primary progressBtn" id="update">
                                          提交
            </button>
           
            <button type="button" class="btn btn-primary progressBtn" onclick="closeDialog();">
                                          返回
            </button>
          
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Order"/>
  <script type="text/javascript">
  
  $("#update").click(function(){	
	      var allPayableMount=$('#allPayableMount').val();
	      var paymentAmount=$('#paymentAmount').val();
          if(paymentAmount==null){
        	 alert("实付金额不能为空！");  
        	 $("#paymentAmount").focus();
        	 return false;
           }
 
	      if(parseFloat(allPayableMount)!=parseFloat(paymentAmount)){
	    	  alert("应付金额和实付金额不相等!");
	    	  $("#paymentAmount").focus();
	    	  return false;
	       }
	      var linePayRemark=$('#linePayRemark').val();
		  if(linePayRemark==''){
			  $("#linePayRemark").focus();
			  $("p").css({
				   "color":"#dd4b39",
			   });
			  return false;
		     }
		  var orderId = $('#orderId').val();
			$.ajax({
				url : "${dynamicDomain}/order/updateToPage/",
				type : 'post',
				data:{'orderId':orderId,'paymentAmount':paymentAmount,'linePayRemark':linePayRemark},
				dataType : 'json',
				success : function(msg) {
					if (msg.result == true) {
						  window.parent.location.reload();
						}else{
							alert(msg.resultReason);
							window.location.reload();
							
						}
				   }
			});		
	});
  
  function checkLen(obj) {
		var maxChars = 200;//最多字符数 
		if (obj.value.length > maxChars)
			obj.value = obj.value.substring(0, maxChars);
		var curr = maxChars - obj.value.length;
		document.getElementById("count").innerHTML = curr.toString();
	}

  
  function closeDialog() {
		
	 		window.parent.$.colorbox.close();
		}
  </script>
</body>
</html>