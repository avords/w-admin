<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="运营端-礼券兑换" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${msg }</div>
                <jdf:message code="运营端-礼券兑换" />
            </h4>
        </div>
        <jdf:form bean="entity" scope="request">
            <form action="${dynamicDomain}/giftExchange/validateCard" method="post" class="form-horizontal" id="validateCardForm" >
                <div class="box-body">
               		<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cardNo" class="col-sm-4 control-label">卡号
								</label>
								<div class="col-sm-8">
									<input type="text" name="cardNo" class="form-control" value="${cardNo}"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="password" class="col-sm-4 control-label">密码<span style="color: red">* </span>：
								</label>
								<div class="col-sm-8">
									<input type="password" name="passWord" class="form-control" />
								</div>
							</div>
						</div>
					</div>
                </div>
                <div class="box-footer">
	                <div class="row">
	                    <div class="editPageButton">
	                       <button type="submit" class="btn btn-primary">确认</button>
	                    </div>
	                        
	                </div>
                </div>
            </form>
        </jdf:form>
    </div>
        <jdf:bootstrapDomainValidate domain="CardInfo"/>
        <script type="text/javascript">
        $(function(){
        	
        	
        });
        </script>
</body>
</html>