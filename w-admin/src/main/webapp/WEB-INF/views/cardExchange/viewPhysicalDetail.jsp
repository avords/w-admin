<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检预约详情</title>
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
      <h4 class="modal-title">体检预约详情</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/order/save?ajax=1" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <script type="text/javascript">
         objectId = '${entity.objectId}';
        </script>
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4 ">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">项目编号：</label>
                <div class="col-sm-8 upView">${physicalPackage.packageNo}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">客户姓名：</label>
                <div class="col-sm-8 upView">${pSubscribe.userName}</div>
              </div>
            </div>
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">卡号：</label>
                <div class="col-sm-8 upView">${pSubscribe.cardNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">卡号有效截止期:</label>
                <div class="col-sm-8 upView">
                  <fmt:formatDate value="${cardCreateInfo.endDate}" pattern="yyyy-MM-dd" />
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">联系电话：</label>
                <div class="col-sm-8 upView">${pSubscribe.cellphoneNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">证件号码：</label>
                <div class="col-sm-8 upView">${pSubscribe.certificateNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">预约单号：</label>
                <div class="col-sm-8 upView">${generalOrderNo}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-8 upView">
                <fmt:formatDate value="${bookDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检时间：</label>
                <div class="col-sm-8 upView">
                <fmt:formatDate value="${pSubscribe.physicalDate }" pattern="yyyy-MM-dd" />
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">套餐名称：</label>
                <div class="col-sm-8 upView">${physicalPackage.packageName}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检中心：</label>
                <div class="col-sm-8 upView">${supplierShop.shopName}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">婚姻状况：</label>
                <div class="col-sm-8 upView">
				<c:choose>
					<c:when test="${pSubscribe.sex eq 1 and pSubscribe.marryStatus eq 1}">
						<span >男已婚</span>
					</c:when>
					<c:when test="${pSubscribe.sex eq 1 and pSubscribe.marryStatus eq 0}">
						<span >男未婚</span>
					</c:when>
					<c:when test="${pSubscribe.sex eq 0 and pSubscribe.marryStatus eq 1}">
						<span >女已婚</span>
					</c:when>
					<c:otherwise>
						<span >女未婚</span>
					</c:otherwise>
				</c:choose><br>
                
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检联系方式：</label>
                <div class="col-sm-8 upView">${supplierShop.telephone}</div>
              </div>
            </div>
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检中心地址：</label>
                <div class="col-sm-8 upView">${supplierShop.address}</div>
              </div>
            </div>
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检乘车路线：</label>
                <div class="col-sm-8 upView">${supplierShop.remarks}</div>
              </div>
            </div>
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">备注信息：</label>
                <div class="col-sm-8 upView">${pSubscribe.remark}</div>
              </div>
            </div>
          </div>
         
          <br>
          <br> <br>
          <div class="row" style="margin-left: 20px;">
           
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th width="3%">序号</th>
                    <th width="10%">体检项目</th>
                    <th width="10%">类别</th>
                    <th width="30%">意义描述</th>
                  </tr>
                </thead>
                
                  <tbody>
                    <c:forEach items="${physicalItems}"  var="physicalItem"  varStatus="num" >
	                    <tr style="">
	                     	<td>${num.index+1}</td>
							<td>${physicalItem.secondItemName }</td>
							<td>${physicalItem.firstItemName }</td>
							<td>${physicalItem.targetExplain }</td>
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
            <c:if test="${show eq 1}">
            	<a href="${dynamicDomain}/CardExchange/changeDate/${pSubscribe.cardNo}" class="btn btn-primary progressBtn">改期</a>  
            </c:if>    
              <a href="${dynamicDomain}/CardExchange/page" class="btn btn-primary progressBtn">返回</a>      
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Order" />
  <script type="text/javascript">
			$(function() {
				$(".datestyle").datepicker({
					format : 'yyyy-mm-dd'
				});
			});

		</script>
</body>
</html>