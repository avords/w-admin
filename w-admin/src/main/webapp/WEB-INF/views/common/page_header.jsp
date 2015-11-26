<%@page import="com.handpay.ibenefit.security.entity.LoginLog"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(function() {
	if ($.cookie('screenFull') == 'true')
	{
		$("body").addClass("sidebar-collapse");
	}
});

function sidebarToggle(){
	if($.cookie('screenFull') == 'true'){
		$.cookie('screenFull', false,{path : '/'});
	}else{
		$.cookie('screenFull', true,{path : '/'});
	}
	$("body").toggleClass("sidebar-collapse");
}
try{
	if(navigator.userAgent.indexOf("MSIE")>0){
		if(navigator.userAgent.indexOf("MSIE 8.0")>0) {  
			var msg = '${message}';
	     	if(msg.length){
	     		alert(msg);
		     	//var url = location.href.replace(/\??message.*&?/,'');
		     	//window.open(url);
	     	} 
	    }
	}else{
		winAlert("${message}");
	}
}catch(e){
}

</script>
<header class="main-header">
	<a href="javascript:clickIndex('${dynamicDomain}')" class="logo"><img src="<jdf:theme/>/img/gw.v1.logo1.png"></a>
	<nav class="navbar navbar-static-top" role="navigation">
		<a href="javascript:sidebarToggle()" id="sidebar-toggle" class="sidebar-toggle" data-toggle="offcanvas" role="button">
	    	<span class="sr-only">Toggle navigation</span>
	  	</a>
		<div class="navbar-custom-menu" >
			<ul class="nav navbar-nav">
				<li class="dropdown user user-menu">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown"> 
						<span class="hidden-xs">欢迎您，${s_fullName }</span>
					</a>
				</li>
				<li class="dropdown user user-menu" onclick="javascript:logOut(1)">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown">
						<span class="hidden-xs">退出</span>
					</a>
				</li>
			</ul>
		</div>
	</nav>
</header>