<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>品牌信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				品牌信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/brand/brandTemplate?ajax=1" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">品牌编号：</label>
								</div>
								<input type="text" class="search-form-control" name="search_STARTS_brandNo">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">品牌中文名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_chineseName">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">品牌英文名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_englishName">
							</div>
						</div>						
					</div>
					

					
				</div>
				<div class="box-footer">
					<a href="javascript:setBrand();" class="btn btn-primary pull-left">
						 确认
					</a>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="brandTemplate?ajax=1">
			<jdf:export view="csv" fileName="brand.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="brand.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.chineseName}" />
				</jdf:column>
				<jdf:column property="brandNo" title="品牌编号" headerStyle="width:20%;" />
				<jdf:column property="logo" title="品牌商标" headerStyle="width:20%;">
				    <img src="${dynamicDomain }${currentRowObject.logo }" width="100px" height="100px"/>
				</jdf:column>
				<jdf:column property="chineseName" title="品牌中文名称" headerStyle="width:20%;" />
				<jdf:column property="englishName" title="品牌英文名称" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setBrand(){
		var brands = getCheckedValuesString($("input[name='schk']")).split(",");
		var brandDiv = $(window.parent.document).find("div[id='${inputName}']");
	      var count = $("#${inputName}",window.parent.document).children().length;
		for(var i in brands){
			var brand = brands[i].split("-");
			brandDiv.html(brandDiv.html()+'<div class="col-sm-12 col-md-12" id="${inputName}'+count+'"><div class="form-group">'+
					'<div class="col-sm-8"><input type="hidden" class="search-form-control" name="productShieldForm.${inputName}['+count+'].objectId" value="'+brand[0]+'"/>'+
					'<input type="text" readonly="readonly" class="search-form-control" name="productShieldForm.${inputName}['+count+'].chineseName" value="'+brand[1]+'"/>'+
					'</div><div class="col-sm-4"><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></div></div></div>');
					count = count+1;
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>