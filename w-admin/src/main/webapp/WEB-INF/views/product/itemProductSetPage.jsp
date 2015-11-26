<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>项目分类商品列表</title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <h4 class="modal-title">项目分类商品列表</h4>
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/product/welfarePlan/${welfareId}" method="post"
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
                                <label class="col-sm-4 control-label">商品类型：</label>
                                <div class="col-sm-8">
                                    <select name="search_EQI_type" id="type" class="form-control">
                                         <option value="">—全部—</option>
                                         <jdf:select dictionaryId="1103"/>
                                    </select>
                                </div>
                            </div>
                        </div>
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
                                <label class="col-sm-4 control-label">参与福利计划：</label>
                                <div class="col-sm-8">
                                    <select name="search_EQI_isWelfarePlan" class="search-form-control"  id="isWelfarePlan">
                                        <option value="">—请选择—</option>
                                        <jdf:select dictionaryId="109"/>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <a href="${dynamicDomain}/product/addWelfarePlanPage?ajax=1&welfareId=${welfareId}"
                            class="pull-left btn btn-primary colorbox-double-template">选择商品
                        </a>
                        <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="deleteProducts();">移除商品</a>
                        <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="setWelfarePlan('1');">参与福利计划</a>
                        <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="setWelfarePlan('0');">不参与福利计划</a>
                        <div class="pull-right">
                            <button type="button" class="btn" onclick="window.location.href='${dynamicDomain}/welfare/itemGoodsSetPage'">返回
                            </button>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/product/welfarePlan/${welfareId}">
            <jdf:export view="csv" fileName="项目分类商品列表.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="项目分类商品列表.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="checkid" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="type" title="商品类型" headerStyle="width:9%;" >
                    <jdf:columnValue dictionaryId="1103" value="${currentRowObject.type}" />
                </jdf:column>
                <jdf:column property="category" title="商品类别" headerStyle="width:5%;" sortable="false">
                  ${currentRowObject.category.firstName}-${currentRowObject.category.secondName}-${currentRowObject.category.name}
                </jdf:column>
                <jdf:column property="name" title="商品名称" sortable="false" headerStyle="width:9%;" >
                    <a href="${dynamicDomain}/product/view/${currentRowObject.objectId}">
                       ${currentRowObject.name}
                   </a>
                </jdf:column>
                <jdf:column property="supplyPrice" title="供货价" sortable="false" headerStyle="width:9%;" >${currentRowObject.supplyPrice}
                </jdf:column>
                <jdf:column property="marketPrice" title="市场价" sortable="false" headerStyle="width:9%;" >${currentRowObject.marketPrice}
                </jdf:column>
                <jdf:column property="sellPrice" title="销售价" sortable="false" headerStyle="width:9%;" >${currentRowObject.sellPrice}
                </jdf:column>
                <jdf:column property="isWelfarePlan" title="是否参与福利计划" sortable="false" headerStyle="width:5%;" >
                    <jdf:columnValue dictionaryId="109" value="${currentRowObject.isWelfarePlan}" />
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
    function setWelfarePlan(value){
    	var ids = getIds();
        var url = "${dynamicDomain}/product/setWelfarePlan?value="+value+"&itemIds="+ids+"&welfareId=${welfareId}";
        window.location.href = url;
    }
    function deleteProducts(){
        var ids = getIds();
        var url = "${dynamicDomain}/product/deleteWelfarePlan?itemIds="+ids+"&welfareId=${welfareId}";
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
                        $("#category3").val('${param.search_EQL_categoryId}').change();
                    }
                });
            }
         }).change();
    });
    </script>
</body>
</html>