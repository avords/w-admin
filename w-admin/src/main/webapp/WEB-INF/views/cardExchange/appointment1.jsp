<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="体检预约" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${msg }</div>
                <jdf:message code="卡密验证" />
            </h4>
        </div>
        <jdf:form bean="entity" scope="request">
            <form action="${dynamicDomain}/CardExchange/validateCard" method="post" class="form-horizontal" id="validateCardForm" >
               <div class="box-body">
               		<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="cardNo" class="col-sm-5 control-label">卡号
								</label>
								<div class="col-sm-5">
									<input type="text" name="cardNo" id="cardNo" class="form-control" value="${cardNo}" readonly="readonly"/>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="password" class="col-sm-5 control-label">密码<span style="color: red">* </span>：
								</label>
								<div class="col-sm-5">
									<input type="password" name="passWord" class="form-control" />
								</div>
							</div>
						</div>
					</div>
                </div>
                <div class="box-footer">
	                <div class="row">
	                    <div class="editPageButton">
	                       <button type="submit" class="btn btn-primary progressBtn">确认</button>
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