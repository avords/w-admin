<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>广告审核</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<%-- <div class="message-right">${message }</div> --%>
				广告审核
			</h4>
		</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/advert/verify" method="post"
				class="form-horizontal">
				<div class="box-body">
					<div class="row">
				       <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">省：</label>
                                <div class="col-sm-8">
                                    <select name="search_LIKES_province" class="search-form-control" id="area1">
                                        <option value="">—全部—</option>
                                        <jdf:selectCollection items="firstArea" optionValue="objectId" optionText="name"/>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4 col-md-4">
                            <div class="form-group">
                                <label class="col-sm-4 form-lable">市：</label>
                                <div class="col-sm-8">
                                    <select name="search_LIKES_city" class="search-form-control" id="area2">
                                        <option value="">—全部—</option>
                                    </select>
                                </div>
                            </div>
                        </div>
				   </div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="search_LIKES_title" class="col-sm-4 form-lable">标题：</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"
										name="search_LIKES_title">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 form-lable">创建日期：</label>
								<div class="col-sm-4">
								<input class="search-form-control" type="text" 
										name="search_GED_createDate" id="search_GED_createDate"
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_createDate\')}'})">
								</div>
								<div class="col-sm-4">
								<input type="text" class="search-form-control"
										name="search_LED_createDate" id="search_LED_createDate" 
										onClick="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'search_GED_createDate\')}'})">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPlatform" class="col-sm-4 control-label">推荐平台:</label>
								<div class="col-sm-8">
									<select name="search_EQI_recommendPlatform" class="form-control"
										id="recommendPlatform">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1202" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPage" class="col-sm-4 control-label">推荐页面:</label>
								<div class="col-sm-8">
									<select name="search_EQI_recommendPage" class="form-control"
										id="recommendPage">
										<option value=""></option>
										<jdf:selectCollection items="secondCategory"
											optionValue="pageCode" optionText="pageName" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="recommendPosition" class="col-sm-4 control-label">推荐位置:</label>
								<div class="col-sm-8">
									<select name="search_LIKES_recommendPosition" class="form-control"
										id="recommendPosition">
										<option value=""></option>
										<jdf:selectCollection items="thirdCategory"
											optionValue="positionCode" optionText="positionName" />
									</select>
								</div>
							</div>
						</div>
					</div>
					<div class="row"></div>

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
			sortRowsCallback="limit" action="verify">
			<jdf:export view="csv" fileName="user.csv" tooltip="导出CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL"
				imageName="xls" />
			<jdf:row>

				<jdf:column alias="common.lable.operate"
					title="common.lable.operate" sortable="false" viewsAllowed="html"
					style="width: 8%">
					
					<a href="${dynamicDomain}/advert/todetail/${currentRowObject.objectId}" class="btn btn-primary progressBtn" > 
					 	审核
					</a>
					
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount"
					title="序号" style="width:4%;text-align:center" />
				<jdf:column property="areaNames" title="区域" headerStyle="width:9%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.areaNames}">
					<a
						href="#">
						<font
						style="font-size: 14px; ">${currentRowObject.areaNames}</font>
					</a>
					</div>
					<c:if test="${empty currentRowObject.areaNames}">
						<a
						href="#">
						<font
						style="font-size: 14px;">全国</font>
					</a>
					</c:if>
				</jdf:column>
				<jdf:column property="noticeNature" title="广告类型"
					headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1201"
						value="${currentRowObject.noticeNature}" />
				</jdf:column>
				<jdf:column property="recommendPosition" title="广告位置" headerStyle="width:7%;">
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.platformName}-${currentRowObject.pageName}-${currentRowObject.positionName}">
					<a
						href="${dynamicDomain}/advert/verifyDetail/${currentRowObject.objectId}">
						<font
						style="font-size: 14px;">${currentRowObject.platformName}-${currentRowObject.pageName}-${currentRowObject.positionName}</font>
					</a>
					</div>
				</jdf:column>
				<jdf:column property="title" title="标题" headerStyle="width:9%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.title}">
					<a
						href="${dynamicDomain}/advert/verifyDetail/${currentRowObject.objectId}">
						<font
						style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.title}</font>
					</a>
					</div>
				</jdf:column>
				
				
				<jdf:column property="startDate" title="广告有效期" style="width:15%">
					<fmt:formatDate value="${currentRowObject.startDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
						~
					<fmt:formatDate value="${currentRowObject.endDate}"
						pattern=" yyyy-MM-dd HH:mm:ss" />
				</jdf:column>
				<jdf:column property="status" title="状态" headerStyle="width:7%;">
					<jdf:columnValue dictionaryId="1203"
						value="${currentRowObject.status}" />
				</jdf:column>

				<%-- <jdf:column property="updateUserId" title="更新人"
					headerStyle="width:10%;">
					<jdf:selectCollection items="user" optionValue="updateUserId"
						optionText="userName" />
				</jdf:column>

				<jdf:column property="updateDate" cell="date" title="更新时间"
					style="width:10%" />
 --%>
				<jdf:column property="checkPersonName" title="审核人"
					headerStyle="width:10%;">
					
				</jdf:column>

				<%-- <jdf:column property="checkDate" cell="date" title="审核时间"  style="width:15%" /> --%>

			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	$(function(){
		$("#area1").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/advert/getCity/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#area2").children().remove();
                        $("#area2").append("<option value=''>—全部—</option>");
                        for ( var i = 0; i < json.citys.length; i++) {
                            $("#area2").append("<option value='" + json.citys[i].areaCode + "'>" + json.citys[i].name + "</option>");
                        }
                        if("${city}"!=""){
              				 $("#area2").val("${city}").change();
              			 }
                    }   
                });
            }
         }).change();
		$("#recommendPlatform")
		.bind(
				"change",
				function() {
					if ($(this).val()) {
						$
								.ajax({
									url : "${dynamicDomain}/advert/category/secondCategory/"
											+ $(this).val()+"?type=1",
									type : 'post',
									dataType : 'json',
									success : function(json) {
										$("#recommendPage")
												.children()
												.remove();
										$("#recommendPage")
												.append(
														"<option value=''></option>");
										for ( var i = 0; i < json.secondCategory.length; i++) {
											$("#recommendPage")
													.append(
															"<option value='" + json.secondCategory[i].pageCode + "'>"
																	+ json.secondCategory[i].pageName
																	+ "</option>");
										}

										$("#recommendPage")
												.val(
														"${entity.recommendPage}");

									}
								});
					}
				}).change();

$("#recommendPage")
		.bind(
				"change",
				function() {
					var page = $("#recommendPage").val();

					var page1 = "${entity.recommendPage}";
					if (page == "") {
						page = page1;
					}
					$
							.ajax({
								url : "${dynamicDomain}/advert/category/thirdCategory/"
										+ page+"?type=1",
								type : 'post',
								dataType : 'json',
								success : function(json) {
									$("#recommendPosition")
											.children().remove();
									$("#recommendPosition")
											.append(
													"<option value=''></option>");
									for ( var i = 0; i < json.thirdCategory.length; i++) {
										$("#recommendPosition")
												.append(
														"<option value='" + json.thirdCategory[i].positionCode + "'>"
																+ json.thirdCategory[i].positionName
																+ "</option>");
									}
									$("#recommendPosition")
											.val(
													"${entity.recommendPosition}");
								}
							});

				}).change();


	});
	</script>
	 <script type="text/javascript">
			$(function() {
				$(".con").each(function() {
					var maxwidth = 20;
					if ($(this).text().length > maxwidth) {
						$(this).text($(this).text().substring(0, maxwidth));
						$(this).html($(this).text() + '...');
					}
				});

			});
		</script>
</body>

</html>