<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<jdf:themeFile file="displaytag.css"/>
<script language="javascript">
	function check(frm){
		alert(frm.action);
	}
</script>
</head>
<body>
	<h2>用户</h2>
	<form action="${dynamicDomain }/dict/page" method="post">
		<ul>
			<li>名称<input type="text"  name="search_LIKES_name" /></li>
			<li>值<input type="text"  name="search_LIKES_value" /></li>
			<li>备注<input type="text"  name="search_LIKES_comment" /></li>
		</ul>
		<input type="submit" value="查询"/>
	</form>
	<display:table name="pageList" export="true" requestURI="page"
		sort="list" pagesize="10" id="currentRowObject" size="page.totalCount">
		<display:column property="id" />
		<display:column property="parentId" title="父节点ID" sortable="true" headerClass="sortable" />
		<display:column property="name" autolink="true" sortable="true" headerClass="sortable" />
		<display:column property="value" title="值" sortable="true" headerClass="sortable" />
		<display:column property="comment" title="备注" sortable="true" headerClass="sortable" />
		<display:column property="sortId" title="顺序" sortable="true" headerClass="sortable" />
		<display:column title="操作">
			<a href="${dynamicDomain }/dict/edit/${currentRowObject.id}">修改</a>
		</display:column>
		<display:setProperty name="export.excel.filename" value="haha.xls" />
	</display:table>
</body>
</html>