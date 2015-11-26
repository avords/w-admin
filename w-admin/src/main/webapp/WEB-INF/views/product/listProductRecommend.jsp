<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品推荐管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				商品推荐管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productRecommend/page" method="post"
				class="form-horizontal" id="ProductRecommendList">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_platform" class="col-sm-4 control-label">推荐平台：</label>
								<div class="col-sm-8">
									<select name="search_EQI_platform" class="search-form-control" id="search_EQI_platform">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1202" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_page" class="col-sm-4 control-label">推荐页面：</label>
								<div class="col-sm-8">
									<select name="search_EQI_page" class="search-form-control" id="search_EQI_page">
										<option value="">—全部—</option>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_location" class="col-sm-4 control-label">推荐位置：</label>
								<div class="col-sm-8">
									<select name="search_LIKES_location" class="search-form-control" id="search_LIKES_location">
										<option value="">—全部—</option>
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="search_EQL_catagoryFirstId"
									class="col-sm-2 control-label">推荐商品分类：</label>
								<div class="row">
									<div class="col-sm-10 col-md-10">
										<div class="col-sm-4">
											<!-- <input type="text" class="search-form-control"
												name="search_EQL_catagoryFirstId"> -->
                                       <select name="search_EQS_firstId" id="category1" class="form-control">
                                          <option value="">—全部—</option>
                                          <jdf:selectCollection items="firstCategory" optionValue="firstId" optionText="name"/>
                                       </select>
										</div>
										<div class="col-sm-4">
											<!-- <input type="text" class="search-form-control"
												name="search_EQL_catagorySecondId"> -->
                                     <select name="search_EQS_secondId" id="category2" class="form-control">
                                     </select>
										</div>
										<div class="col-sm-4">
											<!-- <input type="text" class="search-form-control"
												name="search_EQL_catagoryThirdId"> -->
                                          <select name="search_EQL_categoryId" id="category3" class="form-control">
                                         </select>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQL_supplierId"
									class="col-sm-4 control-label">供应商编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_EQL_supplierId">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_supplierName"
									class="col-sm-4 control-label">供应商名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_supplierName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_type"
									class="col-sm-4 control-label">商品类型：</label>
								<div class="col-sm-8">
										<select name="search_EQI_type" id="type" class="form-control">
                            <option value="">—全部—</option>
                            <jdf:select dictionaryId="1101"/>
                       </select>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_GED_startDate" class="col-sm-4 control-label">商品发布时间：</label>
								<div class="col-sm-4">
								<input class="search-form-control" type="text" 
										name="search_GED_startDate" id="search_GED_startDate"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_startDate\')}',readOnly:true})">
								</div>
								<div class="col-sm-4">
									<input type="text" class="search-form-control"
										name="search_LED_startDate" id="search_LED_startDate" 
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_startDate\')}',readOnly:true})">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_productName"
									class="col-sm-4 control-label">商品名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_productName">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKEL_productId" class="col-sm-4 control-label">商品编号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKEL_productId">
								</div>
							</div>
						</div>
					</div>
					<div class="row"></div>
				</div>
				<div class="box-footer">
					<a href="${dynamicDomain}/productRecommend/create"
						class="pull-left btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
					</a>
					<button type="button"
						onclick="javascript:deleteProductRecommends();"
						class="btn btn-primary">删除</button>
					<button type="button" onclick="javascript:saveProductSortNos();"
						class="btn btn-primary">保存顺序</button>
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
<%
request.getSession().setAttribute("action", "/productRecommend/page");
%>
	<div>
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="商品推荐管理.csv"
				tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="商品推荐管理.xls"
				tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId"
					title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
					style="width: 4%;text-align: center;"
					headerStyle="width: 4%;text-align: center;" viewsAllowed="html"
					sortable="false">
					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />
				<jdf:column property="location" title="位置编号" headerStyle="width:8%;" />
				<jdf:column property="2" title="位置名称" headerStyle="width:20%;" viewsDenied="html">
                       ${currentRowObject.platformName }-${currentRowObject.pageName }-${currentRowObject.locationName }
				</jdf:column>
				<jdf:column property="locationName" title="位置名称" headerStyle="width:20%;" viewsAllowed="html">
                       ${currentRowObject.platformName }-${currentRowObject.pageName }-${currentRowObject.locationName } 
				</jdf:column>
				<jdf:column property="3" title="推荐商品" headerStyle="width:10%;" viewsDenied="html">
                       ${currentRowObject.productName}
                </jdf:column>
               <jdf:column property="productName" title="推荐商品" headerStyle="width:10%;" viewsAllowed="html" sortable="false">
				<c:if test="${currentRowObject.type  eq 3}">
                    <a href="${dynamicDomain}/product/view/${currentRowObject.productId}">
                       ${currentRowObject.productName}
                   </a>
                 </c:if>
                 <c:if test="${currentRowObject.type  eq 2}">
                    <a href="${dynamicDomain}/physicalPackage/view/${currentRowObject.productId}" target="_blank ">
                       ${currentRowObject.productName}
                   </a>
                 </c:if>
                 <c:if test="${currentRowObject.type  eq 1}">
                    <a href="${dynamicDomain}/welfarePackage/view/${currentRowObject.productId}" target="_blank ">
                       ${currentRowObject.productName}
                   </a>
                 </c:if>
                </jdf:column>
					
				<jdf:column property="1" title="排序" headerStyle="width:5%;" viewsDenied="html">
					${currentRowObject.sortNo }
				</jdf:column>
				<jdf:column property="sortNo" title="排序" headerStyle="width:5%;" viewsAllowed="html">
					<input type="text" value="${currentRowObject.sortNo }" name="sortNos" class="order-form-control">
				</jdf:column>
				<jdf:column property="sellPrice" title="商品价格" headerStyle="width:8%;" />
				<jdf:column property="endDate" title="商品有效期" cell="date" headerStyle="width:10%;" />
				<jdf:column property="dayDown" title="倒计时" headerStyle="width:8%;" sortable="false">
				</jdf:column>
				<jdf:column property="userName" title="更新人" headerStyle="width:8%;" />
				<jdf:column property="createdOn" cell="date" title="创建时间" headerStyle="width:10%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	$(function(){
		 $("#search_EQI_platform").bind("change",function(){
          if($(this).val()){
              $.ajax({
                  url:"${dynamicDomain}/advert/category/secondCategory/" + $(this).val()+"?type=2",
                  type : 'post',
                  dataType : 'json',
                  success : function(json) {
                      $("#search_EQI_page").children().remove();
                      $("#search_EQI_page").append("<option value=''>—全部—</option>");
                      for ( var i = 0; i < json.secondCategory.length; i++) {
                          $("#search_EQI_page").append("<option value='" + json.secondCategory[i].pageCode + "'>" + json.secondCategory[i].pageName + "</option>");
                      }
                  }
              });
          }
       }).change();
		 
		 	$("#search_EQI_page").bind("change",function(){
						var page = $("#search_EQI_page").val();
             $.ajax({
                 url:"${dynamicDomain}/advert/category/thirdCategory/"+page+"?type=2",
                 type : 'post',
                 dataType : 'json',
                 success : function(json) {
                     $("#search_LIKES_location").children().remove();
                     $("#search_LIKES_location").append("<option value=''>—全部—</option>");
                     for ( var i = 0; i < json.thirdCategory.length; i++) {
                         $("#search_LIKES_location").append("<option value='" + json.thirdCategory[i].positionCode + "'>" + json.thirdCategory[i].positionName + "</option>");
                     }
                 }
             });
        
      }).change();
  });
	
		function deleteProductRecommends()
		{
			if(getCheckedValuesString($("input[name='schk']"))==null){
	            winAlert('请先勾选商品或者套餐');
	            return false;
	        }
			var productRecomments = getCheckedValuesString($("input[name='schk']")).split(",");
			$.ajax(
			{
				url : "${dynamicDomain}/productRecommend/deleteRecommends",
				type : 'post',
				dataType : 'json',
				data : "ids=" + productRecomments + "&timstamp="
						+ (new Date()).valueOf(),
				success : function(msg)
				{
					if (msg.result)
					{
						winAlert("删除成功");
						ec.submit();
					}
				}
			});
		}

		function saveProductSortNos(){
			var productRecomments = getCheckedValuesString($("input[name='schk']"));
			var productSortNos = getUpdateColumnString($("input[name='sortNos']"));
			if(productRecomments!=""){
				if(productRecomments==null){
		            winAlert('请至少选择一条记录');
		            return false;
		        }
				var sortNoArray = productSortNos.split(",");
				for (var i = 0;i<sortNoArray.length;i++){
					if(sortNoArray[i]!=''&&!/^\d+\.?\d{0,1}$/.test(sortNoArray[i])){
		                winAlert('排序必须为整数或1位小数');
		                return false;
		            }
				}
            	$.ajax(
            			{
            				url : "${dynamicDomain}/productRecommend/saveSortNos",
            				type : 'post',
            				dataType : 'json',
            				data : "ids=" + productRecomments + "&sortNos="
            						+ productSortNos + "&timstamp="
            						+ (new Date()).valueOf(),
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
		
		
		$(function(){
	    	$("#category1").bind("change",function(){
	            if($(this).val()){
	                $.ajax({
	                    url:"${dynamicDomain}/productCategory/secondCategory/" + $(this).val(),
	                    type : 'post',
	                    dataType : 'json',
	                    success : function(json) {
	                        $("#category2").children().remove();
	                        $("#category2").append("<option value=''>—全部—</option>");
	                        for ( var i = 0; i < json.secondCategory.length; i++) {
	                            $("#category2").append("<option value='" + json.secondCategory[i].secondId + "'>" + json.secondCategory[i].name + "</option>");
	                        }
	                        $("#category2").val('${param.search_EQS_secondId}').change();
	                    }
	                });
	            }
	         }).change();

	        $("#category2").bind("change",function(){
	            if($(this).val()){
	                $.ajax({
	                    url:"${dynamicDomain}/productCategory/thirdCategory/" + $(this).val(),
	                    type : 'post',
	                    dataType : 'json',
	                    success : function(json) {
	                        $("#category3").children().remove();
	                        $("#category3").append("<option value=''>—全部—</option>");
	                        for ( var i = 0; i < json.thirdCategory.length; i++) {
	                            $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
	                        }
	                        $("#category3").val('${param.search_EQL_categoryId}').change();
	                    }
	                });
	            }
	         }).change();
	    });
		
	</script>
</body>
</html>