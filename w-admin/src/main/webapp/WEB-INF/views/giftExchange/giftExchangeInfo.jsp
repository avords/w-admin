<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="运营端-礼券兑换" /></title>
</head>
<body>
    <form id="createOrderForm" name="createOrderForm" action="${dynamicDomain}/giftExchange/confirmExGoods" method="post">
		<div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${msg }</div>
                <jdf:message code="运营端-礼券兑换" />
            </h4>
        </div>
	
		<div id="gw-p2-1">
			<div class="panel panel-default"
				style="width: 100%; min-height: 100px;">
				<div class="panel-heading">
					${welfarePackage.packageName}(${category.firstParameter}选${category.secondParameter})
				</div>
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th>商品</th>
							<th>市场参考价</th>
							<th>选择</th>
						</tr>
					</thead>
					<tbody>
						<!-- 套餐类型 1：弹性套餐(N选1)  2：固定套餐(N选N)  -->
						<c:if test="${welfarePackage.wpCategoryType =='1'}">
							<c:forEach var="sku" items="${skuList}">
								<tr>
									<td>
										<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank"> 
											<img style="height: 80px; width: 80px;" src="${adminStaticDomain}${sku.mainPicture}" />
										</a> 
										<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank">${sku.name}</a>
									</td>
									<td>￥${sku.marketPrice}</td>
									<td>
										<c:choose>
											<c:when test="${sku.stock > 0 && sku.checkStatus=='5' && sku.deleted == 0 }">
												<a href="javascript:void(0)" data-val="${sku.objectId}" class="f-ib j-btn-sel">选择</a>
											</c:when>
											<c:otherwise>
												<a href="javascript:void(0)" class="f-ib">已售罄</a>
											</c:otherwise>
										</c:choose>
									</td>
								</tr>
							</c:forEach>
						</c:if>
						<c:if test="${welfarePackage.wpCategoryType =='2'}">
							<c:forEach var="sku" items="${skuList}">
								<tr>
									<td>
										<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank"> 
											<img style="height: 80px; width: 80px;" src="${adminStaticDomain}${sku.mainPicture}" />
										</a> 
										<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank">
											${sku.name}
										</a>
									</td>
									<td>￥${sku.marketPrice}</td>
									<td><a href="#" data-val="${sku.objectId}" class="f-ib z-on">已选</a></td>
								</tr>
							</c:forEach>
						</c:if>
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




			<ul class="f-cbul">
				<li class="f-li">套餐说明:
				${welfarePackage.packageExplain}
				</li>
			</ul>
			<h4>
				<button type="button" class="btn btn-primary j-btn-next">下一步 </button>
				<input value="" class="j-val-sel" id="proSkuIds" name="proSkuIds" type="hidden" />
				<input id="welfarePackageId" name=welfarePackageId type="hidden" value="${welfarePackage.objectId}"  />
				
				
			</h4>
		</div>
	</form>
	<script>
		$(function() {

			// 选择的点击事件
			var _selTag = $('.j-btn-sel'), _valTag = $('.j-val-sel');
			_selTag.click(function() {

				var _this = $(this);
				if (_this.hasClass('z-on')){
					return false;
				}
				_selTag.filter('.z-on').removeClass('z-on').text('选择');
				_this.addClass('z-on').text('已选');
				_valTag.val(_this.attr('data-val'));//设置选择商品的ID值
			});

			// 判断是否选择
			$('.j-btn-next').click(function() {
				var packageType = '${welfarePackage.wpCategoryType}';//套餐类型（ 1：弹性套餐 2：固定套餐）
				if(packageType == '2'){//固定套餐 选择所有商品
					var chooseProId = "";
					var choosesPro = $(".z-on");
					$.each(choosesPro, function(){
						var _this = $(this);
						chooseProId +=_this.attr('data-val')+",";
					});
					_valTag.val(chooseProId);//设置选择商品的ID值
				}
				if (_valTag.val() ==null || _valTag.val()=="") {
					alert('请至少选择一项');
					return false;
				} else {
					$("#createOrderForm").submit();
				}
			});

			// 默认选择
			//初始化选中商品
			var proSkuIds = $("#proSkuIds").val();
			if(proSkuIds!=null && proSkuIds!=''){
				var proSkuIdsList = proSkuIds.split(",");
				for(var i=0;i<proSkuIdsList.length;i++){
					_selTag.each(function(){
					    if($(this).attr("data-val") == proSkuIdsList[i]){
					    	$(this).addClass('z-on').text('已选');
					    }
			  		});
				}
			}
			
			
			
			

		});
	</script>

	<script>
		var isFtFot = false;
	</script>
</body>
</html>