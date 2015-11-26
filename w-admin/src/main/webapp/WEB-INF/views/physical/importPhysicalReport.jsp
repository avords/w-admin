<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<title>导入卡密绑定手机号列表</title>
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
			<h4 class="modal-title">选择体检报告</h4>
		</div>
			<jdf:form bean="request" scope="request">
				<form method="post" action="${dynamicDomain}/physicalReport/uploadPhysicalReport?ajax=1" class="form-horizontal import" id="isform" name="isform" enctype="multipart/form-data">
				<input type="hidden" value="${cardNum}" name="cardNum" id="_cardNum"/>
				<input type="hidden" value="${subOrderId}" name="subOrderId" id="_subOrderId"/> 
					<div class="box-body">
					<div class="row">
						<div class="col-sm-12 alert alert-info" id="messageBox">${message}</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<div class="col-sm-6">
									<input type="file" class="form-control" name="uploadFile" id="isFile" >
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
						<div class="col-sm-8 col-md-6">
							<div class="pull-right">
								<button type="button" id="submitButton"
									onclick="javascript:sbumitFile();" class="btn btn-primary">
									确定
								</button>
								<button type="button" class="btn" onclick="closeDiv()">
									 取消
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
			alert("请先选中要导入的体检报告");
			return false;
		}else{
			if(checkFileSuffix(fileSuffix)){
				if(checkFileSize()){
					document.getElementById("loadingDiv").style.display="";
					isform.submit();
				}else{
					winAlert("体检报告文件大小必须小于20M");
					return false;
				}
			}else{
				winAlert("体检报告文件格式支持 pdf、jpeg、gif、png、bmp、jpg");
				return false;
			}
		}
	}
	
	
	function checkFileSuffix(fileSuffix){
		var suffixFilter = ".pdf|.jpeg|.gif|.png|.bmp|.jpg";
		fileSuffix = fileSuffix + "";
		fileSuffix = fileSuffix.toLowerCase();
		
		if(suffixFilter.indexOf(fileSuffix)>-1){
			return true;
		}
		
		return false;
	} 
	
	
	function closeDiv(){
		parent.$.colorbox.close();

	}
	
	
	/*
	*
	* Function to validate File size
	*
	**/
	function findSize(fileDom){
       var byteSize  = fileDom.files[0].size;
        console.log(byteSize);
        return ( (byteSize/1024/1024).toFixed(2) ); 
	}
      
    function checkFileSize(){  
    	var fileDom = document.getElementById('isFile');
        var size = findSize(fileDom);  
        if(size > 20 ){
        	return false;
        }else{
        	return true;
        }
    }  
	</script>
</body>
</body>
</html>