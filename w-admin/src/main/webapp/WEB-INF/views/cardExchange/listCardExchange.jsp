<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡号兑换预约列表</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right"></div>
				卡号兑换预约列表
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/CardExchange/page" method="post"
				class="form-horizontal">
				<div class="box-body">
				   <div class="row">
                        <div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_cardNo" class="col-sm-4 form-lable">卡号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_cardNo">
								</div>
							</div>
						</div>
						 <div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_orderNo" class="col-sm-4 form-lable">订单号：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_orderNo">
								</div>
							</div>
						</div>
				   </div>
					<div class="row">
						 <div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_phoneNo" class="col-sm-4 form-lable">手机号码：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_phoneNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_idCardNo" class="col-sm-4 form-lable">员工身份证：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_idCardNo">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_staffName" class="col-sm-4 form-lable">员工姓名：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_staffName">
								</div>
							</div>
						</div>
						</div>
						<div class="row">
							<div class="col-sm-4 col-md-4">
								
							</div>
						</div>

						<div class="box-footer">
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
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="page">
			<jdf:export view="csv" fileName="advert.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="advert.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>
				
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 12%">
					<c:if test="${currentRowObject.welfareType  eq 1 and currentRowObject.cardStatus eq 1}">
					<a href="${dynamicDomain}/CardExchange/appointment1/${currentRowObject.cardNo}" class="btn btn-primary progressBtn"> 
					 	预约
					</a>
					</c:if>
					
					<c:if test="${currentRowObject.welfareType  eq 1 and currentRowObject.cardStatus eq 4}">
					<a href='${dynamicDomain}/CardExchange/viewPhysicalDetail/${currentRowObject.cardNo}' class="btn btn-primary progressBtn"> 
					 	查看详情
					</a>
					</c:if>
					
					<c:if test="${currentRowObject.welfareType  eq 0 and currentRowObject.cardStatus eq 1}">
					<a href="${dynamicDomain}/CardExchange/CardExchange/${currentRowObject.cardNo}" class="btn btn-primary progressBtn"> 
					 	兑换
					</a>
					</c:if>
					
					<c:if test="${currentRowObject.welfareType  eq 0 and currentRowObject.cardStatus eq 4}">
					<a href='${dynamicDomain}/CardExchange/viewWelfareDetail/${currentRowObject.generalOrderNo}' class="btn btn-primary progressBtn"> 
					 	查看详情
					</a>
					</c:if>
					
					<%-- <c:if test="${currentRowObject.welfareType  eq 1 and currentRowObject.cardStatus eq 4}">
					<a href="javascript:toUrl('${dynamicDomain}/CardExchange/cancelAppointment/${currentRowObject.cardNo}','你确定要取消预约吗?');" class="btn btn-primary "> 
					 	取消预约
					</a> 
					</c:if> --%>
					<c:if test="${currentRowObject.welfareType  eq 1 and currentRowObject.cardStatus eq 4}">
					<a href='${dynamicDomain}/CardExchange/changeDate/${currentRowObject.cardNo}' class="btn btn-primary progressBtn"> 
					 	改期
					</a>
					</c:if>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount"
					title="序号" style="width:4%;text-align:center" />
				<jdf:column property="itemName" title="卡号类型" headerStyle="width:10%;"></jdf:column>
				<jdf:column property="cardNo" title="卡号" headerStyle="width:10%;"> </jdf:column>
				<jdf:column property="remark" title="卡号说明" headerStyle="width:10%;"> </jdf:column>
				<jdf:column property="generalOrderNo" title="订单号" headerStyle="width:10%;"> </jdf:column>
				<jdf:column property="subOrderState" title="子订单状态" headerStyle="width:7%;">
		          <jdf:columnValue dictionaryId="1400" value="${currentRowObject.subOrderState}" />
		        </jdf:column>
				<jdf:column property="cardStatus" title="卡号状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1604"
						value="${currentRowObject.cardStatus}" />
				</jdf:column>
				<jdf:column property="endDate" title="卡号有效期" style="width:10%">
					<fmt:formatDate value="${currentRowObject.endDate}"
						pattern=" yyyy-MM-dd" />
				</jdf:column>
				<jdf:column property="updateUser" title="预约操作人" headerStyle="width:10%;"> </jdf:column>
				<jdf:column property="bookingDate" title="下单时间" style="width:15%">
					<fmt:formatDate value="${currentRowObject.bookingDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	
	</script>
	
</body>
</html>