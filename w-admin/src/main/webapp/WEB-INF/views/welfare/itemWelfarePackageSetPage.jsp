<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>项目分类套餐列表</title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <h4 class="modal-title">项目分类套餐列表</h4>
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/welfarePackage/welfarePlan/${welfareId}" method="post"
                class="form-horizontal">
                <div class="box-body">
                   <div class="row">               
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">项目类型：</label>
                                <div class="col-sm-8">
                                    <select name="search_EQI_itemType" class="search-form-control"  id="itemType">
                                        <option value="" >全部</option>
                                        <jdf:select dictionaryId="1600" valid="true" />
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">项目大类：</label>
                                <div class="col-sm-8">
                                    <select name="search_EQI_bigItemId"  id="bigItems" class="search-form-control">
                                        <option value="" >全部</option>
                                    </select>
                                </div>
                            </div>
                        </div>  
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">项目分类：</label>
                                <div class="col-sm-8">
                                    <select name="search_EQI_subItemId"  id="subItems" class="search-form-control">
                                        <option value="" >全部</option>
                                    </select>
                                </div>
                            </div>
                        </div>                  
                    </div>
                    <div class="row"> 
                        <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                    <label  class="col-sm-4 control-label">套餐类型:</label>
                                    <div class="col-sm-8">
                                        <select  name="search_EQI_wpCategoryType" class="search-form-control">
                                            <option value="">--请选择--</option>
                                            <jdf:select dictionaryId="1602" valid="true" />
                                        </select>
                                    </div>
                                </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                    <label  class="col-sm-4 control-label">套餐名称:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="search-form-control" name="search_LIKES_packageName">
                                    </div>
                                </div>
                        </div> 
                        <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                    <label  class="col-sm-4 control-label">套餐编号:</label>
                                    <div class="col-sm-8">
                                        <input type="text" class="search-form-control" name="search_LIKES_packageNo">
                                    </div>
                                </div>
                            </div>   
                    </div>
                    <div class="row">    
                        <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                    <label  class="col-sm-4 control-label">商品类型:</label>
                                    <div class="col-sm-8">
                                        <select  name="search_EQI_stockType" class="search-form-control">
                                            <option value="">--请选择--</option>
                                            <jdf:select dictionaryId="1606" valid="true" />
                                        </select>
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
                        <a href="${dynamicDomain}/welfarePackage/addWelfarePlanPage?ajax=1&welfareId=${welfareId}"
                            class="pull-left btn btn-primary colorbox-double-template">选择套餐
                        </a>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/welfarePackage/welfarePlan/${welfareId}">
            <jdf:export view="csv" fileName="项目分类套餐列表.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="项目分类套餐列表.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="checkid" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="wpCategoryType" title="套餐类型" sortable="false" headerStyle="width:9%;" >
                    <jdf:columnValue dictionaryId="1602" value="${currentRowObject.wpCategoryType}" />
                </jdf:column>
                <jdf:column property="itemName" title="项目" sortable="false" style="width:10%" />
                <jdf:column property="packageNo" title="套餐编号" sortable="false" style="width:8%" >
                </jdf:column>   
                <jdf:column property="packageName" title="套餐名称" sortable="false" style="width:12%" >
                  <a href="${dynamicDomain}/welfarePackage/view/${currentRowObject.objectId}"> 
                    ${currentRowObject.packageName}
                </a>
                </jdf:column>
                <jdf:column property="packagePrice" title="售价" sortable="false" headerStyle="width:9%;" >${currentRowObject.packagePrice}
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
        var url = "${dynamicDomain}/welfarePackage/setWelfarePlan?value="+value+"&itemIds="+ids+"&welfareId=${welfareId}";
        window.location.href = url;
    }
    
    $(document).ready(function () {
        //一级下拉联动二级下拉
        $("#itemType").change(function () {
            var value = $("#itemType").val();
            //清除二级下拉列表
            $("#bigItems").empty();
            $("#bigItems").append($("<option/>").text("全部").attr("value",""));
            //要请求的二级下拉JSON获取页面
            $.ajax({
                url: "${dynamicDomain}/welfare/getItems/"+value,
                type : 'post',
                dataType : 'json',
                success :function (data) {
                 //对请求返回的JSON格式进行分解加载
                  for(var i=0;i<data.items.length;i++){
                    //alert(data.items[i].objectId );
                        $("#bigItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
                  }
                  $("#bigItems").val('${param.search_EQI_bigType}').change();
                }
            });
        }).change(); 
        $("#bigItems").change(function () {
            var value = $("#bigItems").val();
            //清除二级下拉列表
            $("#subItems").empty();
            $("#subItems").append($("<option/>").text("全部").attr("value",""));
            //要请求的二级下拉JSON获取页面
            $.ajax({
                url: "${dynamicDomain}/welfare/getSubItems/"+value,
                type : 'post',
                dataType : 'json',
                success :function (data) {
                 //对请求返回的JSON格式进行分解加载
                  for(var i=0;i<data.items.length;i++){
                    //alert(data.items[i].objectId );
                        $("#subItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
                  }
                  $("#subItems").val('${param.search_EQI_itemCategory}').change();
                }
            });
        }).change(); 
        
        $("#checkall").click( 
                function(){ 
                    if(this.checked){ 
                        $("input[name='checkid']").each(function(){this.checked=true;}); 
                    }else{ 
                        $("input[name='checkid']").each(function(){this.checked=false;}); 
                    } 
            });
    });
    </script>
</body>
</html>