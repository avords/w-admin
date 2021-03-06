<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>导入体检物流信息</title>
<style>
.import{
	width:86%;
	margin:0 0 0 40px;
}
</style>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">导入体检物流信息</h4>
		</div>
			<jdf:form bean="request" scope="request">
				<form method="post" action="${dynamicDomain}/physicalReport/uploadInfos?ajax=1" class="form-horizontal import" id="isform" name="isform" enctype="multipart/form-data">
					<input type="hidden" name="companyId" value="1">
					<div class="box-body">
					<div class="row">
						<div class="col-sm-12 alert alert-info" id="messageBox">${message}</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label  class="col-sm-4 control-label"> 信息导入：</label><u><a href="${dynamicDomain}/physicalReport/exportTemplate" target="_blank">模板下载</a></u><br><br>
								<div class="col-sm-6">
									<input type="file" class="form-control" name="uploadFile" id="isFile">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div id="loadingDiv" class="col-sm-8" style="margin: 20px; display: none;">
								<font style="font-color: red; font-weight: bold;">正在上传...<br>请勿关闭窗口</font>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-6">
							<div class="pull-right">
								<button type="button" id="submitButton"
									onclick="javascript:sbumitFile();" class="btn btn-primary progressBtn">
									确定
								</button>
							</div>
						</div>
					</div>
					</div>
				</form>
			</jdf:form>
		</div>
	<script type="text/javascript">
	$(document).ready(function() {
		refreshParentPage(true);
	});
	
	function sbumitFile( ){
		var timeSal2 = $("#isFile").val();
		fileSuffix=/.[^.]+$/.exec(timeSal2);
		if(timeSal2==""){
			alert("请选择Excel表");
			return false;
		}else{
			if(fileSuffix == ".xlsx" || fileSuffix == ".xls"){
				document.getElementById("loadingDiv").style.display="";
				isform.submit();
			}else{
				alert("请选择正确格式的Excel表，如：a.xls和a.xlsx");
				return false;
			}
		}
	}
	</script>
</body>
</body>
</html>