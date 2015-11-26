<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业信息</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/multiCompanyTemplate?ajax=1&inputName=physicalPromoteForm.companys" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">企业名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_companyName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setCompanies();" class="btn btn-primary pull-left">确认</a>
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

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="multiCompanyTemplate?ajax=1">
			<jdf:export view="csv" fileName="sku.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="sku.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.companyName}" />
				</jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:20%;" />
				<jdf:column property="addressDetail" title="详细地址" headerStyle="width:20%;" />
				<jdf:column property="linker" title="联系人" headerStyle="width:20%;" />
				<jdf:column property="phone" title="联系电话" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setCompanies(){
		var selected = getCheckedValuesString($("input[name='schk']"));
		if(selected!=null){
			var companies = selected.split(",");
			var companyDiv = $(window.parent.document).find("div[id='${inputName}']");
			var count = $(window.parent.document).find("div[id='${inputName}']").children().length;
			for(var i in companies){
				var company = companies[i].split("-");
				companyDiv.html(companyDiv.html()+'<div class="col-sm-12 col-md-12" id="company'+count+'"><div class="form-group">'+
						'<div class="col-sm-6"><input type="hidden" class="search-form-control" name="${inputName}['+count+'].objectId" value="'+company[0]+'"/>'+
						'<input type="hidden" class="search-form-control" name="${inputName}['+count+'].companyName" value="'+company[1]+'"/>'+
						company[1]+
						'</div><div class="col-sm-2"><a href="javascript:del(\'company'+count+'\')" class="btn btn-primary">删除</a></div></div></div>');
			    count = count+1;
			}
			parent.$.colorbox.close();
		}else{
			winAlert("请至少选择一个企业");
		}
		
	}
	</script>
</body>
</html>