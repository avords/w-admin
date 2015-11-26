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
            <form action="${dynamicDomain}/custRunReport/queryReport/${reportId}" method="post" class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-12 col-md-12">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">统计日期：</label>
                                </div>
                                <input type="text" id="reportDate" class="form-control pull-left" style="width: 100px;margin-right: 5px;" class="Wdate" 
                    onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})">
                    <input type="text" id="endDate" class="form-control pull-left" style="width: 100px;margin-right: 5px;" class="Wdate" 
                    onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'reportDate\')}',maxDate:'%y-%M-%d',readOnly:true})">
                    <button type="button" class="btn btn-primary pull-left" onclick="javascript:generateReport();">查询生成</button>
                            </div>
                        </div>
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
                <jdf:column property="reportName" title="报表名称" headerStyle="width:50%;">
                	<a href="${dynamicDomain}/report/downloadReport/${currentRowObject.objectId}?ajax=1" >${currentRowObject.reportName}</a>
                </jdf:column>
                <jdf:column property="platform" title="所属平台" headerStyle="width:15%;">
                    <jdf:columnValue dictionaryId="1112" value="${currentRowObject.platform}" />
                </jdf:column>
                <jdf:column property="reportDate" title="统计日期" headerStyle="width:20%;" cell="date"/>
            </jdf:row>
        </jdf:table>
    </div>
    </c:if>
    <script type="text/javascript">
	    $(function(){
	    	$(".colorbox-big").colorbox({
	            opacity : 0.2,
	            fixed : true,
	            width : "65%",
	            height : "90%",
	            iframe : true,
	            close:"",
	            onClosed : function() {
	                if (false) {
	                    location.search=location.search.replace(/message.*&/,"");
	                }
	            },
	            overlayClose : false
	        });
	    });
	    
	    function generateReport(){
	    	var _this = $(this), _dis = 'dis';
			if(_this.hasClass(_dis)) 
			return false;
			_this.addClass(_dis);
	    	var reportDate = $("#reportDate").val();
	    	var endDate = $("#endDate").val();
	    	if(reportDate==null||endDate==null){
	    		winAlert("报表日期不能为空");
	    		return false;
	    	}
	        $.ajax({
                url:"${dynamicDomain}/report/runReport",
                type : 'post',
                dataType : 'json',
                data:"reportDate=" + reportDate + "&reportIds=${reportId}&endDate="+endDate,
                success : function(json) {
                	var reportList = "";
                	if(json.result){
                		window.location.reload();
                	}
                    winAlert("操作成功!<br/>" + reportList);
                }
            });
	    }
    </script>
</body>
</html>