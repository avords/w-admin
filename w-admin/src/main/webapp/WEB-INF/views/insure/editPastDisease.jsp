<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="既往症管理" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
            <jdf:form bean="entity" scope="request">
             <form method="post" action="${dynamicDomain}/pastDisease/save?ajax=1" class="form-horizontal" id="editForm">
                    <div class="callout callout-info">
                        <div class="message-right">${message }</div>
                        <h4 class="modal-title"><jdf:message code="既往症管理" />
                        <c:choose>
                            <c:when test="${entity.objectId eq null }">—新增</c:when>
                            <c:otherwise>—修改</c:otherwise>
                        </c:choose>
                        </h4>
                    </div>
                    <input type="hidden" name="objectId">
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">既往症名称</label>
                                   <div class="col-sm-8">
                                        <input type="text" class="form-control" name="name">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="sortNo"  class="col-sm-2 control-label">序号</label>
                                   <div class="col-sm-8">
                                        <input type="text" class="form-control" name="sortNo">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="description"  class="col-sm-2 control-label">详细说明</label>
                                   <div class="col-sm-8">
                                       <textarea name="description" rows="" cols="" style="width:100%;height:200px;"></textarea>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="submit" class="btn btn-primary">
                                        <jdf:message code="common.button.save"/>
                                </button>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="PastDisease"/>
</body>
</html>