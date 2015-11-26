<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="报表管理" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
            <jdf:form bean="entity" scope="request">
             <form method="post" action="${dynamicDomain}/report/save?ajax=1" class="form-horizontal" id="editForm">
                    <div class="callout callout-info">
                        <div class="message-right">${message }</div>
                        <h4 class="modal-title"><jdf:message code="报表管理" />
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
                                   <label for="reportName"  class="col-sm-2 control-label">报表名称</label>
                                   <div class="col-sm-8">
                                       <input type="text" class="form-control" name="reportName" id="reportName">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                      <label for="statisticalCycle" class="col-sm-4 control-label">统计周期</label>
                                      <div class="col-sm-6">
                                          <select name="statisticalCycle" class="form-control">
                                             <option value="">—请选择—</option>
                                             <jdf:select dictionaryId="2000"/>
                                           </select>
                                      </div>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                        <label for="platform" class="col-sm-4 control-label">所属平台</label>
                                        <div class="col-sm-6">
                                            <select name="platform" class="form-control">
                                             <option value="">—请选择—</option>
                                             <jdf:select dictionaryId="1112"/>
                                         </select>
                                        </div>
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="form-group">
                                      <label for="reportSql" class="col-sm-4 control-label">SQL</label>
                                      <div class="col-sm-8">
                                           <textarea style="width:650px;height: 280px;" name="reportSql"></textarea>
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
    <jdf:bootstrapDomainValidate domain="Report"/>
     <script type="text/javascript">  
        $(function(){
            if('${param.result}'=='true'){
                parent.winAlertReload('操作成功');
                parent.$.colorbox.close();
            }
        });
    </script>  
</body>
</html>