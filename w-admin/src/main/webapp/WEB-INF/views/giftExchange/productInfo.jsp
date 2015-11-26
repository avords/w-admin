<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/taglibs.jsp"%>
<html>
<head>
<meta charset="utf-8" />
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>礼品兑换 - 官网</title>
<script src="${staticDomain}js/jquery.1.8.3.min.js"></script>
<link media="all" rel="stylesheet" href="${staticDomain}css/global.css" />
<link media="all" rel="stylesheet" href="${staticDomain}css/gw.main.v1.css" />
</head>
<body>


	<h5 class="gw-tt">
		<span class="z-t5">商品详情</span>
	</h5>

	<div id="gw-p2-5">
	    ${product.description}
		<img src="${staticDomain}image/gw.v1.tmp01.gif" />
		<h5>
			<a href="javascript:void(0)" class="f-ib j-btn-back">返回</a>
		</h5>
	</div>

	<script>
$(function(){

	// 关闭页面
	$('.j-btn-back').click(function(){

		window.close();
	});
	
});
</script>

	<script>var isFtFot = false;</script>

</body>
</html>