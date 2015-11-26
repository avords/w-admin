<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检预约信息确认</title>
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
      <h4 class="modal-title">体检预约信息确认</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/order/save?ajax=1" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <script type="text/javascript">
         objectId = '${entity.objectId}';
        </script>
        <div class="box-body">
          <h4 >1.核对个人体检信息</h4>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">客户姓名：</label>
                <div class="col-sm-8 upView">${pSubscribe.userName }</div>
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
            <%-- <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">婚姻状况:</label>
                <div class="col-sm-8 upView">
                  <c:choose>
					<c:when test="${voEntity.marryStatus eq 1}">
						<span class="f-ib">已婚</span>
					</c:when>
					<c:otherwise>
						<span class="f-ib">未婚</span>
					</c:otherwise>
				</c:choose><br>
                </div>
              </div>
            </div> --%>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">证件类型：</label>
                <div class="col-sm-8 upView">
                	<c:choose>
					<c:when test="${pSubscribe.certificateType eq 1}">
						<span class="f-ib">身份证</span>
					</c:when>
					<c:when test="${pSubscribe.certificateType eq 2}">
						<span class="f-ib">护照</span>
					</c:when>
					<c:otherwise>
						<span class="f-ib">其他证件</span>
					</c:otherwise>
					</c:choose><br>
                </div>
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
                <label class="col-sm-4 control-label">生日号码：</label>
                <div class="col-sm-8 upView">
                	<fmt:formatDate value="${pSubscribe.birthday }" pattern=" yyyy-MM-dd "/></span><br>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">手机：</label>
                <div class="col-sm-8 upView">${pSubscribe.cellphoneNo }</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">Email：</label>
                <div class="col-sm-8 upView">
               		${pSubscribe.email}
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">邮编：</label>
                <div class="col-sm-8 upView">${pSubscribe.postCode}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">选送体检报告:</label>
                <div class="col-sm-8 upView">
                	<c:if test="${pSubscribe.elecReport eq 1 }">
        			<span class="f-ib">电子报告</span><br/>
        			</c:if>
       		 		<c:if test="${pSubscribe.paperReport  eq 2 }">
		            	<span class="f-ib">纸质报告</span><br/>
		            	<span class="f-ib">邮寄地址:&nbsp;&nbsp;${pSubscribe.postAddress} </span>
         	 		</c:if>
                </div>
              </div>
            </div>
          </div>
          <h4>2.选择体检套餐</h4>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检套餐：</label>
                <div class="col-sm-8 upView">${pSubscribe.packageName}</div>
              </div>
            </div>
          </div>
          <h4>3.选择体检地址和时间</h4>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检地址：</label>
                <div class="col-sm-8 upView">${pSubscribe.physicalAddress}</div>
              </div>
            </div>
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">体检时间：</label>
                <div class="col-sm-8 upView">
                	<fmt:formatDate value="${pSubscribe.physicalDate }" pattern=" yyyy-MM-dd "/>
                </div>
              </div>
            </div>
          </div>
           <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">备注：</label>
                <div class="col-sm-8 upView">${pSubscribe.remark}</div>
              </div>
            </div>
          </div>
          </div>
          <div class="row">
            <div class="editPageButton">
              <a href="${dynamicDomain}/CardExchange/appointment4" class="btn btn-primary progressBtn">确认提交</a>
              <a href="${dynamicDomain}/CardExchange/appointmentFirst" class="btn btn-primary progressBtn">返回重填</a>       
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