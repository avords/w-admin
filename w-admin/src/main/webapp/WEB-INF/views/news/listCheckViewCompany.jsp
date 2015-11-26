<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业信息查询</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				企业信息查询
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/viewInfoContract?ajax=1" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">企业名称：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_companyName">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">行业：</label>
								<div class="col-sm-8">
									<select name="search_EQI_companyType" class="search-form-control">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1303" valid="true" />
									</select>
								</div>
							</div>
						</div>
					</div>
					
				</div>
				<div class="box-footer">
            <div class="pull-left">
						<button type="button" class="btn btn-primary progressBtn" onclick="savePrice();">保存企业信息</button>
					</div>
            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
              <button type="submit" class="btn btn-primary">查询</button>
            </div>
          </div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="viewInfo">
			<jdf:export view="csv" fileName="company.csv" tooltip="导出CSV" imageName="csv" />
			<jdf:export view="xls" fileName="company.xls" tooltip="导出EXCEL" imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox'  id='checkall'>" sortable="false" viewsAllowed="html" style='width: 5%;text-align: center;'  headerStyle="width: 4%;text-align: center;">
					<input type="checkbox" name="schk" id="checkid" class="mybox" onclick="chooseSupplier($(this));" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false"/>
				<jdf:column alias="logoId" title="企业logo" sortable="false" viewsAllowed="html" headerStyle="width: 8%">
                	<img class="avatar-32" src="${dynamicDomain}/${currentRowObject.logoId}" width="40px" alt="logo">
                </jdf:column>
				<jdf:column property="companyName" title="企业名称" headerStyle="width:8%;">
					<input type="text"  name="companyName" value="${currentRowObject.companyName}" size="7" style="border-style:none" disabled="disabled"> 
				</jdf:column>
				<jdf:column property="webSite" title="企业网址" headerStyle="width:7%;" />
				<jdf:column property="managerName" title="客户经理" headerStyle="width:7%;" >
					<input type="text"  name="managerName" value="${currentRowObject.managerName}" size="7" style="border-style:none" disabled="disabled"> 
				</jdf:column>
				<jdf:column property="verifyStatus" title="审核状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1304" value="${currentRowObject.verifyStatus}" />
				</jdf:column>
				<jdf:column property="type" title="企业规模" headerStyle="width:8%;">
					<jdf:columnValue dictionaryId="1301" value="${currentRowObject.type}" />
				</jdf:column>
				
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function chooseSupplier(obj){
		  if (obj.is(":checked")) {
		         // 先把所有的checkbox 都设置为不选种
		        $('input.mybox').prop('checked', false);
		        // 把自己设置为选中
		        obj.prop('checked',true);
		    }
	}
	
	function savePrice(){
		parent.$("#customerId").val(getCheckedValuesString(document.getElementsByName("schk")));
		parent.$("#customerName").val(getUpdateColumnString(document.getElementsByName("companyName")));
		parent.$("#managerId").val(getUpdateColumnString(document.getElementsByName("managerName")));
		window.parent.$.colorbox.close();
		
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