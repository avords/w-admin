<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检项目管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检项目管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physical/page" method="post"  id="physicalItem" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="sortNoArray" id="sortNoArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">一级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_firstItemName" class="search-form-control"  id="firstItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/physical/create?ajax=1" class="colorbox-mini pull-left">
						<button type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
						</button>
					</a>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="saveSort();">保存排序</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="invalid();">置为无效</button>
					</div> 
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="del();">删除</button>
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
			<jdf:export view="csv" fileName="physicalItem.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicalItem.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate" title="操作" sortable="false" viewsAllowed="html" style="width: 10%;text-align:center">
					<a
						href="${dynamicDomain}/physical/edit/${currentRowObject.objectId}?ajax=1"
						class="btn btn-primary colorbox-mini "> <i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="itemNo" title="一级项目编号" style="width:15%" />
				<jdf:column property="firstItemName" title="一级项目名称" style="width:25%" />
				<jdf:column property="sortNo" title="排序"  style="width:5%" >
					<input type="text"  maxlength="9"  name="sortNo" value="${currentRowObject.sortNo}">
				</jdf:column>
				<jdf:column property="subItemNum"  title="二级项目数量" style="width:10%" >
					<a style="color:#000" href="${dynamicDomain}/physical/subItemPage/${currentRowObject.objectId}?isValid=${currentRowObject.status}" ><font style="font-size:14px;color:blue;text-decoration: underline;">${currentRowObject.subItemNum } </font></a>
				</jdf:column>
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	
	$(function(){
		$('input[name="sortNo"]').change(function(){
			var reg = /(\d{1,7}(\.\d{1,2})?)/;
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
	
	
	function saveSort(){
		$('input[name="sortNo"]').trigger('change');
		
		$("#physicalItem").attr("action","${dynamicDomain}/physical/updateToPage?parentItemId=${parentItemId}") ;
		var chck = getCheckedValuesString(document.getElementsByName("schk"));
		if(!chck){
			alert('请选择！');
			return false ;
		}
		$("#objectIdArray").val(chck);
		$("#sortNoArray").val(getUpdateColumnString(document.getElementsByName("sortNo")));
		var sortNoArray = document.getElementsByName("sortNo");
		for (var i =0;i<sortNoArray.length;i++){
			if(isNaN(sortNoArray[i].value)==true){
				alert("排序框中必须输入数字！");
				return false;
			}
		}
		$("#physicalItem").submit();
	}
	function invalid(){
		$("#physicalItem").attr("action","${dynamicDomain}/physical/updateToPage?parentItemId=${parentItemId}&invalid=1&level=1") ;
		var chck = getCheckedValuesString(document.getElementsByName("schk"));
		if(!chck){
			alert('请选择！');
			return false ;
		}
		$("#objectIdArray").val(chck);
		$("#physicalItem").submit();
	}

	function del(){
		$("#physicalItem").attr("action","${dynamicDomain}/physical/delPhy") ;
		var ret  = document.getElementsByName("schk");
		var chck = getCheckedValuesString(ret);
		if(!chck){
			alert('请选择！');
			return false ;
		}
		if(!window.confirm('确定删除？'))
			return false;
		$("#objectIdArray").val(chck);
		$("#physicalItem").submit();
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