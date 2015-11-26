<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
</head>
<body>
	<div class="contentBody contentborder">
		<div class="tab-pane" id="tabPane">
			<div id="message"><%=message %></div>
			<div class="tab-page">
				 <h1 class="tab">属地列表</h1>
 				 <div class="contentborder">
                	 <jdf:form bean="request" scope="request">
						 <form action="${dynamicDomain}/dimLocation/page" method="post">
							 <table class="inputTable">
			                 	<tr>
									<td nowrap class="label cancelBorderLeft">
										<label for="search_LIKES_fullCode">属地全路径编码：</label>
									</td>
									<td class="content">
										<input type="text" name="search_LIKES_fullCode" size="12"/>
									</td>
									<td nowrap class="label">
										<label for="search_LIKES_fullName">属地全路径名称：</label>
									</td>
									<td class="content">
										<input type="text" name="search_LIKES_fullName" size="12"/>
									</td>
			                 	</tr>
			                 	<tr>
                                	<td class="bottomLabel" nowrap colspan="4">
                                		<div class="right">
											<button type="reset">重置</button>
											<button type="submit">查询</button>
                                		</div>
									</td>
			                 </table>
			            </form>
			        </jdf:form>
				</div>
				<div class="contentborder listArea">
					<div class="toolBar">
		 				<button type="button" onclick="window.location.href='${dynamicDomain}/dimLocation/create'">增加</button>
					</div>
					<div id="tableDiv">
						<jdf:table items="items"  retrieveRowsCallback="limit" var="dimLocation" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
							<jdf:export fileName="属地.csv" tooltip="导出CSV" />
							<jdf:export fileName="属地.xls" tooltip="导出EXCEL"/>
							<jdf:row>
								<jdf:column property="fullCode" title="属地全路径编码" style="width: 30%" />
								<jdf:column property="fullName" title="属地全路径名称" style="width: 40%" />
								<jdf:column property="category" title="类别" style="width: 20%">
									<jdf:columnValue dictionaryId="125" value="${dimLocation.category}"/>
								</jdf:column>
								<jdf:column alias="操作" sortable="false" viewsAllowed="html" style="width: 10%">
									<a href="${dynamicDomain}/dimLocation/edit/${dimLocation.id}">修改</a>
									<a href="#" onclick="toDeleteUrl('${dynamicDomain}/dimLocation/delete/${dimLocation.id}')">删除</a>
								</jdf:column>
							</jdf:row>
						</jdf:table>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
