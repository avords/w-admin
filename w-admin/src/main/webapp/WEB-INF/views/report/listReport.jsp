<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="报表管理" /></title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="报表管理" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/report/page" method="post"  class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">报表名称：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_LIKES_reportName">
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">统计周期：</label>
                                </div>
                                <select name="search_EQI_statisticalCycle" class="search-form-control">
                                    <option value="">—全部—</option>
                                    <jdf:select dictionaryId="2000" valid="true" />
                                </select>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">所属平台：</label>
                                </div>
                                <select name="search_EQI_platform" class="search-form-control">
                                    <option value="">—全部—</option>
                                    <jdf:select dictionaryId="1112" valid="true" />
                                </select>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <a href="${dynamicDomain}/report/create?ajax=1" class="btn btn-primary pull-left colorbox-double">
                        <span class="glyphicon glyphicon-plus"></span>
                    </a>
                    <input type="text" id="reportDate" class="form-control pull-left" style="width: 100px;margin-right: 5px;" class="Wdate" 
                    onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})">
                    <input type="text" id="endDate" class="form-control pull-left" style="width: 100px;margin-right: 5px;" class="Wdate" 
                    onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'reportDate\')}',maxDate:'%y-%M-%d',readOnly:true})">
                    <button type="button" class="btn btn-primary pull-left" onclick="javascript:generateReport();">手工生成</button>
                    <div class="pull-right">
                        <button type="button" class="btn" onclick="clearForm(this)">
                        	<i class="icon-remove icon-white"></i>重置
                        </button>
                        <button type="submit" class="btn btn-primary">查询
                        </button>
                    </div>
                </div>
            </form>
        </jdf:form>
    </div>

    <div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="报表管理.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="报表管理.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
            	<jdf:column alias="" title="<input type='checkbox' name='pchk' onclick='pchkClick()'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
                <jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 10%">
                    <a href="${dynamicDomain}/report/edit/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-big"> 
                        <i class="glyphicon glyphicon-pencil"></i>
                    </a>
                    <a href="javascript:toDeleteUrl('${dynamicDomain}/report/delete/${currentRowObject.objectId}')"  class="btn btn-danger btn-mini"> 
                    	<i class="glyphicon glyphicon-trash"></i>
                    </a>
                </jdf:column>
                <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="objectId" title="ID" headerStyle="width:10%;" />
                <jdf:column property="reportName" title="报表名称" headerStyle="width:20%;" />
                <jdf:column property="statisticalCycle" title="统计周期" headerStyle="width:15%;">
                    <jdf:columnValue dictionaryId="2000" value="${currentRowObject.statisticalCycle}" />
                </jdf:column>
                <jdf:column property="platform" title="所属平台" headerStyle="width:15%;">
                    <jdf:columnValue dictionaryId="1112" value="${currentRowObject.platform}" />
                </jdf:column>
            </jdf:row>
        </jdf:table>
    </div>
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
	    	var reportDate = $("#reportDate").val();

	    	var endDate = $("#endDate").val();
	    	if(reportDate==null){
	    		winAlert("报表日期不能为空");
	    		return false;
	    	}
	    	var content = '';
	        $(".option:checked").each(function(){
	            content =content+$(this).val()+",";
	        });
	        
	        if(content.length==0){
	        	winAlert("请至少选择一个报表");
	    		return false;
	        }
	        $.ajax({
                url:"${dynamicDomain}/report/runReport",
                type : 'post',
                dataType : 'json',
                data:"reportDate=" + reportDate + "&reportIds=" + content+"&endDate="+endDate,
                success : function(json) {
                	var reportList = "";
                	if(json.result){
                		var dataId = json.result.split(",");
                		for(i=0;i<dataId.length;i++){
                			reportList += '<a href="${dynamicDomain}/report/downloadReport/' + dataId[i] + '">' + dataId[i] + '</a>&nbsp;';
                		}
                		
                	}
                    winAlert("操作成功!<br/>" + reportList);
                }
            });
	    }
    </script>
</body>
</html>