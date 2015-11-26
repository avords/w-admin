<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				商品信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfarePackage/wpProductAddTemplate?ajax=1&recommendCount=${recommendCount}&reserveCount=${reserveCount}" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品编号：</label>
								</div>
								<input type="text" class="search-form-control" name="search_STARTS_skuNo">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_name">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:void(0);" onclick="setProduct();" class="btn btn-primary pull-left">
						确认
					</a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="wpProductAddTemplate?ajax=1">
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-|-${currentRowObject.name}-|-${currentRowObject.marketPrice}-|-${currentRowObject.sellPrice}-|-${currentRowObject.productPublish.mainPicture}-|-${currentRowObject.skuNo}" />
				</jdf:column>
				<jdf:column property="checkStatus" title="商品状态" headerStyle="width:10%;" >
					<jdf:columnValue dictionaryId="1108" value="${currentRowObject.checkStatus}" />
				</jdf:column>
				<jdf:column property="skuNo" title="商品编号" headerStyle="width:15%;" />
				<jdf:column property="name" title="商品名称" headerStyle="width:20%;" />
				<jdf:column property="attributeValue1" title="尺寸" headerStyle="width:15%;" />
				<jdf:column property="attributeValue2" title="颜色" headerStyle="width:15%;" />
				<jdf:column property="sellPrice" title="商品价格" headerStyle="width:15%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	
	var recommendCount = "${recommendCount}";
	var reserveCount = "${reserveCount}";
	
	function renderProDesc(){
		var labels = window.parent.$('label.prod-desc');
		for(var i=0;i<labels.length;i++){
			$(labels[i]).text('备选商品'+(i+1)+'：');
		}
	}
	
	
	function crosArr(products,selectedProIdArr)	{
		for(var i=0;i<products.length;i++){
			var pid = products[0].split("-|-")[0];
			for(var j=0;pid&&j<selectedProIdArr.length;j++){
				var s_pid = selectedProIdArr[j];
				if(s_pid && pid == s_pid){
					products.splice(i,1);
				}
			}
		}
	}
	function setProduct(){
		 
		var s = document.getElementsByName("schk");
		s = getCheckedValuesString(s) ;
		if(!s){
			alert('请选择');
			return false;
		}
		var products = s.split(",");
		var productDiv;
		if(reserveCount){
			reserveCount = parseInt(reserveCount);
			if(products.length > reserveCount){
				alert("只能选择最多"+reserveCount+"种备选商品");
				return false;
			}
			productDiv = window.parent.$("#reserveProductList");
			var _html = productDiv.html();
			
			var reserveproductIdArray = window.parent.$("#reserveproductIdArray").val();
			var selectedProIdArr = reserveproductIdArray.split(",");
			crosArr(products,selectedProIdArr);
			
			var productIdArray = window.parent.$("#productIdArray").val();
			var selectedProIdArr = productIdArray.split(",");
			crosArr(products,selectedProIdArr);
			
			for(var i in products){
				 var product = products[i].split("-|-");
				 
				 _html +='<div class="row" id="progetted_rev'+product[0]+'">'					 
					 	   +'<div class="col-sm-3 col-md-3">'						 		 
							     +'<div class="row">'
							     	+'<div class="form-group">'
								     	+'<label class="col-sm-3 control-label prod-desc"></label>'
									 	+'<div class="col-sm-9"><img id="showPackageImg" style="width: 120px;height: 90px;" src="${dynamicDomain}'+product[4]+'"></div>'
								 	+'</div>'
								 +'</div>'								 
						   +'</div>'	
						   +'<div class="col-sm-9 col-md-9">'  							 	 
							 	 +'<div class="row">' 
								 	+'<div class="col-sm-6 col-md-6">'
									 	+'<div class="form-group">'
									 		+'<label class="col-sm-3 control-label">商品标题：</label><span>'+product[1]+'</span>'
									 	+'</div>'
								 	+'</div>'
								 	+'<div class="col-sm-6 col-md-6">'
									 	+'<div class="form-group">'
									 		+'<label class="col-sm-3 control-label">优先级：</label>'
									 		+'<div class="col-sm-2">'
												+'<input type="text" class="form-control sortNoVerify" name="sProductPriority" value="0">'
											+'</div>'
									 	+'</div>'
								 	+'</div>'
						 		 +'</div>'
						 		 
						 		+'<div class="row">' 
								 	+'<div class="col-sm-6 col-md-6">'
									 	+'<div class="form-group">'
									 		+'<label class="col-sm-3 control-label">商品ID1：</label><span>'+product[0]+'</span>'
									 	+'</div>'
								 	+'</div>'
								 	+'<div class="col-sm-6 col-md-6">'
									 	+'<div class="form-group">'
									 		+'<label class="col-sm-3 control-label">商品编号：</label><span>'+product[5]+'</span>'
									 	+'</div>'
								 	+'</div>'
					 		 	+'</div>'
							 	 
							 	 +'<div class="row">'
								 	+'<div class="col-sm-6 col-md-6">'
									 	+'<div class="form-group">'
									 		+'<label class="col-sm-3 control-label">市场价：</label><span>'+product[2]+'</span>'
									 	+'</div>'
								 	+'</div>'
								 	+'<div class="col-sm-6 col-md-6">'
								 		+'<div class="form-group">'
								 			+'<label class="col-sm-3 control-label">销售价：</label><span>'+product[3]+'</span>'
								 		+'</div>'
								 	+'</div>'
							 	 +'</div>' 
						 	     
							 	+'<div class="row">'
								     +'<div class="col-sm-2">'
								 		+'<a href="javascript:delRev(\'progetted_rev'+product[0]+'\','+product[0]+')" class="btn btn-primary">删除</a>'
								     +'</div>' 
							    +'</div>' 
							    
						    +'</div>'
						 +'</div>'; 
				  
				
				if(reserveproductIdArray==""){
					reserveproductIdArray = product[0];
				}else{
					reserveproductIdArray +=","+ product[0];
				}
			}//end of forIn
			productDiv.html(_html);
			renderProDesc();
			window.parent.$("#reserveproductIdArray").val(reserveproductIdArray);
			window.parent.$.colorbox.close();
		}//end of if
		else if(recommendCount!=""){

			productDiv = $(window.parent.document).find("#productList");
			var index = parseInt($(window.parent.document).find("input[id='index']").val());
			var _html = productDiv.html();
			
			var productIdArray = window.parent.$("#productIdArray").val();			
			var selectedProIdArr = productIdArray.split(",");
			crosArr(products,selectedProIdArr);
			
			var reserveproductIdArray = window.parent.$("#reserveproductIdArray").val();
			var selectedProIdArr = reserveproductIdArray.split(",");
			crosArr(products,selectedProIdArr);
			
			for(var i in products){
				var product = products[i].split("-|-");
				var index_num = parseInt(parseInt(index)+parseInt(i));
				_html  +='<div class="row" id="progetted'+product[0]+'">'+
							'<div class="col-sm-3 col-md-3">'+
								'<div class="row">'+
									'<div class="form-group">'+
										'<label class="col-sm-3 control-label">推荐商品</label>'
										+'<div class="col-sm-9"><img id="showPackageImg" style="width: 120px;height: 90px;" src="${dynamicDomain}'+product[4]+'">'+
										'</div>'+
									'</div>'+
								'</div>'+
							'</div>'+
							'<div class="col-sm-9 col-md-9" style="padding-left:30px;">'+
								'<div class="row">'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">商品标题：</label><span>'+product[1]+'</span>'+
										'</div>'+
									'</div>'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">优先级：</label>'+
											'<div class="col-sm-5"><input type="text" name="productPriority" value="0" class="order-form-control sortNoVerify">'+
											'</div>'
										+'</div>'+
									'</div>'+
								'</div>'+
								'<div class="row">'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">商品ID：</label><span>'+product[0]+'</span>'+
										'</div>'+
									'</div>'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">商品编号：</label><span>'+product[5]+'</span>'+
										'</div>'
									+'</div>'+
								'</div>'+

								'<div class="row">'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">市场价：</label><span>'+product[2]+'</span>'+
										'</div>'+
									'</div>'+
									'<div class="col-sm-6 col-md-6">'+
										'<div class="form-group"><label class="col-sm-3 control-label">销售价：</label><span>'+product[3]+'</span>'+
										'</div>'
									+'</div>'+
								'</div>'+
								'<div class="col-sm-2">'+
									'<a href="javascript:del(\'progetted'+product[0]+'\','+product[0]+')" class="btn btn-primary">删除</a>'+
								'</div>'+
							'</div>'+
						'</div>';
				if(productIdArray==""){
					productIdArray += product[0];
				}else{
					productIdArray +=","+ product[0];
				}
			}
			productDiv.html(_html);
			$(window.parent.document).find("#productIdArray").val(productIdArray);
			$(window.parent.document).find("input[id='index']").val(parseInt(index)+products.length);
			window.parent.$.colorbox.close();
			
		}
	}
	</script>
</body>
</html>