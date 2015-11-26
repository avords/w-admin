<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增体检项目报价</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action=""   id="PhysicalPrice" class="form-horizontal">
			<input type="hidden" name="subItemIdArray" id="subItemIdArray">
			<input type="hidden" name="marketPriceArray" id="marketPriceArray">
			<input type="hidden" name="supplierPriceArray" id="supplierPriceArray">
			<input type="hidden" name="shopIdArray" id="shopIdArray">
			<input type="hidden" name="shopNameArray" id="shopNameArray">
				<div class="box-body">
				
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label for="supplierId" class="col-sm-4 control-label">供应商</label>
								<div class="col-sm-8">
									<select name="supplierId" class="search-form-control" id="supplierList">
										<jdf:selectCollection items="supplierList" optionValue="objectId"  optionText="supplierName" />
									</select>
								</div>
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
					                    	<!-- 
					                    	<c:forEach items="${physicalItemList }" var="physicalItem" varStatus="num">
						                    	 <tr id="item${num.index}">
							                        <td>${num.index+1 }</td>
							                        <td>${physicalItem.firstItemName }</td>
							                        <td>${physicalItem.secondItemName }<input type="hidden" name="subItemId"  value="${physicalItem.objectId }"></td>
							                        <td><input type="text" name="supplierPrice"  maxlength="11"></td>
							                        <td><input type="text" name="marketPrice"  maxlength="11" ></td>
							                        <td onclick="deleteTr('item${num.index}')"><a href='#'>删除</a></td>
						                      	</tr>
						                    </c:forEach>
					                    	-->
					                    </tbody>
					                </table>
							</div>	
					</div>
					
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
										<label  for="supplierAllShop" class="col-sm-4 control-label">支持门店<span class="not-null">*</span></label>
									<div class="col-sm-8">
										<jdf:radio dictionaryId="1210" name="supplierAllShop"/>
										<!-- 
										<input type="radio" name="supplierAllShop"  checked id="allShop" value=1>全部
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
				
			<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" onclick="subPrice()"  class="btn btn-primary">提交</button>
							<button type="button"  class="btn btn-primary" onclick=" location.href='page';">取消</button>
						</div>
					</div>
			</div>
	</div>
	</form>
	</jdf:form>
	</div>
	<script type="text/javascript">
			$(document).ready(function(){
				if("${entity.supplierAllShop}"==1){
					$("#allShop").attr("checked","checked");
				}else if("${entity.supplierAllShop}"==2){
					$("#someShop").attr("checked","checked");
				}
				
				$("#checkShop").click(function () {
			 		var supplierAllShop = $('input[name="supplierAllShop"]:checked').val();
			 		if(supplierAllShop==2){
			 			var supplierId = $("#supplierList").val();
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
				
				$('input[name="supplierPrice"],input[name="marketPrice"]').change(function(){
					var reg = /(\d{1,8}(\.\d{1,2})?)/;
					var val = $(this).val(),val = $.trim(val);	
					if(val){
						var arr = val.match(reg) ;
						if(arr){
							val = arr[1] || '';
						}
					}
					$(this).val(val);					
				});
				 
				$('#supplierList').change(function(){
					var supplierId = $(this).val(); 
					$.ajax({
	           			url: "${dynamicDomain}/physicalPrice/getPhysicalItemsBySupplier/"+supplierId,
	           			//data:{supplierId:supplierId},
	           			type : 'post',
	           			dataType : 'json',
	           			success :function (data) {
	           				var domString = '';
	           				var target = $('table#priceItem tbody');
	           				target.empty();
	           				var physicalItemList  = data.physicalItemList;
	           				for(var i=0;physicalItemList.length&&i<physicalItemList.length;i++){
								var item = physicalItemList[i];									
								domString +='<tr id="item'+i+'">';
								domString +='<td>'+(i+1)+'</td>';
								domString +='<td>'+item['firstItemName']+'</td>';
								domString +='<td>'+item['secondItemName']+'<input name="physicalPrices['+i+'].subItemId" value="'+item['objectId']+'" type="hidden"> </td>' ;
								domString +='<td><input name="physicalPrices['+i+'].supplierPrice" id="physicalPrices['+i+'].supplierPrice" maxlength="11" type="text" class="required money"></td>' ;
								domString +='<td><input name="physicalPrices['+i+'].marketPrice" id="physicalPrices['+i+'].marketPrice" maxlength="11" type="text" class="required money"></td>' ;
								domString +='<td onclick="deleteTr(\'item'+i+'\')"><a href="#"> 删除</a></td>' ;
								domString +='</tr>' ; 
	           				}
	           				target.append(domString);
	           				
	           			}
					
	           		});
				}); 
				$('#supplierList').trigger('change');
			});
			
			 function deleteTr(trId){
				    $("#"+trId).remove();     
			}
			
			function subPrice(){
				
				$("#PhysicalPrice").attr("action","${dynamicDomain}/physicalPrice/saveToPageList") ;
				$("#subItemIdArray").val(getUpdateColumnString(document.getElementsByName("subItemId")));
				$("#marketPriceArray").val(getUpdateColumnString(document.getElementsByName("marketPrice")));
				$("#supplierPriceArray").val(getUpdateColumnString(document.getElementsByName("supplierPrice")));
				
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
				
				var supportShop = $('input[name="supplierAllShop"]:checked');
				if(!supportShop.length){
					alert('请选择支持门店！');
					return ;
				}	
				
				var rows = $('#priceItem tr');
				if(rows.length<=1){
					alert('列项不能为空！');
					return ;
				}
				/*
				var supplier = $('select[name="supplierId"]:selected');				
				if(!supplier.length){
					alert('请选择供应商！');
					return ;
				}
				*/ 
				if($("#PhysicalPrice").valid()){
					$("#PhysicalPrice").submit();
				}
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