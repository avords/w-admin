<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.contracts"/></title>
</head>
<body>
	 <div class="panel panel-default">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-user"></span>合同信息
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/contracts/save?ajax=1" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">	
					
						 <div class="row">
						 <div class="span12 alert alert-info" id="messageBox">
							${message}
						</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="name" class="col-sm-3 control-label">
								客户姓名
								</label>
								 <div class="col-sm-6">
                                    <select name="custermId" style="width: 200px"  class="form-control" >
                                        <option value="0"></option>
                                        <jdf:selectCollection items="names" optionValue="objectId" optionText="name"/>
                                    </select>
                                </div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							
							<div class="form-group">
								<label for="welfare" class="col-sm-3 control-label">
									福利
								</label>
								<div class="col-sm-7">
									<input type="text" class="form-control" id="welfare" name="welfare">
								</div>
							 </div>
						
					 </div>
					 
					<div class="row">
						<div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="beginDate" class="col-sm-3 control-label">
                                                                                                                    合同开始日期
                                </label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="beginDate" id="datepicker1">
                                    <span class="add-on"><i class="icon-calendar"></i></span>
                                </div>
                             </div>
                        </div>
						<div class="col-sm-6 col-md-6">
                            <div class="form-group">
                                <label for="endDate" class="col-sm-3 control-label">
                                                                                                                    合同结束日期
                                </label>
                                <div class="col-sm-7">
                                    <input type="text" class="form-control" name="endDate" id="datepicker2">
                                    <span class="add-on"><i class="icon-calendar"></i></span>
                                </div>
                                </div>
                             </div>
                        </div>
					 	
	
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="contents" class="col-sm-3 control-label">
									主要内容
								</label>
								<div class="col-sm-8">
								<textarea rows="20" name="contents" cols="90" > </textarea>									
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
	
	<jdf:bootstrapDomainValidate domain="Contracts"/>
	<script type="text/javascript">
	

	
	$(function() {
		//$("#search_GED_createDate").datetimepicker({pickTime: false});
		$("#search_GED_createDate").datepicker({format: 'yyyy-mm-dd'});
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
</body>
</html>