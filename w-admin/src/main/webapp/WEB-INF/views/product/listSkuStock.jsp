<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品库存管理" /></title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="商品库存管理" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/sku/stockPage" method="post" class="form-horizontal">
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
                                <input type="checkbox" name="isSearchWarning" value="1">库存预警
                                <input type="checkbox" name="isGroup" value="1">查询整组
                                    </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                     <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="submitStock();" validateMethod="verification()">提交库存
<!--                         <button type="button" class="btn btn-primary">提交库存 -->
<!--                         </button> -->
                    </a>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="stockPage">
            <jdf:export view="csv" fileName="商品库存管理.csv" tooltip="导出CSV"
                imageName="csv" />
            <jdf:export view="xls" fileName="商品库存管理.xls" tooltip="导出EXCEL"
                imageName="xls" />
            <jdf:row>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:2%;text-align:center" headerStyle="width:2%;"/>
                <jdf:column property="checkStatus" title="商品状态" headerStyle="width:5%;">
                  <jdf:columnValue dictionaryId="1108" value="${currentRowObject.checkStatus}" />
                </jdf:column>
                <jdf:column property="supplierName" title="供应商名称" headerStyle="width:5%;"/>
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
                  <c:choose>
                      <c:when test="${currentRowObject.type==3}">
                          <a href="${dynamicDomain}/product/importStockPage?ajax=1&skuId=${currentRowObject.objectId}" class="colorbox-big">
                              <jdf:columnValue dictionaryId="1101" value="${currentRowObject.type}" />
                          </a>
                      </c:when>
                      <c:otherwise>
                          <jdf:columnValue dictionaryId="1103" value="${currentRowObject.type}" />
                      </c:otherwise>
                  </c:choose>
                </jdf:column>
                <jdf:column property="category" title="商品类别" headerStyle="width:5%;" sortable="false">
                  ${currentRowObject.category.firstName}-${currentRowObject.category.secondName}-${currentRowObject.category.name}
                </jdf:column>
                <jdf:column property="attributeValue1" title="属性1" headerStyle="width:2%;" />
                <jdf:column property="attributeValue2" title="属性2" headerStyle="width:2%;" />
                <jdf:column property="attr" title="增加库存" headerStyle="width:2%;text-align:center" sortable="false">
                 <c:if test="${currentRowObject.type!=3}">
                    <input name="skuObjectId" type="hidden" value="${currentRowObject.objectId}"/>
                    <input name="addStock" style="width: 50px;"/>
                  </c:if>
                </jdf:column>
                <jdf:column property="stock" title="总库存" headerStyle="width:2%;" viewsAllowed="html">
                   <c:choose>
                     <c:when test="${currentRowObject.stock<currentRowObject.safetyStock}">
                       <span style="color:red;">${currentRowObject.stock}</span>
                     </c:when>
                     <c:otherwise>
                       <span>${currentRowObject.stock}</span>
                     </c:otherwise>
                   </c:choose>
                </jdf:column>
                <jdf:column property="1" title="总库存" headerStyle="width:2%;" viewsDenied="html">
                       ${currentRowObject.stock}
                </jdf:column>
                <jdf:column property="safetyStock" title="安全库存" headerStyle="width:2%;" />
                <jdf:column property="sellPrice" title="商品价格" headerStyle="width:2%;" />
                <jdf:column property="product.releaseType" title="发布类型" headerStyle="width:5%;">
                  <jdf:columnValue dictionaryId="1106" value="${currentRowObject.product.releaseType}" />
                </jdf:column>
            </jdf:row>
        </jdf:table>
        </div>
        <script type="text/javascript">
        function submitStock(){
        	if(verification()){
        		var stockArray = new Array();
        		var idArray = new Array();
	            $(".tableBody input[name='addStock']").each(function(){
	            	var addStock = $(this);
	            	if(addStock.val()!=null&&addStock.val()!=''){
	            		stockArray.push(addStock.val());
                        idArray.push(addStock.prev().val());
	            	}
	            });
	            var skuIds = '';
	            var addStocks = '';
	            for(var i=0;i<stockArray.length;i++){
	            	skuIds = skuIds+idArray[i]+',';
	            	addStocks = addStocks+stockArray[i]+',';
	            }
	            if(addStocks.indexOf(",")>0){
	            	skuIds =skuIds.substring(0,skuIds.length-1);
	            	addStocks =addStocks.substring(0,addStocks.length-1);
	            }
	            if(addStocks.length==0){
	            	winAlert('请填写要增加的库存!');
	            	return false;
	            }
	            window.location.href='${dynamicDomain}/sku/addStock?skuIds='+skuIds+'&addStocks='+addStocks;
        	}
        }
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
                            $("#category2").val('${search_EQS_secondId}').change();
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
                            $("#category3").val('${search_EQS_categoryId}').change();
                        }
                    });
                }
             }).change();
            
            $(".colorbox-big").colorbox({
                opacity : 0.2,
                fixed : true,
                width : "65%",
                height : "90%",
                iframe : true,
                close:"",
                onClosed : function() {
                    if (false) {
                        location.search=location.search.replace(/message.*&/,"");
                    }
                },
                overlayClose : false
            });
        });
        
        function verifiStock(){
        	var addSto = new Array();
            $("input[name='addStock']").each(function(){
                //addSto.push($(this).val());
                var addStock = $(this);
                if(addStock.val()!=null&&addStock.val()!=''){
                	addSto.push(addStock.val());
                }
            });
            for(var i=0;i<addSto.length;i++){
                if(!/^-?\d+$/.test(addSto[i])){
                    winAlert('库存必须为整数');
                    return false;
                }
            }
            if(addSto.length==0){
                winAlert('请填写要增加的库存!');
                return false;
            }
            return true;
        }
        function verification(){
        	var flag = verifiStock();
            return flag;
        }
        </script>
</body>
</html>