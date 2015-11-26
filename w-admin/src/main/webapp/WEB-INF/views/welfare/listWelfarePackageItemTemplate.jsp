<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>选择套餐</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				福利套餐信息
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="queryPackageList?ajax=1" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">项目类型：</label>
								</div>
								<select name="search_EQI_itemType" class="search-form-control">
									<%--
									<option value="">—全部—</option>
									<jdf:select dictionaryId="1600" valid="true" />
									 --%> 
									<option value="1">福利</option>
								</select>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">项目大类：</label>
								</div>
								<select name="search_EQI_bigItemId" id="bigItems"  class="search-form-control">
									<%--
									<option value="">全部</option>
									 --%> 
									 <jdf:selectCollection items="bigItemList" optionValue="objectId"  optionText="itemName" />
								</select>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">项目分类：</label>
								</div>
								<select name="search_EQI_subItemId" id="subItems"  class="search-form-control">
									
								</select>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">商品类型：</label>
								</div>
								<select name="search_EQI_stockType" class="search-form-control">
									<option value="">—全部—</option>
									<jdf:select dictionaryId="1119" valid="true" />
								</select>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">套餐类型：</label>
								</div>
								<select name="search_EQI_wpCategoryType" class="search-form-control">
									<option value="">—全部—</option>
									<jdf:select dictionaryId="1602" valid="true" />
								</select>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label class="form-lable">套餐名称：</label>
								</div>
								<input type="text" class="search-form-control" name="search_LIKES_packageName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					 
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" 
		sortRowsCallback="limit" action="${action}">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				
				<jdf:column property="objectId" title="选择" 	style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="radio" class="noBorder" name="schk"  data-objId="${currentRowObject.objectId}" data-packageName="${currentRowObject.packageName}" data-startDate="${currentRowObject.startDate}"  data-endDate="${currentRowObject.endDate}"  data-holdNum="${currentRowObject.packageStock}" data-packageNo="${currentRowObject.packageNo}" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.packageNo}-${currentRowObject.packageName}-<jdf:columnValue dictionaryId="1606" value="${currentRowObject.stockType}" />-<jdf:columnValue dictionaryId="1602" value="${currentRowObject.wpCategoryType}" />" />
				</jdf:column>
				<jdf:column property="wpCategoryType" title="套餐类型" headerStyle="width:10%;">
				    <jdf:columnValue dictionaryId="1602"    value="${currentRowObject.wpCategoryType}" />
				</jdf:column>
				<jdf:column property="stockType" title="商品类型" headerStyle="width:10%;">
				    <jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" headerStyle="width:15%;" />
				<jdf:column property="packageStockReal" title="剩余份数" headerStyle="width:10%;" />
				<jdf:column property="packageName" title="套餐名称" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
		
		
	</div>
	<div class="row">
			<div class="editPageButton">
				<button type="button" onclick="selectPackage()" class="btn btn-primary">确定</button>
				<button type="button" class="btn btn-primary" onclick="parent.$.colorbox.close()">返回</button>
			</div>
		</div>
	<script type="text/javascript">
	
	function selectPackage(){
		var chckRadio = $('input[name="schk"]:checked');	
		if(!chckRadio.length){
			alert('请选择！');return ;
		}
		var packageId = chckRadio.attr('data-objId');
		var packageName = chckRadio.attr('data-packageName');
		var startDate = chckRadio.attr('data-startDate');
		var endDate = chckRadio.attr('data-endDate');
		var holdNum = chckRadio.attr('data-holdNum');
		
		var packageNo= chckRadio.attr('data-packageNo');
		var ret = $.ajax({
			url:'countResidueCard',
			async:false,
			data:{packageNO:packageNo},
			success:function(res){
				window.parent.$('#cardAmount').attr('data-leftNum',res.packageNO); 
			}
		});
		
		window.parent.$('#startDateId').val(startDate);
		window.parent.$('#endDateId').val(endDate);
		window.parent.$('#hiddenPackageId').val(packageId);
		window.parent.$('#packageName').val(packageName);
		window.parent.$('#cardAmount').attr('data-holdNum',holdNum); 
		window.parent.$('#cardAmount').attr('max',holdNum); 
		parent.$.colorbox.close();
	}
	
	function schkClick(){
		var id = $('input[name="schk"]').val();
	}
	
	 
	function setPackage(){
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("tbody[id='${inputName}']");
		var count = $("#${inputName} tr",window.parent.document).length;
		for(var i in products){
			var product = products[i].split("-");
			productDiv.html(productDiv.html()+'<tr id="${inputName}'+count+'"><th><a href="javascript:del(\'${inputName}'+count+'\')" class="btn btn-primary">删除</a></th><th>'+'<input type="hidden" class="search-form-control" name="productShieldForm.${inputName}['+count+'].objectId" value="'+product[0]+'"/>'+(count+1)+
					'</th><th>'+product[1]+'</th><th>'+product[2]+'</th>'+
					'<th>'+product[3]+'</th><th>'+product[4]+'</th><th>'+product[5]+'</th></tr>');
		count = count+1;
		}
		parent.$.colorbox.close();
	}
	
	function setSelectStatus(){
		var arr = location.search.match(/init\s*?=\s*?(.*).+?bigItemId\s*?=\s*?(.*).+?subItemId\s*?=\s*?(.*)/) ;
		if(arr && !setSelectStatus.disable){
			var bigId = arr[2];
			var subId = arr[3];
			//&bigItemId=5101&subItemId=5151
			var origiUrl = $('form').attr('action');
			$('form').attr('action',origiUrl+'&init=1&bigItemId='+bigId+'&subItemId='+subId);
			selectBigItem(bigId,function(){
				$("#bigItems option[value="+bigId+"]").prop('selected',true);
				$("#subItems option[value="+subId+"]").prop('selected',true);
				setSelectStatus.disable = true;
				$("#bigItems").prop('disabled',true);
				$("#subItems").prop('disabled',true);
			});	 
		}else{
			$("#bigItems").trigger('change');
		}
	}
	
	
	
	function selectBigItem(bigId,cbFn){  
    	var bigItemId = bigId || $('#bigItems').val();  
    	$.ajax({
   			url: "${dynamicDomain}/cardCreateInfo/getSecondMenu2",
   			type : 'post',
   			dataType : 'json',
   			data:{parentItemId:bigItemId},
   			success :function (data) {
   			  data = data.secondItems;
   			  var target = $("#subItems");
   			  //var str = '<option value="">全部</option>';
   			  var str = '';
   			  itemIdStr = '';
   			  for(var i=0;data && data.length && i<data.length;i++){
   				   var obj = data[i];
   				   str +=  '<option value="' +obj.objectId+'">' + obj.itemName +'</option>';
   				   if(!itemIdStr){
   						itemIdStr += obj.objectId;
   				   }else{
   						itemIdStr += ',' + obj.objectId;
   				   } 
   			  }
   			  target.html(str);
   			  cbFn && cbFn();
   			}
	 		});
    }
	$(function(){
		$("#bigItems").change(function () {
        	selectBigItem();
		});
		//$("#bigItems").trigger('change');
		setSelectStatus();
	});	
	</script>
</body>
</html>