<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>导入生活服务类订单</title>
<style>
.import{
	width:86%;
	margin:0 0 0 40px;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">导出生活服务类订单</h4>
		</div>
			<jdf:form bean="request" scope="request">
				<form method="post" action="" class="form-horizontal import" id="isform" name="isform">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12 col-md-12 menuContent">
								<div class="form-group">
									<label for="lifeServies" class="col-sm-2 control-label">生活服务</label>
									<div class="col-sm-10">
										<jdf:checkBox dictionaryId="1115" name="lifeServies"/>
									</div>
								</div>
							</div>
						</div>					
						<div class="row">
							<div class="col-sm-12 col-md-6">
								<div class="pull-right">
									<button type="button" id="submitButton"
										onclick="javascript:downloadFile();" class="btn btn-primary">
										确定
									</button>
								</div>
							</div>
						</div>
					</div>
				</form>
			</jdf:form>
		</div>
	<script type="text/javascript">
		function downloadFile(){
			var lifeServies = getCheckedValuesString($("input[name='lifeServies']:checked")).split(",");
			var typestring;
			for(i=0;i<lifeServies.length;i++){
				if(i==0){
					typestring=lifeServies[i];
				}else{
					typestring=typestring+","+lifeServies[i];	
				}
			}
			
			var startbookingDate = window.parent.$("#startbookingDate").val();
			var endbookingDate = window.parent.$("#endbookingDate").val();
			var subOrderNo = window.parent.$("#subOrderNo").val();
			var subOrderState = window.parent.$("#subOrderState").val();
			var userName = window.parent.$("#userName").val();
			var supplierId = window.parent.$("#supplierId").val();
			var supplierName = window.parent.$("#supplierName").val();
		    var url = "${dynamicDomain}/lifeserviceoderstatusupdate/exportOrder?startbookingDate="+startbookingDate+
		    		 "&endbookingDate="+endbookingDate+
		    		 "&subOrderNo="+subOrderNo+
		    		 "&subOrderState="+subOrderState+
		    		 "&userName="+userName+
		    		 "&supplierId="+supplierId+
		    		 "&supplierName="+supplierName+
		    		 "&lifeType="+typestring;
		     document.location.href = url;
		}
	</script>
</body>
</body>
</html>