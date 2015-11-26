<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>卡密订单管理</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>卡密订单管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/cardUpdateLog/page"  method="post"  id="cardInfo"
				class="form-horizontal">
				<input type="hidden" name="cardStatus" id="cardStatus">
				<input type="hidden" name="packageID" id="packageID" value="${packageID}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐编号：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_packageNo"  class="search-form-control"  >
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐名称：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_packageName"  class="search-form-control"  >
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">卡密备注：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_remark"  class="search-form-control"  >
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">卡号：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_cardNo"  class="search-form-control"   id="cardNo" >
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">手机号码：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_mobilePhone"  class="search-form-control"  >
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">卡号状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_cardStatus" class="search-form-control"  id="cardStatus">
										<option value="">—全部—</option>
										<jdf:select dictionaryId="1604" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
			              <div class="form-group">
			                <label for="search_GED_bookingDate" class="col-sm-4 control-label">下单时间：</label>
			                <div class="col-sm-4">
			                  <input class="search-form-control" type="text" name="search_GED_bookingDate" id="search_GED_bookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_bookingDate\')}'})">
			                </div>
			                <div class="col-sm-4">
			                  <input type="text" class="search-form-control" name="search_LED_bookingDate" id="search_LED_bookingDate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_bookingDate\')}'})">
			                </div>
			              </div>
			            </div>
			            <div class="col-sm-4 col-md-4">
			              <div class="form-group">
			                <label class="col-sm-4 control-label">子订单号：</label>
			                <div class="col-sm-8">
			                  <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
			                </div>
			              </div>
			            </div>
			            <div class="col-sm-4 col-md-4">
			              <div class="form-group">
			                <label class="col-sm-4 control-label">订单状态：</label>
			                <div class="col-sm-8">
			                  <select name="search_EQI_orderStatus" id="search_EQI_orderStatus" class="search-form-control">
			                    <option value="">—全部—</option>
			                    <jdf:select dictionaryId="2002" valid="true" />
			                  </select>
			                </div>
			              </div>
			            </div>
		           </div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<a href="#" onclick="javascript:commitUpdateApply('${dynamicDomain}/cardUpdateLog/commitUpdateApply/');" 
						id="commitUpdateApply" class="pull-left btn btn-primary colorbox-template">卡密状态调整</a>
					</div>
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>	
</div>
<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
			 <jdf:row>
			 	<jdf:column property="cardId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" 
							onclick="schkClick()" value="${currentRowObject.cardId}" />
				</jdf:column>
				<jdf:column property="packageName" title="套餐名称" style="width:10%" />
				<jdf:column property="packageNo" title="套餐编号" style="width:5%" />
				<jdf:column property="cardNo" title="卡号" style="width:8%" />
<%-- 				<jdf:column property="remark" title="卡号备注" style="width:10%" /> --%>
				<jdf:column property="subOrderNo" title="订单号" style="width:10%" />
				<jdf:column property="subOrderState" title="订单状态" style="width:5%">
					<jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
				</jdf:column>
				<jdf:column property="bookingDate" title="下单时间" style="width:8%">
				     <fmt:formatDate value="${currentRowObject.bookingDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</jdf:column>
				<jdf:column property="companyName" title="公司名称" style="width:10%"/>
				<jdf:column property="userName" title="员工姓名" style="width:5%"/>
				<jdf:column property="cardStatus" title="卡密状态" style="width:5%" >
					<jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardStatus}" />
				</jdf:column>
				<jdf:column property="cardNewStatus" title="卡密变更状态" style="width:8%">
					<jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardNewStatus}" />
				</jdf:column>
				<jdf:column property="operation" title="操作记录" style="width:8%">
					<c:if test="${!(currentRowObject.cardNewStatus eq null) }">
						<a class="colorbox-template" target="_blank" href="${dynamicDomain}/cardUpdateLog/details/${currentRowObject.cardId}">查看详情</a>
					</c:if>
				</jdf:column>
				<jdf:column property="checkStatus" title="审核状态" style="width:5%">
					<jdf:columnValue dictionaryId="2003" value="${currentRowObject.checkStatus}" />
				</jdf:column>
			</jdf:row>
		</jdf:table> 
</div>
<script>
  $('.j-chk-all').click(function(){
	var _this = $(this);
	var _chlid = $('input:checkbox[name="schk"]').filter(function(){
		return !$(this).is(':disabled');
	});

	var _bool = _this.is(':checked') ? true : false;
	_chlid.prop('checked', _bool);
  });
  
  
  function commitUpdateApply(url) {
		var objectIdArray = getCheckedValuesString(document.getElementsByName("schk"));
		$("#commitUpdateApply").attr("href", url + objectIdArray + "?ajax=1");
	}
// 	/**
// 	 * 获得的需要批量更新处理表格列的内容值,以split分隔的字符串
// 	 */
// 	function getUpdateColumnString(columnItem, split) {
// 		var checkItem = document.getElementsByName("schk");
// 		if (split == null) {
// 			split = ",";
// 		}
// 		str = "";
// 		for (var i = 0; i < checkItem.length; i++) {
// 			if (checkItem[i].checked == true) {
// 				str = appendSplit(str, columnItem[i].value, split);
// 			}
				
// 		}
// 		if (str == "") {
// 			return null;
// 		}
// 		return str;
// 	}
// 	/**
// 	 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
// 	 */
// 	function appendSplit(str, strAppend, split) {
// 		if (str == null || str == "") {
// 			return strAppend;
// 		} else {
// 			return str + "," + strAppend;
// 		}
// 	}
	
// 	function commitUpdateApply()
// 	{
// 		if(getCheckedValuesString($("input[name='schk']"))==null){
//             winAlert('请先勾选商品或者套餐');
//             return false;
//         }
// 		var productRecomments = getCheckedValuesString($("input[name='schk']")).split(",");
// 		$("#commitUpdateApply").attr("href","${dynamicDomain}/cardUpdateLog/commitUpdateApply?productRecomments="+productRecomments);
// 	}
</script>
</body>
</html>