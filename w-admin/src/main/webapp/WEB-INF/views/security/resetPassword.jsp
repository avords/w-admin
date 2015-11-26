<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="panel">
		<div class="panel-header">
			<i class="icon-key"></i>重置“${entity.loginName}”的密码
		</div>
		<div class="panel-content">
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/user/saveReset?ajax=1" class="form-horizontal" id="editForm">
					<input type="hidden" name="objectId">	
					<div class="row">
						<div class="span12">
							<div id="messageBox" class="alert alert-info" style="display:none">${message}</div>
						</div>
            			<div class="span12">
							<div class="control-group">
								<label class="control-label" for="newPassword">新密码</label>
								<div class="controls">
									<input type="password" class="input-medium" name="newPassword" id="newPassword">
								</div>
							</div>
						</div>
            			<div class="span12">
							<div class="control-group">
								<label class="control-label" for="password">再输一遍</label>
								<div class="controls">
									<input type="password" class="input-medium" name="confirmPassword" id="confirmPassword">
								</div>
							</div>
						</div>
						<div class="btn-toolbar pull-right">
							<div class="btn-group">
                                <button type="submit" class="btn btn-primary"><i class="icon-save icon-white"></i>重置</button>
                            </div>
                        </div>
					</div>
				</form>
			</jdf:form>
		</div>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#editForm").validate({
				rules:{
					newPassword:{required:true,maxLength:50},
					confirmPassword:{required:true,equalTo:'#newPassword'}
				}
				
			});
			refreshParentPage(false);
		});
	</script>
</body>