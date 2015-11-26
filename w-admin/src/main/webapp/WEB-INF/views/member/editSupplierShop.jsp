<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商门店管理</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<style>
.upView {
  margin: 7px 0 0 0;
}
</style>
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
			<form method="post" action="${dynamicDomain}/supplierShop/save" id="SupplierShop" class="form-horizontal">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="shopType" class="col-sm-4 control-label">供应商类型</label>
								<div class="col-sm-8">
									<select name="shopType" id="shopType"
										class="search-form-control">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1314" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierId" class="col-sm-4 control-label">供应商</label>
								<div class="col-sm-8">
									<select name="supplierId" id="supplierId" class="search-form-control">
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="supplierShopNo" class="col-sm-4 control-label">供应商内部门店代号</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="supplierShopNo" id="supplierShopNo">
								</div>
							</div>
						</div>
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
									<input type="text" class="search-form-control" name="telephone" maxlength="50">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="areaId" class="col-sm-2 control-label">门店地址</label>
								<div class="col-sm-5">
									<ibs:areaSelect code="${entity.areaId}" district="areaId" styleClass="form-control inline" />
								</div>
                                <div class="col-sm-5">
                                  <input type="text" class="search-form-control" name="address" placeholder="请输入详细地址" >
                                </div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="remarks" class="col-sm-2 control-label">门店备注</label>
								<div class="col-sm-10">
									<textarea rows="3" cols="36" name="remarks" class="search-form-control" placeholder="请输入预约到达时间提示，以及检前注意事项说明"></textarea>
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
	                                	height:200,
	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
	                                });
	                            };
                      		 	</script>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                      <div class="col-sm-12 col-md-12">
                        <div class="form-group">
                          <label for="shopImage" class="col-sm-2 control-label">门店主图 </label>
                          <div class="col-sm-2">
                            <input type="hidden" name="shopImage" id="shopImage">
                            <img alt="" class="logoImg" height="100px" width="100px">
                          </div>
                        </div>
                      </div>
                    </div>
                    <div class="row">
                      <div class="col-sm-12 col-md-12">
                        <div class="form-group">
                          <label for="" class="col-sm-2 control-label"></label>
                          <div class="col-sm-3">
                            <input type="file" class="search-form-control img_type" style="display: inline;" name="uploadFile1" id="uploadFile1">
                          </div>
                          <div class="col-sm-1 upView">
                            <input type="button" value="上传" style="display: inline;" onclick="ajaxFileUpload1();" id="uploadButton1">
                          </div>
                        </div>
                      </div>
                    </div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="isValid" class="col-sm-4 control-label">是否有效</label>
								<div class="col-sm-8">
									<%--
									<jdf:radio dictionaryId="1319" name="isValid" />
									 --%>
									<label><input type="radio" name="isValid" id="isValid1" value="1" <c:if test="${entity.isValid!=1}"> checked </c:if> >是</label>
									<label><input type="radio" name="isValid" id="isValid2" value="2" <c:if test="${entity.isValid==2}"> checked </c:if> >否</label>
								</div>
							</div>
						</div>
					</div>
					
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" id="btn" class="btn btn-primary">保存</button>
								<a href="${dynamicDomain}/supplierShop/page" class="btn btn-default">返回</a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
<jdf:bootstrapDomainValidate domain="SupplierShop" index="0"/>
<script type="text/javascript">
$("#shopType").bind("change",function(){
    if($(this).val()){
        $.ajax({
            url:"${dynamicDomain}/supplierShop/getSuppliers/" + $(this).val(),
            type : 'post',
            dataType : 'json',
            success : function(json) {
                $("#supplierId").children().remove();
                var ID="${supplierId}";
                if(ID!=null && ID!=""){
                	for ( var i = 0; i < json.suppliers.length; i++) {
                		if(ID==json.suppliers[i].objectId){
                			$("#supplierId").append("<option value='" +ID+ "'>" + json.suppliers[i].supplierName + "</option>");
                			break;
                		}
                    }
                	for ( var i = 0; i < json.suppliers.length; i++) {
                		if(ID!=json.suppliers[i].objectId){
                			$("#supplierId").append("<option value='" +json.suppliers[i].objectId+ "'>" + json.suppliers[i].supplierName + "</option>");
                		}
                    }
                }else{
                	$("#supplierId").append("<option value=''>—请选择—</option>");
                	for ( var i = 0; i < json.suppliers.length; i++) {
                        $("#supplierId").append("<option value='" + json.suppliers[i].objectId + "'>" + json.suppliers[i].supplierName + "</option>");
                    }
                }
                $("#supplierId").val('${supplierId}');
            }
        });
    }
}).change();

$(document).ready(function() {
	refreshParentPage(true);
	var logoPath="${entity.shopImage}";
	$('img.logoImg').attr('src','${dynamicDomain}'+logoPath);
});

$(function(){
	
	//地址
	$("#btn").bind("click",function(){
		$("#errorA").css("display", "none");
		var area = $("#city").val();
		var errorA = "<label id=\"errorA\" class=\"validate_input_errorA\"><font color='red'>门店地址省市不能为空</font></label>";
		if (area == null || area=="") {
			$("#_areaId").after(errorA);
			$("#province").focus();
			return false;
		}
		
		//验证供应商内部门店代号的唯一性
		var supplierShopNo = $("#supplierShopNo").val();
		var shopType = $("#shopType").val();
		var supplierId = $("#supplierId").val();
		var objectId = '${entity.objectId}';
		$.ajax({
            url:"${dynamicDomain}/supplierShop/checkSupplierShopNo/",
            type : 'post',
            data : {'supplierShopNo':supplierShopNo,'objectId':objectId,'shopType':shopType,'supplierId':supplierId},
            dataType : 'json',
            success : function(json) {
            	var data = json.ret;
            	if (!data) {
            		alert("供应商内部门店代号已存在");
            		return false;
            	}else{
            		$("#SupplierShop").submit();
            	}
            }
        });
	});
});

function ajaxFileUpload1() { 
	var filePath = $('#uploadFile1').val();
	if(!filePath) {
        alert('请选择文件！');
        return ;
    }
	fileSuffix = /.[^.]+$/.exec(filePath);
	if (fileSuffix == ".jpg" || fileSuffix == ".bmp" || fileSuffix == ".png" || 
			fileSuffix == ".JPG" || fileSuffix == ".BMP" || fileSuffix == ".PNG") {
		$.ajaxFileUpload({  
            url: '${dynamicDomain}/supplierShop/uploadShopImage?ajax=1',  
            secureuri: false,  
            fileElementId: 'uploadFile1',  
            dataType: 'json',  
            success: function(json, status) {
                if(json.result){
                    var filePath = json.filePath;
                    $('input[name="shopImage"]').val(filePath);
                    $('img.logoImg').attr('src','${dynamicDomain}'+filePath);
                    $('#uploadButton1').val('重新上传');
                }else{
                	alert(json.msg);
                }
		        },error: function (data, status, e){//服务器响应失败处理函数
		           	alert(e);
		        }
        });
	} else {
		$("#uploadFile1").after(errorLo);
		$("#uploadFile1").focus();
		return false;
	}
return false;  
} 
</script>
</body>
</html>