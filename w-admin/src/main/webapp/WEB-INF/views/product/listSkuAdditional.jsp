<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="供应商商品发布" /></title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="供应商商品发布" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/sku/additionalPage" method="post"
                class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                 <label class="col-sm-4 control-label">一级分类：</label>
                                 <div class="col-sm-8">
	                                 <select name="search_EQS_firstId" id="category1" class="form-control">
	                                     <option value="">—全部—</option>
	                                     <jdf:selectCollection items="firstCategory" optionValue="firstId" optionText="name"/>
	                                </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                    <label class="col-sm-4 control-label">二级分类：</label>
                                <div class="col-sm-8">
	                                 <select name="search_EQS_secondId" id="category2" class="form-control">
	                                </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                    <label class="col-sm-4 control-label">三级分类：</label>
                                <div class="col-sm-8">
                                 <select name="search_EQL_categoryId" id="category3" class="form-control">
                                </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                    <label class="col-sm-4 control-label">供应商编号：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control"
                                    name="search_LIKES_supplierNo">
                               </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                    <label class="col-sm-4 control-label">供应商名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="search-form-control"
                                    name="search_LIKES_supplierName">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">商品类型：</label>
                                <div class="col-sm-8">
	                                <select name="search_EQI_type" id="type" class="form-control">
	                                     <option value="">—全部—</option>
	                                     <jdf:select dictionaryId="1103"/>
	                                </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">发布日期：</label>
                                <div class="col-sm-4">
                                <input class="search-form-control" type="text" 
                                        name="search_EQD_publishDate1" id="search_GED_createDate"
                                        onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_createDate\')}'})">
                                </div>
                                <div class="col-sm-4">
                                <input type="text" class="search-form-control"
                                        name="search_EQD_publishDate2" id="search_LED_createDate" 
                                        onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_createDate\')}'})">
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">发布类型：</label>
                                <div class="col-sm-8">
                                <select name="search_EQI_releaseType"  class="form-control">
                                     <option value="">—全部—</option>
                                     <jdf:select dictionaryId="1106"/>
                                </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">商品状态：</label>
                                <div class="col-sm-8">
                                <select name="search_EQI_checkStatus" class="form-control">
                                     <option value="">—全部—</option>
                                     <jdf:select dictionaryId="1108"/>
                                </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                 <label class="col-sm-4 control-label">商品名称：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control"
                                    name="search_LIKES_name">
                                    </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">商品编号：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="search-form-control"
                                    name="search_LIKES_skuNo">
                                    </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                 <label class="col-sm-4 control-label"></label>
                                <div class="col-sm-8">
                                	<label><input type="checkbox" name="isGroup" value="1">查询整组</label>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <%-- <a href="${dynamicDomain}/product/create" class="btn btn-primary pull-left">新增普通商品</a>
                    <a href="${dynamicDomain}/product/create?productType=insure" class="btn btn-primary pull-left">新增保险商品</a>
                    <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="upProduct();">上架</a>
                    <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="downProduct();">下架</a>
                    <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="deleteProduct();">删除</a> --%>
                    <div class="pull-right">
                        <button type="button" class="btn" onclick="clearForm(this)">
                                <i class="icon-remove icon-white"></i>重置
                         </button>
                        <button type="submit" class="btn btn-primary">查询
                        </button>
                    </div>
                </div>
            </form>
        </jdf:form>
    </div>

    <div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="additionalPage?message=">
            <jdf:export view="csv" fileName="商品发布(代理).csv" tooltip="导出CSV"
                imageName="csv" />
            <jdf:export view="xls" fileName="商品发布(代理).xls" tooltip="导出EXCEL"
                imageName="xls" />
            <jdf:row>
                 <jdf:column alias="" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="checkid" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
                <jdf:column alias="操作" title="操作" sortable="false" viewsAllowed="html"
                    style="width: 5%;text-align:center" headerStyle="width:5%;">
                 <a href="${dynamicDomain}/product/editAdditional/${currentRowObject.productId}"
                     class="btn btn-primary btn-mini"> <i
                     class="glyphicon glyphicon-pencil"></i>
                 </a>
                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" headerStyle="width:4%;"/>
                <jdf:column property="checkStatus" title="商品状态" headerStyle="width:5%;">
                  <jdf:columnValue dictionaryId="1108" value="${currentRowObject.checkStatus}" />
                </jdf:column>
                <jdf:column property="supplierName" title="供应商名称" headerStyle="width:5%;" />
                <jdf:column property="skuNo" title="商品编号" headerStyle="width:5%;" viewsAllowed="html">
                   <a href="${dynamicDomain}/product/view/${currentRowObject.productId}">
                       ${currentRowObject.skuNo}
                   </a>
                </jdf:column>
                <jdf:column property="1" title="商品编号" headerStyle="width:5%;" viewsDenied="html">
                       ${currentRowObject.skuNo}
                </jdf:column>
                <jdf:column property="name" title="商品名称" headerStyle="width:5%;" viewsAllowed="html">
                    <a href="${dynamicDomain}/product/view/${currentRowObject.productId}">
                       ${currentRowObject.name}
                   </a>
                </jdf:column>
                <jdf:column property="1" title="商品名称" headerStyle="width:5%;" viewsDenied="html">
                       ${currentRowObject.name}
                </jdf:column>
                <jdf:column property="type" title="商品类型" headerStyle="width:5%;">
                    <jdf:columnValue dictionaryId="1103" value="${currentRowObject.type}" />
                </jdf:column>
                <jdf:column property="category" title="商品类别" headerStyle="width:5%;" sortable="false">
                  ${currentRowObject.category.firstName}-${currentRowObject.category.secondName}-${currentRowObject.category.name}
                </jdf:column>
                <jdf:column property="attributeValue1" title="属性1" headerStyle="width:2%;" />
                <jdf:column property="attributeValue2" title="属性2" headerStyle="width:2%;" />
                <jdf:column property="sellPrice" title="商品价格" headerStyle="width:2%;" />
                <jdf:column property="releaseType" title="发布类型" headerStyle="width:5%;">
                  <jdf:columnValue dictionaryId="1106" value="${currentRowObject.product.releaseType}" />
                </jdf:column>
                <jdf:column property="updateUserName" title="修改人" headerStyle="width:5%;" />
                <jdf:column property="updatedOn" title="修改时间" headerStyle="width:5%;" cell="date" format="yyyy-MM-dd"/>
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
    	if(window.confirm('你确定要删除吗?')){
	        var ids = getIds();
	        var url = "${dynamicDomain}/sku/deleteProduct?skuIds="+ids;
	        window.location.href = url;
    	}
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
                        $("#category3").val('${param.search_EQL_categoryId}').change();
                    }
                });
            }
         }).change();
    });
    </script>
</body>
</html>