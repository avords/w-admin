<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="短信通知模版" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
		    <jdf:form bean="entity" scope="request">
		     <form method="post" action="${dynamicDomain}/other/save?ajax=1" class="form-horizontal" id="editForm" enctype="multipart/form-data">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="短信推送中心" />
			            <c:choose>
			                <c:when test="${entity.objectId eq null }">—新增</c:when>
			                <c:otherwise>—修改</c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
				<input type="hidden" name="msgStatus" value="0"> 
				<div class="box-body">
					<c:if test="${not empty entity.objectId}">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="objectId" class="col-sm-5 control-label">短信推送编号<span class="not-null">*：</span></label>
									<div class="col-sm-4">
										<input type="text" readonly="readonly" name="objectId" style="border: 0px;"/>
									</div>
								</div>
							</div>
						</div>
					</c:if>
				
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="sendType" class="col-sm-4 control-label">推送类型<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<select name="sendType" class="search-form-control">
										<jdf:select dictionaryId="1800" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="receiver" class="col-sm-4 control-label">发送号码<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<textarea style="width:200px;height: 100px;" name="receiver" class="search-form-control" placeholder="多个手机号码请以换行分割"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="msgContent" class="col-sm-4 control-label">短信内容<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<textarea style="width:200px;height: 100px;" class="search-form-control" name="msgContent"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12 menuContent">
							<div class="form-group">
								<label for="sendTime" class="col-sm-4 control-label">发送时间<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<input type="text" name="sendTime" class="search-form-control" onFocus="WdatePicker({minDate:'%y-%M-%d %H:%m:%s',dateFmt:'yyyy-MM-dd HH:mm:ss'})" format="yyyy-MM-dd HH:mm:ss" readonly/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="col-sm-12 col-md-12 menuContent">
							<div class="form-group">
								<div class="editPageButton">
									<button type="button" id="sub" class="btn btn-primary">提交</button>
									<button type="button" class="btn btn-primary" onclick="closeDialog();">取消</button>
									<!-- parent.$.colorbox.close(); -->
								</div>							
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<%-- <jdf:bootstrapDomainValidate domain="Message" /> --%>
</body>
<script type="text/javascript">
	$(function(){
		$("#sub").click(function(){
			var receivers = $("textarea[name=receiver]").val();
			if (receivers == "") {
				alert("发送号码不能为空");
				return false;
			}
			
			var v = receivers.split("\n");
			for (var i = 0; i < v.length; i++) {
				if(!(/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(v[i]))){ 
			        alert("第" + (i + 1) + "行手机号码格式不正确"); 
			        return false;
			    } 
			}
			
			var msgContent = $("textarea[name=msgContent]").val();
			if (msgContent == "") {
				alert("短信内容不能为空");
				return false;
			}
			if (msgContent.length > 200) {
				alert("短信内容限200字以内");
				return false;
			}
			
			var sendTime = $("input[name=sendTime]").val();
			if (sendTime == "") {
				alert("发送时间不能为空");
				return false;
			}
			
			$("#editForm").submit();
		});
	});
	
	function closeDialog() {
		$("#cboxClose").click();
	}
</script>
</html>