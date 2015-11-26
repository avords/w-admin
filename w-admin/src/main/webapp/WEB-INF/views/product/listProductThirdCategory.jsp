<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品运营分类管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">商品运营三级分类</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productCategory/thirdpage" method="post" class="form-horizontal">
				<div class="box-body">
					<div class="row">				
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
								<label for="name" class="col-sm-6 control-label">所属二级分类名称：</label>                              
								<span class="lable-span">${secondProductCategory.name}</span>                                
                            </div>
                        </div>
                        <div class="pull-right">
                        	<a href="${dynamicDomain}/productCategory/secondpage" class="btn btn-primary">返回</a>
                        </div>
					</div>				
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-6 control-label">三级分类编号：</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control"
										name="search_LIKES_thirdId">
								</div>
							</div>
						</div>	
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">三级分类：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_name">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_status" class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_status" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>
							</div>
						</div>						
					</div>            
                </div>
                <div class="box-footer">
                	<c:if test="${secondProductCategory.status==1 }">
                    <a href="${dynamicDomain}/productCategory/createThirdCategory?ajax=1" class="colorbox-mini pull-left btn btn-primary">
                    	<span class="glyphicon glyphicon-plus"></span>
                    </a>
                    </c:if>
                    <button type="button" class="btn btn-primary pull-left" onclick="invalid()">置为无效</button>
	                <button type="button" class="btn btn-primary pull-left" onclick="saveSortNo()">保存排序</button>
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="thirdpage">
            <jdf:export view="csv" fileName="商品运营三级分类.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="商品运营三级分类.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
            	<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 4%">
                    <a href="${dynamicDomain}/productCategory/editThirdCategory/${currentRowObject.thirdId}?ajax=1" class="btn btn-primary btn-mini colorbox-mini"> 
                    	<i class="glyphicon glyphicon-pencil"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="thirdId" title="商品运营三级分类编号" headerStyle="width:20%;" />
                <jdf:column property="name" title="三级分类名称" headerStyle="width:20%;" />
                <jdf:column property="sortNo" title="排序" headerStyle="width:15%;" >
                	<input type="text" value="${currentRowObject.sortNo }" name="sortNos" id="sortNos${currentRowObject.objectId}" class="order-form-control">
                </jdf:column>                        
                <jdf:column property="status" title="状态" headerStyle="width:15%;">
                    <jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
                </jdf:column> 
            </jdf:row>
        </jdf:table>
    </div>
     <script type="text/javascript">
    	function invalid(){
    		var ids = getCheckedValuesString($("[name='schk']"));
    		if(ids==null){
    			winAlert("请至少选择一条记录");
    			return false;
    		}
    		$.ajax( {
   				url : "${dynamicDomain}/productCategory/invalid",
   				type : 'post',
   				dataType : 'json',
   				data : "ids=" + ids + "&timstamp=" + (new Date()).valueOf(),
   				success : function(msg) {
   					if (msg>0) {
   						winAlert("成功保存" + msg + "条记录");
   						$("[name='sortNos']").remove();
   						ecFormSubmit();
   					} else {
   						winAlert("保存失败");
   					}
   				}
   			});
    	}
    	
    	function saveSortNo(){
   			var sortNos = getUpdateColumnString("sortNos");
   			var ids = getCheckedValuesString($("[name='schk']"));
   			if(ids==null){
   				winAlert("请至少选择一条记录");
   				return false;
   			}
   			$.ajax( {
   				url : "${dynamicDomain}/productCategory/saveSortNos",
   				type : 'post',
   				dataType : 'json',
   				data : "ids=" + ids + "&sortNos=" + sortNos + "&timstamp=" + (new Date()).valueOf(),
   				success : function(msg) {
   					if (msg) {
   						winAlert("保存成功");
   						$("[name='sortNos']").remove();
   						ecFormSubmit();
   					} else {
   						winAlert("保存失败");
   					}
   				}
   			});
    	}
    	
    	function getUpdateColumnString(elementName, split) {
			var checkItem = document.getElementsByName("schk");
			if (split == null) {
				split = ",";
			}
			str = "";
			for (var i = 0; i < checkItem.length; i++) {
				if (checkItem[i].checked == true) {
					str = appendSplit(str, $("#" +elementName + $(checkItem[i]).val()).val(), split);
				}

			}
			if (str == ""){
				return null;
			}
			return str;
		}
    </script>
</body>
</html>