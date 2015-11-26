<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>账户充值管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				账户充值管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/companyAccount/page" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">公司名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">用户账户：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_loginName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1311" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">申请时间：</label>
								<div class="col-sm-4">
						            <input  name="search_GED_applyTime"  id="search_GED_applyTime" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_applyTime\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
								</div>
								<div class="col-sm-4">
									<input  id="search_LED_applyTime" name="search_LED_applyTime"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_applyTime\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<a href="${dynamicDomain}/companyAccount/create?ajax=1" class="btn btn-primary colorbox-big pull-left">
							充值
					    </a>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" headerStyle="width: 7%">
				<c:if test="${currentRowObject.status==1}">
					<button type="button" class="btn btn-primary" onClick="return cancleApply(${currentRowObject.objectId});">取消申请</button>
				</c:if>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 5%" style="text-align:center" sortable="false"/>
                <jdf:column property="loginName" title="用户账户" headerStyle="width:7%" />
				<jdf:column property="companyName" title="公司名称" headerStyle="width:8%;" />
				<jdf:column property="userName" title="用户姓名" headerStyle="width:7%" />
				<jdf:column property="telephone" title="用户联系方式" headerStyle="width:10%" />
				<jdf:column property="email" title="用户邮箱" headerStyle="width:8%" />
				<jdf:column property="accountStatus" title="账户状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1312" value="${currentRowObject.accountStatus}" />
				</jdf:column>
				<jdf:column property="rechargeMoney" title="充值金额" headerStyle="width:7%;" >
					<font color="red"><fmt:formatNumber type="number" value="${currentRowObject.rechargeMoney}" maxFractionDigits="2"/> </font>
				</jdf:column>
				<jdf:column property="accountMoney" title="账户余额" headerStyle="width:8%" >
					<fmt:formatNumber type="number" value="${currentRowObject.accountMoney}" maxFractionDigits="2"/>
				</jdf:column>
				<jdf:column property="status" title="状态" headerStyle="width:6%;" >	
                <c:if test="${currentRowObject.status!=4}">
					<jdf:columnValue dictionaryId="1311" value="${currentRowObject.status}" />
				</c:if>
				<c:if test="${currentRowObject.status==4}">
					<a data-content="${currentRowObject.reasons}" rel="popover" href="#" class="view" style="font-size:14px;">审核不通过</a>
				</c:if>
				</jdf:column>
				<jdf:column property="applyName" title="申请人" headerStyle="width:7%" />
				<jdf:column property="applyTime" title="申请时间" cell="date"  headerStyle="width:8%;" />
				
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function cancleApply(id){
		 $.ajax({
             url:"${dynamicDomain}//companyAccount/cancleApply/" +id,
             type : 'post',
             dataType : 'json',
             success : function(json) {
                 if(json.result==true){
                	 location.reload(true); 
                 }else{
                	 alert("申请失败，请检查");
                 }
             }
         });
	}
	
	$(document).ready(function(){
		$("a.view").popover({trigger:'hover'});
	});
	</script>
</body>
</html>