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
				账户充值审核
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/companyAccount/verify" method="post"
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
								<label class="col-sm-4 control-label">充值时间：</label>
								<div class="col-sm-4">
						            <input  name="search_GED_verifyDate"  id="search_GED_verifyDate" class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_verifyDate\')}',dateFmt:'yyyy-MM-dd'})" readonly/> 
								</div>
								<div class="col-sm-4">
									<input  id="search_LED_verifyDate" name="search_LED_verifyDate"  class="search-form-control "  style="display: inline-block;"  type="text" onFocus="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_verifyDate\')}',dateFmt:'yyyy-MM-dd'})" readonly/>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="verify" >
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row highlightRow="false">
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" headerStyle="width: 10%">
				<c:if test="${currentRowObject.status==1}">
					<button type="button" class="btn btn-primary" onClick="if(confirm('你确定审核通过？')){verifySuccess(${currentRowObject.objectId});}">&nbsp;&nbsp;审核通过&nbsp;&nbsp;&nbsp;</button>
					<button type="button" class="btn btn-primary" onClick="return verifyFail(${currentRowObject.objectId});">审核不通过</button>
				</c:if>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
                <jdf:column property="loginName" title="用户账户" headerStyle="width:6%" />
				<jdf:column property="companyName" title="公司名称" headerStyle="width:6%;" />
				<jdf:column property="userName" title="用户姓名" headerStyle="width:7%" />
				<jdf:column property="telephone" title="用户联系方式" headerStyle="width:6%" />
				<jdf:column property="email" title="用户邮箱" headerStyle="width:7%" />
				<jdf:column property="accountStatus" title="账户状态" headerStyle="width:6%;">
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
				<jdf:column property="applyName" title="申请人" headerStyle="width:6%" />
				<jdf:column property="applyTime" title="申请时间" cell="date"  headerStyle="width:7%;" />
				<jdf:column property="verifyName" title="审核人" headerStyle="width:6%" />
				<jdf:column property="verifyDate" title="审核时间" cell="date"  headerStyle="width:7%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function verifySuccess(companyAccountId){
		$.ajax({
            url:"${dynamicDomain}//companyAccount/verifySuccess/" + companyAccountId,
            type : 'post',
            dataType : 'json',
            success : function(json) {
            	if(json.result==true){
            		window.location.reload(true); 
                }
            }
        });
	}
	
	function verifyFail(id){ 
		var url="${dynamicDomain}/companyAccount/reasonsForFail/"+id+"?ajax=1";
		$.colorbox({href:url,opacity:0.2,fixed:true,width:"35%", height:"45%", iframe:true,onClosed:function(){ if(reloadParent){parent.location.reload(true);}},overlayClose:false});
	}
	
	$(document).ready(function(){
		$("a.view").popover({trigger:'hover'});
	});
	
	</script>
</body>
</html>