<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>相关商品推荐管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				相关商品推荐管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productRecommendRelevant/page"
				method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_productName"
									class="col-sm-4 control-label">商品名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_productName">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_productId"
									class="col-sm-4 control-label">商品编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_productId">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_relevantProductName"
									class="col-sm-4 control-label">相关商品名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_relevantProductName">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_relevantProductId"
									class="col-sm-4 control-label">相关商品编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_relevantProductId">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/productRecommendRelevant/create"
						class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a> 
						<button type="button" onclick="javascript:deleteProductRelevance();" class="btn btn-primary">删除</button>
						<button type="button" onclick="javascript:saveProductPrioritys();" class="btn btn-primary">保存优先级</button>
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
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="相关商品推荐管理.csv"
				tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="相关商品推荐管理.xls"
				tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId"
					title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
					style="width: 4%;text-align: center;"
					headerStyle="width: 4%;text-align: center;" viewsAllowed="html"
					sortable="false">
					<input type="checkbox" class="noBorder" name="schk"
						onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
				<jdf:column property="productId" title="主商品编号" headerStyle="width:10%;" />
				<jdf:column property="productName" title="主商品名称" headerStyle="width:15%;" />
				<jdf:column property="1" title="优先级" headerStyle="width:6%;" viewsDenied="html">
					${currentRowObject.priority }
				</jdf:column>
				<jdf:column property="priority" title="优先级" headerStyle="width:6%;" viewsAllowed="html">
					<input type="text" value="${currentRowObject.priority }" class="order-form-control" name="prioritys" >
				</jdf:column>
				<jdf:column property="relevantProductId" title="相关商品编号" headerStyle="width:10%;" />
				<jdf:column property="relevantProductName" title="相关商品名称" headerStyle="width:15%;" />
				<jdf:column property="createdOn" cell="date" title="创建时间" headerStyle="width:15%;" />
				<jdf:column property="createdBy" title="创建用户" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		function deleteProductRelevance()
		{
			var productRelevances = getCheckedValuesString($("input[name='schk']")).split(",");
			$.ajax(
					{
						url : "${dynamicDomain}/productRecommendRelevant/deleteRelevances" ,
						type : 'post',
						dataType : 'json',
						data:"ids="+productRelevances+"&timstamp=" + (new Date()).valueOf(),
						success : function(msg)
						{
							if (msg.result)
							{
								winAlert("删除成功");
								 location.reload();
							}
						}
					});
		}
		
		function saveProductPrioritys(){
			var productRelevances = getCheckedValuesString($("input[name='schk']"));
			var productPrioritys = getUpdateColumnString($("input[name='prioritys']"));
			if(productRelevances!=""){
				if(productRelevances==null){
		            winAlert('请至少选择一条记录');
		            return false;
		        }
				var sortNoArray = productPrioritys.split(",");
				for (var i = 0;i<sortNoArray.length;i++){
					if(sortNoArray[i]!=''&&!/^\d+\.?\d{0,1}$/.test(sortNoArray[i])){
		                winAlert('排序必须为整数或1位小数');
		                return ;
		            }
				}
				$.ajax(
            			{
            				url : "${dynamicDomain}/productRecommendRelevant/saveProductPrioritys",
            				type : 'post',
            				dataType : 'json',
            				data:"ids="+productRelevances+"&prioritys="+productPrioritys+"&timstamp=" + (new Date()).valueOf(),
    						success : function(msg)
            				{
            					if (msg.result)
            					{
            						winAlert("保存成功");
            					}
            				}
            			});
			}else{
				winAlert("请在列表中先勾选需要更新的记录");
			}
		}
		/**
		 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
		 */
		function getUpdateColumnString(columnItem, split) {
			var checkItem = document.getElementsByName("schk");
			if (split == null) {
				split = ",";
			}
			str = "";
			for (var i = 0; i < checkItem.length; i++) {
				if (checkItem[i].checked == true) {
					str = appendSplit(str, columnItem[i].value, split);
				}
					
			}
			if (str == "") {
				return null;
			}
			return str;
		}
		/**
		 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
		 */
		function appendSplit(str, strAppend, split) {
			if (str == null || str == "") {
				return strAppend;
			} else {
				return str + "," + strAppend;
			}
		}
	</script>
</body>
</html>