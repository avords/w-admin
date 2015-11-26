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
       	员工退保管理
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/insureUserRefund/page" method="post" class="form-horizontal" id="form1">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">退保时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_refundDate\')}'})" 
                  name="search_GED_refundDate" id="search_GED_refundDate" >
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_refundDate\')}'})" class="search-form-control" 
                  name="search_LED_refundDate" id="search_LED_refundDate" >
                </div>
              </div>
            </div>
              <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_subOrderNo">
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
                  <input type="text" class="search-form-control" name="search_EQS_contractNo">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">退保账户：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_refundName">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">手机号码：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_mobilePhone">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">电子邮箱：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_email">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
           	<button type="button" class="btn btn-primary" id="refundInsure">
				<span class="glyphicon glyphicon-export"></span>退保
			</button>
			<button type="button" class="btn btn-primary" id="del">
				删除
			</button>
           	<button type="button" class="btn btn-primary" id="batchRefundInsure">
				<span class="glyphicon glyphicon-export"></span>批量退保
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
      <jdf:export view="csv" fileName="insureUserRefund.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="insureUserRefund.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="objectId" title="<input type='checkbox' name='checkall' id='checkall' />" 
			style="text-align: center;" headerStyle="width: 2%;text-align: center;" viewsAllowed="html" sortable="false">
          	<input type="checkbox" class="option" name="checkId" value="${currentRowObject.objectId}" />
        </jdf:column>
        <jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" />
        <jdf:column property="contractNo" title="合同号" headerStyle="width:8%;" />
        <jdf:column property="generalOrderNo" title="订单号" headerStyle="width:10%;" />
        <jdf:column property="proName" title="保险商品" headerStyle="width:8%;" />
        <jdf:column property="attribute1Value" title="商品规格" headerStyle="width:9%;">
        </jdf:column>
        <jdf:column property="refundName" title="退保账户" headerStyle="width:7%;" />
        <jdf:column property="refundPremiumq" title="退保费" headerStyle="width:7%;" />
        <jdf:column property="remark" title="备注" headerStyle="width:7%;" />
        <jdf:column property="mobilePhone" title="手机号码" headerStyle="width:8%;" />
        <jdf:column property="email" title="电子邮件" headerStyle="width:8%;" />
        <jdf:column property="refundDate" title="退保时间" headerStyle="width:8%;" />
        <jdf:column property="operatorName" title="操作人" headerStyle="width:10%;"/>
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
	
	$("#del").bind("click",function(){
		var ids = getIds();
		if (ids=="") {
			winAlert("请选择数据！");			
		}else{
			$.ajax({
				url : "${dynamicDomain}/insureUserRefund/doDelete/",
				type : 'post',
				data:{'objectIds':ids},
				dataType : 'json',
				success : function(msg) {
					if (msg.result) {
						$('#addSupplier').submit();
						window.parent.$.colorbox.close();
	                }else{
	                  alert(msg.resultReason);						
	               }
				}
			});
		}
		
	});
	
	$("#refundInsure").click(function(){
		var url = "${dynamicDomain}/insureUserRefund/addRefundInsure?ajax=1";
		//toUrl(url);
		$.colorbox({
			href:url,
			opacity:0.2,
			fixed:true,
			width:"45%",
			height:"60%", 
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
	
	$("#batchRefundInsure").click(function(){
		var url = "${dynamicDomain}/insureUserRefund/importInsureOrder?ajax=1";
		//toUrl(url);
		$.colorbox({
			href:url,
			opacity:0.2,
			fixed:true,
			width:"35%",
			height:"40%", 
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
	
	$("#checkall").click( 
		function(){ 
			if(this.checked){ 
				$("input[name='checkId']").each(function(){this.checked=true;}); 
			}else{ 
				$("input[name='checkId']").each(function(){this.checked=false;}); 
			} 
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