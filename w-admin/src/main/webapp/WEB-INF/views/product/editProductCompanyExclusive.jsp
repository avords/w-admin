<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>添加设置</title>
<style>
.checkbox-lineh{
margin-top:10px;
}
.product-standard{
height: 50px;
}
.attribute-remark{
 width: 50px;
}
.attribute-value span{
margin-right: 0px;
}
.attribute-value .attValItem{
margin-right: 10px;
}
table th{
text-align: center;
}
table tbody tr td input{
width: 60px;
}
.detail-picture img{
margin-right: 10px;
}
.attValue{
width: 20px;
margin-right: 0px;
}
.noBorder{
border-left: 0;
border-right: 0;
border-top: 0;
border-bottom: 0;
}
.welfare-div{
margin-top: 10px;
}
.welfare-tag{
background-color: white;
border: 1px solid black;
outline:none;
}
.welfare-tag-border{
border: 1px solid red;
}
</style>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		<jdf:form bean="entity" scope="request">
			        <form method="post" action="${dynamicDomain}/productCompanyExclusive/save" class="form-horizontal" id="editForm" onsubmit="return verification();">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title">添加设置</h4>
			        </div>
                    <input type="hidden" name="objectId">
                    <input type="hidden" name="releaseType" value="1">
                    <input type="hidden" name="checkStatus" id="checkStatus">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="companyName" class="col-sm-2 control-label">选择企业</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/company/companyPublishTemplate?ajax=1&inputName=productCompanyExclusiveForm.company"
											class="pull-left btn btn-primary colorbox-template">选择
										</a>
									</div>
									<div class="col-sm-6">
										<input type="text" class="search-form-control" name="productCompanyExclusiveForm.companyName"> 
										<input type="hidden" class="search-form-control" name="productCompanyExclusiveForm.companyId">
									</div>
								</div>
                            </div>
                        </div>
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="products" class="col-sm-2 control-label">专属商品</label>
									<div class="col-sm-1">
										<a href="${dynamicDomain}/product/productCompanyExclusiveTemplate?ajax=1&inputName=products"
											class="pull-left btn btn-primary colorbox-double-template">添加
										</a>
									</div>
								</div>								
							</div>                               
                        </div>                                                 
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <table border="1" style="width: 100%;" >
                                  <thead>
                                     <tr>
                                         <th>操作</th><th>序号</th><th>供应商名称</th><th>商品货号</th><th>商品名称</th>
                                         <th>商品类别</th><th>商品价格</th>
                                     </tr>
                                  </thead>
                                  <tbody id="products">
                                  </tbody>
                                </table>
                            </div>
                        </div>                        
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="submit" class="btn btn-primary">确定
                                </button>
                                <a href="${dynamicDomain}/productCompanyExclusive/page" class="btn btn-primary">返回</a>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="ProductCompanyExclusive"/>

	<script type="text/javascript">
	function del(divId) {
		$("#"+divId).remove();
	}
	function verifiEmpty(){
        var companyId = $("input[name='productCompanyExclusiveForm.companyId']").val();
        if(companyId==''){
            winAlert('企业不能为空!');
            return false;
        }
        var products = $('#products').text();
        if(/^\s*$/.test(products)){
            winAlert('专属不能为空！');
            return false;
        }
        return true;
    }
    function verification(){
        var flag = verifiEmpty();
        return flag;
    }
	</script>
</body>
</html>