<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="system.menu.user" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">新增订单</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/order/save" class="form-horizontal" id="editForm">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="loginName" style="color: blue; font-weight: bold" class="btn btn-flat">收货地址信息</label>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="loginName" style="color: blue; font-weight: bold" class="btn btn-flat">收货信息</label>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="receiptAddress" class="btn btn-flat">收货地址 ：</label>
                </div>
                <input type="text" class="form-control" name="receiptAddress">
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="receiptContacts" class="btn btn-flat">收货人姓名<span style="color: red">*</span> ：
                  </label>
                </div>
                <input type="text" class="form-control" name="receiptContacts">
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <input type="hidden" class="form-control" name="">
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="receiptMoblie" class="btn btn-flat">手机号码 <span style="color: red">*</span>：
                  </label>
                </div>
                <input type="text" class="form-control" name="receiptMoblie">
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6 col-md-6">
            <div class="input-group">
              <input type="hidden" class="form-control" name="">
            </div>
          </div>
          <div class="col-sm-6 col-md-6">
            <div class="input-group">
              <div class="input-group-btn">
                <label for="receiptEmail" class="btn btn-flat">邮箱 <span style="color: red">*</span>：
                </label>
              </div>
              <input type="text" class="form-control" name="receiptEmail">
            </div>
          </div>
        </div>
  </div>
  <div class="box-footer">
    <div class="row">
      <div class="editPageButton">
        <button type="submit" class="btn btn-primary">
         保存
        </button>
        <a href="${dynamicDomain}/order/page" class="back-btn">返回</a>
      </div>

    </div>
  </div>
  </div>
  </form>
  </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="Orders" />

</body>
</html>