<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>编辑报价</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action=""   id="PhysicalPrice" class="form-horizontal">
			<input type="hidden" name="objectId" id="objectId">
			<input type="hidden" name="supplierId" id="supplierId">
			<input type="hidden" name="subItemId" id="subItemId">
			<input type="hidden" name="auditStatus" id="auditStatus"  value="1">
			<input type="hidden" name="applyPeople" id="applyPeople">
			<input type="hidden" name="applyTime" id="applyTime">
			<input type="hidden" name="shopIdArray" id="shopIdArray">
			<input type="hidden" name="shopNameArray" id="shopNameArray">
			
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<input type="hidden" id="hiddenAuditStatus" value="${entity.auditStatus}"/>
									<label class="col-sm-4 control-label">审核状态：</label>
									<span class="lable-span"><jdf:dictionaryName  dictionaryId="1605"  value="${entity.auditStatus }"/>
										<fmt:formatDate value="${physicalAudited.auditedTime }" pattern=" yyyy-MM-dd"/>
									</span>
							</div>
						</div>	
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 control-label">申请人：</label>
									<span class="lable-span">${entity.applyPeople }</span>
							</div>
						</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label class="col-sm-4 control-label">申请时间：</label>
										<span class="lable-span"><fmt:formatDate value="${entity.applyTime }" pattern=" yyyy-MM-dd"/></span>
								</div>
							</div>	
					</div>
					<c:if test="${physicalAudited.isPassed==3 }">
						<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label class="col-sm-4 control-label">不通过原因：</label>
										<span class="lable-span">${physicalAudited.rejectReason }</span>
								</div>
							</div>	
						</div>
					</c:if>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 control-label">供应商：</label>
									<span class="lable-span">${supplierName }</span>
							</div>
						</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-12 col-md-12">
								<table id="priceItem" class="table table-bordered table-hover">
					                    <thead>
					                      <tr>
					                        <th>序号</th>
					                        <th>一级项目</th>
					                        <th>二级项目</th>
					                        <th>供货价</th>
					                        <th>门市价</th>
					                      </tr>
					                    </thead>
					                    <tbody>
						                    <tr id="item1">
							                        <td>1</td>
							                        <td>${firstItemName }</td>
							                        <td>${secondItemName }</td>
							                        <td><input type="text" name="supplierPrice" ></td>
							                        <td><input type="text" name="marketPrice"  ></td>
						                     </tr>
					                    </tbody>
					                </table>
							</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label   class="col-sm-4 control-label">支持门店：</label>
									<div class="col-sm-8">
										<jdf:radio dictionaryId="1210" name="supplierAllShop"/>
										<!-- 
										<input type="radio" name="supplierAllShop"  id="allShop" value=1>全部
										<input type="radio" name="supplierAllShop"  id="someShop" value=2>支持部分
										 -->
									</div>
								</div>
							</div>
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<div class="col-sm-8">
										<button type="button" id="checkShop" class="btn btn-primary">选择门店</button>
									</div>
								</div>
							</div>
					</div>
<!-- 测试门店关联数据插入，等门店与供应商信息完成后替换为动态关联数据 begin-->		
			<div id="shopNameList">
			</div>
					
<!-- 测试门店关联数据插入，等门店与供应商信息完成后替换为动态关联数据 end-->	
					
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label  class="col-sm-4 control-label">状态：</label>
									<div class="col-sm-8">
										<input type="radio" name="status"  id="status1" value=1>有效
										<input type="radio" name="status"  id="status2" value=2>失效
									</div>
								</div>
							</div>
					</div>
					
				
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button"  onclick="subPrice()" class="btn btn-primary">提交</button>
						</div>
					</div>
			</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalPrice" />
	<script type="text/javascript">
	var INVALID_STATUS = 2,VALID_STATUS = 1;
	var AUDIT_PAST = 2;//审核通过。
	
 
	var old_status ,old_sprice,old_mprice, old_shop_type,old_auditStatus ;
	
	$(function(){ 
		var psrList = "${psrList}";
		if (psrList!="") {
			<c:forEach items="${psrList}" var="item">
			$("#shopNameList").append('<div class="row"><div class="col-sm-12 col-md-12" ><div class="form-group">'+
					'<div class="col-sm-6"><input type="hidden" class="search-form-control" name="shopId" value="${item.shopId}"/>'+
					'<input type="hidden" class="search-form-control" name="shopName" value="${item.shopName}"/>'+
					'<label class="col-sm-6 control-label">${item.shopName}</label>'+
					'</div></div></div></div>');
			</c:forEach>
		}
		$("#checkShop").click(function ()
	     {
		 		var supplierAllShop = $('input[name="supplierAllShop"]:checked').val();
		 		if(supplierAllShop==2){
		 			var supplierId = "${entity.supplierId }";
		 			$.colorbox({
		 				opacity : 0.2,
		 				href:   "${dynamicDomain}/supplierShop/getSupplierShop?ajax=1&supplierId="+supplierId,
		                fixed : true,
		                width : "80%",
		                height : "90%",
		                iframe : true,
		                onClosed : function() {
		                    if (false) {
		                        location.reload(true);
		                    }
		                },
		                overlayClose : false
		 			});
		 		}
		     });
	});
			$(document).ready(function(){
				if("${entity.status}"==1){
					$("#status1").attr("checked","checked");
				}else if("${entity.status}"==2){
					$("#status2").attr("checked","checked");
				}
				if("${entity.supplierAllShop}"==1){
					$("#allShop").attr("checked","checked");
				}else if("${entity.supplierAllShop}"==2){
					$("#someShop").attr("checked","checked");
				}
				
				
				//暂存 旧的供货价、门市价和有效状态
				old_status = $('input[type="radio"][name="status"]:checked').val();
				old_sprice = $('input[name="supplierPrice"]').val();
				old_mprice = $('input[name="marketPrice"]').val();
				old_shop_type = $('input[name="supplierAllShop"]:checked').val();
				old_auditStatus = $('#hiddenAuditStatus').val();
				 
			});
			
			function subPrice(){
				$("#PhysicalPrice").attr("action","${dynamicDomain}/physicalPrice/editToPage") ;
				
				var shopId = document.getElementsByName("shopId");
				var shopName = document.getElementsByName("shopName");
				var shopIds = "";
				var shopNames = "";
				for (var i = 0; i < shopId.length; i++) {
					shopIds = appendSplit(shopIds, shopId[i].value, ",");
				}
				for (var i = 0; i < shopName.length; i++) {
					shopNames = appendSplit(shopNames, shopName[i].value, ",");
				}
				$("#shopIdArray").val(shopIds);
				$("#shopNameArray").val(shopNames);
				//$("#shopIdArray").val(getUpdateColumnString(document.getElementsByName("shopId")));
				//$("#shopNameArray").val(getUpdateColumnString(document.getElementsByName("shopName")));
				
				var sprice = $('input[name="supplierPrice"]').val();
				if($.trim(sprice) == ''){
					alert('金额不能为空！');
					return ;
				}
				
				
				var mprice = $('input[name="marketPrice"]').val();
				if($.trim(mprice) == ''){
					alert('金额不能为空！');
					return ;
				}
				
				sprice = parseFloat(sprice);
				mprice = parseFloat(mprice);
				
				if(sprice > 1000000 || mprice > 1000000 ){
					alert('金额过大');
					return ;
				}
				
				
				var shop_type = $('input[name="supplierAllShop"]:checked').val();
				var status = $('input[type="radio"][name="status"]:checked').val();
				//如果仅把无效改为有效，则不用更新审核状态。
				if(old_status == INVALID_STATUS 
						&& status ==VALID_STATUS 
						&& 	sprice == old_sprice
						&&  mprice == old_mprice
						&& shop_type == old_shop_type
						&& AUDIT_PAST == old_auditStatus
				){
					$("#PhysicalPrice").attr("action","${dynamicDomain}/physicalPrice/editValidStatus") ;
				}
				
				$("#PhysicalPrice").submit();
			}
			
		  /**
			 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
			 */
			function getUpdateColumnString(columnItem, split) {
				var checkItem = document.getElementsByName("schk");
				if (split == null) {
					split = ",";
				}
				str = "";
				for (var i = 0; i < checkItem.length; i++) {
					if (checkItem[i].checked == true) {
						str = appendSplit(str, columnItem[i].value, split);
					}
				}
				if (str == "") {
					return null;
				}
				return str;
			}
		  
			function getStringArray(name, split) {
				var checkItem = document.getElementsByName(name);
				if (split == null) {
					split = ",";
				}
				str = "";
				for (var i = 0; i < checkItem.length; i++) {
					str = appendSplit(str, columnItem[i].value, split);
				}
				return str;
			}
			/**
			 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
			 */
			function appendSplit(str, strAppend, split) {
				if (str == null || str == "") {
					return strAppend;
				} else {
					return str + "," + strAppend;
				}
			}	
	</script>
</body>
</html>