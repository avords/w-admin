<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>面向企业商品价格设置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">面向企业商品价格设置</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productCompanyPrice/page" method="post"
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
                                	<select name="search_EQI_type" class="form-control" id="search_EQI_type">
	                                	<option value="">—请选择—</option>
	                                	<jdf:select dictionaryId="1101"/>
                                	</select>									
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
								<label class="col-sm-4 control-label">面向企业名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
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
					</div>
					<div class="row">						
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
					<div class="box-footer">
						<a href="${dynamicDomain}/productCompanyPrice/create" class="pull-left btn btn-primary">
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
<%
request.getSession().setAttribute("action", "/productCompanyPrice/page");
%>
	<div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="Productcompanyprice.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="Productcompanyprice.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 4%">
                    <a href="${dynamicDomain}/productCompanyPrice/edit/${currentRowObject.OBJECTID}" class="btn btn-primary btn-mini"> 
                    	<i class="glyphicon glyphicon-pencil"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="status" title="商品状态" headerStyle="width:7%;" >
					<jdf:columnValue dictionaryId="1108" value="${currentRowObject.STATUS}" />
				</jdf:column>
                <jdf:column property="skuno" title="商品编号" headerStyle="width:7%;" >
                <a href="${dynamicDomain}/product/view/${currentRowObject.PRODUCTID}">
                     ${currentRowObject.SKUNO}
                </a>
                </jdf:column>
                <jdf:column property="productname" title="商品名称" headerStyle="width:11%;" >
                <a href="${dynamicDomain}/product/view/${currentRowObject.PRODUCTID}">
                     ${currentRowObject.PRODUCTNAME}
                </a>
                </jdf:column>
                <jdf:column property="companyname" title="面向企业" headerStyle="width:9%;" >${currentRowObject.COMPANYNAME}
                </jdf:column>
                <jdf:column property="attributevalue1" title="属性1" headerStyle="width:5%;" >${currentRowObject.ATTRIBUTEVALUE1}
                </jdf:column>
                <jdf:column property="attributevalue2" title="属性2" headerStyle="width:5%;" >${currentRowObject.ATTRIBUTEVALUE2}
                </jdf:column>
                <jdf:column property="sellprice" title="销售价（元）" headerStyle="width:7%;" >${currentRowObject.SELLPRICE}
                </jdf:column>
                <jdf:column property="companyprice" title="企业价格（元）" headerStyle="width:7%;" >${currentRowObject.COMPANYPRICE}
                </jdf:column>
                <jdf:column property="suppliername" title="供应商名称" headerStyle="width:9%;" >${currentRowObject.SUPPLIERNAME}
                </jdf:column>
                <jdf:column property="username" title="更新人" headerStyle="width:8%;" >${currentRowObject.USERNAME}
                </jdf:column>
                <jdf:column property="updatedate" title="更新时间" headerStyle="width:12%;" >${currentRowObject.UPDATEDATE}
                </jdf:column>
            </jdf:row>
        </jdf:table>
	</div>
	
	<script type="text/javascript">
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