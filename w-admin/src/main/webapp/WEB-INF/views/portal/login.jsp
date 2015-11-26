<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge;Chrome=1">
<meta name="renderer" content="webkit">
<meta charset="UTF-8" />
<link rel="stylesheet" type="text/css" media="all" href="../static/theme/d/css/bootstrap.min.css"/>
<link rel="stylesheet" type="text/css" media="all" href="../static/theme/d/css/login.css"/>
<!--[if lt IE 9]>
<script src="../static/js/html5.js"></script>
<script src="../static/js/respond.min.js"></script>
<![endif]-->
<script src="../static/js/jquery-1.8.2.min.js"></script>
<script src="../static/js/jquery.validate.min.js"></script>
<script src="../static/js/jquery.validate_zh.js"></script>
<script src="../static/js/jquery.placeholder.min.js"></script>
<title>IBS运营管理平台</title>
</head>
<body class="login">
	<div class="main-login col-md-4 col-md-offset-4 col-sm-6 col-sm-offset-3">
		<div class="box-login">
		     <form method="post" id="loginForm" action="${loginUrl}">
			    <div class="login-logo">
					 <h2>运营管理平台</h2>
				</div>
				<div class="alert alert-danger" id="messageBox" style="display: none;">
					<i class="fa fa-remove-sign" id="messageBox-remove-sign"></i>${message}
				</div>
			    <fieldset>
					<div class="form-group">
						<div  class="input-group">
							<div  class="input-group-addon"><span class="glyphicon glyphicon-user"></span></div>
							<input type="text" class="form-control" name="loginName" id="loginname" placeholder="登录名">
						</div >
					</div>
					<div class="form-group">
						<div  class="input-group">
							<div class="input-group-addon"><span class="glyphicon glyphicon-lock"></span></div>
							<input type="password" class="form-control password" name="password" placeholder="密码">
						</div>
					</div>
					<div class="form-group">
						<div  class="input-group">
							<div class="input-group-addon"><span class="glyphicon glyphicon-qrcode"></span></div>
							<input type="text" class="form-control" name="authcode" placeholder="验证码"/>
							<div class="input-group-addon" style="background: none;border: none;padding: 0px 0px 0px 5px;">
								<img src="../kaptcha" style="height:34px;width:120px;" id="kaptchaImage" class="img-rounded"/>
							</div>
							<input type="hidden" name="platform"  value="1"/>
						</div>
					</div>
					<div class="form-actions">
						<button type="submit" class="width-35 pull-right btn btn-primary">登录</button>
					</div>
				</fieldset>
			  </form>
		</div>
	</div>
	<script type="text/javascript">
	if(window.location!=window.parent.location){
		window.parent.location = "${loginUrl}";
	}
	$(function(){
		String.prototype.trim = function() {
			return this.replace(/(^\s*)|(\s*$)/g, "");
		};
		$('input').placeholder();
        $("#loginForm").validate({
            rules: {
            	loginName: {
                    required: true
                },
                password: {
                    required: true
                },
                authcode: {
                    required: true
                }
            },
            highlight: function(element) {
                $(element).closest('.form-group').addClass('has-error');
            },
            unhighlight: function(element) {
                $(element).closest('.form-group').removeClass('has-error');
            },
            errorElement: 'span',
            errorClass: 'help-block',
            errorPlacement: function(error, element) {
                if(element.parent('.input-group').length) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
        $("#loginname").focus();
        $("#kaptchaImage").click(
        	function(){
        		$(this).attr('src','../kaptcha?' + Math.floor(Math.random()*100)); 
        	}
        );
 
		$("#loginform").keydown(function(e){
			var e = e || event,
			keycode = e.which || e.keyCode;
			if (keycode==13) {
				$("#submit").trigger("click");
			}
		});
		
        if($("#messageBox-remove-sign").parent().text().trim().length!=0){
        	$("#messageBox").show();
        }else{
        	$("#messageBox").hide();
        }
    });

	</script>
</body>
</html>