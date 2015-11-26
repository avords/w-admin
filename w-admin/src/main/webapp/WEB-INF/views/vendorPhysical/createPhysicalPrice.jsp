<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action=""   id="PhysicalPrice" class="form-horizontal">
			<input type="hidden" name="supplierId" id="supplierId" value="${supplierId }">
			<input type="hidden" name="subItemIdArray" id="subItemIdArray">
			<input type="hidden" name="marketPriceArray" id="marketPriceArray">
			<input type="hidden" name="supplierPriceArray" id="supplierPriceArray">
			<input type="hidden" name="shopIdArray" id="shopIdArray">
			<input type="hidden" name="shopNameArray" id="shopNameArray">
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-4 control-label">供应商</label>
									<span class="lable-span">${supplierName} </span>
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
					                        <th>操作</th>
					                      </tr>
					                    </thead>
					                    <tbody>
						                    <c:forEach items="${physicalItemList }" var="physicalItem" varStatus="num">
						                    	 <tr id="item${num.index}">
							                        <td>${num.index+1 }</td>
							                        <td>${physicalItem.firstItemName }</td>
							                        <td>${physicalItem.secondItemName }<input type="hidden" name="subItemId"  value="${physicalItem.objectId }"></td>
							                        <td><input type="text" name="supplierPrice"></td>
							                        <td><input type="text" name="marketPrice"></td>
							                        <td onclick="deleteTr('item${num.index}')"><a href='#'>删除</a></td>
						                      	</tr>
						                    </c:forEach>
					                    </tbody>
					                </table>
							</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label  for="supplierAllShop" class="col-sm-4 control-label">支持门店</label>
									<div class="col-sm-8" >
										<jdf:radio dictionaryId="1210" name="supplierAllShop"/>
										<!-- <a href="" class="colorbox-define" id="chooseShop">
                                          <button type="button" onclick="chooseShop();">选择</button>
                                      </a> -->
                                      <%--  <a
										href="${dynamicDomain}/vendorPhysicalPrice/supplierShop?ajax=1"
										class="pull-left btn btn-primary colorbox-double-template">选择
									</a>  --%>
									
									</div>
								</div>
							</div>
					</div>
<!-- 测试门店关联数据插入，等门店与供应商信息完成后替换为动态关联数据 begin-->		
			
					<input type="hidden" name="shopId"  value="1">
					<input type="hidden" name="shopName" value="门店1">
					
					<input type="hidden" name="shopId"  value="2">
					<input type="hidden" name="shopName" value="门店2">
					
<!-- 测试门店关联数据插入，等门店与供应商信息完成后替换为动态关联数据 end-->		
				
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" onclick="subPrice()"  class="btn btn-primary">提交</button>
						</div>
					</div>
			</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalPrice" />
	
	<script type="text/javascript">
	$(function(){ 
		$("input[name='supplierAllShop']").click(function ()
	     {
		 		var supplierAllShop = $('input[name="supplierAllShop"]:checked').val();
		 		if(supplierAllShop==2){
		 			$.colorbox({
		 				opacity : 0.2,
		 				href:   "${dynamicDomain}/vendorPhysicalPrice/supplierShop?ajax=1",
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
	</script>
	<script type="text/javascript">

			$(document).ready(function(){
				if("${entity.supplierAllShop}"==1){
					$("#allShop").attr("checked","checked");
				}else if("${entity.supplierAllShop}"==2){
					$("#someShop").attr("checked","checked");
				}
			})
			
			 function deleteTr(trId){
				    $("#"+trId).remove();     
			}
			
			function subPrice(){
				$("#PhysicalPrice").attr("action","${dynamicDomain}/vendorPhysicalPrice/saveToPage") ;
				$("#subItemIdArray").val(getUpdateColumnString(document.getElementsByName("subItemId")));
				$("#marketPriceArray").val(getUpdateColumnString(document.getElementsByName("marketPrice")));
				$("#supplierPriceArray").val(getUpdateColumnString(document.getElementsByName("supplierPrice")));
				$("#shopIdArray").val(getUpdateColumnString(document.getElementsByName("shopId")));
				$("#shopNameArray").val(getUpdateColumnString(document.getElementsByName("shopName")));
				$("#PhysicalPrice").submit();
			}
			
			/**
			 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
			 */
			function getUpdateColumnString(columnItem, split) {
				if (split == null) {
					split = ",";
				}
				str = "";
				for (var i = 0; i < columnItem.length; i++) {
						str = appendSplit(str, columnItem[i].value, split);
				}
				if (str == "") {
					return null;
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