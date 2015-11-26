<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="common.js" />
<title>用户管理</title>
</head>
<body>
  <div>
    <jdf:form bean="entity" scope="request">
      <div class="callout callout-info">
        <div class="message-right">${message }</div>
        <h4 class="modal-title">
          用户管理
          <c:choose>
            <c:when test="${entity.objectId eq null }">新增</c:when>
            <c:otherwise>修改</c:otherwise>
          </c:choose>
        </h4>
      </div>
      <form method="post" action="${dynamicDomain}/user/saveToPage" id="User" class="form-horizontal">
        <input type="hidden" name="objectId">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">所属平台</label>
                <div class="col-sm-8">
                  <c:choose>
                    <c:when test="${entity.objectId eq null }">
                      <jdf:radio dictionaryId="1112" name="platform" />
                    </c:when>
                    <c:otherwise>
                      <span class="lable-span"><jdf:dictionaryName dictionaryId="1112" value="${entity.platform }" /></span>
                      <input type="hidden" name="platform" value="${entity.platform }">
                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="companyName" class="col-sm-4 control-label">公司名称</label>
                <c:choose>
                  <c:when test="${entity.objectId eq null }">
                    <div class="col-sm-6">
                      <input type="text" class="search-form-control" name="companyName" id="companyName" readonly="readonly"> <input type="hidden" class="search-form-control" name="companyId" id="companyId">
                    </div>
                    <div class="col-sm-2">
                      <a href="#" onclick="javascript:setEnterprise('${dynamicDomain }/user/getEnterprise/','company');" id="enterprise-btn" class="pull-left btn btn-primary colorbox-template"> 选择 </a>
                    </div>
                  </c:when>
                  <c:otherwise>
                    <div class="col-sm-8">
                      <span class="lable-span">${entity.companyName }</span> <input type="hidden" name="companyName" value="${entity.companyName }"> <input type="hidden" name="companyId" value="${entity.companyId }">
                    </div>
                  </c:otherwise>
                </c:choose>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="userName" class="col-sm-4 control-label">用户姓名</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" id="userName" name="userName">
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="loginName" class="col-sm-4 control-label">用户帐户</label>
                <div class="col-sm-8">
                  <c:choose>
                    <c:when test="${entity.objectId eq null }">
                      <input type="text" class="search-form-control {account_no:[6,50]} required" name="loginName" id="loginName">
                    </c:when>
                    <c:otherwise>
                      <span class="lable-span">${entity.loginName }</span>
                      <input type="hidden" name="loginName" value="${entity.loginName }">

                    </c:otherwise>
                  </c:choose>
                </div>
              </div>
            </div>
          </div>
          <c:choose>
            <c:when test="${entity.objectId eq null }">
              <div class="row">
                <div class="col-sm-6 col-md-6">
                  <div class="form-group">
                    <label for="password" class="col-sm-4 control-label">会员密码</label>
                    <div class="col-sm-8">
                      <input type="password" class="search-form-control {account_pass:[6,18]} required" name="password" id="password">
                    </div>
                  </div>
                </div>
                <div class="col-sm-6 col-md-6">
                  <div class="form-group">
                    <label for="password" class="col-sm-4 control-label">确认密码</label>
                    <div class="col-sm-8">
                      <input type="password" class="search-form-control {required:true,equalTo:'#password'}" name="confirmPassword" id="confirmPassword">
                    </div>
                  </div>
                </div>
              </div>
            </c:when>
            <c:otherwise>
              <input type="hidden" class="search-form-control {account_pass:[6,18]} required" name="password" id="password">
              <input type="hidden" class="search-form-control {account_pass:[6,18]} required" name="confirmPassword" id="confirmPassword" value="${entity.password }">
            </c:otherwise>
          </c:choose>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="type" class="col-sm-4 control-label">用户类型</label>
                <div class="col-sm-8">
                  <c:choose>
                    <c:when test="${entity.objectId eq null }">
                      <jdf:radio dictionaryId="1123" name="type" />
                    </c:when>
                    <c:otherwise>
                      <span class="lable-span"><jdf:dictionaryName dictionaryId="1111" value="${entity.type }" /></span>
                      <input type="hidden" name="type" value="${entity.type }">
                    </c:otherwise>
                  </c:choose>

                </div>
              </div>
            </div>
            
            <c:choose>
              <c:when test="${entity.objectId eq null }">
                <div class="col-sm-6 col-md-6" id="isAgencyDiv" style="display: none;">
                  <div class="form-group">
                    <label for="type" class="col-sm-4 control-label">是否代理</label>
                    <div class="col-sm-8">
                      <jdf:radio dictionaryId="1124" name="isAgency" />
                    </div>
                  </div>
                </div>
              </c:when>
              <c:otherwise>
                <c:if test="${entity.type == 2 }">
                  <div class="col-sm-6 col-md-6" id="isAgencyDiv">
                    <div class="form-group">
                      <label for="type" class="col-sm-4 control-label">是否代理</label>
                      <div class="col-sm-8">
                        <span class="lable-span"><jdf:dictionaryName dictionaryId="1124" value="${entity.isAgency }" /></span> <input type="hidden" name="isAgency" value="${entity.isAgency }">
                      </div>
                    </div>
                  </div>
                </c:if>
              </c:otherwise>
            </c:choose>
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label for="mobilePhone" class="col-sm-2 control-label">手机号码</label>
                <div class="col-sm-4">
                  <input type="text" class="search-form-control mobile" id="mobilePhone" name="mobilePhone">
                </div>
              </div>
            </div>

            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="email" class="col-sm-4 control-label">电子邮件</label>
                  <div class="col-sm-8">
                    <input type="text" class="search-form-control email" id="email" name="email">
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="status" class="col-sm-4 control-label">是否启用</label>
                  <div class="col-sm-8">
                    <jdf:radio dictionaryId="1122" name="status" />
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="ipAddress" class="col-sm-4 control-label">IP限制</label>
                  <div class="col-sm-8">
                    <textarea rows="3" cols="36" name="ipAddress" id="ipAddress" class="search-form-control ips"></textarea>
                  </div>
                </div>
              </div>
              <div class="col-sm-6 col-md-6">
                <div class="form-group">
                  <label for="remark" class="col-sm-4 control-label">备注</label>
                  <div class="col-sm-8">
                    <textarea rows="3" cols="36" name="remark" class="search-form-control"></textarea>
                  </div>
                </div>
              </div>
            </div>
            <div class="box-footer">
              <div class="row">
                <div class="editPageButton">
                  <button type="submit"  class="btn btn-primary">保存</button>
                  <a href="${dynamicDomain}/user/page" class="btn btn-primary">返回</a>
                </div>
              </div>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="User" />
  <script type="text/javascript">
			$(":radio[name=type][value='2']").attr("disabled", "true");
			$(":radio[name=type][value='4']").attr("disabled", "true");
			$("input[name='platform']").click(function() {
				$("input[name='companyId']").val("");
				$("input[name='companyName']").val("");
				if ($("input[name=platform]:checked").val() == 1) {
					$(":radio[name=type][value='1']").removeAttr("disabled");
					$(":radio[name=type][value='1']").attr("checked", "true");
					$(":radio[name=type][value='2']").attr("disabled", "true");
					$(":radio[name=type][value='4']").attr("disabled", "true");
					$("#isAgencyDiv").hide();
				} else if ($("input[name=platform]:checked").val() == 3) {
					$(":radio[name=type][value='1']").attr("disabled", "true");
					$(":radio[name=type][value='2']").attr("disabled", "true");
					$(":radio[name=type][value='4']").removeAttr("disabled");
					$(":radio[name=type][value='4']").attr("checked", "true");
					$("#isAgencyDiv").hide();
				} else if ($("input[name=platform]:checked").val() == 4) {
					$(":radio[name=type][value='1']").attr("disabled", "true");
					$(":radio[name=type][value='2']").removeAttr("disabled");
					$(":radio[name=type][value='2']").attr("checked", "true");
					$(":radio[name=type][value='4']").attr("disabled", "true");
					$("#isAgencyDiv").show();
				}
				if($.data(document.getElementById("mobilePhone"), "previousValue"))
				{
					$.data(document.getElementById("mobilePhone"), "previousValue").old = null; 
				}
				if($.data(document.getElementById("email"), "previousValue"))
				{
					$.data(document.getElementById("email"), "previousValue").old = null; 
				}
				$("#mobilePhone").rules("add",
					{
						remote : {
							url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}&platform="+$("input[name=platform]:checked").val(),
							type : "post",
							dataType : "json"
						},
						required: {
		                    depends:function(){ //二选一  
		                        return ($('#email').val().length <= 0);  
		                    }  
		                },
						messages : {
							remote : "该手机号码已存在",
							required: "手机号码、邮箱二选一"
						}
					});
				$("#email").rules("add", {
					remote : {
						url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}&platform="+$("input[name=platform]:checked").val(),
						type : "post",
						dataType : "json"
					},
					required: {
	                    depends:function(){ //二选一  
	                        return ($('#mobilePhone').val().length <= 0);  
	                    }  
	                },
					messages : {
						remote : "该邮箱已存在",
						required :"手机号码、邮箱二选一"
					}
				});
			});
			$(document)
					.ready(
							function() {
								$("#loginName")
										.rules("add",
												{
													remote : {
														url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}",
														type : "post",
														dataType : "json"
													},
													messages : {
														remote : "该帐户名称已存在"
													}
												});
								refreshParentPage(true);
							});
			$(document).ready(function() {
				$("#mobilePhone")
						.rules("add",
								{
									remote : {
										url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}&platform="+$("input[name=platform]:checked").val(),
										type : "post",
										dataType : "json"
									},
									required: {
					                    depends:function(){ //二选一  
					                        return ($('#email').val().length <= 0);  
					                    }  
					                },
									messages : {
										remote : "该手机号码已存在",
										required: "手机号码、邮箱二选一"
									}
								});
				refreshParentPage(true);
			});
			$("#email").rules("add", {
				remote : {
					url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}&platform="+$("input[name=platform]:checked").val(),
					type : "post",
					dataType : "json"
				},
				required: {
                    depends:function(){ //二选一  
                        return ($('#mobilePhone').val().length <= 0);  
                    }  
                },
				messages : {
					remote : "该邮箱已存在",
					required :"手机号码、邮箱二选一"
				}
			});
			function setEnterprise(url, inputName) {
				var platform = $('input[name="platform"]:checked').val();
				$("#enterprise-btn").attr("href",
						url + platform + "?ajax=1&inputName=" + inputName);
			}

			/* function verification() {
				var platform = $('input[name="platform"]:checked').val();
				if(platform==undefined){
					platform="${entity.platform}";
				}
				
				var mobilePhone = $('input[name="mobilePhone"]').val();
				var result = false;
				$.ajax({
					url : "${dynamicDomain}/user/isUnique?ajax=1&objectId=${entity.objectId}&platform="+platform+"&mobilePhone="+mobilePhone, //后台处理程序    
		            type : "post",
		            dataType : "json",
		            success : function(json) {
		            	if(!json){
		            		winAlert("用户手机号重复");
		            	}else{
		            		if($("#User").valid()){
		            			result = true;
		            		}
		            	}
		            }
		        });
				return result;
			} */
		</script>
  <script type="text/javascript">
			$(function() {
				$("input[name='platform']").bind("change", function() {
					var platform = $('input[name="platform"]:checked').val();
					if (platform == 1) {
						$.ajax({
							url : '${dynamicDomain}/company/getPlatform',
							type : 'post',
							dataType : 'json',
							success : function(json) {
								$("#companyName").val(json.companyName);
								$("#companyId").val(json.companyId);
							}
						});
					}

				}).change();

			});
		</script>
</body>
</html>