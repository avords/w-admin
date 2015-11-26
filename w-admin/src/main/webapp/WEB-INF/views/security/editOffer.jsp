<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<!--可查询下拉列表-->
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="css/select2.css"/>
<!--可查询下拉列表-->
<title>Offer信息</title>
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
				
				<li><a href="${dynamicDomain}/resume/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>基本信息</span>
                   </a>
                 </li>
				<li><a href="${dynamicDomain}/educationhistory/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>教育信息</span>
                   </a></li>
                     
				<li><a href="${dynamicDomain}/workhistory/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>工作信息</span>
                   </a></li>
                <li><a href="${dynamicDomain}/follow/edit/<%=request.getAttribute("objectId") %>?ajax=1">
                              <span>跟进信息</span>
                   </a></li>
                <li><a href="${dynamicDomain}/offer/edit/<%=request.getAttribute("objectId") %>?ajax=1">
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
			<span class="glyphicon glyphicon-user"></span>Offer信息
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/offer/save?ajax=1" class="form-horizontal" id="editForm">
					<c:if test="${not empty objectId}">
						<input type="hidden" name="resumeId" value="${objectId}"> 
					</c:if>
					<c:if test="${empty objectId}">
						<input type="hidden" class="form-control" id="resumeId" name="resumeId">
					</c:if>
					<input type="hidden" name="objectId" >	
					<div class="row">
						<!-- 项目，负责人 -->
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="projectId" class="col-sm-3 control-label">
									项&nbsp;&nbsp;目
								</label>
								<div class="col-sm-8">
									<select id="e3" class="populate" style="width:280px" name="projectId" >
								     <jdf:selectCollection items="projects" optionValue="objectId" optionText="name"/>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="userId" class="col-sm-3 control-label">
									负责人
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="keyWords" name="keyWords" value="${sessionScope.username}">
									
								</div>
								<%-- <div class="col-sm-8">
									<select id="e2" class="populate" style="width:280px" name="userId">
								     <jdf:selectCollection items="user" optionValue="objectId" optionText="userName"/>
									</select>
								</div> --%>
							</div>
						</div>
					 </div>
					 <!-- 客户，下达时间 -->
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="customerId" class="col-sm-3 control-label">
									客&nbsp;&nbsp;户
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="expectedCareer" name="expectedCareer" value="">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="sendDate" class="col-sm-3 control-label">
									下达时间 
								</label>
								<div class="col-sm-8">
									<input type="text" name="sendDate" style="width:280px;height:30px" class="sendDate">
                  					<span class="add-on"><i class="icon-calendar"></i></span>
								</div>
							 </div>
						</div>
					 </div>
					 <!-- 状态，年薪-->
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="status" class="col-sm-3 control-label">
									状&nbsp;&nbsp;态
								</label>
								<div class="col-sm-8">
									<select name="status" class="form-control" style="width:280px">
										<option value=""></option>
										<jdf:select dictionaryId="136" valid="true"/>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="annualSalary" class="col-sm-3 control-label">
									年&nbsp;&nbsp;薪
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" style="width:280px" id="annualSalary" name="annualSalary">
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
	</div>
	<jdf:bootstrapDomainValidate domain="Offer"/>
	<script type="text/javascript">
	$('.beginDate').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	$('.sendDate').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	</script>
</body>
</html>