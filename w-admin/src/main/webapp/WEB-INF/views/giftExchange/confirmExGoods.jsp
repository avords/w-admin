<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
	<title><jdf:message code="运营端-礼券兑换" /></title>
	
	
	<style>
		.tishi{color: red;}
		.f-ib{color: red;}
	</style>
		
</head>
<body>
<div>

	<form id="Order" name="Order" action="${dynamicDomain}/giftExchange/createSubOrder" method="post">
	 	<div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${msg }</div>
                <jdf:message code="运营端-礼券兑换" />
            </h4>
        </div>
        
        
         <div class="box-body">
         	
         	<c:if test="${stockType =='1'}">
	         	<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label"><h3>收货地址</h3></label>
						</div>
					</div>
				</div>
	        	<div class="row">
	        		<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">
								所在地区：<span class="not-null">*</span>
							</label>
							<div class="col-sm-8">
								<select class="j-pro" ><option>--请选择--</option></select>
								<select class="j-city"><option>--请选择--</option></select>
								<select class="j-area"><option>--请选择--</option></select>
								<span class="tishi"></span>
							</div>
						</div>
					</div>
				</div>
				
				
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">详细地址：<span class="not-null">*</span></label>
							<div class="col-sm-8">
								<input type="text" name="receiptAddress" id="receiptAddress"  class="f-ib w2 j-addr form-control" maxlength="60" value="例：上海市 浦东新区 世纪大道 100号 4楼101" />
								<span class="f-ib"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">邮政编码：</span></label>
							<div class="col-sm-8">
								<input type="text" name="receiptZipcode" maxlength="7" class="f-ib w3 form-control" />
							</div>
						</div>
					</div>
				</div>
			</c:if>
			<c:if test="${stockType =='2'}">
	         	<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label"><h3>收货信息</h3></label>
						</div>
					</div>
				</div>
			</c:if>
			<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">收货人姓名：<span class="not-null">*</span></label>
							<div class="col-sm-8">
								<input type="text" name="receiptContacts" class="f-ib w1 receiptContacts form-control" maxlength="30"/><span class="f-ib"></span>
							</div>
						</div>
					</div>
				</div>
				
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">手机号码：<span class="not-null">*</span></label>
							<div class="col-sm-8">
								<input type="text" name="receiptMoblie" class="f-ib w1 mobile form-control" maxlength="11" /><span class="f-ib"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">来电人姓名：</label>
							<div class="col-sm-8">
								<input type="text" name="callUserName" class="f-ib w1 form-control" maxlength="50" /><span class="f-ib"></span>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-6 col-md-6">
						<div class="form-group">
							<label for="cardNo" class="col-sm-4 control-label">来电人电话：</label>
							<div class="col-sm-8">
								<input type="text" name="callUserMobile" class="f-ib w1 mobile form-control" maxlength="11" /><span class="f-ib"></span>
							</div>
						</div>
					</div>
				</div>
				<c:if test="${stockType =='2'}">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cardNo" class="col-sm-4 control-label">邮箱：<span class="not-null">*</span></label>
								<div class="col-sm-8">
									<input type="text" name="receiptEmail" class="f-ib w1 email form-control" maxlength="30"/><span class="f-ib"></span>
								</div>
							</div>
						</div>
					</div>
				</c:if>
		</div>








	




		<div id="gw-p2-2">
			<div class="panel-heading">
				<h3>${welfarePackage.packageName}(${category.firstParameter}选${category.secondParameter})</h3>
			</div>
			
			<table class="table table-bordered table-hover">
				<thead>
					<tr>
						<th>商品</th>
						<th>市场参考价</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${skuPublishList}" var="sku">
						<tr>
		                    <td>
		                    	<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank">
		                    	<img style="height: 80px; width: 80px;" src="${adminStaticDomain}${sku.mainPicture}"></a>
		                    	<a href="${dynamicDomain}/product/view/${sku.productId}" target="_blank">${sku.name}</a>
		                    </td>
							<td>
								￥${sku.marketPrice}
							</td>
		                </tr>
					</c:forEach>
				</tbody>
				<tfoot>
					<tr>
						<th></th>
						<th></th>
					</tr>
				</tfoot>
			</table>
			
			<h4>
				<button type="button" class="btn btn-primary j-btn-sure">确定兑换 </button>
				<button type="button" class="btn btn-primary j-btn-back">返回 </button>
				
				<input type="hidden" id="proSkuIds" name ="proSkuIds" value="${proSkuIds}"/>
				<input type="hidden" id="welfarePackageId" name ="welfarePackageId" value="${welfarePackage.objectId}"/>
				
				<input type="hidden" id="province" name="province" value=""/>
				<input type="hidden" id="city" name="city" value=""/>
				<input type="hidden" id="county" name="county" value=""/>
			</h4>
		</div>
	</form>
	
	<jdf:bootstrapDomainValidate domain="Order" />
	
</div>
	<script>
		$(function() {
			//初始化省份
			var url = '${dynamicDomain}'+ "/area/getRoot";
			$.ajax({
				type: "POST",
				dataType: 'json',
				url: url ,
				success: function(data){
					$(".j-pro").children().remove();
                    $(".j-pro").append("<option value=''>—请选择—</option>");
					$.each(data.allProvince, function(i){
						 $(".j-pro").append("<option value='"+data.allProvince[i].objectId+"'>"+data.allProvince[i].name+"</option>");
					});
				}
			});
			
			//获取 省份 子节点信息
			function getsun(clas,parentId){
				var url2 = '${dynamicDomain}'+ "/area/getChildren/"+parentId;
				$.ajax({
					type: "POST",
					dataType: 'json',
					url: url2 ,
					success: function(data){
						$(clas).children().remove();
	                    $(clas).append("<option value=''>—请选择—</option>");
						$.each(data.areas, function(i){
							 $(clas).append("<option value='"+data.areas[i].objectId+"'>"+data.areas[i].name+"</option>");
						});
					}
				});
			}
			$('.j-pro').change(function() {
				getsun(".j-city",$('.j-pro').val());
				getsun(".j-area","");
			});
			
			$('.j-city').change(function() {
				getsun(".j-area",$('.j-city').val());
			});
			
			
			
			
			

			var isVirtual = "${stockType==1}";
			var _str = [ '例：上海市 浦东新区 世纪大道 100号 4楼101' ];

			// 模拟placeholder效果
			$('.j-addr').focus(function() {

				var _this = $(this), _val = $.trim(_this.val());
				if (_val == _str[0]) {
					_this.val('');
				}

			}).blur(function() {

				var _this = $(this), _val = $.trim(_this.val());
				if (_val == '') {
					_this.val(_str[0]);
				}
			});

			// 判断是否选择
			$('.j-btn-sure').click(function() {
				// 非虚拟
				if (isVirtual == 'true') {
					var _tag = $('.j-pro'), _val = $.trim(_tag.val());
					if(_val == ""){
						$(".tishi").html("请选择所在地区");
						_tag.focus();
						return false;
					}
					var _tag = $('.j-city'), _val = $.trim(_tag.val());
					if($(".j-city").val() == ""){
						$(".tishi").html("请选择所在地区");
						_tag.focus();
						return false;
					}
					var _tag = $('.j-area'), _val = $.trim(_tag.val());
					var _txt = _tag.next();
					if($(".j-area").val() == ""){
						$(".tishi").html("请选择所在地区");
						_tag.focus();
						return false;
					}
					
					
					// 详细地址
					var _tag = $('.j-addr'), _val = $.trim(_tag.val());
					var _txt = _tag.next();
					if (_val == _str[0]) {
						_txt.text('必填');
						_tag.focus();
						return false;
					}
					if (_val.length <= 1) {
						_txt.text('请填写完整地址');
						return false;
					} else {
						_txt.text('');
					}
				}else{
					/* // 邮箱
					var _tag = $('.j-email'), _val = $.trim(_tag.val());
					var _txt = _tag.next();
					if (_val.length <= 0) {
						_txt.text('必填');
						return false;
					} else {
						_txt.text('');
					} */
				}

				// 姓名
				/* var _tag = $('.j-name'), _val = $.trim(_tag.val());
				var _txt = _tag.next();
				if (_val.length <= 0) {
					_txt.text('必填');
					return false;
				} else {
					_txt.text('');
				} */

				

				
				var pro = $(".j-pro").find("option:selected").text();
				var city = $(".j-city").find("option:selected").text();
				var area = $(".j-area").find("option:selected").text();
				
				
				$("#province").val(pro);
				$("#city").val(city);
				$("#county").val(area);
				
				
				$("#Order").submit();
				
				
			});

			// 返回操作
			$('.j-btn-back').click(function() {
				window.history.go(-1);
			});
			
			
			
			
			
			

		});
	</script>

	<script>
		var isFtFot = false;
	</script>

</body>
</html>