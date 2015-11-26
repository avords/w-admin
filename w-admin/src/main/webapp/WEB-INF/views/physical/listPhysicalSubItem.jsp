<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>二级项目管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				二级项目管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/physical/subItemPage/${parentItemId}"  id="subItemPage"  method="post"  class="form-horizontal">
			<input type="hidden" name="objectIdArray" id="objectIdArray">
			<input type="hidden" name="sortNoArray" id="sortNoArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">二级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_secondItemName" class="search-form-control"  id="secondItemName">
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
					<a href="${dynamicDomain}/physical/createSubItem/${parentItemId}?ajax=1" class="colorbox-double pull-left">
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
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit"  sortRowsCallback="limit" 
			action="${dynamicDomain}/physical/subItemPage/${parentItemId}" >
			<jdf:export view="csv" fileName="physicalSubItem.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicalSubItem.xls" tooltip="Export EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate"   title="操作" sortable="false" viewsAllowed="html"  style="width: 10%;text-align:center">
					<a href="${dynamicDomain}/physical/editSubItem/${parentItemId}/${currentRowObject.objectId}?ajax=1" class="btn btn-primary colorbox-double "> 
						<i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="itemNo" title="二级项目编号"	style="width:15%" />
				<jdf:column property="secondItemName" title="二级项目名称"	style="width:25%" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.secondItemName}">${currentRowObject.secondItemName}</div>
				</jdf:column>
				<jdf:column property="sortNo" title="排序"	style="width:5%" >
					<input type="text"  name="sortNo"  maxlength="9" value="${currentRowObject.sortNo}" class="sortNoVerify">
				</jdf:column>
				<jdf:column property="targetExplain" title="指标意义"  style="width:15%"  >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.targetExplain}">${currentRowObject.targetExplain}</div>
				</jdf:column>
				<jdf:column property="isMan" title="属性"  style="width:15%"  >
					<c:if test="${currentRowObject.isMan eq 1}">男</c:if><c:if test="${currentRowObject.isWomanUnmarried eq 1}">，女未婚</c:if>
					<c:if test="${currentRowObject.isWomanMarried eq 1}">，女已婚</c:if>
				</jdf:column>
				<jdf:column property="status" title="状态"	style="width:5%">
					<jdf:columnValue dictionaryId="111"	value="${currentRowObject.status}" />
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
			
			//状态继承设定
			var reg = /\?+isValid\s?=\s?(\w)+&?/;
			var arr = location.search.match(reg);
			if(arr && arr[1]){
				var validStat = arr[1];
				$('select[name="search_EQL_status"] option[value='+validStat+']').prop('selected',true);
			}
			
			

	}); 
		function saveSort(){
			
			var chck = getCheckedValuesString(document.getElementsByName("schk"));
			if(!chck){
				alert('请选择');
				return ;
			}
			$("#objectIdArray").val(chck);	
			$("#sortNoArray").val(getUpdateColumnString(document.getElementsByName("sortNo")));
			if($("#objectIdArray").val()!=""){
				var sortNoArray = $("#sortNoArray").val().split(",");
				for (var i = 0;i<sortNoArray.length;i++){
					if(!/^[1-9]{1}\d{0,5}(\.\d)?$/.test(sortNoArray[i])){
		                alert('排序必须为6位整数或1位小数');
		                return ;
		            }
				}
				
			}else{
				alert("请在列表中先勾选需要更新的记录");
			}
			$("#subItemPage").attr("action","${dynamicDomain}/physical/updateToPage?parentItemId=${parentItemId}") ;
			$("#subItemPage").submit(); 
			
		}
		
		function invalid(){
			$("#subItemPage").attr("action","${dynamicDomain}/physical/updateToPage?parentItemId=${parentItemId}&invalid=1") ;
			var chck = getCheckedValuesString(document.getElementsByName("schk"))
			if(!chck){
				alert('请选择');
				return ;
			}
			$("#objectIdArray").val(chck);
			$("#subItemPage").submit();
		}
		
		function del(){
			$("#subItemPage").attr("action","${dynamicDomain}/physical/delPhy?parentItemId=${parentItemId}&subItem=1") ;
			var chck = getCheckedValuesString(document.getElementsByName("schk"));
			if(!chck){
				alert('请选择');
				return ;
			}
			if(confirm('确定删除？')){
				$("#objectIdArray").val(chck);
				$("#subItemPage").submit();
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