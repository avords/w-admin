<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>角色管理</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">角色管理
			<c:choose>
				<c:when test="${entity.objectId eq null }">新增</c:when>
				<c:otherwise>修改</c:otherwise>
			</c:choose>
			</h4>
		</div>
			<form method="post" action="${dynamicDomain}/role/saveToPage" class="form-horizontal" id="Role" onsubmit="return verification();">
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="platform" class="col-sm-4 control-label">所属平台</label>
								<c:choose>
                                      <c:when test="${entity.objectId eq null }">
                                        <jdf:radio dictionaryId="1112" name="platform" />
                                      </c:when>
                                      <c:otherwise>
                                        <span class="lable-span"><jdf:dictionaryName dictionaryId="1112" value="${entity.platform }"/></span>
                                        <input type="hidden" name="platform" value="${entity.platform }">
                                      </c:otherwise>
                                  </c:choose>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="companyName" class="col-sm-4 control-label">公司名称</label>
								<c:choose>
                                      <c:when test="${entity.objectId eq null }">
                                        <div class="col-sm-6">
        									<input type="text" class="search-form-control" name="companyName" id="companyName" readonly="readonly"> 
        									<input type="hidden" class="search-form-control" name="companyId" id="companyId">
        								</div>
        								<div class="col-sm-2">
        									<a href="#" onclick="javascript:setEnterprise('${dynamicDomain }/user/getEnterprise/','company');"
        										id="enterprise-btn" class="pull-left btn btn-primary colorbox-template">
        											选择
        									</a>
        								</div>
                                      </c:when>
                                      <c:otherwise>
                                        <div class="col-sm-8">
                                          <span class="lable-span">${entity.companyName }</span>
                                        <input type="hidden" name="companyName" id="companyName" value="${entity.companyName }">
                                        <input type="hidden" name="companyId" id="companyId" value="${entity.companyId }">
                                        </div>
                                      </c:otherwise>
                                  </c:choose>
							</div>
						</div>
                </div>
                <div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="roleCode" class="col-sm-4 control-label">角色代码</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="roleCode" id="roleCode">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="name" class="col-sm-4 control-label">角色名称</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="name">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="remark" class="col-sm-2 control-label">备注</label>
								<div class="col-sm-10">
									<textarea rows="6" cols="16" style="width: 360px" class="search-form-control" name="remark"></textarea>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary"> 保存
								</button>
                     <a href="${dynamicDomain}/role/page" class="btn btn-primary">返回</a>
							</div>

						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<jdf:bootstrapDomainValidate domain="Role" />
	<script type="text/javascript">
	function verification() {
		var companyId = $('#companyId').val();
		var platform = $('input[name="platform"]:checked').val();
		var roleCode = $('input[name="roleCode"]').val();
		$.ajax({
			url : "${dynamicDomain}/role/isUnique?ajax=1&objectId=${entity.objectId}&companyId="+companyId+"&platform="+platform+"&roleCode="+roleCode, //后台处理程序    
            type : "post",
            dataType : "json",
            success : function(json) {
            	if(!json){
            		winAlert("该企业角色代码已经存在");
            		return false;
            	}else{
                	return true;
            	}
            }
        });
	}
	$("input[name='platform']").click(function(){
		$("input[name='companyId']").val("");
		$("input[name='companyName']").val("");
		$("#roleCode").val("");
		if($("input[name=platform]:checked").val()==1){
			$(":radio[name=type][value='1']").removeAttr("disabled");
			$(":radio[name=type][value='1']").attr("checked","true");
			$(":radio[name=type][value='2']").attr("disabled","true");
			$(":radio[name=type][value='3']").attr("disabled","true");
			$(":radio[name=type][value='4']").attr("disabled","true");
			$(":radio[name=type][value='5']").attr("disabled","true");
			$(":radio[name=type][value='6']").attr("disabled","true");
		}else if($("input[name=platform]:checked").val()==3){
			$(":radio[name=type][value='1']").attr("disabled","true");
			$(":radio[name=type][value='2']").attr("disabled","true");
			$(":radio[name=type][value='3']").attr("disabled","true");
			$(":radio[name=type][value='4']").removeAttr("disabled");
			$(":radio[name=type][value='4']").attr("checked","true");
			$(":radio[name=type][value='5']").removeAttr("disabled");
			$(":radio[name=type][value='6']").attr("disabled","true");
		}else if($("input[name=platform]:checked").val()==4){
			$(":radio[name=type][value='1']").attr("disabled","true");
			$(":radio[name=type][value='2']").removeAttr("disabled");
			$(":radio[name=type][value='2']").attr("checked","true");
			$(":radio[name=type][value='3']").removeAttr("disabled");
			$(":radio[name=type][value='4']").attr("disabled","true");
			$(":radio[name=type][value='5']").attr("disabled","true");
			$(":radio[name=type][value='6']").removeAttr("disabled");
		}
});
	function setEnterprise(url,inputName){
		var platform = $('input[name="platform"]:checked').val();
		$("#roleCode").val("");
		$("#enterprise-btn").attr("href",url+platform+"?ajax=1&inputName="+inputName);
	}
	/* $(document).ready(
			function() {
				$("#roleCode").bind("change",function(){
					var companyId = $('#companyId').val();
					var platform = $('input[name="platform"]:checked').val();
				     $("#roleCode").rules("add",{
				        remote : {
				            url : "${dynamicDomain}/role/isUnique?ajax=1&objectId=${entity.objectId}&companyId="+companyId+"&platform="+platform, //后台处理程序    
				            type : "get",
				            dataType : "json"
				        },
				        messages : {
				            remote : "该企业角色代码已经存在"
				        }
				    });
					refreshParentPage(true);
				});
	    }); */
	</script>
	<script type="text/javascript">
		$(function() {
			$("input[name='platform']").bind("change",function(){
				var platform = $('input[name="platform"]:checked').val();
				if(platform == 1){
					$.ajax({
			            url:'${dynamicDomain}/company/getPlatform',
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