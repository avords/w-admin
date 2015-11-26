<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检报告物流管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检报告物流管理
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalOrder/page" method="post"  id="physicalReport" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="subOrderNoArray" id="subOrderNoArray">
				<input type="hidden" name="companyArray" id="companyArray">
				<input type="hidden" name="logisticsTonoArray" id="logisticsTonoArray">
				<div class="box-body">
					 <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">HR总订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_hrOrderNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">兑换自订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">物流编号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_logisticsTono">
                </div>
              </div>
            </div>
          </div>
				<div class="box-footer">
					
					<div class="pull-left">
						<button type="button" class="btn btn-primary progressBtn" onclick="savePrice();">保存物流信息</button>
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
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="physicaPrice.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicaPrice.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="hrOrderNo" title="HR总订单号" style="width:15%" />
				<jdf:column property="subOrderNo" title="兑换子订单号" style="width:15%" >
					<input type="text"  name="subOrderNo" value="${currentRowObject.subOrderNo}" size="7" style="border-style:none" disabled="disabled"> 
				</jdf:column>
						<jdf:column property="company" title="物流公司" style="width:5%" >
							${currentRowObject.company}
						</jdf:column>
				<jdf:column property="logisticsNo" title="物流面单号" style="width:5%" >
					<input type="text"  name="logisticsNo" value="${currentRowObject.logisticsNo}"  size="7">
				</jdf:column>
				<jdf:column property="updateUser" title="更新人"  style="width:5%"  />
				<jdf:column property="updateTime" title="更新时间"  style="width:10%"  >
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	function savePrice(){
		$("#physicalReport").attr("action","${dynamicDomain}/physicalOrder/updateToPage") ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#subOrderNoArray").val(getUpdateColumnString(document.getElementsByName("subOrderNo")));
		$("#logisticsTonoArray").val(getUpdateColumnString(document.getElementsByName("logisticsTono")));
		if($("#objectIdArray").val() == ""){

		}
		else{
			$("#physicalReport").submit();
		}
				
		/* $("#physicalReport").submit();   */
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