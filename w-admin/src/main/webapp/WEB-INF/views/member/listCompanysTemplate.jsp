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
			<form action="${dynamicDomain}/company/listCompanysTemplate?ajax=1&inputName=companyForms" method="post" class="form-horizontal">
		        <div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="search_LIKES_companyName" class="form-lable">企业名称：</label>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_companyName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setCompanys();" class="btn btn-primary pull-left"> 确认 </a>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this);$('#search_STARTS_areaId').val('')">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
	<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="listCompanysTemplate?ajax=1&inputName=companyForms">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				 <jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" 
							value="${currentRowObject.objectId}-${currentRowObject.companyName}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
                <jdf:column property="companyName" title="企业名称" headerStyle="width:10%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">
					<a href="${dynamicDomain}/company/view/${currentRowObject.objectId}" target="_blank">
					<font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.companyName}</font></a></div>
				</jdf:column>
				<jdf:column property="managerName" title="客户经理" headerStyle="width:7%" />
				<jdf:column property="type" title="企业规模" headerStyle="width:8%;">
                    <div class="text-ellipsis" style="width: 120px;" title="<jdf:columnValue dictionaryId='1301' value='${currentRowObject.type}' />">
					<jdf:columnValue dictionaryId="1301" value="${currentRowObject.type}" /></div>
				</jdf:column>
				<jdf:column property="companyStatus" title="企业状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1302" value="${currentRowObject.companyStatus}" />
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:6%;" />
				<jdf:column property="email" title="联系人邮箱" headerStyle="width:8%;" />
				<jdf:column property="phone" title="办公电话" headerStyle="width:7%;" />
				<jdf:column property="telephone" title="手机" headerStyle="width:6%;" />
				<jdf:column property="verifyStatus" title="审核状态" headerStyle="width:7%;">
					<c:if test="${currentRowObject.verifyStatus==3}">
                    <font color="green"><jdf:columnValue dictionaryId="1304" value="3" /></font>
                    </c:if>
                    <c:if test="${currentRowObject.verifyStatus!=3}">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.verifyStatus}" />
                    </c:if>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	
	function setCompanys(){
		var selected = getCheckedValuesString($("input[name='schk']"));
		if(selected!=null){
			var companys = selected.split(",");
			var productDiv = $(window.parent.document).find("div[id='${inputName}']");
			for(var i in companys){
				var company = companys[i].split("-");
				 productDiv.html(productDiv.html()+ 
						 
				          '<div class="form-group" id="relevance'+i+'">'+
								 '<label for="companyName" class="col-sm-4 product-control-label">公司名：</label>'+
								 '<input type="hidden" class="search-form-control" name="${inputName}['+i+'].companyId" value="'+company[0]+'">'+ 
								 '<div class="col-sm-4"><span class="lable-span">'+company[1]+'</span></div>' +
								 '<div class="col-sm-4"><a href="javascript:del(\'relevance'+i+'\')" class="btn btn-primary">删除</a><div>'+
						   '</div>' );
			}
			
			parent.$.colorbox.close();
		}else{
			winAlert("请至少选择一个企业");
		}
	}
	</script>
</body>
</html>