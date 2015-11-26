<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>导入结果</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				导入结果:
			</h4>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-sm-6 col-md-6">
					<div class="form-group">
						<label for="platform" class="col-sm-4 control-label">${msg}</label>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="row">
					<div class="editPageButton">
						<c:if test="${result==false}">
							<a href="#" class="btn " id="expUserInfo" >下载错误数据</a>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	<form action="${dynamicDomain}/insureOrder/excResult/${insureOrderId}" method="post" class="form-horizontal" id="form1">
  </form>
</body>
<script type="text/javascript">
$(function(){
	
	$("#expUserInfo").bind("click",function(){
		$("#form1").submit();
		
	});
});
</script>
</html>