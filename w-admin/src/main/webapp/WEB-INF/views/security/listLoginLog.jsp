<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title> 用户登录日志查询</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right"> ${message }</div>
                          用户登录日志查询
      </h4>
    </div>

    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/loginLog/page" method="post" class="form-horizontal">
        
        		<div class="box-body">
					<div class="row">
					
					    <div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_loginName"
									class="col-sm-4 control-label">登录账户：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_loginName">
								</div>
							</div>
						</div>
						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_ip" class="col-sm-4 control-label">登录IP：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_ip">
								</div>
							</div>
						</div>
					
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_platform" class="col-sm-4 control-label">用户类型：</label>
								<div class="col-sm-8">
									 <select name="search_EQI_type" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1111" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
					    <div class="col-sm-8 col-md-8">
						  <div class="form-group">
			                
			                 <label for="search_EQI_platform" class="col-sm-2 control-label">登录时间：</label>
			                 <div class="col-sm-3">
			                  <input class="search-form-control" id="search_GED_beginDate" name="search_GED_beginDate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',maxDate:'#F{$dp.$D(\'search_LED_beginDate\')}'})" class="search-form-control" />
							 </div>	
							 
							 <div class="col-sm-1">
                               <span class="lable-span">—</span>
                            </div>
							
							 <div class="col-sm-3">
			                  <input class="search-form-control" id="search_LED_beginDate" name="search_LED_beginDate" type="text" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',minDate:'#F{$dp.$D(\'search_GED_beginDate\')}'})" class="search-form-control" />
							 </div>	
					       </div>
				        </div>
				  </div>
					
				</div>
             
              <div class="box-footer">
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">查询
						</button>
						<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i> 重置
						</button>
					</div>
				</div>
            
      </form>
    </jdf:form>
    
    <div id="tableDiv">
      <jdf:table items="items" retrieveRowsCallback="limit" var="currentRowObject" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
       
        <jdf:export view="csv" fileName="login_Log.csv" tooltip="导出CSV" imageName="csv" />
        <jdf:export view="xls" fileName="login_Log.xls" tooltip="导出EXCEL" imageName="xls" />
        
        <jdf:row>
           <jdf:column property="rowcount" cell="rowCount" title="序号" style="width:4%;text-align:center" sortable="false"/>
          <jdf:column property="loginName" title="system.lable.user.login_name" style="width:10%" />
           <jdf:column property="ip" title="登录IP" style="width:10%" />
          <jdf:column property="beginDate" title="system.lable.login.begin_date" style="width:20%" cell="date" format="yyyy-MM-dd HH:mm:ss" />
        </jdf:row>
      </jdf:table>
    </div>
 </div>

</body>
</html>