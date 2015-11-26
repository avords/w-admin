<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>面向企业套餐价格设置</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">面向企业套餐价格设置</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfareCompanyPrice/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">				
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
								<label class="col-sm-4 control-label">项目名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_itemName">
								</div>
							</div>
						</div>	
						<div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">套餐名称：</label>
                                <div class="col-sm-8">
                                    <input type="text" class="search-form-control"
                                        name="search_LIKES_packageName">
                                </div>
                            </div>
                        </div>					
					</div>
					<div class="row">						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_packageNo">
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<a href="${dynamicDomain}/welfareCompanyPrice/create" class="btn btn-primary pull-left">
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
request.getSession().setAttribute("action", "/welfareCompanyPrice/page");
%>
	<div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="Productcompanyprice.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="Productcompanyprice.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 4%">
                    <a href="${dynamicDomain}/welfareCompanyPrice/edit/${currentRowObject.OBJECTID}" class="btn btn-primary btn-mini"> 
                    	<i class="glyphicon glyphicon-pencil"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="itemname" title="项目名称" headerStyle="width:9%;" >${currentRowObject.ITEMNAME}
                </jdf:column>
                <jdf:column property="packageno" title="套餐编号" headerStyle="width:9%;" >${currentRowObject.PACKAGENO}
                </jdf:column>
                <jdf:column property="packagename" title="套餐名称" headerStyle="width:9%;" >${currentRowObject.PACKAGENAME}
                </jdf:column>
                <jdf:column property="stocktype" title="库存类型" headerStyle="width:9%;" >
                    <jdf:columnValue dictionaryId="1606"  value="${currentRowObject.STOCKTYPE}" />
                </jdf:column>
                <jdf:column property="companyname" title="企业名称" headerStyle="width:9%;" >${currentRowObject.COMPANYNAME}
                </jdf:column>
                <jdf:column property="companyprice" title="企业价格" headerStyle="width:5%;" >${currentRowObject.COMPANYPRICE}
                </jdf:column>
                <jdf:column property="familyprice" title="家属价格" headerStyle="width:5%;" >${currentRowObject.FAMILYPRICE}
                </jdf:column>
                <jdf:column property="username" title="更新人" headerStyle="width:8%;" >${currentRowObject.USERNAME}
                </jdf:column>
                <jdf:column property="updatedate" title="更新时间" headerStyle="width:12%;" >${currentRowObject.UPDATEDATE}
                </jdf:column>
            </jdf:row>
        </jdf:table>
	</div>
</body>
</html>