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
                    <span class="widget-caption">客户信息列表</span>
                    <div class="widget-buttons">
                    <!-- 放大和缩小 -->
                        <a href="#" data-toggle="maximize"> <i class="fa fa-expand"></i></a> 
                    <!-- 折叠按钮 -->                      
                        <a href="#" data-toggle="collapse"> <i class="fa fa-minus"></i></a> 
                    <!-- 超链接增加按钮 -->    
                        <a href="${dynamicDomain}/customer/create?ajax=1" class="colorbox-large btn btn-primary"> 
                        <i class="fa fa-plus"></i>&nbsp;&nbsp;增加</a>
                    </div>
                </div>
                <div class="widget-body">
                <jdf:form bean="request" scope="request">
                <form action="${dynamicDomain}/customer/page" method="post" class="form-horizontal">
                     <div class="row">
                        <div class="col-sm-12 alert alert-info" id="messageBox">
                           ${message}
                        </div>
                     </div>
                    <div class="row">
                        <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="search_LIKES_name" class="col-sm-2 control-label">
                                                                                                                  客户名称
                                </label>
                                <div class="col-sm-5">
                                    <input type="text"  id="search_LIKES_name" name="search_LIKES_name" class="form-control">
                                </div>
                            </div>
                        </div>
                       
                       <div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="search_EQI_status" class="col-sm-2 control-label">
                                    客户状态
                                </label>
                                <div class="col-sm-5">
                                   <select name="search_EQI_status" class="form-control">
										<option value=""></option>
									    <jdf:select dictionaryId="140" valid="true" /> 
									</select> 
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
                            <jdf:column property="name" title="客户名称" style="width:20%" />
                            <jdf:column property="website" title="网址" style="width:15%" >
                            <a target="_blank" href="http://${currentRowObject.website}">${currentRowObject.website}</a>
                            </jdf:column>
                            <jdf:column property="telephone" title="联系电话" style="width:10%" />
                            <jdf:column property="description" title="简介" style="width:10%" />
                            <jdf:column property="status" title="状态" style="width:10%">
                               <c:if test="${currentRowObject.status==10}">
                                 <jdf:columnValue dictionaryId="107" value="已合作" />
                                </c:if>
                                <c:if test="${currentRowObject.status==5}">
                                 <jdf:columnValue dictionaryId="107" value="待确认合同" />
                                </c:if>
                                 <c:if test="${currentRowObject.status==1}">  
                                  <jdf:columnValue dictionaryId="107" value="有意向，跟进中" />
                                </c:if>
                                
                            </jdf:column>
                            <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 30%">
                                <a href="${dynamicDomain}/customer/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-edit"></span>
                                    <jdf:message code="common.button.edit"/>
                                </a>
                                
                                 <a href="${dynamicDomain}/customer/view/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-large">
                                    <span class="glyphicon glyphicon-view"></span>
                                    <jdf:message code="查看"/>
                                </a>
                               
<%--                                  <a href="javascript:toDeleteUrl('${dynamicDomain}/customer/delete/${currentRowObject.objectId}')" class="btn btn-danger btn-mini"> --%>
<!--                                     <span class="glyphicon glyphicon-trash"></span> -->
<%--                                     <jdf:message code="common.button.delete"/> --%>
<!--                                 </a> -->
                              
                                <a type="button" class="btn btn-danger btn-mini" onClick="return adddelete(${currentRowObject.objectId})">
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
    
    
    <script type="text/javascript">
	function adddelete(deletId){
		$.ajax({
			 async: true,
	        url:"${dynamicDomain}/customer/delete1/"+deletId,
	        type:'post',
	        data:"deletId="+deletId,
	        dataType:'json',
	        success:function(data){
	            if(data.result){
	            	alert("该客户对应的有合同信息，请先删合同信息再删客户信息！");
	            	 } 
	            else{
	            	window.location.reload();
	            }
	        }
	     });
	}
	</script>
	 
    
</body>
