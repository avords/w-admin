<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.server"/></title>
</head>
<body>
	 <div class="panel panel-default">
		<div class="panel-heading">
			<span class="glyphicon glyphicon-user"></span>客户信息
		 </div>
	  	<div class="panel-body">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/customer/save?ajax=1" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">	
					<div class="row">
                        <div class="col-sm-12 alert alert-info" id="messageBox">
                           ${message}
                        </div>
                     </div>
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
									网址
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="website" name="website">
								</div>
							 </div>
						</div>
					 </div>
				 	 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="contacts" class="col-sm-3 control-label">
									联系人
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="contacts" name="contacts">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone" class="col-sm-3 control-label">
									联系电话
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="telephone" name="telephone">
								</div>
							 </div>
						</div>
					 </div>
					 
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="email" class="col-sm-3 control-label">
									邮件地址
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="email" name="email">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="qq" class="col-sm-3 control-label">
									QQ
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="qq" name="qq">
								</div>
							 </div>
						</div>
					 </div>
					 
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
								<label for="status" class="col-sm-3 control-label">
									客户状态
								</label>
								<div class="col-sm-8">
									<select name="status" class="form-control">
									  <jdf:select dictionaryId="140"/>
									</select>
								</div>
							 </div>
						</div>
					 </div>
					 
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="address1" class="col-sm-3 control-label">
									客户地址1
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="address1" name="address1">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone1" class="col-sm-3 control-label">
									联系电话1
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="telephone1" name="telephone1">
								</div>
							 </div>
						</div>
					 </div>
					 
					  <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="address2" class="col-sm-3 control-label">
									客户地址2
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="address2" name="address2">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone2" class="col-sm-3 control-label">
									联系电话2
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="telephone2" name="telephone2">
								</div>
							 </div>
						</div>
					 </div>
					 
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="address3" class="col-sm-3 control-label">
									客户地址3
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="address3" name="address3">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="telephone3" class="col-sm-3 control-label">
									联系电话3
								</label>
								<div class="col-sm-8">
									<input type="text" class="form-control" id="telephone3" name="telephone3">
								</div>
							 </div>
						</div>
					 </div>
					 <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="description" class="col-sm-3 control-label">
									简介
								</label>
								<div class="col-sm-8">
								<textarea rows="10" name="description" cols="100" > </textarea>
									
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
	<jdf:bootstrapDomainValidate domain="Message"/>
	<script type="text/javascript">
		
	</script>
</body>
</html>