<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业自主申请管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业自主申请管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/apply" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label class="col-sm-2 control-label">企业所在地：</label>
								<div class="col-sm-8">
									<ibs:areaSelect code="${param.search_STARTS_areaId}" district="search_STARTS_areaId" styleClass="form-control inline"/>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">手机：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_telephone">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业规模：</label>
								<div class="col-sm-8">
									<select name="search_EQI_type" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1301" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">行业：</label>
								<div class="col-sm-8">
									<select name="search_EQI_companyType" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1303" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_applyStatus" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1308" valid="true" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_linker">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">联系人邮箱：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_email">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<button type="button" class="btn btn-primary" id="callOn">
							分配
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="apply">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;">
					<input type="checkbox" name="checkid" id="checkid" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 5%" style="text-align:center" sortable="false"/>
				<jdf:column property="applyStatus" title="状态" headerStyle="width:6%;">
					<jdf:columnValue dictionaryId="1308" value="${currentRowObject.applyStatus}" />
				</jdf:column>
				<jdf:column property="followSum" title="跟进次数" headerStyle="width:8%;" />
				<jdf:column property="managerId" title="客户经理" style="width:8%">
                   <jdf:columnCollectionValue items="users"  nameProperty="userName" value="${currentRowObject.managerId}" />
                </jdf:column>
				<jdf:column property="channels" title="省" headerStyle="width:5%;">
					<jdf:columnValue dictionaryId="1311" value="${currentRowObject.channels}" />
				</jdf:column>
				<jdf:column property="channels" title="市" headerStyle="width:5%;">
					<jdf:columnValue dictionaryId="1312" value="${currentRowObject.channels}" />
				</jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:8%;">
					<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}?ajax=1" class="colorbox-big">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.companyName}</font></a>
				</jdf:column>
				<jdf:column property="webSite" title="企业网址" headerStyle="width:10%;" />
				<jdf:column property="companyType" title="行业" headerStyle="width:5%;">
					<jdf:columnValue dictionaryId="1303" value="${currentRowObject.companyStatus}" />
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:6%;" />
				<jdf:column property="email" title="联系人邮箱" headerStyle="width:8%;" />
				<jdf:column property="phone" title="办公电话" headerStyle="width:8%;" />
				<jdf:column property="telephone" title="手机" headerStyle="width:7%;" />
				<jdf:column property="channels" title="了解渠道" headerStyle="width:8%;">
					<jdf:columnValue dictionaryId="1309" value="${currentRowObject.channels}" />
				</jdf:column>
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
	$("#callOn").click(function(){ 
        var id="";
	 	if($("input[type='checkbox']").is(':checked')){
			$("input[name='checkid']:checked").each(function(){
				id+=this.value+",";
			}); 
			ids=id.substring(0,id.lastIndexOf(","));
			var url="${dynamicDomain}/company/callOn?ajax=1&ids="+ids;
			$.colorbox({href:url,opacity:0.2,fixed:true,width:"55%", height:"75%", iframe:true,onClosed:function(){ if(reloadParent){location.reload(true);}},overlayClose:false});
		}else{
			alert("请勾选要分配的企业！");
		} 
	});
	</script>
</body>
</html>