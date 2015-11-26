<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>年节订单汇总表</title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
              		 年节订单汇总表
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/report/downExOrder" method="post" id="downExOrder" class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-8 col-md-8">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">下单时间<font color="red">*</font>：</label>
                                </div>
                                <input type="text" id="beginDate" name="beginDate" class="form-control pull-left" style="width: 200px;margin-right: 5px;" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'endDate\',{M:-1});}',maxDate:'#F{$dp.$D(\'endDate\')}',readOnly:true})"/>
			                    <input type="text" id="endDate"  name="endDate" class="form-control pull-left" style="width: 200px;margin-right: 5px;" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'beginDate\')}',maxDate:'%y-%M-%d'&&'#F{$dp.$D(\'beginDate\',{M:1});}',readOnly:true})"/>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">套餐编号<font color="red">*</font>：</label>
                                </div>
                                <input type="text" class="search-form-control" name="packageNo" id="packageNo">
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">卡密备注：</label>
                                </div>
                                <input type="text" class="search-form-control" name="remark" id="remark">
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label class="form-lable">项目名称：</label>
                                </div>
                                <input type="text" class="search-form-control" name="search_GED_reportDate" id="search_GED_reportDate">
                            </div>
                        </div>
                    </div>
                </div>
                
                
                <div class="box-footer">
                    <div class="pull-right">
                        <button type="button" class="btn" onclick="clearForm(this)">
                        	<i class="icon-remove icon-white"></i>重置
                        </button>
                        <button type="button" class="btn btn-primary" onclick="queryExOrder();">查询生成</button>
                    </div>
                </div>
                
                <div class="box-footer">
                    <div class="pull-left">
                       	<font color="red">说明：下单时间和套餐编号筛选条件为必输项</font>
                    </div>
                </div>
                
                
                
                <div class="box-footer" id="queryExOrder" style="display: none;">
                    <div class="pull-left">
                       	《年节订单汇总表》生成完成，请点击下载
                       	<button type="button" class="btn btn-primary" onclick="exportExOrder();">下载</button>
                    </div>
                </div>
                
                
                
                
                
                
                
                
            </form>
        </jdf:form>
    </div>
    
    
    <script type="text/javascript">
    	function queryExOrder(){
    		
    		var beginDate = $("#beginDate").val();
	    	var endDate = $("#endDate").val();
    		var packageNo = $("#packageNo").val();
    		
    		
    		if(beginDate==null || beginDate==''){
    			winAlert("下单时间不能为空");
    			return;
    		}
    		if(endDate==null || endDate==''){
    			winAlert("下单时间不能为空");
    			return;
    		}
			if(packageNo==null || packageNo==''){
				winAlert("套餐编号不能为空");
				return;
    		}
    		$("#queryExOrder").show();
    	}
    
    
    	//导出
    	function exportExOrder(){
    		var beginDate = $("#beginDate").val();
	    	var endDate = $("#endDate").val();
    		var packageNo = $("#packageNo").val();
    		
    		
    		if(beginDate==null || beginDate==''){
    			winAlert("下单时间不能为空");
    			return;
    		}
    		if(endDate==null || endDate==''){
    			winAlert("下单时间不能为空");
    			return;
    		}
			if(packageNo==null || packageNo==''){
				winAlert("套餐编号不能为空");
				return;
    		}
			$("#downExOrder").submit();
    	}
    </script>
    
</body>
</html>