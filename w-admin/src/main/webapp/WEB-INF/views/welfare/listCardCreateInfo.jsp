<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡密预生成管理</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				卡密预生成管理
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/cardCreateInfo/cardCreateInfopage" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐编号：</label>
								<div class="col-sm-8">
								<input type="text" class="search-form-control" name="search_LIKES_packageNo">
								</div>	
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">套餐名称：</label>
								<div class="col-sm-8">
								<input type="text" class="search-form-control" name="search_LIKES_packageName">
								</div>	
							</div>
						</div>
						
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">生成日期：</label>
								<div class="col-sm-4">
									<input name="search_GED_createTime" id="search_GED_createTime" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_createTime\')}'})" class="search-form-control">
								</div>	
								<div class="col-sm-4">
									<input name="search_LED_createTime" id="search_LED_createTime" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_createTime\')}'})" class="search-form-control">
								</div>
							</div>
						</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">是否过期：</label>
								<div class="col-sm-8">
									<input type="radio"   name="isExpire"  id ="isExpire1"  value=1>已过期
									<input type="radio"   name="isExpire"  id ="isExpire0"  value=0>未过期
								</div>	
							</div>
						</div>
					 </div>
					</div>
				</div>	
				<div class="box-footer">
					<a href="${dynamicDomain}/cardCreateInfo/createCard"  class="pull-left btn btn-primary">
						<span class="glyphicon glyphicon-plus"></span>
					</a> 
					<div class="pull-right">
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="${dynamicDomain}/cardCreateInfo/cardCreateInfopage">
			<jdf:export view="csv" fileName="cardCreateInfo.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="cardCreateInfo.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 10%;text-align:center">
					<a
						href="${dynamicDomain}/cardInfo/page/${currentRowObject.objectId}"
						class="btn btn-primary "> <i class="icon-pencil icon-white"></i>查看详情
					</a>
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="packageNo" title="套餐编号" style="width:15%" />
				<jdf:column property="packageName" title="套餐名称" style="width:15%" />
				<jdf:column property="cardAmount" title="生成份数" style="width:8%" />
				<jdf:column property="used_num" title="已使用" style="width:5%" />
				<jdf:column property="notUsed_num" title="未使用" style="width:5%" />
				<jdf:column property="1"   title="有效期"   style="width:17%" >
					<fmt:formatDate value="${currentRowObject.startDate}" pattern=" yyyy-MM-dd "/>
						至
					<fmt:formatDate value="${currentRowObject.endDate}" pattern=" yyyy-MM-dd "/>
				</jdf:column>
				<jdf:column property="createUser"  title="更新人" style="width:10%"  />
				<jdf:column property="createTime" title="更新时间"  cell="date"  style="width:10%" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		$(document).ready(function(){
			if("${expireStatus}"=='1'){
				$("#isExpire1").attr("checked","checked");
			}else if("${expireStatus}"=='0'){
				$("#isExpire0").attr("checked","checked");
			}
		})
</script>
</body>
</html>