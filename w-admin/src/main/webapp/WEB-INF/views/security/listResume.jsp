<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="简历管理" /></title>

<jdf:themeFile file="css/dataTables.bootstrap.css" />
</head>
<body>
    <div class="row">
        <div class="col-xs-12 col-md-12">
            <div class="widget">
                <div class="widget-header ">
                    <span class="widget-caption">简历列表</span>
                    <div class="widget-buttons">
                    <!-- 放大和缩小 -->
                        <a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i></a> 
                    <!-- 折叠按钮 -->                      
                        <a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i></a> 
                    <!-- 超链接增加按钮 -->    
                        <a href="${dynamicDomain}/resume/create?ajax=1" class="colorbox-large btn btn-primary"> 
                        <i class="fa fa-plus"></i>&nbsp;&nbsp;增加</a>
                        <%-- <a href="${dynamicDomain}/department/create?ajax=1" class="btn btn-success colorbox">
							<i class="icon-plus-sign icon-white"></i><jdf:message code="common.button.add"/>
						</a> --%>
                    </div>
                </div>
                <div class="widget-body">
                <jdf:form bean="request" scope="request">
                <form action="${dynamicDomain}/resume/page" method="post" class="form-horizontal">
                  	<div class="row">
                        <div class="col-sm-6 col-md-6">
                             <label for="search_LIKES_name" class="col-sm-2 control-label">
                                    	用户姓名
                                </label>
                                <div class="col-sm-5">
                                    <input type="text"  id="search_LIKES_name" name="search_LIKES_name" class="form-control">
                                </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <label for="search_EQI_workYears" class="col-sm-3 control-label">
									工作年限
							</label>
								<div class="col-sm-8">
									<select name="search_EQI_workYears" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="127" valid="true"/>
									</select>
								</div>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6 col-md-6">
                             <label for="search_LIKES_expectedCareer" class="col-sm-2 control-label">
                                    	求职意向
                                </label>
                                <div class="col-sm-5">
                                    <input type="text"  id="search_LIKES_expectedCareer" name="search_LIKES_expectedCareer" class="form-control">
                                </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                          <label for="search_EQI_expectedSalary" class="col-sm-3 control-label">
									期望薪资
								</label>
								<div class="col-sm-8">
									<select name="search_EQI_expectedSalary" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="132" valid="true"/>
									</select>
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
                            <%-- <jdf:column property="objectId" title="common.lable.id" style="width: 5%" /> --%>
                            <jdf:column property="name" title="用户姓名" style="width:8%" />
                           <%--  <jdf:column property="updateDate" title="更新时间" style="width:10%" /> --%>
                            <jdf:column property="updateDate" cell="date" title="更新时间"  style="width:10%" />
                            <jdf:column property="expectedCareer" title="求职意向" style="width:10%"/>
                            <jdf:column property="workYears" title="工作年限" headerStyle="width:10%;">
              					<jdf:columnValue dictionaryId="127" value="${currentRowObject.workYears}" />
           					 </jdf:column>
           					 <jdf:column property="expectedSalary" title="期望薪水" headerStyle="width:10%;">
              					<jdf:columnValue dictionaryId="132" value="${currentRowObject.expectedSalary}" />
           					 </jdf:column>
                            <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width:50%">
                                <%-- <a href="${dynamicDomain}/resume/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini ">
                                    <span class="glyphicon glyphicon-edit"></span>
                                   	修改
                                </a> --%>
                                <a href="${dynamicDomain}/resume/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                   	选项卡
                                </a>
                               <%--  <a href="${dynamicDomain}/educationhistory/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                   	教育
                                </a>
                                <a href="${dynamicDomain}/workhistory/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                  	  工作
                                </a> --%>
                                <a href="${dynamicDomain}/follow/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    	跟进
                                </a>
                                <a href="${dynamicDomain}/offer/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    Offer
                                </a>
                                <a href="javascript:toDeleteUrl('${dynamicDomain}/resume/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
                                    <span class="glyphicon glyphicon-trash"></span>
                                    <jdf:message code="common.button.delete"/>
                                </a>
                                <a href="${dynamicDomain}/resume/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                  	预览
                                </a>
                                <a href="${dynamicDomain}/resume/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                  	导出
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
