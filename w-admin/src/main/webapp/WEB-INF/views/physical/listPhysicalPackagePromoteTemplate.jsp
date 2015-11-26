<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检套餐信息</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physicalPackage/physicalPackagePromoteTemplate?ajax=1&inputName=${inputName}&packageType=${packageType}" method="post"
				class="form-horizontal">
				<input type="hidden" name="inputName" value="${inputName }">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">套餐编号：</label>
								</div>
								<input type="text" class="search-form-control" name="search_STARTS_packageNo">
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">套餐名称:</label>
									<div class="col-sm-8">
										<input type="text" class="search-form-control" name="search_LIKES_packageName">
									</div>
								</div>
							</div>	
					</div>
				</div>
				<div class="box-footer">
					<a href="javascript:setPackage();" class="btn btn-primary pull-left">确认</a>
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
		sortRowsCallback="limit" action="physicalPackagePromoteTemplate?ajax=1&inputName=${inputName}&packageType=${packageType}">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.packagePrice}-${currentRowObject.packageName}"  />
				</jdf:column>
				<jdf:column property="packageName" title="套餐名称" headerStyle="width:20%;" />
				<jdf:column property="packagePrice" title="套餐价格" headerStyle="width:10%;" />
				<jdf:column property="packageType" title="套餐类型" headerStyle="width:10%;">
				   <jdf:columnValue dictionaryId="1607" value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="stockType" title="套餐库存" headerStyle="width:15%;">
				   <jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />(${currentRowObject.packageStock})
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" headerStyle="width:15%;" />
			 
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function setPackage(){
		if(getCheckedValuesString($("input[name='schk']"))==null){
            winAlert('请选择套餐');
            return;
        }
		
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("div[id='${inputName}']");
		var inputName = "${inputName}";
		 var idPrefix = inputName.replace(".","");
		 var setPromotPrice = false;
		 
		 if ("addtionalWelfares" == inputName.split(".")[1]) {
			 setPromotPrice = true;
		 }
		 
		for(var i in products){
			var product = products[i].split("-");
			var str = productDiv.html()+'<div class="row" id="'+idPrefix+i+'"><div class="col-sm-12 col-md-12"><div class="form-group">'+
			'<input type="hidden" name="${inputName}[' + i + '].objectId" value="'+product[0]+'">'+
			'<label class="col-sm-1 control-label"></label>'+
			'<div class="col-sm-12"><div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'+
			'<label class="col-sm-2 product-control-label">套餐名：</label>'+
			'<div class="col-sm-3"><span class="lable-span">'+product[2]+'</span></div> '+
			 
			'<label class="col-sm-1 product-control-label">套餐价格：</label>'+
			'<div class="col-sm-1"><span class="lable-span">'+product[1]+'</span></div> ';
			
			if (setPromotPrice) {
				str = str + '<label for="promotePrice" class=" col-sm-1 control-label">升级价格</label>' +
				' <div class="col-sm-2">'+
					'<input type="text" id="price'+ i +'" class="decimal2 search-form-control" name="priceForm[' + i + '].promotePrice" value="">' +
				'</div>';
			}
			
			
			str = str + '<div class="col-sm-1"><button type="button" onclick="javascript:del(\''+ idPrefix +i+'\')" class="btn btn-primary">删除</button></div></div></div></div>'+
			            '  </div></div></div></div>';
			productDiv.html(str);
		}
		parent.$.colorbox.close();
	}
		
	 
	</script>
</body>
</html>