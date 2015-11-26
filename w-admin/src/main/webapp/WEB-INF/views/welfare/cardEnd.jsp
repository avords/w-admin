<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡密生成成功</title>
</head>
<body>
	<div>
		<div class="box-body">
			<h1 style="text-align: center;">提示</h1>
			<p class="lead" style="text-align: left;">恭喜您，预生成卡密${count }份成功。</p>
			<a href="${dynamicDomain}/cardCreateInfo/exportAll/${createInfoId }" style="text-align: left;font-size: 20px;text-decoration: underline;">导出卡密》》</a>
			<div class="box-footer"> 
				<div class="row">
					<div class="editPageButton">
						<a href="${dynamicDomain}/cardCreateInfo/cardCreateInfopage" class="btn btn-primary">
			             	返回
			            </a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	</script>
</body>
</html>