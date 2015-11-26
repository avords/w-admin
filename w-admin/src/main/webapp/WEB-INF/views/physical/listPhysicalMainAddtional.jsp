<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>维护体检套餐加项包编号</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				维护体检套餐加项包编号
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalMainAddtional/page" method="post"  id="PhysicalMainAddtional" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="packageCodeArray" id="packageCodeArray">
				
				<div class="box-body">
					<div class="row">
						 
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">主套餐名称：</label>
								<div class="col-sm-4">
									<input type="text"  name="search_LIKES_mainPackageName" class="search-form-control"  id="mainPackageName">
								</div>	
								<div class="col-sm-4">
								 <button type="submit" class="btn btn-primary">查询</button>
								 </div>	
							</div>
						</div>
						 
					</div>
				</div>
				<div class="box-footer">
				    
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="setPackageCode();">提交套餐编号</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			 
			<jdf:export view="xls" text="ALL" fileName="addtionalPhysicalPackageCode.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				 <jdf:column property="supplierName" title="体检机构" style="width:10%" />
				 
				<jdf:column property="mainPackageName" title="主套餐名称" style="width:10%" />
				 
				<jdf:column property="addPackageName" title="加项套餐名称" style="width:10%" />
				<jdf:column property="sexAndMarry" title="属性" style="width:10%" />
				<jdf:column property="temp" title="套餐编号"  style="width:10%" viewsDenied="html">
				 	${currentRowObject.packageCode}
				</jdf:column>
				<jdf:column property="packageCode" title="套餐编号"  style="width:10%" viewsAllowed="html">
				  <input type="text" name="packageCode" id="packageCode${currentRowObject.objectId}" value="${currentRowObject.packageCode}" size="30" maxlength="100"/>
				</jdf:column>
				 
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	 
	
	function setPackageCode(){
		
		var checkItems = $('input[type="checkbox"][name="schk"]:checked');
		if(!checkItems.length){
			alert('请选择记录！');
			return ;
		}
		$("#PhysicalMainAddtional").attr("action","${dynamicDomain}/physicalMainAddtional/updateToPage?status="+status) ;
		 
		var str = getUpdateColumnString(document.getElementsByName("packageCode"));
		 
		if (null == str || "" == str) {
			alert('请选输入套餐编号');
			return ;
		}
		
		$("#packageCodeArray").val(str);
		$("#PhysicalMainAddtional").submit();
	}
	
	/**
	 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
	 */
	function getUpdateColumnString(columnItem, split) {
		var trim = /\s/g;
		 
		var checkItem = document.getElementsByName("schk");
		if (split == null) {
			split = ",";
		}
		
		str = "";
		for (var i = 0; i < checkItem.length; i++) {
			
			if (checkItem[i].checked == true  ) {
				code =  $("#packageCode" + checkItem[i].value).val();
				
				if (code.replace(trim,'') != '') {
				  str = appendSplit(str, checkItem[i].value +"-" + code, split);
			    }
				 
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