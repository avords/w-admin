<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>重置密码</title>
</head>
<body>
  <div>
    <jdf:form bean="entity" scope="request">
      <div class="callout callout-info">
        <div class="message-right">${message }</div>
        <h4 class="modal-title">重置密码</h4>
      </div>
      <form method="post" action="${dynamicDomain}/user/savePassword" id="User" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="oldPassword" class="col-sm-2 control-label">原密码：</label>
                <div class="col-sm-4">
                  <input type="password" class="search-form-control required" name="oldPassword" id="oldPassword">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="oldPassword" class="col-sm-2 control-label">新密码：</label>
                <div class="col-sm-4">
                  <input type="password" class="search-form-control {account_pass:[6,18]} required" name="newPassword" id="newPassword">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="oldPassword" class="col-sm-2 control-label">确认密码：</label>
                <div class="col-sm-4">
                  <input type="password" class="search-form-control {required:true,equalTo:'#newPassword'}" name="confirmPassword" id="confirmPassword">
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="editPageButton">
                <button type="submit" class="btn btn-primary">保存</button>
              </div>
            </div>
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
</body>
<script type="text/javascript">
$("#User").validate();
</script>
</html>