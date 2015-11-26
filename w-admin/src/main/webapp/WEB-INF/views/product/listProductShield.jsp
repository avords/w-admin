<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业商品销售范围配置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">企业商品销售范围配置</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productShield/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">一级分类：</label>
								<div class="col-sm-7">
									<select name="search_EQS_firstId" id="category1" class="form-control">
										<option value="">—全部—</option>
										<jdf:selectCollection items="firstCategory" optionValue="firstId" optionText="name"/>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">二级分类：</label>
								<div class="col-sm-7">
	                                <select name="search_EQS_secondId" id="category2" class="form-control">
	                                </select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">三级分类：</label>
								<div class="col-sm-7">
                                	<select name="search_LIKES_categoryId" id="category3" class="form-control">
                                	</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">供应商编号：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_supplierNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">供应商名称：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_supplierName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">商品名称：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_productName">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">商品货号：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_productNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">面向企业名称：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">商品品牌：</label>
								<div class="col-sm-7">
									<input type="text" class="search-form-control"
										name="search_LIKES_chineseName">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">生活服务：</label>
								<div class="col-sm-7">
									<select name="search_LIKES_lifeServiceId" id="lifeService" class="form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1115" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<a href="${dynamicDomain}/productShield/create" class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
						</a>
						<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
							<button type="submit" class="btn btn-primary">查询</button>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="ProductShield.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="ProductShield.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 8%">
                    <a href="${dynamicDomain}/productShield/edit/${currentRowObject.COMPANY_ID}" class="btn btn-primary btn-mini"> 
                    	<i class="glyphicon glyphicon-pencil"></i>
                    </a>
                    <a  href="javascript:toDeleteUrl('${dynamicDomain}/productShield/delete/${currentRowObject.COMPANY_ID}')"  class="btn btn-danger btn-mini"> 
                    	<i class="glyphicon glyphicon-trash"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" sortable="false">
                    <span title="${currentRowObject.COMPANY_NAME}" class="con">${currentRowObject.COMPANY_NAME}</span>
                </jdf:column>
                <jdf:column property="shieldSupplier" title="屏蔽供应商" headerStyle="width:15%;" sortable="false">
                    <span title="${currentRowObject.SUPPLIER}" class="con">${currentRowObject.SUPPLIER}</span>
                </jdf:column>
                <jdf:column property="shieldBrand" title="屏蔽品牌" headerStyle="width:15%;" sortable="false">
                    <span title="${currentRowObject.BRAND}" class="con">${currentRowObject.BRAND}</span>
                </jdf:column>
                <jdf:column property="shieldCategory" title="屏蔽商品分类" headerStyle="width:10%;" sortable="false">
                    <span title="${currentRowObject.CATAGORY}" class="con">${currentRowObject.CATAGORY}</span>
                </jdf:column>
                <jdf:column property="shieldProductCount" title="屏蔽商品数量" headerStyle="width:5%;" sortable="false">${currentRowObject.PRODUCTCOUNT}
                </jdf:column>
                <jdf:column property="shieldPackageCount" title="屏蔽套餐数量" headerStyle="width:5%;" sortable="false">${currentRowObject.PACKAGECOUNT}
                </jdf:column>
                <jdf:column property="shieldLifeService" title="屏蔽生活服务" headerStyle="width:10%;" sortable="false">
                    <span title="${currentRowObject.LIFESERVICE}" class="con">${currentRowObject.LIFESERVICE}</span>
                </jdf:column>
            </jdf:row>
        </jdf:table>
	</div>
	
    <script type="text/javascript">
    function getIds(){
        var content = '';
        $(".option:checked").each(function(){
            content =content+$(this).val()+",";
        });
        if(content.indexOf(",")>0){
            content =content.substring(0,content.length-1);
        }
        return content;
    }
    function upProduct(){
       var ids = getIds();
       var url = "${dynamicDomain}/sku/upProduct?skuIds="+ids;
       window.location.href = url;
    }
    function downProduct(){
        var ids = getIds();
        var url = "${dynamicDomain}/sku/downProduct?skuIds="+ids;
        window.location.href = url;
    }
    function deleteProduct(){
        var ids = getIds();
        var url = "${dynamicDomain}/sku/deleteProduct?skuIds="+ids;
        window.location.href = url;
    }
    $("#checkall").click( 
            function(){ 
                if(this.checked){ 
                    $("input[name='checkid']").each(function(){this.checked=true;}); 
                }else{ 
                    $("input[name='checkid']").each(function(){this.checked=false;}); 
                } 
        });
    
    $(function(){
    	$("#category1").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/productCategory/secondCategory/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#category2").children().remove();
                        $("#category2").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.secondCategory.length; i++) {
                            $("#category2").append("<option value='" + json.secondCategory[i].secondId + "'>" + json.secondCategory[i].name + "</option>");
                        }
                        $("#category2").val('${param.search_EQS_secondId}').change();
                    }
                });
            }
         }).change();

        $("#category2").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/productCategory/thirdCategory/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#category3").children().remove();
                        $("#category3").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.thirdCategory.length; i++) {
                            $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
                        }
                        $("#category3").val('${param.search_LIKES_categoryId}').change();
                    }
                });
            }
         }).change();
        //省略号显示
        $(".con").each(function(){
        	var value = $(this).text();
        	var content = value;
        	if(value.length>=20){
        		content = content.substring(0,41)+"...";
        	}
        	$(this).text(content);
        });
    });
    </script>	
</body>
</html>