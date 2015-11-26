<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品品牌管理" /></title>
<script type="text/javascript">
var reloadParent = false;
</script>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="商品品牌管理" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/brand/page" method="post"
                class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label type="button" class="form-lable">品牌编号：</label>
                                </div>
                                <input type="text" class="search-form-control"
                                    name="search_LIKES_brandNo">
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label type="button" class="form-lable">品牌中文名称：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_LIKES_chineseName">
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label type="button" class="form-lable">品牌英文名称：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_LIKES_englishName">
                            </div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label type="button" class="form-lable">状态：</label>
                                </div>
                                <select name="search_EQI_status" class="search-form-control">
                                    <option value="">—全部—</option>
                                    <jdf:select dictionaryId="1110" valid="true" />
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <a href="${dynamicDomain}/brand/create?ajax=1" class="btn btn-primary pull-left colorbox-big">
                        <span class="glyphicon glyphicon-plus"></span>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="商品品牌管理.csv" tooltip="导出CSV"
                imageName="csv" />
            <jdf:export view="xls" fileName="商品品牌管理.xls" tooltip="导出EXCEL"
                imageName="xls" />
            <jdf:row>
                <jdf:column alias="common.lable.operate"
                    title="common.lable.operate" sortable="false" viewsAllowed="html"
                    style="width: 10%">
                    <a href="${dynamicDomain}/brand/edit/${currentRowObject.objectId}?ajax=1"
                        class="btn btn-primary btn-mini colorbox-big"> <i
                        class="glyphicon glyphicon-pencil"></i>
                    </a>
                    <a
                        href="javascript:toDeleteUrl('${dynamicDomain}/brand/delete/${currentRowObject.objectId}')"
                        class="btn btn-danger btn-mini"> <i
                        class="glyphicon glyphicon-trash"></i>
                    </a>

                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="brandNo" title="品牌编号" headerStyle="width:20%;" />
                <jdf:column property="logo" title="品牌商标" headerStyle="width:20%;">
                   <img src="${dynamicDomain}${currentRowObject.logo}" width="80px" height="80px"/>
                </jdf:column>
                <jdf:column property="chineseName" title="中文名称" headerStyle="width:15%;" />
                <jdf:column property="englishName" title="英文名称" headerStyle="width:15%;" />
                <jdf:column property="status" title="状态" headerStyle="width:10%;">
                    <jdf:columnValue dictionaryId="1110" value="${currentRowObject.status}" />
                </jdf:column> 
            </jdf:row>
        </jdf:table>
    </div>
    <script type="text/javascript">
    function success(){
    	window.location.href='${dynamicDomain}/brand/page?message=品牌添加成功';
    }
    </script>
</body>
</html>