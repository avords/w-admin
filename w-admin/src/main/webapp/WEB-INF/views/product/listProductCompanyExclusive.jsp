<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业专属商品设置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">企业专属商品设置</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productCompanyExclusive/page" method="post"
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
									<select name="search_EQL_categoryId" id="category3" class="form-control">
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
					</div>
					<div class="box-footer">
						<a href="${dynamicDomain}/productCompanyExclusive/create" class="pull-left btn btn-primary">
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
            <jdf:export view="csv" fileName="ProductCompanyExclusive.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="ProductCompanyExclusive.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 4%;text-align:center">
                    <a  href="javascript:toDeleteUrl('${dynamicDomain}/productCompanyExclusive/delete/${currentRowObject.OBJECT_ID}')"  class="btn btn-danger btn-mini"> 
                    	<i class="glyphicon glyphicon-trash"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="companyname" title="企业名称" headerStyle="width:10%;" >${currentRowObject.COMPANYNAME}
                </jdf:column>
                <jdf:column property="productno" title="商品货号" headerStyle="width:10%;" >
                <a href="${dynamicDomain}/product/view/${currentRowObject.PRODUCTID}">
                       ${currentRowObject.PRODUCTNO}
                 </a>
                </jdf:column>
                <jdf:column property="productname" title="商品名称" headerStyle="width:10%;" >
                <a href="${dynamicDomain}/product/view/${currentRowObject.PRODUCTID}">
                       ${currentRowObject.PRODUCTNAME}
                 </a>
                </jdf:column>
                <jdf:column property="categoryname" title="商品分类" headerStyle="width:10%;" >${currentRowObject.CATEGORYNAME}
                </jdf:column>
                <jdf:column property="operateuser" title="操作人" headerStyle="width:10%;" >${currentRowObject.OPERATEUSER}
                </jdf:column>
                <jdf:column property="operatetime" title="操作时间" headerStyle="width:10%;">
                   <c:if test="${!empty currentRowObject.OPERATETIME}">
                    <fmt:formatDate value="${currentRowObject.OPERATETIME}" pattern="yyyy-MM-dd HH:mm:ss"/>
                   </c:if>
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