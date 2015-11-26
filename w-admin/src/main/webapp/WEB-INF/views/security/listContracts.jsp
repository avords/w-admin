<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<!--可查询下拉列表-->
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="css/select2.css"/>
<!--可查询下拉列表-->

<title><jdf:message code="列表界面模板" /></title>
<jdf:themeFile file="css/dataTables.bootstrap.css" />
</head>
<body>
	<div class="row">
		<div class="col-xs-12 col-md-12">
			<div class="widget">
				<div class="widget-header ">
					<span class="widget-caption">合同信息列表</span>
					<div class="widget-buttons">
						<!-- 放大和缩小 -->
						<a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i></a>
						<!-- 折叠按钮 -->
						<a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i></a>
						<!-- 超链接增加按钮 -->
						<a href="${dynamicDomain}/contracts/create?ajax=1"
							class="colorbox-large btn btn-primary"> <i class="fa fa-plus"></i>&nbsp;&nbsp;增加
						</a>
					</div>
				</div>
				<div class="widget-body">
					<jdf:form bean="request" scope="request">
						<form action="${dynamicDomain}/contracts/page" method="post"
							class="form-horizontal">
					 <div class="row">
                        <div class="col-sm-12 alert alert-info" id="messageBox">
                           ${message}
                        </div>
                     </div>
					 <div class="row">
                        <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="search_EQL_custermId" class="col-sm-2 control-label">
                                                                                                                       客户姓名
                                </label>
                                <div class="col-sm-5">
                                    <select id="e1" class="populate" style="width:200px" name="search_EQL_custermId" >
                                      <option value=""></option>
								     <jdf:selectCollection items="customers" optionValue="objectId" optionText="name"/>
									</select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="search_LIKES_beginDate" class="col-sm-2 control-label">
                                                                                                                       合同时间                                                                                  
                                </label>
                                <div class="col-sm-5 control-label">
                                    <input type="text" name="search_GED_beginDate" id="datepicker1" size="10" style="height:25px">
                                    <span class="add-on"><i class="icon-calendar"></i></span>-
                                     <input type="text" name="search_LED_beginDate" id="datepicker2" size="10" style="height:25px">
                                    <span class="add-on"><i class="icon-calendar"></i></span>
                                   
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
										<jdf:column property="custermId" title="客户姓名" style="width:15%">
										 <jdf:columnCollectionValue items="customers" nameProperty="name" value="${currentRowObject.custermId}" />
										</jdf:column>
										<jdf:column property="beginDate" cell="date" title="开始日期" style="width:9%" />
										<jdf:column property="endDate" cell="date" title="结束日期" style="width:9%" />
										<jdf:column property="contents" title="内容" style="width:15%" styleClass="con"/>
										<jdf:column property="welfare" title="福利" style="width:10%" />
										<jdf:column property="userName" title="负责人" style="width:7%">
										<jdf:columnCollectionValue items="user" nameProperty="userName" value="${currentRowObject.userId}" />
										</jdf:column>
										<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 30%">
										<a href="${dynamicDomain}/contracts/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large"> 
										<span class="glyphicon glyphicon-edit"></span> 
										<jdf:message code="common.button.edit" />
										</a>
										 <a href="${dynamicDomain}/contracts/view/${currentRowObject.objectId}?ajax=1"
											class="btn btn-primary btn-mini colorbox-large"> <span
											class="glyphicon glyphicon-view"></span> 
											 <jdf:message code="查看"/>
										<a href="javascript:toDeleteUrl('${dynamicDomain}/contracts/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini">
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

 <script id="script_e1"> 
$(document).ready(function() {
    $("#e1").select2();
});

</script>



<script type="text/javascript">
	
	$(function() {
		//$("#search_GED_createDate").datetimepicker({pickTime: false});
		$("#search_GED_createDate").datepicker({format: 'yyyy-mm-dd'});
		
		   $(".con").each(function(){
	            var maxwidth=40;
	            if($(this).text().length>maxwidth){
	                $(this).text($(this).text().substring(0,maxwidth));
	                $(this).html($(this).text()+'...');
	            }
	        });

	});
	
	$('#datepicker1').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
		
	$('#datepicker2').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	</script>
	
	<script type="text/javascript">
	 $(function(){
	        $(".con").each(function(){
	            var maxwidth=10;
	            if($(this).text().length>maxwidth){
	                $(this).text($(this).text().substring(0,maxwidth));
	                $(this).html($(this).text()+'...');
	            }
	        });
	    });
	</script>
	
	
</body>
