<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>导入员工管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				导入员工管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/companyStaff/viewInfo/${companyId}" method="post" class="form-horizontal">
				<input type="hidden" name="search_EQL_companyId" id="search_EQL_companyId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">导入状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1313" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">导入时间：</label>
								<div class="col-sm-4">
						            <input  name="search_GED_importDate"  id="search_GED_importDate" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_importDate\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
								</div>
								<div class="col-sm-4">
									<input  id="search_LED_importDate" name="search_LED_importDate"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_importDate\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">员工姓名：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_staffName">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<a href="${dynamicDomain}/companyStaff/importStaffs/${companyId}?ajax=1" class="btn btn-primary colorbox">导入</a>
						<button type="button" class="btn btn-primary" id="exportAll">
							导出
						</button>
						<button type="button" class="btn btn-primary" id="verifyAll">
							数据校验
						</button>
						<button type="button" class="btn btn-primary" id="deleteAll">
							删除
						</button>
					</div>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							重置
						</button>
						<button type="submit" class="btn btn-primary">
							<jdf:message code="common.button.query" />
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/companyStaff/viewInfo/${companyId }">
			<jdf:export view="csv" fileName="companyStaff.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="companyStaff.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox' id='checkall' style='margin-left:5px;'>" sortable="false" viewsAllowed="html" headerStyle="width: 3%;">
					<input type="checkbox" name="checkid" id="checkid" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column property="loginName" title="员工账户" headerStyle="width:7%;"/>
				<jdf:column property="workNo" title="员工工号" headerStyle="width:7%;"/>
				<jdf:column property="departmentId" title="所属机构" headerStyle="width:10%;" />
				<jdf:column property="staffName" title="姓名" headerStyle="width:7%;"/>
                <jdf:column property="entryDay" cell="date" title="入职日期" headerStyle="width:7%;"/>
                <jdf:column property="telephone" title="手机号码" headerStyle="width:7%;"/>
				<jdf:column property="email" title="邮箱" headerStyle="width:6%;" />
				<jdf:column property="status" title="导入状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1313" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="logs" title="错误日志" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	 $("#checkall").click( 
		function(){ 
			if(this.checked){ 
				$("input[name='checkid']").each(function(){this.checked=true;}); 
			}else{ 
				$("input[name='checkid']").each(function(){this.checked=false;}); 
			} 
	});
	 
	$("#exportAll").click(function(){ 
        var id="";
	 	if($("input[type='checkbox'][name='checkid']").is(':checked')){
			$("input[name='checkid']:checked").each(function(){
				id+=this.value+",";
			}); 
			ids=id.substring(0,id.lastIndexOf(","));
			var url="${dynamicDomain}/companyStaff/exportAll?companyId=${companyId}&ids="+ids;
			window.open(url);
		}else{
			alert("请勾选要导出的项！");
		} 
	});
	
	$("#verifyAll").click(function(){ 
        var id="";
	 	if($("input[type='checkbox'][name='checkid']").is(':checked')){
			$("input[name='checkid']:checked").each(function(){
				id+=this.value+",";
			}); 
			ids=id.substring(0,id.lastIndexOf(","));
			$.ajax({  
			    url:"${dynamicDomain}/companyStaff/verifyAll",
				type : 'post',
				data : "ids="+ids+'&companyId=${companyId}&data='+ (new Date().getDate()),
				dataType : 'json',
				success : function(msg) {
					if(msg.result=='true'){
						alert("校验成功！");
					}else{
						alert("校验失败，请重新校验");
					}
					window.location.reload();
				}
			});
		}else{
			alert("请勾选要校验的项！");
		} 
	});
	
	$("#deleteAll").click(function(){ 
		var id="";
		if($("input[type='checkbox'][name='checkid']").is(':checked')){
			if(confirm("你确认要删除？")){
				$("input[name='checkid']:checked").each(function(){
					id+=this.value+",";
				}); 
				ids=id.substring(0,id.lastIndexOf(","));
				$.ajax({  
				    url:"${dynamicDomain}/companyStaff/deleteAll",
					type : 'post',
					data : "ids="+ids+'&data='+ (new Date().getDate()),
					dataType : 'json',
					success : function(msg) {
						if(msg.result==true){
							alert("删除成功！");
							window.location.reload();
						}
					}
				});
			}
		}
		else{
			alert("请勾选要删除的项！");
		} 
	});
	</script>
</body>
</html>