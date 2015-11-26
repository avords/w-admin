<%@page import="com.alibaba.dubbo.remoting.exchange.Request"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>合同管理</title>
<style>
 .col-sm-6{
 	  white-space: nowrap;
 }
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">合同
			 <c:choose>
                <c:when test="${entity.objectId eq null }">新增</c:when>
                <c:otherwise>
                 	 修改
                </c:otherwise>
            </c:choose>
			</h4>
		</div>
		<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/contract/save" class="form-horizontal" id="editForm" enctype="multipart/form-data">
					<input type="hidden" name="objectId">
					<input type="hidden" name="managerId" id="managerId">
					<div class="box-body">
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<c:choose>
					                <c:when test="${entity.objectId eq null }">
										<label for="customerType" class="col-sm-4 control-label">合同签订对象</label>
										<div class="col-sm-6">
											<select name="customerType" id="customerType" class="search-form-control" >
												<jdf:select dictionaryId="1204" />
											</select>
										</div>
					                </c:when>
					                <c:otherwise>
					                 	 <label for="customerType" class="col-sm-4 control-label">对方编号</label>
										<div class="col-sm-6">
										<label class="control-label">${entity.customerNo }</label>
										</div>
					                </c:otherwise>
					            </c:choose>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="customerName" class="col-sm-4 control-label">对方名称</label>
								<div class="col-sm-6">
									<c:choose>
						                <c:when test="${entity.objectId eq null }">
											<input type="hidden"  class="search-form-control" name="customerNo" id="customerId"> 
											<input type="text"  class="search-form-control" name="customerName" id="customerName" onclick="chooseCompany();">
						                </c:when>
						                <c:otherwise>
						                 	 <label class="control-label">${entity.customerName }</label>
						                </c:otherwise>
						            </c:choose> 
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="contractNo" class="col-sm-4 control-label">合同编号</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="contractNo" id="contractNo">
								</div>
							</div>
						</div>
					</div>
						
						<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="attachmentNo" class="col-sm-4 control-label">上传合同文件
								</label>
								<div class="col-sm-6">
								<c:choose>
					                <c:when test="${entity.objectId eq null }">
					                </c:when>
					                <c:otherwise>
										<a href="${dynamicDomain}${entity.attachmentNo}">${dynamicDomain}${entity.attachmentNo}</a>
					                </c:otherwise>
					            </c:choose>
								<input type="file" class="" name="attachmentNo" id="attachmentNo">
								</div>
							</div>
						</div>
					</div>
					
					 <div class="row">
                            <div class="col-sm-10 col-md-10">
                                <div class="form-group">
                                     <label for="startDate" class="col-sm-4 control-label">合同有效期：</label>
                                    <div class="col-sm-6">
                                        <input type="text" style="width:215px;height:33px;" id="effectiveDate" name="startDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'${startDateShow}',maxDate:'#F{$dp.$D(\'expireDate\')}',readOnly:true})">~
                                        <input type="text" style="width:215px;height:33px;" id="expireDate" name="endDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'effectiveDate\',{d:1})}',readOnly:true})">
                                    </div>
                                </div>
                            </div>
                  </div>	
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" onclick="checkContractNo();">
										保存
								</button>
								<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">返回</button>
							</div>
								
						</div>
						</div>
					</div>
				</form>
			</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="Contract"/>
	<script type="text/javascript">
	
	function checkContractNo(){
		var contractNo = $("#contractNo").val();
		var attachmentNo = $("#attachmentNo").val();
		var objectId ='${entity.objectId}';
		if (contractNo==null || contractNo=="") {
			$("#editForm").submit();
			return;
		}
		if (objectId==null||objectId=="") {
			$.ajax({
				url: "${dynamicDomain}/contract/checkContractNo",
				type : 'post',
				data :{'contractNo':contractNo},
				dataType : 'json',
				success :function (data) {
				 //对请求返回的JSON格式进行分解加载
				  ret = data.result;
				 if (!ret) {
					 alert("合同编号已存在");
					 return false;
				 }else{
					 if (attachmentNo ==null || attachmentNo==""){
						alert("请上传合同文件");
						return false;
					}
					 $("#editForm").submit();
				 }
				}
			});
		}else{
			$("#editForm").submit();
			return;
		}
	}
	
	function chooseCompany(){
		var customerType = $("#customerType").val();
		if(customerType==""){
			return false;
		}
		 $.colorbox({
			opacity : 0.2,
			href:   "${dynamicDomain}/contract/chooseCustomer?ajax=1&customerType="+customerType,
            fixed : true,
            width : "60%",
            height : "80%",
            iframe : true,
            onClosed : function() {
                if (false) {
                    location.reload(true);
                }
            },
            overlayClose : false
			}); 
	}
	</script>
	<script type="text/javascript">
	$(function(){
		$("#customerType").bind("change",function(){
          	$("#customerName").val("");
         });
		
	}); 
	function comeBack(){
		window.location.href = '${dynamicDomain}/contract/page';
	}
	</script>
</body>
</html>