<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品分类属性管理" /></title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="商品分类属性管理" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/attribute/page" method="post"
                class="form-horizontal">
                <div class="box-body">
                      <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">一级分类：</label>
                                <div class="col-sm-8">
                                  <input type="text" class="search-form-control" name="search_LIKES_firstName">
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">二级分类：</label>
                                <div class="col-sm-8">
                                  <input type="text" class="search-form-control" name="search_LIKES_secondName">
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">三级分类：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control" name="search_LIKES_thirdName">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                         <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">一级编号：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control" name="search_LIKES_firstId">
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">二级编号：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control" name="search_LIKES_secondId">
                                </div>
                            </div>
                        </div>
                         <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">三级编号：</label>
                                <div class="col-sm-8">
                                <input type="text" class="search-form-control" name="search_LIKES_thirdId">
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 control-label">是否有效：</label>
                                <div class="col-sm-8">
	                                <select name="search_EQI_status" class="search-form-control">
	                                    <option value="">—全部—</option>
	                                    <jdf:select dictionaryId="111" valid="true" />
	                                </select>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <a href="${dynamicDomain}/attribute/distributePage?ajax=1" class="btn btn-primary pull-left colorbox-big">分配PM</a>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="商品分类属性管理.csv" tooltip="导出CSV"
                imageName="csv" />
            <jdf:export view="xls" fileName="商品分类属性管理.xls" tooltip="导出EXCEL"
                imageName="xls" />
            <jdf:row>
                <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html"
                    style="width: 10%;text-align:center;">
                    <a href="${dynamicDomain}/attribute/editAttr/${currentRowObject.thirdId}?ajax=1"
                        class="btn btn-primary btn-mini colorbox-big"> <i
                        class="glyphicon glyphicon-pencil"></i>
                    </a>

                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="firstId" title="一级分类" headerStyle="width:15%;">
                	${currentRowObject.firstName}
                </jdf:column>
                <jdf:column property="secondId" title="二级分类" headerStyle="width:15%;">
                	${currentRowObject.secondName}
                </jdf:column>
                <jdf:column property="thirdId" title="三级分类编号" headerStyle="width:15%;" />
                <jdf:column property="name" title="三级分类" headerStyle="width:15%;" />
                <jdf:column property="properties" title="属性" headerStyle="width:15%;" sortable="false"/>
                <jdf:column property="status" title="状态" headerStyle="width:15%;">
                    <jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
                </jdf:column>
            </jdf:row>
        </jdf:table>
    </div>
</body>
</html>