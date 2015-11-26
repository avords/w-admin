<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>核保单详情</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">核保单详情</h4>
    </div>
    <div class="box-body">
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-4 control-label">投保信息</label> 
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投保企业：</label> 
                <span class="">
                ${company.companyName}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">保险名称：</label> 
                <span class="">
                ${productPublish.name}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">保险规格：</label> 
                <span class="">
                ${attributeValue.attributeValue}
                </span>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">合同号：</label> 
                <span class=""> 
                	${insureOrder.contractNo}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投保时间：</label> 
                <span class=""> 
                	<fmt:formatDate value="${insureOrder.insureDate}" pattern="yyyy-MM-dd HH:mm" />
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投保账号：</label> 
                <span class=""> 
                	${user.loginName}
                </span>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投保角色：</label> 
                <span class=""> 
                	${role.name}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">手机号码：</label> 
                <span class=""> 
                	${user.mobilePhone}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">电子邮箱：</label> 
                <span class=""> 
                	${user.email}
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">订单编号：</label> 
                <span class=""> 
                	${subOrder.subOrderNo}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付时间：</label> 
                <span class=""> 
                	<c:if test="${subOrder.paymentDate!=null}">
	                	<fmt:formatDate value="${subOrder.paymentDate}" pattern="yyyy-MM-dd HH:mm" />
                	</c:if>
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">支付账号：</label> 
                <span class=""> 
                	${subOrder.payUserId}
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-4 control-label">供应商信息</label> 
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-3 col-md-3">
              <div class="form-group">
                <label class="col-sm-6 control-label">供应商编号：</label> 
                <span class=""> 
                	${supplier.supplierNo}
                </span>
              </div>
            </div>
            <div class="col-sm-3 col-md-3">
              <div class="form-group">
                <label class="col-sm-6 control-label">供应商名称：</label> 
                <span class=""> 
                	${supplier.supplierName}
                </span>
              </div>
            </div>
            <div class="col-sm-3 col-md-3">
              <div class="form-group">
                <label class="col-sm-6 control-label">联系人：</label> 
                <span class=""> 
                	${supplier.linker}
                </span>
              </div>
            </div>
            <div class="col-sm-3 col-md-3">
              <div class="form-group">
                <label class="col-sm-6 control-label">联系电话：</label> 
                <span class=""> 
                	${supplier.linkTelephone}
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-4 control-label">核保单信息</label> 
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">核保时间：</label> 
                <span class=""> 
                	<c:if test="${insureOrder.underwritingDate!=null}">
	                	<fmt:formatDate value="${insureOrder.underwritingDate}" pattern="yyyy-MM-dd HH:mm" />
                	</c:if>
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">参加投保人数：</label> 
                <span class="col-sm-3 control-label"> 
                	共${allNum}人
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">通过投保人数：</label> 
                <span class=""> 
                	${passNum}人
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">人均保费：</label> 
                <span class=""> 
                	
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label"></label> 
                <span class="col-sm-3 control-label"> 
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">未通过投保人数：</label> 
                <span class=""> 
                	${notPassNum}人
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">应付：</label> 
                <span class=""> 
                	
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="editPageButton">
              	<button type="button" class="btn btn-primary" id="expUserInfo">
					下载列表
				</button>
				<button type="button" class="btn btn-primary" id="impUserInsureOrder">
					上传核保结果
				</button>
              	<a href="${dynamicDomain}/insureOrder/page" class="btn btn-primary">返回 </a>
            </div>
          </div>
  </div>
  <form action="${dynamicDomain}/insureOrder/exportAll/${insureOrder.objectId}" method="post" class="form-horizontal" id="form1">
  </form>
<script type="text/javascript">
$(function(){
	$("#impUserInsureOrder").click(function(){
		var url = "${dynamicDomain}/insureOrder/importInsureOrder/${insureOrder.objectId}?ajax=1";
		//toUrl(url);
		$.colorbox({
			href:url,
			opacity:0.2,
			fixed:true,
			width:"40%",
			height:"55%", 
			iframe:true,
			onClosed:function(){ 
				if(true){
					parent.location.reload(true);
				}
			},
			close:"",
			overlayClose:false
		});
	});
	
	$("#expUserInfo").bind("click",function(){
		$("#form1").submit();
		
	});
});
</script>
</body>
</html>