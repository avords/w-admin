<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>选择商品</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				选择商品
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/product/addWelfarePlanPage?ajax=1" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<input type="hidden" name="welfareId" value="${welfareId }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_name">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">商品型号：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_LIKES_productModel">
                            </div>
                        </div>
					</div>
				</div>
				<div class="box-footer">
				<a href="javascript:addWelfarePlan();" class="btn btn-primary pull-left"> 确认
                </a>
				    选中的商品是否参加福利计划：
				    <input type="radio" name="isWelfarePlan" value="1">是
				    <input type="radio" name="isWelfarePlan" value="0" checked="checked">否
					
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="addWelfarePlanPage?ajax=1">
			<jdf:export view="csv" fileName="productCompanyExclusive.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="productCompanyExclusive.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="checkid" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
				<jdf:column property="objectId" title="ID" headerStyle="width:10%;" />
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;" />
				<jdf:column property="productNo" title="商品货号" headerStyle="width:15%;" />
				<jdf:column property="productModel" title="商品型号" headerStyle="width:15%;" />
				<jdf:column property="name" title="商品名称" headerStyle="width:20%;" />
				<jdf:column property="category.name" title="商品分类" headerStyle="width:15%;">
				    ${currentRowObject.category.firstName}-${currentRowObject.category.secondName}-${currentRowObject.category.name}
				</jdf:column>
				<jdf:column property="sellPrice" title="商品价格" headerStyle="width:15%;" />
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
    $("#checkall").click( 
        function(){ 
            if(this.checked){ 
                $("input[name='checkid']").each(function(){this.checked=true;}); 
            }else{ 
                $("input[name='checkid']").each(function(){this.checked=false;}); 
            } 
    });
    function addWelfarePlan(){
    	var value = $("input[name='isWelfarePlan']:checked").val();
    	var ids = getIds();
    	$.ajax({
            url:"${dynamicDomain}/product/addWelfarePlan",
            type : 'post',
            dataType : 'json',
            data:{'itemIds':ids,'value':value,'welfareId':'${welfareId}'},
            success : function(json) {
                    parent.winAlertReload(json.message);
                    parent.$.colorbox.close();
            }
        });
    }
	</script>
</body>
</html>