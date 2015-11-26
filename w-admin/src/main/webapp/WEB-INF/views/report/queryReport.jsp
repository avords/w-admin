<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>${report.reportName }</title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                ${report.reportName }
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/report/queryReport/${report.objectId}" method="post" class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">统计日期：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_GED_reportDate" id="search_GED_reportDate" style="width: 100px;display: inline" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_reportDate\')}'})">-
                                <input type="text" class="search-form-control" name="search_LED_reportDate" id="search_LED_reportDate" style="width: 100px;display: inline" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_reportDate\')}',maxDate:'%y-%M-%d',readOnly:true})">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <div class="pull-right">
                        <button type="button" class="btn" onclick="clearForm(this)">
                        	<i class="icon-remove icon-white"></i>重置
                        </button>
                        <button type="submit" class="btn btn-primary">查询</button>
                    </div>
                </div>
            </form>
        </jdf:form>
    </div>
    <c:if test="${not empty report.platform }">
    <div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${report.objectId}">
            <jdf:export view="csv" fileName="报表管理.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="报表管理.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
                <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 5%">
                    <a href="${dynamicDomain}/report/downloadReport/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini"> 
                        <i class="glyphicon glyphicon-download-alt"></i>
                    </a>
                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:5%;text-align:center"/>
                <jdf:column property="reportName" title="报表名称" headerStyle="width:70%;">
                	<a href="${dynamicDomain}/report/downloadReport/${currentRowObject.objectId}?ajax=1" >${currentRowObject.reportName}</a>
                </jdf:column>
                <jdf:column property="reportDate" title="统计日期" headerStyle="width:20%;" cell="date"/>
            </jdf:row>
        </jdf:table>
    </div>
    </c:if>
</body>
</html>