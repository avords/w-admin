<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>福利&激励管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				项目分类管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfare/subItemPage/${parentItemId}" method="post" id="WelfareItemSubList" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="sortNoArray" id="sortNoArray">
				<input type="hidden" name="parentItemId" id="parentItemId" value="${parentItemId}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
									<label class="col-sm-5 control-label">项目类型：</label>
									<span class="lable-span">
										<jdf:dictionaryName  dictionaryId="1600"  value="${bigItem.itemType}"/>
									</span>
							</div>		
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">项目大类名称：</label>
								<span class="lable-span">
									${bigItem.itemName}
								</span>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label class="col-sm-5 control-label">项目分类名称：</label>
									<div class="col-sm-6">
										<select name="search_EQL_objectId" class="search-form-control">
											<option value="">—全部—</option>
											<jdf:selectCollection items="subitems" optionValue="objectId"  optionText="itemName" />
										</select>
									</div>
								</div>	
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-5 control-label">状态：</label>
								<div class="col-sm-4">
									<select name="search_EQI_status" class="search-form-control"  id="status">
										<option value="" >—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>	
				<div class="box-footer">
					<c:choose>
					<c:when test="${parentStatus==2}">
					<a href="javascript:void(0);" class="pull-left">
						<button type="button" class="btn btn-primary" onclick="noskip();">
							<span class="glyphicon glyphicon-plus"></span>
						</button>
					</a>
					</c:when>
					<c:otherwise>
					<a href="${dynamicDomain}/welfare/createSubItem/${parentItemId}?ajax=1&itemType=${bigItem.itemType}" class="colorbox-big  pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					</c:otherwise>
					</c:choose>
					
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="setStatus();">置为无效</button>
					</div>
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="saveSort();">保存排序</button>
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
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="${parentItemId}">
			<jdf:export view="csv" fileName="welfareSubItem.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="welfareSubItem.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate"   title="common.lable.operate" sortable="false" viewsAllowed="html"  style="width: 10%;text-align:center">
					<a href="${dynamicDomain}/welfare/editSubItem/${parentItemId}/${currentRowObject.objectId}?ajax=1&itemType=${bigItem.itemType}" class="btn btn-primary colorbox-big "> 
						<i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="itemType" title="项目类型"  style="width:15%" >
					<jdf:columnValue dictionaryId="1600"		value="${currentRowObject.itemType}" />
				</jdf:column>
				<jdf:column property="itemNo" title="项目分类编号"	style="width:15%" />
				<jdf:column property="itemName" title="项目分类名称"	style="width:25%" />
				<jdf:column property="sortNo" title="排序"	style="width:5%" >
					<input type="text"  name="sortNo" value="${currentRowObject.sortNo}" size="6" maxlength="9">
				</jdf:column>
				<jdf:column property="status" title="状态"	style="width:5%">
					<jdf:columnValue dictionaryId="111"	value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		$(function(){
			//var url = $(".createSubItem").attr('href');
			/*
			$(".createSubItem").colorbox({
				opacity:0.2,
				fixed:true,
				width:"75%", 
				height:"75%", 
				iframe:true,
				onClosed:function(){ 
				},
				overlayClose:false 
			});	
			*/
		});
		function saveSort(){
			$("#WelfareItemSubList").attr("action","${dynamicDomain}/welfare/updateSubToPage") ;
			$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
			$("#sortNoArray").val(getUpdateColumnString(document.getElementsByName("sortNo")));
			if($("#objectIdArray").val()!=""){
				var sortNoArray = $("#sortNoArray").val().split(",");
				for (var i = 0;i<sortNoArray.length;i++){
					if(sortNoArray[i]!=''&&!/^\d+\.?\d{0,1}$/.test(sortNoArray[i])){
		                alert('排序必须为整数或1位小数');
		            }else{
		            	$("#WelfareItemSubList").submit();
		            }
				}
			}else{
				alert("请在列表中先勾选需要更新的记录");
			}
		}
		
		function setStatus(){
    		var ids = getCheckedValuesString($("[name='schk']"));
    		if(ids==null){
    			alert("请至少选择一条记录");
    			return false;
    		}
    		$.ajax( {
   				url : "${dynamicDomain}/welfare/subInvalid",
   				type : 'post',
   				dataType : 'json',
   				data : "ids=" + ids + "&timstamp=" + (new Date()).valueOf(),
   				success : function(msg) {
   					if (msg>0) {
   						alert("成功保存" + msg + "条记录");
   						$("[name='sortNos']").remove();
   						$("#WelfareItemSubList").submit();
   					} else {
   						alert("保存失败");
   					}
   				}
   			});
		}
		
		function noskip(){
			alert("主项目无效不可添加子项目！");
			return false;
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