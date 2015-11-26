<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品分类属性管理" /></title>
</head>
<body>
    <div>
         <div class="callout callout-info">
             <div class="message-right" style="margin-right: 30px;font-size: 20px;">${message }</div>
             <h4 class="modal-title"><jdf:message code="查看对应前端分类" />
             </h4>
         </div>
         <table  class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>前端平台</th>
                    <th>一级分类名称</th>
                    <th>二级分类名称</th>
                    <th>三级分类名称</th>
                  </tr>
                </thead>
                <c:forEach items="${items}" var="item" varStatus="num">
                  <tbody>
                    <tr>
                      <td><jdf:columnValue dictionaryId="1114" value="${item.platform}" /></td>
                      <td>${item.firstName}</td>
                      <td>${item.secondName}</td>
                      <td>${item.name}</td>
                    </tr>
                  </tbody>
                </c:forEach>
              </table>
    </div>
</body>
</html>