<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>首页</title>
</head>
<body>
	<section class="content">
		<c:forEach items="${userMenus }" var="userMenu">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title">${userMenu.folderName }</h3>
				</div>
				<c:forEach items="${userMenu.menus }" var="menu">
					<div class="panel-body">
						<a
							href="javascript:clickSubMenu(${menu.objectId},${menu.parentId },'${dynamicDomain}${menu.url }')">${menu.name }</a>
					</div>
				</c:forEach>
			</div>
		</c:forEach>
	</section>
</body>
