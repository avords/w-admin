<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>供应商入驻管理</title>
<style>
.downView{
	padding:10px 0 0 10px;
}
.upView{
	margin:0 0 -15px 0;
}
</style>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				供应商入驻信息查询
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/supplier/viewInfoContract?ajax=1" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_supplierName" class="col-sm-4 control-label">供应商名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_supplierName">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="search_LIKES_supplierNo" class="col-sm-4 control-label">供应商编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="search_LIKES_supplierNo">
								</div>
							</div>
						</div>
						
					</div>

		<div class="box-footer">
            <div class="pull-left">
						<button type="button" class="btn btn-primary progressBtn" onclick="savePrice();">保存供应商信息</button>
					</div>
            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
              <button type="submit" class="btn btn-primary">查询</button>
            </div>
          </div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="viewInfo">
			<jdf:export view="csv" fileName="supplier.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="supplier.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" style='width: 5%;text-align: center;'  headerStyle="width: 4%;text-align: center;">
					<input type="checkbox" name="schk" id="checkid" class="mybox" onclick="chooseSupplier($(this));" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="status" title="审核状态" headerStyle="width:10%;">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="supplierNo" title="供应商编号" headerStyle="width:10%;" />
				<jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;" >
					<input type="text"  name="supplierName" value="${currentRowObject.supplierName}" size="7" style="border-style:none" disabled="disabled"> 
					<input type="hidden"  name="managerId" value="${currentRowObject.accountManager}" size="7" style="border-style:none" disabled="disabled"> 
				</jdf:column>
				<jdf:column property="businessTerm" title="营业执照期限" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
	
	<script type="text/javascript">
	function chooseSupplier(obj){
		  if (obj.is(":checked")) {
		         // 先把所有的checkbox 都设置为不选种
		        $('input.mybox').prop('checked', false);
		        // 把自己设置为选中
		        obj.prop('checked',true);
		    }
	}
	
	function savePrice(){
		parent.$("#customerId").val(getCheckedValuesString(document.getElementsByName("schk")));
		parent.$("#customerName").val(getUpdateColumnString(document.getElementsByName("supplierName")));
		parent.$("#managerId").val(getUpdateColumnString(document.getElementsByName("managerId")));
		window.parent.$.colorbox.close();
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