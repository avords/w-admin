<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>  
<title>体检项目管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检套餐搭配
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalPackage/page" method="post"  id="physicalPackage" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									 <select name="search_EQL_supplierId"  id="supplierId" class="search-form-control">
									 <option value=""></option>
									  <c:forEach items="${supplierList }" var="supplier" >
									    <option value="${supplier. objectId}">${supplier. supplierName}</option>
									  </c:forEach>
									 </select>
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐名称：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_packageName" class="search-form-control"  id="packageName">
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐类型：</label>
								<div class="col-sm-8">
								<select name="search_EQL_packageType" class="search-form-control"  id="j_packageType" onchange="packageTypeChange(this.value);">
										<option value="-1"></option>
										<jdf:select dictionaryId="1607" valid="true" />
									</select>
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3" style="display: none;" id="main_package">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="main_status" class="search-form-control" disabled="disabled">
										<option value="-1"></option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3" style="display: none;" id="addtional_package">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="addtional_status" class="search-form-control" disabled="disabled">
										<option value="-1"></option>
										<jdf:select dictionaryId="1120" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="create()">
							<span class="glyphicon glyphicon-plus"></span>
						</button>
						<button type="button" class="btn btn-primary"  onclick="putAway(2)">上架</button>
						<button type="button" class="btn btn-primary"  onclick="putAway(3)">下架</button>
						<!-- <button type="button" class="btn btn-primary"  onclick="del()">删除</button> -->
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
			<!--<jdf:export view="csv" fileName="physicalPackage.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicalPackage.xls" tooltip="Export EXCEL"  imageName="xls" />-->
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 3%;text-align: center;" headerStyle="width: 3%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}_${currentRowObject.packageType}" />
				</jdf:column>
				<jdf:column alias="common.lable.operate" title="操作" sortable="false" viewsAllowed="html" style="width: 3%;text-align:center">
				<c:if test="${currentRowObject.packageType ==0}">
					<c:if test="${currentRowObject.status!=2}">
						<a
							href="${dynamicDomain}/physicalPackage/edit/${currentRowObject.objectId}"> <i class="glyphicon glyphicon-pencil"></i>
						</a>
	                </c:if>
                </c:if>
                <c:if test="${currentRowObject.packageType ==1}">
					<a
						href="${dynamicDomain}/physicalPackage/edit/${currentRowObject.objectId}"> <i class="glyphicon glyphicon-pencil"></i>
					</a>
                </c:if>
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:3%;text-align:center" sortable="false"/>
               <jdf:column property="packageNo" title="套餐编号" style="width:5%" />
               <jdf:column property="packageName" title="套餐名称" style="width:10%">
               		<a href="${dynamicDomain}/physicalPackage/view/${currentRowObject.objectId}">
	               		${currentRowObject.packageName}
					</a>
               </jdf:column>
               <jdf:column property="stockType" title="商品类型" style="width:5%"    >
                   <jdf:columnValue dictionaryId="1119" value="${currentRowObject.stockType}" />
               </jdf:column>
               
               <jdf:column property="packageStock" title="  套餐剩余库存" style="width:5%" />
               
               <jdf:column property="supplierName" title=" 供应商" style="width:10%" >
               <a href="javascript:void(0);" onclick="goSupInfo('<c:forEach items="${physicalSupplyList }" var="physicalSupply" ><c:if test="${physicalSupply.packageId == currentRowObject.objectId}">${physicalSupply.supplierId},</c:if></c:forEach>')">
                <%--     <c:forEach items="${physicalSupplyList }" var="physicalSupply" >
						<c:if test="${physicalSupply.packageId == currentRowObject.objectId}">
							${physicalSupply.supplierName },
						</c:if>
					</c:forEach> --%>
					
					<c:forEach items="${physicalSupplyList }" var="physicalSupply" >
						<c:if test="${physicalSupply.packageId == currentRowObject.objectId}">
						
						
						 <c:forEach items="${supplierList }" var="supplier" >
							 <c:if test="${physicalSupply.supplierId  == supplier.objectId}">
							 	${supplier.supplierName},
							 </c:if>
						 </c:forEach>
<%-- 						 ${physicalSupply.supplierName }, --%>
						 
						</c:if>
					</c:forEach>
					
					
					</a>
               </jdf:column>
			  	<jdf:column property="startDate" title="有效期" style="width:15%">
					<fmt:formatDate value="${currentRowObject.startDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
						至
					<fmt:formatDate value="${currentRowObject.endDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
				</jdf:column>
				<c:choose>
					 <c:when test="${currentRowObject.packageType == 0}">
				              <jdf:column property="status" title=" 状态" style="width:5%"   >
				                   <jdf:columnValue dictionaryId="1120" value="${currentRowObject.status}" />
				              </jdf:column>
			           </c:when>
		              	<c:otherwise>
				              <jdf:column property="status" title=" 状态" style="width:5%"   >
				                   <jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				              </jdf:column>
			             </c:otherwise>
	             </c:choose>
              <jdf:column property="updatedUserName" title="修改人"  style="width:5%"  />
              <jdf:column property="updatedOn" title="修改时间" style="width:10%">
					<fmt:formatDate value="${currentRowObject.updatedOn}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
				</jdf:column>
              
			</jdf:row>
		</jdf:table>
	</div>
	<form action="${dynamicDomain}/physicalPackage/showSupInfo" id="showSupInfoForm" method="post">
		<input type="hidden" name="supIds" id="j_supIds" value=""/>
	</form>
	<script type="text/javascript">	
	function del(){
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		if(confirm("确定要删除该体检套餐吗？")){
			$("#physicalPackage").attr("action","${dynamicDomain}/physicalPackage/delPhy") ;
			$("#objectIdArray").val(getCheckedValuesString_(document.getElementsByName("schk")));
			$("#physicalPackage").submit();
		}
	}
	
	function putAway(status){
	
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		var ids = "";
		var _c = true;
		checkItems.each(function(index,domEle){ 
			var _i = $(domEle).val(); 
				if(_i.split("_")[1] == 1){
					alert('包含加项套餐，不能做上/下架操作！');
					_c = false;
					return false;
				}else{
					ids += (_i.split("_")[0]+",");
				}
			}); 
		if(_c){
			
			var msg = "确定要继续";
			if(status==2){
				msg+="上架";
			}else{
				msg+="下架";
			}
			msg+="操作吗？";
			if(confirm(msg)){
				$("#physicalPackage").attr("action","${dynamicDomain}/physicalPackage/updateToPage?status="+status) ;
				$("#objectIdArray").val(getCheckedValuesString_(document.getElementsByName("schk")));
				$("#physicalPackage").submit();
			}
		}
	}
	
	function getCheckedValuesString_(){
		var ids = "";
		$('input[type="checkbox"][name="schk"]:checked').each(function(index,domEle){ 
			var _i = $(domEle).val(); 
			 ids += (_i.split("_")[0]+",");
			}); 
		return ids;
	}
	
	function create(){
		window.location.href = "${dynamicDomain}/physicalPackage/create";
	}
		/**
		 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
		 */
		function getUpdateColumnString(columnItem, split) {
			if (split == null) {
				split = ",";
			}
			str = "";
			for (var i = 0; i < columnItem.length; i++) {
					str = appendSplit(str, columnItem[i].value, split);
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
		
		//跳转套供应商明细页面
		function goSupInfo(supId){
			if(supId != null){
				$("#j_supIds").val(supId);
				$("#showSupInfoForm").submit();
			}
		}
		
		function packageTypeChange(packageType){
			if(packageType == '1'){
				 $("#main_package").show();
				 $("#main_status").removeAttr("disabled");
				 $("#addtional_status").attr("disabled","disabled");
				 $("#addtional_package").hide();
			}else if(packageType == '0'){
				$("#addtional_package").show();
				$("#main_package").hide();
				$("#main_status").attr("disabled","disabled");
				 $("#addtional_status").removeAttr("disabled");
			}else{
				$("#addtional_package").hide();
				$("#main_package").hide();
				$("#main_status").attr("disabled","disabled");
				 $("#addtional_status").attr("disabled","disabled");
			}
		}
	</script>
</body>
</html>