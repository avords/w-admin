<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>选择体检套餐</title>
<jdf:themeFile file="ajaxfileupload.js" />
<style>
.upView {
	margin: 7px 0 0 0;
}
</style>

</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">选择体检套餐</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/CardExchange/listPhysicalStore" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
         <input type="hidden" name="packageName" id="packageName" value="${welfarePackage.packageName}">
          <br>
          <br> <br>
          <div class="row">
           
              <table align="center">
                 <tbody>	
                 		 <thead>
		                 	<tr>
								<td width="50px" colspan="1">序号</td>
								<td width="200px"  colspan="1">套餐名称</td>
							</tr>
               		 	</thead>
                 		<c:forEach items="${addtionPackages}"  var="welfarePackage"  varStatus="num" >
		                    <tr>
		                     	<td width="50px" >${num.index+1}</td>
								<td width="200px" >${welfarePackage.packageName}</td>
								<td ><a href="${dynamicDomain}/CardExchange/packageDetail/${welfarePackage.objectId}" >[查看套餐详情]</a></td>
		                    </tr>
	                    </c:forEach>
                  </tbody>              
              </table>
              
              <br>
              <br>
              <br>
          </div>
          <div class="row">
            <div class="editPageButton">
            <a href="javascript:void(0)" onclick="comeBack();" class="btn btn-primary progressBtn">返回</a>      
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Order" />
  <script type="text/javascript">
			function comeBack(){
				window.history.go(-1); 
			}
 </script>
</body>
</html>