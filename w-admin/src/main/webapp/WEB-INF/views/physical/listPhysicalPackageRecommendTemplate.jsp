<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<title>体检套餐搭配</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐搭配
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physicalPackage/physicalPackageRecommendTemplate?ajax=1" method="post"
				id="physicalPackage" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									<select name="search_EQL_supplierId" id="supplierId"
										class="search-form-control">
										<option value=""></option>
										<c:forEach items="${suppliers }" var="supplier">
											<option value="${supplier.objectId}">${supplier.supplierName}</option>
										</c:forEach>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐名称：</label>
								<div class="col-sm-8">
									<input type="text" name="search_LIKES_packageName"
										class="search-form-control" id="packageName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status" id="status"
										class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
						<button type="button" onclick="setPhysicalPackages()" class="btn btn-primary">确认</button>
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<script type="text/javascript">
	function setPhysicalPackages()
	{
		if(getCheckedValuesString($("input[name='schk']"))==null){
            alert('请体检套餐');
            return false;
        }
		var products = getCheckedValuesString($("input[name='schk']")).split(",");
		var productDiv = $(window.parent.document).find("div[id='${inputName}']");
		var packageBudgetName;
		for ( var i in products)
		{
			var product = products[i].split("-");
			var productType = '<jdf:dictionaryName value="${currentRowObject.packageType }" dictionaryId="1119"/>';
			productDiv.html(productDiv.html()
					+ '<div class="row" id="${inputName}'+i+'"><div class="col-sm-12 col-md-12"><div class="form-group">'
					+ '<input type="hidden" name="${inputName}['+i+'].productId" value="'+product[0]+'">'
					+ '<input type="hidden" name="type" value="2">'
					+ '<label class="col-sm-1 control-label"></label>'
					+ '<div class="col-sm-3"><img src="${dynamicDomain}'+product[3]+'" width="240px" height="120px;">'
					+ '</div><div class="col-sm-8"><div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'
					+ '<label for="companyName" class="col-sm-2 product-control-label">商品标题：</label>'
					+ '<div class="col-sm-6"><span class="lable-span">'
					+ product[1]
					+ '</span></div></div></div></div>'
					+ '<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'
					+ '<label for="companyName" class="col-sm-2 product-control-label">销售价：</label>'
					+ '<div class="col-sm-6"><span class="lable-span">'
					+ product[4]
					+ '</span></div></div></div></div>'
					+ '<div class="row"><div class="col-sm-12 col-md-12"><div class="form-group">'
					+ '<label for="companyName" class="col-sm-2 product-control-label">优先级：</label>'
					+ '<div class="col-sm-1"><input type="text" name="${inputName}['+i+'].priority" value="0" class="order-form-control"></div>'
					+ '<div class="col-sm-6"><button type="button" onclick="javascript:deleteProductRecommendDiv(\'${inputName}'
					+ i
					+ '\')" class="btn btn-primary">删除</button></div></div></div></div></div></div></div></div>');
	parent.$.colorbox.close();
		}
	}
	</script>
	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="physicalPackageRecommendTemplate?ajax=1">
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" style="width: 4%;text-align: center;"
					headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}-${currentRowObject.packageName}-${currentRowObject.packageType}-${currentRowObject.imageUrl}-${currentRowObject.packagePrice}" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" style="width:10%" />
				<jdf:column property="packageName" title="套餐名称" style="width:10%" />
				<jdf:column property="packageType" title="商品类型" style="width:10%">
					<jdf:columnValue dictionaryId="1119"
						value="${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column property="packageStock" title="  套餐剩余库存" style="width:10%" />
				<jdf:column property="supplierName" title=" 供应商" style="width:10%">
					<c:forEach items="${currentRowObject.physicalSupply}" var="ps" varStatus="num">
						<a href="#">${ps.supplierName }</a>
					</c:forEach>
				</jdf:column>
				<jdf:column property="status" title=" 状态" style="width:10%">
					<jdf:columnValue dictionaryId="1120"
						value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		function del()
		{
			$("#physicalPackage").attr("action",
					"${dynamicDomain}/physicalPackage/delPhy");
			$("#objectIdArray").val(
					getCheckedValuesString(document.getElementsByName("schk")));
			$("#physicalPackage").submit();
		}

		function putAway(status)
		{
			$("#physicalPackage").attr(
					"action",
					"${dynamicDomain}/physicalPackage/updateToPage?status="
							+ status);
			$("#objectIdArray").val(
					getCheckedValuesString(document.getElementsByName("schk")));
			$("#physicalPackage").submit();
		}

		/**
		 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
		 */
		function getUpdateColumnString(columnItem, split)
		{
			if (split == null)
			{
				split = ",";
			}
			str = "";
			for (var i = 0; i < columnItem.length; i++)
			{
				str = appendSplit(str, columnItem[i].value, split);
			}
			if (str == "")
			{
				return null;
			}
			return str;
		}
		/**
		 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
		 */
		function appendSplit(str, strAppend, split)
		{
			if (str == null || str == "")
			{
				return strAppend;
			} else
			{
				return str + "," + strAppend;
			}
		}
	</script>
</body>
</html>