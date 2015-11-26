<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>简历管理</title>
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
			<span class="glyphicon glyphicon-user"></span>简历信息
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/resume/save?ajax=1" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">	
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">
									姓名
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="name" name="name">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="website" class="col-sm-3 control-label">
									性  别
								</label>
								<div class="col-sm-8">
									<INPUT type="radio" name="gender" value="1" checked>男
	      							<INPUT type="radio" name="gender" value="2">女<br>
								</div>
							 </div>
						</div>
					 </div>
				 	 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="birthday" class="col-sm-3 control-label">
									出生日期
								</label>
								<div class="col-sm-8">
										 <input type="text" name="birthday" class="datepicker">
                  						  <span class="add-on"><i class="icon-calendar"></i></span>
								 </div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="height" class="col-sm-3 control-label">
									身&nbsp;&nbsp;高
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="height" name="height">
								</div>
							 </div>
						</div>
					 </div>
					 
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="weight" class="col-sm-3 control-label">
									体&nbsp;&nbsp;重
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="weight" name="weight">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="maritalStatus" class="col-sm-3 control-label">
									婚姻状况
								</label>
								<div class="col-sm-8">
									<select name="maritalStatus" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="125" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="nation" class="col-sm-3 control-label">
									民&nbsp;&nbsp;族
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="nation" name="nation">
								</div>
							 </div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="politicalLandscape" class="col-sm-3 control-label">
									政治面貌
								</label>
								<div class="col-sm-8">
									<select name="politicalLandscape" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="126" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					<!--  邮编，工作年限 -->
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="zipCode" class="col-sm-3 control-label">
									邮&nbsp;&nbsp;编
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="zipCode" name="zipCode">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="workYears" class="col-sm-3 control-label">
									工作年限
								</label>
								<div class="col-sm-8">
									<select name="workYears" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="127" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					<!-- 身份证号，居住地 -->
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="idCard" class="col-sm-3 control-label">
									身份证号
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="idCard" name="idCard">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="residenceCode" class="col-sm-3 control-label">
									居住地
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="residenceCode" name="residenceCode">
								</div>
							 </div>
						</div>
					 </div>
					<!-- 求职状态，邮箱 -->
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="status" class="col-sm-3 control-label">
									求职状态
								</label>
								<div class="col-sm-8">
									<select name="status" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="128" valid="true"/>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for=email class="col-sm-3 control-label">
									邮&nbsp;&nbsp;箱
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email" name="email">
								</div>
							 </div>
						</div>
					 </div>
					<!-- 目前薪水，手机 -->
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="mobile" class="col-sm-3 control-label">
									手机
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="mobile" name="mobile">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="annualSalary" class="col-sm-3 control-label">
									目前薪水
								</label>
								<div class="col-sm-8">
									<select name="annualSalary" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="129" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					 <!-- 联系地址，户口 -->
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="address" class="col-sm-3 control-label">
									联系地址
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="address" name="address">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="houseHoldCode" class="col-sm-3 control-label">
									户&nbsp;&nbsp;口
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="houseHoldCode" name="houseHoldCode">
								</div>
							 </div>
						</div>
					 </div>
					 
					 <!-- 关键词，学历 -->
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="keyWords" class="col-sm-3 control-label">
									关键词
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="keyWords" name="keyWords">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="education" class="col-sm-3 control-label">
									学&nbsp;&nbsp;历
								</label>
								<div class="col-sm-8">
									<select name="education" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="130" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					 <!-- 工作单位，自我评价 -->
					 <div class="row">
					 <div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="company" class="col-sm-3 control-label">
									工作单位
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="company" name="company">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="expectedCareer" class="col-sm-3 control-label">
									求职意向
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="expectedCareer" name="expectedCareer">
								</div>
							</div>
						</div>
						
					 </div>
					 <!-- 工作类型，期望薪水 -->
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<label for=workType class="col-sm-3 control-label">
									工作类型
								</label>
								<div class="col-sm-8">
									<select name="workType" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="131" valid="true"/>
									</select>
								</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="expectedSalary" class="col-sm-3 control-label">
									期望薪水
								</label>
								<div class="col-sm-8">
									<select name="expectedSalary" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="132" valid="true"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					  <!-- 到岗时间 -->
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<label for=arriveDate class="col-sm-3 control-label">
									到岗时间
								</label>
								<div class="col-sm-8">
									<select name="arriveDate" class="form-control">
										<option value=""></option>
										<jdf:select dictionaryId="133" valid="true"/>
									</select>
								</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="selfEvaluation" class="col-sm-3 control-label">
									自我评价
								</label>
								<div class="col-sm-8">
								<textarea rows="4" name="selfEvaluation" cols="40.8" > </textarea>
									
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
	<jdf:bootstrapDomainValidate domain="resume"/>
	<script type="text/javascript">
	$('.datepicker').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	</script>
</body>
</html>