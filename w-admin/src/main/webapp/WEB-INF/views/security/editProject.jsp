<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.server"/></title>
</head>
<body>
	 <div class="panel panel-default">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-user"></span>职位信息
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/project/save?ajax=1" class="form-horizontal" id="editForm">
					<div class="row">
                        <div class="col-sm-12 alert alert-info" id="messageBox">
                           ${message}
                        </div>
                     </div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">
									职位名称
								</label>								
								<div class="col-sm-7">
									<input type="text" class="form-control" id="name" name="name">
								</div>
							</div>
						</div>
						
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="beginSalary" class="col-sm-3 control-label">
									薪资范围
								</label>
								<div class="col-sm-9">
									<input type="text" id="beginSalary" name="beginSalary" size="10" style="height:30px;">-
									<input type="text"  id="endSalary" name="endSalary" size="10"  style="height:30px;">
								</div>
							</div>
						</div>
					 </div>
				 	 				 					 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="description" class="col-sm-3 control-label">
									职位描述
								</label>
								<div class="col-sm-8">
								<textarea rows="10" name="description" cols="80" > </textarea>									
								</div>
							</div>
						</div>						
					 </div>
					 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="remark" class="col-sm-3 control-label">
									备注
								</label>
								<div class="col-sm-8">
								<textarea rows="10" name="remark" cols="80" > </textarea>
									
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
	<jdf:bootstrapDomainValidate domain="Project"/>
	<script type="text/javascript">
	
	$(function() {
		//$("#search_GED_createDate").datetimepicker({pickTime: false});
		$("#search_GED_createDate").datepicker({format: 'yyyy-mm-dd'});
	});
	
	$('#datepicker').datepicker({
		format: "yyyy-mm-dd",
	    autoclose: true
	});
	
	
		
	</script>
</body>
</html>