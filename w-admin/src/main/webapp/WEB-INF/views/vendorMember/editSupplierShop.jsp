<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商门店管理</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					供应商门店
					<c:choose>
						<c:when test="${entity.objectId eq null }">新增</c:when>
						<c:otherwise>修改</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<form method="post" action="${dynamicDomain}/vendorSupplierShop/save" id="SupplierShop" class="form-horizontal">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierId" class="col-sm-4 control-label">供应商</label>
								<div class="col-sm-8">
									${supplierName}
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="shopType" class="col-sm-4 control-label">供应商类型</label>
								<div class="col-sm-8">
								<c:forEach items="${supplierTypes}" var="item" varStatus="status">
									<input type="radio" name="shopType" value="${item.typeId}"><jdf:columnValue dictionaryId='1314' value='${item.typeId}' />
								</c:forEach>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierShopNo" class="col-sm-4 control-label">供应商内部门店代号</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="supplierShopNo">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="shopName" class="col-sm-4 control-label">门店名称</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="shopName">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone" class="col-sm-4 control-label">门店联系电话</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="telephone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-8">
							<div class="form-group">
								<label for="areaId" class="col-sm-3 control-label">门店地址</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${area.areaId}" district="areaId" styleClass="form-control inline" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="" class="col-sm-4 control-label"></label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="address">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="remarks" class="col-sm-4 control-label">门店备注</label>
								<div class="col-sm-8">
									<textarea rows="3" cols="36" name="remarks" class="search-form-control"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row" id="content" >
                        <div class="col-sm-12 col-md-12">
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="details">门店详情</label>
                                <div class="col-sm-10">
                                    <textarea name="details" id="txt" class="search-form-control"></textarea>
	                             <script type="text/javascript">
	                          	  window.onload = function(){
		                                CKEDITOR.replace( 'txt',{
		                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
		                                });
		                            };
	                      		 </script>
                                </div>
                            </div>
                        </div>
                    </div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="isValid" class="col-sm-4 control-label">是否有效</label>
								<div class="col-sm-8">
									<jdf:radio dictionaryId="1319" name="isValid" />
								</div>
							</div>
						</div>
					</div>
					
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">保存</button>
								<a href="${dynamicDomain}/vendorSupplierShop/page">
									<button type="button" class="btn">返回</button>
								</a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
<jdf:bootstrapDomainValidate domain="SupplierShop"/>
<script type="text/javascript">
$("#shopType").bind("change",function(){
    if($(this).val()){
        $.ajax({
            url:"${dynamicDomain}/supplierShop/getSuppliers/" + $(this).val(),
            type : 'post',
            dataType : 'json',
            success : function(json) {
                $("#supplierId").children().remove();
                $("#supplierId").append("<option value=''>—请选择—</option>");
                for ( var i = 0; i < json.suppliers.length; i++) {
                    $("#supplierId").append("<option value='" + json.suppliers[i].objectId + "'>" + json.suppliers[i].supplierName + "</option>");
                }
                $("#supplierId").val('${category.objectId}');
            }
        });
    }
}).change();

</script>
</body>
</html>