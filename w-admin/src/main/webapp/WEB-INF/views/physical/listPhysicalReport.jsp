<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<title>体检报告物流管理</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right"></div>
        	体检报告物流管理
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/physicalReport/page" method="post" id="physicalReport" class="form-horizontal">
       			<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="logisticsCompanyArray" id="logisticsCompanyArray">
				<input type="hidden" name="logisticsTonoArray" id="logisticsTonoArray">
        
        <div class="box-body">
          <div class="row">
            <!-- <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" onClick="WdatePicker()" name="search_GED_bookingDate">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-8">
                  <input type="text" onClick="WdatePicker()" class="search-form-control" name="search_LED_bookingDate">
                </div>
              </div>
            </div> -->
            <div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_GED_bookingDate" class="col-sm-4 control-label">下单时间：</label>
								<div class="col-sm-4">
								<input class="search-form-control" type="text" 
										name="search_GED_bookingDate" id="search_GED_bookingDate"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_bookingDate\')}',readOnly:true})">
								</div>
								<div class="col-sm-4">
									<input type="text" class="search-form-control"
										name="search_LED_bookingDate" id="search_LED_bookingDate" 
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_bookingDate\')}',readOnly:true})">
								</div>
							</div>
						</div>
            
           	 <!-- 此处一点问题 -->
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">报告类型：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_ReportType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1207" valid="true" />
                  </select>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">总订单号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_generalOrderNo">
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
                  <select name="search_EQI_orderStatus" id="statusType" class="search-form-control">
                    <option value="">—全部—</option>
                    <jdf:select dictionaryId="1209" valid="true" />
                  </select>
                </div>
              </div>
            </div>

          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">供应商编号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_supplierNo">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">供应商名称：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_LIKES_supplierName">
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">兑换卡号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_cashCard">
                </div>
              </div>
            </div>
          </div>
          
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">报告上传状态：</label>
                <div class="col-sm-8">
	                  <select name="search_EQI_uploadStatus" id="statusType" class="search-form-control">
	                    <option value="">—全部—</option>
	                    <option value="1">已上传</option>
	                    <option value="2">未上传</option>
	                  </select>
                </div>
              </div>
            </div>
           </div>
          <div class="box-footer">
            <div class="pull-left">
	            <a href="${dynamicDomain}/physicalReport/importInfo?ajax=1"class="colorbox btn btn-primary progressBtn">导入</a>
				 <a href="${dynamicDomain}/physicalOrder/page"> <Lable type="Lable" class="btn btn-primary progressBtn"> </span>查看导入详情</Lable></a>
				 <a href="javascript:void(0);" id="uploadReportBtn" class="btn btn-primary" onclick="uploadReport();">体检报告上传</a>
	            <button type="button" class="btn btn-primary" onclick="savePrice();">保存物流信息</button>
			</div>
            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
              <button type="submit" class="btn btn-primary progressBtn">查询</button>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <div>
	 		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
				sortRowsCallback="limit" action="page">
				<jdf:export view="csv" fileName="体检报告物流信息.csv" tooltip="Export CSV"  imageName="csv" />
				<jdf:export view="xls" fileName="体检报告物流信息.xls" tooltip="Export EXCEL"  imageName="xls" />
				<jdf:row>
					<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
								style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
								<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
					</jdf:column>
					<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:5%;text-align:center" />
			        <jdf:column property="generalOrderNo" title="HR总订单号" headerStyle="width:12%;">
			          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
			        </jdf:column>
			        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:10%;">
			            <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;"> ${currentRowObject.subOrderNo}</font></a> 
			        </jdf:column>
			        <jdf:column property="subOrderState" title="订单状态" headerStyle="width:8%;" >
			         	<jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
			        </jdf:column>
			        <jdf:column property="subOrderState" title="报告类型" headerStyle="width:8%;" >
			         	<c:if test="${currentRowObject.elecReport ==1}">
			         		电子报告
			         	</c:if>
			         	 <c:if test="${currentRowObject.pageReport eq 1 or currentRowObject.pageReport eq 2 }">
			         		纸质报告
			         	</c:if> 
			         	<input type="hidden" name="elecReport" id="j_elecReport_${currentRowObject.objectId}" value="${currentRowObject.elecReport}"/>
			         	<input type="hidden" name="pageReport" id="j_pageReport_${currentRowObject.objectId}" value="${currentRowObject.pageReport}"/>
			        </jdf:column>
			        <jdf:column property="cashCard" title="兑换卡号" headerStyle="width:8%;" >
			        <input type="hidden" id="cashCard_${currentRowObject.objectId}" value="${currentRowObject.cashCard }"/>
			        <input type="hidden" id="subOrderState_${currentRowObject.objectId}" value="${currentRowObject.subOrderState }"/>
			        ${currentRowObject.cashCard }</jdf:column>
					<jdf:column property="bookingDate" title="预约时间" style="width:8%">
						<fmt:formatDate value="${currentRowObject.bookingDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
					</jdf:column>
			        <jdf:column property="companyName" title="物流公司"  headerStyle="width:5%;" viewsDenied="xls" >
			        		 <select name="logisticsCompany"  id="companyName">
                                  <c:forEach items="${logisticsCompanys }"  var="lCompany"  varStatus="num" >
                                   		<c:if test="${lCompany.objectId  eq currentRowObject.logisticsCompany}">
								 			 <option value="${lCompany.objectId}"selected="selected">${lCompany.companyName}</option>
								 		</c:if>
								 		<c:if test="${lCompany.objectId  != currentRowObject.logisticsCompany}">
								 			 <option value="${lCompany.objectId}">${lCompany.companyName}</option>
								 		</c:if>
									</c:forEach> 
								<c:if test="${empty currentRowObject.logisticsCompany}">
										<option value="0" selected="selected">——</option> 
								</c:if> 
                            </select>
			        </jdf:column>
			        
			        <jdf:column property="logisticsNo" title="物流编号" style="width:8%" viewsAllowed="html">
						 <input type="text"  name="logisticsNo" value="${currentRowObject.logisticsNo}"  maxlength="200"> 
					</jdf:column>
			        
			        
			       <jdf:column property="reportFileName" title="报告文件名" headerStyle="width:8%;">
			       		${currentRowObject.reportFileName}
			        </jdf:column> 
			       <jdf:column property="userName" title="更新人" headerStyle="width:7%;">
			        </jdf:column>
			        
			        <jdf:column property="orderEditTime" title="更新时间" style="width:7%">
						<fmt:formatDate value="${currentRowObject.orderEditTime}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
					</jdf:column>
				</jdf:row>
		</jdf:table>
  </div>
  <script type="text/javascript">
	function savePrice(){
		$("#physicalReport").attr("action","${dynamicDomain}/physicalReport/updateToPage") ;
		$("#objectIdArray").val(getCheckedValuesString(document.getElementsByName("schk")));
		$("#logisticsCompanyArray").val(getUpdateColumnString(document.getElementsByName("logisticsCompany")));
		$("#logisticsTonoArray").val(getUpdateColumnString(document.getElementsByName("logisticsNo")));
		if($("#objectIdArray").val()!=""){
			var readySave =  true;
			
			var idArry = $("#objectIdArray").val().split(',');
			for (var i = 0; i < idArry.length; i++) {
				if(isOnlyElecReport(idArry[i])){
					winAlert("保存的记录中包含电子报告的记录");
					readySave = false;
					break;
				}
			}
			if(readySave){
				var logisticsCompany  =$("#logisticsCompanyArray").val();
				var attr = new Array();
				attr = logisticsCompany.split(',');
				for(var i=0;i<attr.length;i++){
					 if(attr[i]==0){
						winAlert("请填写物流");
						readySave =  false;
					} 
				}
			}
			if(readySave){
				var logisticsNums  =$("#logisticsTonoArray").val();
				attr = logisticsNums.split(',');
				for(var i=0;i<attr.length;i++){
					 if(attr[i]== '' || attr[i]== null  || typeof(attr[i]) == 'undefined' ){
						winAlert("请填写物流");
						readySave =  false;
					} 
				}
			}
			//保存物流信息
			if(readySave){
		 	 	$("#physicalReport").submit();  
			}
		}else{
			winAlert("请选择要保存的记录");
		} 
	}
	
	/**判断是否只有电子报告**/
	function isOnlyElecReport(id){
		var onlyElecReport = true;

		var pageReport  = $('#j_pageReport_'+id).val();
		
		if(pageReport == 1 || pageReport == 2){
			onlyElecReport = false;
		}
		
		return onlyElecReport;
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
					str = appendSplit(str, $(columnItem[i]).val(), split);
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
		
		function uploadReport(){
			var strSchk = getCheckedValuesString(document.getElementsByName("schk")); 
			if(strSchk != null && strSchk != '' && typeof(strSchk) != 'undefined' ){
				var strSchkinfo=strSchk.split(",");
				if(strSchkinfo.length <= 0){
					winAlert("温馨提示:请选择要上传体检报告的记录");
				}else if(strSchkinfo.length > 1){
					winAlert("温馨提示:一次只能上传一个体检报告");
				}else{
						var cardNum = $("#cashCard_"+strSchkinfo[0]).val();
						var status = $("#subOrderState_"+strSchkinfo[0]).val();
						var subOrderId = strSchkinfo[0];
						if(status == 13 || status == 14  || status == 15|| status == 16){
						    $("#uploadReportBtn").colorbox({
				                opacity : 0.2,
				                fixed : true,
				                href : "${dynamicDomain}/physicalReport/importPhysicalReport?ajax=1&cardNum="+cardNum+"&subOrderId="+subOrderId,
				                width : "920px",
				                height : "60%",
				                iframe : true,
								onClosed : function() {
									location.reload(false);
								},
								overlayClose : false
				            });
						}else{
							winAlert("温馨提示:请选择订单状态为已预约、已到检、报告已出或者报告已寄出的记录");
						}
						
				}
			}else{
				winAlert("温馨提示:请选择要上传体检报告的记录");
			}
		}
	</script>
</body>
</html>