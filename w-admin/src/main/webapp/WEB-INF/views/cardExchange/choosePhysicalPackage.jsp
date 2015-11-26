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
          <div class="row" style="margin-left: 20px;">
           
              <table align="center">
                 <tbody>
	                    <tr>
	                     	<td width="50px" style="border-style:none;"><input type="radio" checked="checked"  /></td>
							<td width="150px" style="border-style:none;">${welfarePackage.packageName}</td>
							<td style="border-style:none;"><a href="${dynamicDomain}/CardExchange/packageDetail/${welfarePackage.objectId}" >[查看套餐详情]</a></td>
	                    </tr>
                  </tbody>              
              </table>
              
              <br>
              <br>
              <br>
          </div>
          <div class="row">
            <div class="editPageButton">
              <button type="submit" class="btn btn-primary progressBtn" >下一步</button>     
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Order" />
  <script type="text/javascript">
		
	</script>
</body>
</html>