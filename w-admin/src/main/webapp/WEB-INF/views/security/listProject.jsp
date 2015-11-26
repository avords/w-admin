<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="列表界面模板" /></title>
<jdf:themeFile file="css/dataTables.bootstrap.css"/>
</head>
<body>
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header ">
                    <span class="widget-caption">职位信息列表</span>
                    <div class="widget-buttons">
                    <!-- 放大和缩小 -->
                        <a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i></a> 
                    <!-- 折叠按钮 -->                      
                        <a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i></a> 
                    <!-- 超链接增加按钮 -->    
                        <a href="${dynamicDomain}/project/create?ajax=1" class="colorbox-large btn btn-primary"> 
                        <i class="fa fa-plus"></i>&nbsp;&nbsp;增加</a>
                    </div>
                </div>
                <div class="widget-body">
                <jdf:form bean="request" scope="request">
                <form action="${dynamicDomain}/project/page" method="post" class="form-horizontal">
                   <div class="row">
                        <div class="col-sm-12 alert alert-info" id="messageBox">
                           ${message}
                        </div>
                     </div>
                    <div class="row">
                        <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="search_LIKES_name" class="col-sm-3 control-label">
                                  	职位名称	
                                </label>
                                <div class="col-sm-6">
                                    <input type="text"  id="search_LIKES_name" name="search_LIKES_name"  class="form-control">
                                </div>
                            </div>
                        </div>
                       
                    </div>
                                
                     <div class="row">
                        <div class="col-sm-12  col-md-12">
                            <div class="pull-right">
                                <button type="button" class="btn" onclick="clearForm(this)">
                                    <span class="glyphicon glyphicon-remove"></span>
                                    <jdf:message code="common.button.clear" />
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-search"></span>
                                    <jdf:message code="common.button.query" />
                                </button>
                            </div>
                        </div>
                     </div>
                   </form>
                </jdf:form>
              <div id="tableDiv" class="row">
                <div class="col-sm-12 col-md-12">
                    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
                        <jdf:export view="csv" fileName="server.csv" tooltip="Export CSV" imageName="csv" />
                        <jdf:export view="xls" fileName="server.xls" tooltip="Export EXCEL" imageName="xls" />
                        <jdf:row>
                            <jdf:column property="objectId" title="common.lable.id" style="width: 10%" />
                            <jdf:column property="name" title="职位名称" style="width:20%" />
                            <jdf:column property="description" title="职位描述" style="width:15%" />
                            <jdf:column property="createdOn"  cell="date" title="创建时间" style="width:15%" format="yyyy-MM-dd hh:mm:ss"/>
                            <jdf:column property="provided" title="已推荐人数" style="width:10%" />
                            <jdf:column property="sended" title="已发送简历数" style="width:5%">
                            </jdf:column>
                            <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 30%">
                                <a href="${dynamicDomain}/project/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <jdf:message code="common.button.edit"/>
                                </a>
                                
                                  <a href="${dynamicDomain}/project/view/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-view"></span>
                                    <jdf:message code="查看"/>
                                </a>
                                
                                <a href="javascript:toDeleteUrl('${dynamicDomain}/project/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
                                    <span class="glyphicon glyphicon-trash"></span>
                                    <jdf:message code="common.button.delete"/>
                                </a>
                                
                            </jdf:column>
                        </jdf:row>
                    </jdf:table>
                </div>
            </div>
                </div>
            </div>
        </div>
    </div>
    
    
</body>
