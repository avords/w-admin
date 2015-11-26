<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>推荐套餐管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				推荐套餐管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/welfarePackage/page"  id="welfarePackageInfo" method="post"  class="form-horizontal">
			<input type="hidden" name="objectIdArray" id="objectIdArray">
			<input type="hidden" name="priorityArray" id="priorityArray">
			<input type="hidden" name="status" id="status">
				<div class="box-body">
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">项目类型:</label>
										<div class="col-sm-8">
											<select class="search-form-control" name="search_EQI_itemType" id="itemTypes">
												<option value="">--请选择--</option>
												<jdf:select dictionaryId="1600" valid="true" />
											</select>
										</div>
								</div>
							</div>	
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label   class="col-sm-4 control-label">项目大类:</label>
									<div class="col-sm-8">
										<select name="search_EQI_bigItemId" class="search-form-control"  id="bigItems">
											<option value="">--请选择--</option>
											<jdf:selectCollection items="bigItems" optionValue="objectId"  optionText="itemName" />
										</select>
									</div>	
								</div>
							</div>
							<div class="col-sm-4  col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">项目分类:</label>
									<div class="col-sm-8">
										<select name="search_EQI_subItemId"  id="subItems" class="search-form-control">
											<option value="">--请选择--</option>
										</select>
									</div>	
								</div>
							</div>
					</div>	
					<div class="row">
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">套餐类型:</label>
									<div class="col-sm-8">
										<select  name="search_EQI_wpCategoryType" class="search-form-control">
											<option value="">--请选择--</option>
											<jdf:select dictionaryId="1602" valid="true" />
										</select>
									</div>
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
							<div class="col-sm-4 col-md-4">
								<div class="form-group">
									<label  class="col-sm-4 control-label">状态:</label>
									<div class="col-sm-8">
										<select name="search_EQI_status"  class="search-form-control">
											<option value=""></option>
											<jdf:select dictionaryId="1120" valid="true" />
										</select>
									</div>
								</div>		
							</div>	
					</div>	
							
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/welfarePackage/create" class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					<div class="pull-left">
									<button type="button" onclick="savePriority();" class="btn btn-primary">
										保存排序
									</button>
							
									<button   type="button" onclick="changeStatus('2');" class="btn btn-primary">
										上架
									</button>
								
									<button   type="button" onclick="changeStatus('3');"  class="btn btn-primary">
										下架
									</button>
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
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit"  sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="welfarePackage.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="welfarePackage.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 5%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate"  title="操作" sortable="false" viewsAllowed="html"  style="width: 5%;text-align:center">
				<c:choose>
                   <c:when test="${currentRowObject.status!=2}">
                      <a
						href="${dynamicDomain}/welfarePackage/edit/${currentRowObject.objectId}"
						class="btn btn-primary btn-mini "> <i class="glyphicon glyphicon-pencil"></i>
					</a>
                 </c:when>
                 <c:otherwise>
                  <a
                  href="${dynamicDomain}/welfarePackage/view/${currentRowObject.objectId}"
                    class="btn btn-primary btn-mini "> <i class="glyphicon glyphicon-pencil"></i>
                </a>
                 </c:otherwise>
                  </c:choose>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="itemName" title="项目" style="width:10%" />
				<jdf:column property="wpCategoryType" title="套餐类型" style="width:10%" >
					<jdf:columnValue dictionaryId="1602"	value="${currentRowObject.wpCategoryType}" />
				</jdf:column>
				<jdf:column property="stockType" title="商品类型" style="width:10%">
					<jdf:columnValue dictionaryId="1606"  value="${currentRowObject.stockType}" />
				</jdf:column>
				<jdf:column property="packageNo" title="套餐编号" style="width:8%" >
				</jdf:column>		
				<jdf:column property="packageStock" title="套餐库存"  style="width:8%" >
				</jdf:column>
				<jdf:column property="priority" title="优先级" style="width:7%" >
					<input type="text"  name="priority" value="${currentRowObject.priority}" size="6" maxlength="9">
				</jdf:column>
				<jdf:column property="startDate" title="有效期" style="width:13%" >
					<fmt:formatDate value="${currentRowObject.startDate}" pattern=" yyyy-MM-dd HH:mm:ss"/>至
					<fmt:formatDate value="${currentRowObject.endDate}" pattern=" yyyy-MM-dd HH:mm:ss"/>
				</jdf:column>
				<jdf:column property="packageName" title="套餐名称" style="width:12%" >
                  <a href="${dynamicDomain}/welfarePackage/view/${currentRowObject.objectId}"> 
                    ${currentRowObject.packageName}
                </a>
                </jdf:column>
                
				<jdf:column property="status" title="状态"  style="width:7%">
					<jdf:columnValue dictionaryId="1120"  value="${currentRowObject.status}" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		$(document).ready(function () {
			
			//项目类型下拉联动大类下拉
	        $("#itemTypes").change(function () {
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#bigItems").empty();
	            	$("#bigItems").append($("<option/>").text("--请选择--").attr("value",""));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=1&itemType="+itemType,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		            				//alert(data.items[i].objectId );
		                          	$("#bigItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			  if("${bigItemId}"!=""){
			            				 $("#bigItems").val("${bigItemId}").change();
			            			 }
		            			}
	       	 			});
					}).change(); 
			
	        //大类下拉联动分类下拉
	        $("#bigItems").change(function () {
	        	var	bigItemId = $("#bigItems").val();
	        	var	itemType = $("#itemTypes").val();
	            //清除二级下拉列表
	            	$("#subItems").empty();
	            	$("#subItems").append($("<option/>").text("--请选择--").attr("value",""));
	            //要请求的二级下拉JSON获取页面
		            	$.ajax({
		            			url: "${dynamicDomain}/welfarePackage/getItems?itemGrade=2&itemType="+itemType+"&bigItemId="+bigItemId,
		            			type : 'post',
		            			dataType : 'json',
		            			success :function (data) {
		            			 //对请求返回的JSON格式进行分解加载
		            			  for(var i=0;i<data.items.length;i++){
		            				//alert(data.items[i].objectId );
		                          	$("#subItems").append("<option value='" +data.items[i].objectId + "'>" + data.items[i].itemName+"</option>");
		            			  }
		            			  if("${subItemId}"!=""){
			            				 $("#subItems").val("${subItemId}").change();
			            			 }
		            			}
	       	 			});
					}); 
			});
		
		function changeStatus(status){
			$("#welfarePackageInfo").attr("action","${dynamicDomain}/welfarePackage/updateToPage") ;
			$("#status").val(status);
			$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
			if($("#objectIdArray").val()!=""){
				if(status==2){
					if(confirm("确认将所选套餐上架吗？")){
						$("#welfarePackageInfo").submit();
					}
				}else if(status==3){
					if(confirm("确认将所选套餐下架吗？")){
						$("#welfarePackageInfo").submit();
					}
				}
			}else{
				alert("请在列表中先勾选需要更新的套餐记录");
			}
		}
		
		function savePriority(status){
			$("#welfarePackageInfo").attr("action","${dynamicDomain}/welfarePackage/updateToPage") ;
			$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
			$("#priorityArray").val(getUpdateColumnString(document.getElementsByName("priority")));
			if($("#objectIdArray").val()!=""){
				var priorityArray = $("#priorityArray").val().split(",");
				for (var i = 0;i<priorityArray.length;i++){
					if(priorityArray[i]!=''&&!/^\d+\.?\d{0,1}$/.test(priorityArray[i])){
		                alert('优先级必须为整数或1位小数');
		            }else{
		            	$("#welfarePackageInfo").submit();
		            }
				}
			}else{
				alert("请在列表中先勾选需要更新的套餐记录");
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