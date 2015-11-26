<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检项目报价编辑</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检项目报价编辑
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalPrice/page" method="post"  id="physicaPrice" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="supplierPriceArray" id="supplierPriceArray">
				<input type="hidden" name="marketPriceArray" id="marketPriceArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									<select name="search_EQL_supplierId" class="search-form-control"  id="supplierId">
										<option value="">—请选择—</option>
										<jdf:selectCollection items="supplierList" optionValue="objectId"  optionText="supplierName" />
									</select>
									<!-- 
									<input type="text"  name="search_LIKES_supplierName" class="search-form-control"  id="supplierName">
									 -->
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">一级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_firstItemName" class="search-form-control"  id="firstItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">二级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_secondItemName" class="search-form-control"  id="secondItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="status" class="search-form-control">
										<option value="">全部</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/physicalPrice/create" class="btn btn-primary pull-left">
						 <span class="glyphicon glyphicon-plus"></span>
					</a>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="savePrice();">保存报价</button>
					</div>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="physicaPrice.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicaPrice.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate" title="操作" sortable="false" viewsAllowed="html" style="width: 7%;text-align:center">
					<a
						href="${dynamicDomain}/physicalPrice/edit/${currentRowObject.objectId}"
						class="btn btn-primary "> <i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="supplierName" title="供应商" style="width:15%" />
				<jdf:column property="firstItemName" title="一级项目" style="width:10%" >
					${currentRowObject.firstItemName}
				</jdf:column>
				<jdf:column property="secondItemName" title="二级项目" style="width:15%" />
				<jdf:column property="1" title="供货价" style="width:5%" viewsDenied="html">
					${currentRowObject.supplierPrice}
				</jdf:column>
				<jdf:column property="supplierPrice" title="供货价" style="width:5%" viewsAllowed="html">
					<input type="number"   step="0.01"  name="supplierPrice" value="${currentRowObject.supplierPrice}" size="7" maxlength="8">
				</jdf:column>
				<jdf:column property="2" title="门市价" style="width:5%" viewsDenied="html">
					${currentRowObject.marketPrice}
				</jdf:column>
				<jdf:column property="marketPrice" title="门市价" style="width:5%" viewsAllowed="html">
					<input type="number"   step="0.01"   name="marketPrice" value="${currentRowObject.marketPrice}"  size="7" maxlength="8">
				</jdf:column>
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="auditStatus" title="审核状态"  style="width:7%">
					<jdf:columnValue dictionaryId="1605" value="${currentRowObject.auditStatus}" />
				</jdf:column>
				<jdf:column property="updatedBy" title="修改人"  style="width:5%"  />
				<jdf:column property="updatedOn" title="修改时间"  style="width:10%"  >
					<fmt:formatDate value="${currentRowObject.updatedOn }" pattern=" yyyy-MM-dd  HH:mm"/>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">	
	$(function(){
		$('input[name="supplierPrice"],input[name="marketPrice"]').change(function(){
			var reg = /(\d{1,6}(\.\d{1,2})?)/;
			var val = $(this).val(),val = $.trim(val);	
			if(val){
				var arr = val.match(reg) ;
				if(arr){
					val = arr[1] || '';
				}
			}
			$(this).val(val);					
		});
	});
	
	function savePrice(){
		
		$('input[name="supplierPrice"],input[name="marketPrice"]').trigger('change');
		//var supplierPrice
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		
		$("#physicaPrice").attr("action","${dynamicDomain}/physicalPrice/updateToPage") ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#supplierPriceArray").val(getUpdateColumnString(document.getElementsByName("supplierPrice")));
		$("#marketPriceArray").val(getUpdateColumnString(document.getElementsByName("marketPrice")));
		$("#physicaPrice").submit();
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