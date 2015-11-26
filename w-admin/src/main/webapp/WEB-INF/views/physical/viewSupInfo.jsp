<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>供应商详情</title>
</head>
<body>
<div>
	<div class="callout callout-info">
		<div class="message-right">${message }</div>
		<h4 class="modal-title">
		 供应商门店详情
		</h4>
	</div>
	<div style="margin-top: 20px;margin-left: 20px;">
	<table border="0">
		 <c:forEach items="${supplierMaps}" var="supplier" >
		 <tr><td><B><font size="5">${supplier.key}</font></B></td></tr>
		     <c:forEach var="supplieraddr" items="${supplier.value}"> 
				<tr><td>${supplieraddr.address}</td></tr>
			</c:forEach>
		</c:forEach>
	</table>
	</div>
     <div class="box-footer">
			<div class="row">
				<div class="editPageButton">
						<button type="button" class="btn btn-primary" onclick="goBack();">返回</button>
				</div>
			</div>
	 </div>
 </div>	
 <script type="text/javascript">
 function goBack(){
	window.location.href= "${dynamicDomain }/physicalPackage/page";	 
 }
 </script>
</body>
</html>