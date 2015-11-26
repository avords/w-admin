<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="短信通知模版" /></title>
<jdf:themeFile file="${staticDomain}js/ajaxfileupload.js" />
</head>
<body>
    <div>
		    <jdf:form bean="entity" scope="request">
		     <form method="post" action="${dynamicDomain}/other/msgTemplate/saveMsg" class="form-horizontal" id="MessageTemplate" enctype="multipart/form-data">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="短信通知模版" />
			            <c:choose>
			                <c:when test="${empty str}">—新增</c:when>
			                <c:otherwise>—修改</c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
			    <input type="hidden" name="str"> 
				<input type="hidden" name="objectId"> 
				<input type="hidden" name="messageType" value="2">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="messageCode" class="col-sm-2 control-label">模版编号</label>
								<div class="col-sm-6">
									<c:choose>
										<c:when test="${empty str}">
											<input type="text" class="search-form-control"
												name="messageCode" maxlength="50">
										</c:when>
										<c:otherwise>
										    ${entity.messageCode}
											<input type="hidden" class="search-form-control"
												name="messageCode" maxlength="50">
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="messageName" class="col-sm-2 control-label">模版名称</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control"
										name="messageName"  maxlength="50">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="messageContent" class="col-sm-2 control-label">模版内容</label>
								<div class="col-sm-8">
									<textarea style="width:100%;height: 200px;" name="messageContent"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12 menuContent">
							<div class="form-group">
								<label for="status" class="col-sm-2 control-label">是否有效</label>
								<div class="col-sm-8">
									<jdf:radio dictionaryId="1110" name="status" />
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" id="sub" class="btn btn-primary">提交</button>
							<button type="button" class="btn btn-primary" onclick="comeBack();">返回</button>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="MessageTemplate" />
	<script type="text/javascript">
	$(function(){
		$("#sub").click(function(){
			var messageCode = $("input[name=messageCode]").val();
			messageCode = messageCode.trim();
			if (messageCode == "") {
				$("label[for='messageCode']").css("color","red");
			    $("input[name='messageCode']").focus();
				return false;
			}
			//var regx=/^(((?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z])|([0-9])|([a-zA-Z]))*$/;
			var regx=/^\w+$/i;
			if(!regx.test(messageCode)){
				alert("模版编号格式有误，只能输入数字、字母、下划线");
				return false;
			}
			var messageName = $("input[name=messageName]").val();
			messageName = messageName.trim();
			if (messageName == "") {
				$("label[for='messageName']").css("color","red");
			    $("input[name='messageName']").focus();
				return false;
			}
			var msgContent = $("textarea[name=messageContent]").val();
			msgContent = msgContent.trim();
			if (msgContent == "") {
				$("label[for='messageContent']").css("color","red");
				$("textarea[name=messageContent]").focus();
				return false;
			}
			var str = $("input[name=str]").val();
			if(str == ""){
				var data = {} ;
				data.messageCode = messageCode ;
				data = jQuery.param(data) ;
				var url = "${dynamicDomain}/other/msgTemplate/isUniqueTemplate?objectId=${entity.objectId}&deleted=0";
				$.ajax({
					type: "post",
					dataType: "json",
					data : data,
					url: url,
					success:function(resu){
						if(resu == true){
							alert("模版编号已存在，请重新输入！");
							return false;
						}else{
							$("#MessageTemplate").submit();
						}
					}
				});
			}else{
				$("#MessageTemplate").attr("action","${dynamicDomain}/other/msgTemplate/saveMsg?str=editMsg");
				$("#MessageTemplate").submit();
			}
		});
	});
</script>
<script type="text/javascript">
function comeBack(){
	window.location.href = '${dynamicDomain}/other/msgTemplate/queryMsgList';
}
</script>
</body>
</html>