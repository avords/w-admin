<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>教育经历</title>
<link rel="stylesheet" type="text/css"
	href="/hh/static/theme/d/css/ddcolortabs.css" />
</head>
<style>
.navbar li span {
	color: blank;
	font-size: 16px;
	font-famliy: SimSun;
	font-weight: bold;
}
</style>
</head>
<body>
	<div class="navbar">
		<div id="colortab" class="ddcolortabs">
			<ul class="nav nav-pills">
				<li role="presentation"><a href="${dynamicDomain}/resume/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>基本信息</span>
                   </a>
                 </li>
				<li role="presentation"><a href="${dynamicDomain}/educationhistory/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>教育信息</span>
                   </a></li>
                     
				<li role="presentation"><a href="${dynamicDomain}/workhistory/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>工作信息</span>
                   </a></li>
                <li role="presentation"><a href="${dynamicDomain}/follow/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>跟进信息</span>
                   </a></li>
                <li role="presentation"><a href="${dynamicDomain}/offer/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>Offer信息</span>
                   </a></li>
				<c:if test="${supportPolicy==1}">
					<li><a href="javascript:void(0)" class="brand"
						onclick="toMenu('${dynamicDomain}/attachmentInfoTemp/viewAttachment/${enterpriseId }/13?ajax=1')"
						title="扶持政策查看"><span>扶持政策查看</span></a></li>
				</c:if>
			</ul>
		</div>
	</div>
	 <div class="panel panel-default">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-user"></span>教育经历
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/educationhistory/save?ajax=1" class="form-horizontal" id="editForm">
					<c:if test="${not empty objectId}">
						<input type="hidden" name="resumeId" value="${objectId}"> 
					</c:if>
					<c:if test="${empty objectId}">
						<input type="hidden" class="form-control" id="resumeId" name="resumeId">
					</c:if>
					<input type="hidden" name="objectId" >	
					<div class="row">
						<div class="row">
						<!-- 开始时间，结束时间 -->
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="beginDate" class="col-sm-3 control-label">
									开始时间
								</label>
								<div class="col-sm-8">
										 <input type="text" name="beginDate" style="width:270px;height:30px" class="beginDate">
                  						  <span class="add-on"><i class="icon-calendar"></i></span>
								 </div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="endDate" class="col-sm-3 control-label">
									结束时间
								</label>
								<div class="col-sm-8">
										 <input type="text" name="endDate" style="width:270px;height:30px" class="endDate">
                  						  <span class="add-on"><i class="icon-calendar"></i></span>
								 </div>
							</div>
						</div>
					 </div>
					 <!-- 学校，专业 -->
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="school" class="col-sm-3 control-label">
									学&nbsp;&nbsp;校
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="school" name="school">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="major" class="col-sm-3 control-label">
									专&nbsp;&nbsp;业
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="major" name="major" style="width:270px">
								</div>
							 </div>
						</div>
					 </div>
					  
					  <!-- 专业描述 -->
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="majorDescrption" class="col-sm-3 control-label">
									专业描述
								</label>
								<div class="col-sm-8">
								<textarea rows="4" name="majorDescrption" cols="40.8" > </textarea>
								</div>
							</div>
						</div>
					 </div>
					 
				  	<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="pull-right">
								<button type="submit" class="btn btn-primary">
									<span class="glyphicon glyphicon-ok"></span><jdf:message code="common.button.save"/>
								</button>
							</div>
						</div>
					</div>
            	  </form>
			</jdf:form>
		</div>
		 <div id="tableDiv" class="row">
                <div class="col-sm-12 col-md-12">
                    <jdf:table items="page" var="currentRowObject" action="page">
                        <jdf:export view="csv" fileName="server.csv" tooltip="Export CSV" imageName="csv" />
                        <jdf:export view="xls" fileName="server.xls" tooltip="Export EXCEL" imageName="xls" />
                        <jdf:row>
                            <jdf:column property="objectId" title="common.lable.id" style="width: 5%" />
                            <jdf:column property="school" title="学校" style="width:20%" />
                            <jdf:column property="major" title="专业" style="width:20%" />
                            <jdf:column alias="common.lable.operate" title="操作" sortable="false" viewsAllowed="html" style="width:25%">
                            	<a href="${dynamicDomain}/educationhistory/editone?objectId=${currentRowObject.objectId}&resumeId=${currentRowObject.resumeId}&ajax=1" class="btn btn-primary">
                                    <span class="glyphicon glyphicon-ok"></span>
                                    		修改
                                </a>
                                <a href="javascript:toDeleteUrl('${dynamicDomain}/educationhistory/delete/${currentRowObject.objectId}?ajax=1')" class="btn btn-danger btn-mini">
                                    <span class="glyphicon glyphicon-trash"></span>
                                    		删除
                                </a>
                            </jdf:column>
                        </jdf:row>
                    </jdf:table>
                </div>
            </div>
	</div>
	<jdf:bootstrapDomainValidate domain="Server"/>
	<script type="text/javascript">
	$('.beginDate').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	$('.endDate').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	</script>
</body>
</html>