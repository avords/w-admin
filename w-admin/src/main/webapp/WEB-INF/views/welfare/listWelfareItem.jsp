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
				福利&激励管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfare/page" method="post" id="WelfareItemList" class="form-horizontal">
				<input type="hidden" id="tempType" value="">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="sortNoArray" id="sortNoArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-6 control-label">项目类型：</label>
								<div class="col-sm-6">
									<select name="search_EQI_itemType" class="search-form-control"  id="itemType">
										<option value="" >全部</option>
										<jdf:select dictionaryId="1600" valid="true" />
									</select>
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-6 control-label">项目大类：</label>
								<div class="col-sm-6">
									<select name="search_EQL_objectId"  id="bigItems" class="search-form-control">
										<option value="" >全部</option>
									</select>
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-6 control-label">状态：</label>
								<div class="col-sm-6">
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
					<a href="${dynamicDomain}/welfare/create?ajax=1" class="colorbox-mini-iframe btn btn-primary pull-left">
							<span class="glyphicon glyphicon-plus"></span>
					</a> 
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="welfareItem.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="welfareItem.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 10%;text-align:center">
					<a href="${dynamicDomain}/welfare/edit/${currentRowObject.objectId}?ajax=1"
						class="btn btn-primary colorbox-mini-iframe"> <i class="glyphicon glyphicon-pencil"></i>
					</a>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="itemType" title="项目类型" style="width:15%" >
					<jdf:columnValue dictionaryId="1600" value="${currentRowObject.itemType}" />
				</jdf:column>
				<jdf:column property="itemNo" title="项目大类编号" style="width:15%" />
				<jdf:column property="itemName" title="项目大类名称" style="width:25%" />
				<jdf:column property="sortNo" title="排序"  style="width:5%"  >
					<input type="text"  name="sortNo" value="${currentRowObject.sortNo}" size="6" maxlength="9">
				</jdf:column>
				<jdf:column property="subItemNum"  title="项目分类数量" style="width:10%" >
					<a href="${dynamicDomain}/welfare/subItemPage/${currentRowObject.objectId}" style="text-align: center;">
					<font style="font-size: 14px; color: blue; text-decoration: underline;">
					${currentRowObject.subItemNum } 
					</font>
					</a>
				</jdf:column>
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
			var	itemType = $("#itemType").val();
        	var bigItemsValue= '${tempType}';
			changeType(itemType,bigItemsValue);
			//一级下拉联动二级下拉
	        $("#itemType").change(function () {
	        	var	type = $("#itemType").val();
	        	changeType(type,"");
			}); 
		});

		function changeType(value,bigValue){
			if (value != null && value!="") {
				//清除二级下拉列表
	        	$("#bigItems").empty();
		        $("#bigItems").append($("<option/>").text("全部").attr("value",""));
	            //要请求的二级下拉JSON获取页面
	        	$.ajax({
	       			url: "${dynamicDomain}/welfare/getItems/"+value,
	       			type : 'post',
	       			dataType : 'json',
	       			success :function (data) {
	       			 //对请求返回的JSON格式进行分解加载
	       			  for(var i=0;i<data.items.length;i++){
	       				//alert(data.items[i].objectId );
	                    if (data.items[i].objectId==bigValue) {
	                    	$("#bigItems").append("<option value='" +data.items[i].objectId + "' selected >" + data.items[i].itemName+"</option>");
	                    }else{
		       				$("#bigItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
	                    } 	
	       			  }
	       			}
	 	 		});
			} 
		}
		
		function saveSort(){
			$("#WelfareItemList").attr("action","${dynamicDomain}/welfare/updateToPage") ;
			$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
			$("#sortNoArray").val(getUpdateColumnString(document.getElementsByName("sortNo")));
			if($("#objectIdArray").val()!=""){
				var sortNoArray = $("#sortNoArray").val().split(",");
				for (var i = 0;i<sortNoArray.length;i++){
					if(sortNoArray[i]!=''&&!/^\d+\.?\d{0,1}$/.test(sortNoArray[i])){
		                alert('排序必须为整数或1位小数');
		            }else{
		            	$("#WelfareItemList").submit();
		            }
				}
			}else{
				alert("请在列表中先勾选需要更新的记录");
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