<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检套餐详情</title>
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
      <h4 class="modal-title">体检套餐详情</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/order/save?ajax=1" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <div class="box-body">
			         
          <br>
          <br> <br>
          <div class="row" style="margin-left: 20px;">
           
              <table class="table table-bordered table-hover">
                <thead>
                 <tr>
					<td colspan="3">${physicalPackage.packageName}</td>
				</tr>
                </thead>
                
                  <tbody>
                  			<tr>
								<td >体检项目</td>
								<td >临床意义</td>
							</tr>
                  		<c:forEach items="${physicalItems}"  var="physicalItem"  varStatus="num" >
							<tr>
								<td>${physicalItem.firstItemName }</td>
								<td>${physicalItem.secondItemNames }</td>
								<td>${physicalItem.targetExplains }</td>
							</tr>
					   </c:forEach>
							<tr>
								<td>体检报告</td>
								<td>纸/电子报告</td>
								<td>电子报告须员工个人授权加密获取</td>
							</tr>
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
  <jdf:bootstrapDomainValidate domain="" />
  <script type="text/javascript">
			$(function() {
				$(".datestyle").datepicker({
					format : 'yyyy-mm-dd'
				});
			});
			function comeBack(){
				window.history.go(-1); 
			}
 </script>
 
</body>
</html>