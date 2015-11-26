<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>选择体检机构</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					选择体检机构
				</h4>
			</div>
			<form name="form1" method="post" action="#" id="appointment" class="form-horizontal" >
				<input type="hidden" name="objectId">
				<div class="box-body">
					
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="store" class="col-sm-4 control-label">体检城市</label>
								<div class="col-sm-3">
									 <select name="search_LIKES_province" class="search-form-control" id="area1">
                                        <option value="">—全部—</option>
                                        <jdf:selectCollection items="firstArea" optionValue="objectId" optionText="name"/>
                                    </select>
								</div>
								
								<div class="col-sm-3">
                                     <select name="search_LIKES_city" class="search-form-control" id="area2">
                                        <option value="">—全部—</option>
                                    </select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="brand" class="col-sm-4 control-label">品牌筛选</label>
								<div class="col-sm-8">
									 <c:forEach items="${supplierList }"  var="supplier"  varStatus="num" >
								 		<input type="radio" value="${supplier.objectId} " name="brand">${supplier.supplierName }
									</c:forEach> 
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="brand" class="col-sm-4 control-label">机构列表:</label>
							</div>
						</div>
					</div>
					<div class="row" style="margin-left: 170px;">
		              <table id="store" >
		                 <tbody>
			                 <%--  <tr>
			                     	 <td width="50px" style="border-style:none;"><input type="radio" value="1111"  /></td>
									<td width="150px" style="border-style:none;">哈哈哈哈啊哈哈</td>
									<td style="border-style:none;"><a href="${dynamicDomain}/CardExchange/packageDetail/${welfarePackage.objectId}" >[查看套餐详情]</a></td> 
			                    </tr> --%>
		                  </tbody>              
		              </table>
		          </div>
							
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" onclick="choosePhysicalStore();">确定所选机构</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary progressBtn">返回</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalSubscribe" />
	
	<script type="text/javascript">
	$(function(){
		$("#area1").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/advert/getCity/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#area2").children().remove(); 
                        $("#area2").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.citys.length; i++) {
                            $("#area2").append("<option value='" + json.citys[i].areaCode + "'>" + json.citys[i].name + "</option>");
                        }
                        if("${city}"!=""){
           				 $("#area2").val("${city}").change();
           			 }
                    }   
                });
            }
         }).change();

	});
	</script>
	
	<script type="text/javascript">
		$("#area2").bind("change",function(){
			$('#store tbody').empty();
			var brand = $('input[name="brand"]:checked').val();
			var cityId = $("#area2").val();
			$.ajax({
				url: "${dynamicDomain}/CardExchange/getPhysicalStore?brand="+brand+"&cityId="+cityId,
				type : 'post',
				dataType : 'json',
				success :function (data) {
				  for(var i=0;i<data.supplierShopList.length;i++){
						  $('#store tbody').append('<tr>').append('<td width="50px" style="border-style:none;"><input type="radio" name="physicalStore" value= '+data.supplierShopList[i].objectId +'></td>')
						  .append('<td width="410px" style="border-style:none;">'+data.supplierShopList[i].shopName+"-"+data.supplierShopList[i].address +'</td>')
						  .append('<td style="border-style:none;"><a href=${dynamicDomain}/CardExchange/supplierShopDetail/'+data.supplierShopList[i].objectId +'>[查看分院详情]</a></td>')
						  .append('</tr>')
						  ;
				  }
				}
			});
         });
	</script>
	
	<script type="text/javascript">
	$("input[name='brand']").bind("click",function(){
		$('#store tbody').empty();
		var brand = $('input[name="brand"]:checked').val();
		var cityId = $("#area2").val();
		$.ajax({
			url: "${dynamicDomain}/CardExchange/getPhysicalStore?brand="+brand+"&cityId="+cityId,
			type : 'post',
			dataType : 'json',
			success :function (data) {
			  for(var i=0;i<data.supplierShopList.length;i++){
					  $('#store tbody').append('<tr>').append('<td width="50px" style="border-style:none;"><input type="radio" name="physicalStore" value= '+data.supplierShopList[i].objectId +'></td>')
					  .append('<td width="410px" style="border-style:none;">'+data.supplierShopList[i].shopName+"-"+data.supplierShopList[i].address +'</td>')
					  .append('<td style="border-style:none;"><a href=${dynamicDomain}/CardExchange/supplierShopDetail/'+data.supplierShopList[i].objectId +'>[查看分院详情]</a></td>')
					  .append('</tr>')
					  ;
			  }
			}
		});
     });
	function choosePhysicalStore(){
		var storeId = $('input[name="physicalStore"]:checked').val();
		if(storeId == null){
			alert("请选择体检门店！");
			return;
		}else{
			window.location.href = "${dynamicDomain}/CardExchange/choosePhysicalDate?storeId="+storeId;
		}
	}
	</script>
    
</body>
</html>