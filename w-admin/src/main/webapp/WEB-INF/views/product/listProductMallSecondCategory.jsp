<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>福利商城分类管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">福利商城二级分类</h4>
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/productMallCategory/secondpage" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
								<label class="col-sm-6 control-label">所属一级分类名称：</label>
								<div class="col-sm-6">                           
									<span class="lable-span">${firstProductMallCategory.name}</span>
								</div>                               
                            </div>                            
                        </div> 
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
								<label class="col-sm-4 control-label">所属平台：</label>
								<div class="col-sm-8">                       
									<span class="lable-span"><jdf:dictionaryName dictionaryId="1114" value="${firstProductMallCategory.platform }"/></span>
								</div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
	                        <div class="pull-right">
	                        	<a href="${dynamicDomain}/productMallCategory/page" class="btn btn-primary">返回</a>
	                        </div>
                        </div>                     						
					</div>		
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-6 control-label">二级分类编号：</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control"
										name="search_LIKES_secondId">
								</div>
							</div>
						</div>							
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">二级分类：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_name">
								</div>
							</div>
						</div>						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_EQI_status" class="col-sm-6 control-label">状态：</label>
								<div class="col-sm-6">
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
                	<c:if test="${firstProductMallCategory.status==1 }">
                    <a href="${dynamicDomain}/productMallCategory/createMallSecondCategory?ajax=1" class="colorbox-mini pull-left btn btn-primary">
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
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="secondpage">
            <jdf:export view="csv" fileName="福利商城二级分类.csv" tooltip="导出CSV" imageName="csv" />
            <jdf:export view="xls" fileName="福利商城二级分类.xls" tooltip="导出EXCEL" imageName="xls" />
            <jdf:row>
            	<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>" style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
					<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
                <jdf:column alias="操作" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 8%">
                    <a href="${dynamicDomain}/productMallCategory/editMallSecondCategory/${currentRowObject.objectId}?ajax=1" class="btn btn-primary btn-mini colorbox-mini">  
                    	<i class="glyphicon glyphicon-pencil"></i>
                    </a>
                    <a  href="javascript:toDeleteUrl('${dynamicDomain}/productMallCategory/delete/${currentRowObject.objectId}?action=../secondpage')"  class="btn btn-danger btn-mini"> 
                    	<i class="glyphicon glyphicon-trash"></i>
                    </a>
                </jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
                <jdf:column property="secondId" title="二级分类编号" headerStyle="width:20%;" />
                <jdf:column property="name" title="二级分类名称" headerStyle="width:20%;" />
                <jdf:column property="sortNo" title="排序" headerStyle="width:10%;" >
                	<input type="text" value="${currentRowObject.sortNo }" name="sortNos" id="sortNos${currentRowObject.objectId}" class="order-form-control">
                </jdf:column>
                <jdf:column property="1" title="三级分类" headerStyle="width:10%;" viewsDenied="html">  
                	${currentRowObject.childrenCount }
               	</jdf:column>                
                <jdf:column property="childrenCount" title="三级分类" headerStyle="width:10%;" viewsAllowed="html">  
                	<a href="${dynamicDomain}/productMallCategory/thirdpage?search_EQL_secondId=${currentRowObject.secondId}" class="active">${currentRowObject.childrenCount }</a>
               	</jdf:column>          
                <jdf:column property="status" title="状态" headerStyle="width:10%;">
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
   				url : "${dynamicDomain}/productMallCategory/invalid",
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
   				url : "${dynamicDomain}/productMallCategory/saveSortNos",
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