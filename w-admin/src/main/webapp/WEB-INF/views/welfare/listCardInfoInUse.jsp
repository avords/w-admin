<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>已使用卡密统计</title>
</head>
<body>
	<div>
	
	<!--  
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				卡密信息
			</h4>
		</div>
		<div class="box-body">
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">选择商品：</label>
								<label class="col-sm-9 control-label">${cardCreateInfo.packageName }</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">生成份数：</label>
								<label class="col-sm-9 control-label">${cardCreateInfo.cardAmount }</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">有效期：</label>
								<label class="col-sm-9 control-label">
									<fmt:formatDate value="${cardCreateInfo.startDate}" pattern=" yyyy-MM-dd "/>
										至
									<fmt:formatDate value="${cardCreateInfo.endDate}"  pattern=" yyyy-MM-dd "/>
								</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">备注：</label>
								<label class="col-sm-9 control-label">${cardCreateInfo.remark }</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3  control-label">操作日志：</label>
								<c:forEach items="${logitems }" var="cardOperateLog" varStatus="num">
									<c:choose>
											<c:when test="${num.index eq 0 }">
												<label class="col-sm-9 control-label">${cardOperateLog.operateUser }
															<fmt:formatDate value="${cardOperateLog.operateTime }" pattern=" yyyy-MM-dd  HH:mm"/> 将
															${cardOperateLog.operateAmount } 份卡密置为 <jdf:dictionaryName  dictionaryId="1604"  value="${cardOperateLog.operateType }"/>    
												</label>
											</c:when>
											<c:when test="${num.index<5 }">
													<label class="col-sm-3 control-label"></label>
													<label class="col-sm-9 control-label">${cardOperateLog.operateUser }
															<fmt:formatDate value="${cardOperateLog.operateTime }" pattern=" yyyy-MM-dd  HH:mm"/> 将
															${cardOperateLog.operateAmount } 份卡密置为 <jdf:dictionaryName  dictionaryId="1604"  value="${cardOperateLog.operateType }"/>    
													</label>
											</c:when>
											<c:otherwise>
											</c:otherwise>
									</c:choose>	
								</c:forEach>
							</div>
						</div>
						<div class="col-sm-2 col-md-2">
								<div class="pull-left">
									<button onclick="lookAllLog(${createInfoId});" class="btn btn-primary">
										查看全部日志
									</button>
								</div>
						</div>
					</div>
		</div>
		
		-->
						<div class="callout callout-info">
							<h4 class="modal-title">
								<div class="message-right">${message }</div>
									已使用卡密统计
							</h4>
						</div>
		<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/cardInfo/countCardInUse/${createInfoId}"  method="post"  id="cardInfo"
				class="form-horizontal">
				<input type="hidden" name="cardStatus" id="cardStatus">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="createInfoId" id="createInfoId"  value="${createInfoId}" >
				<input type="hidden" name="tempStatus" id="tempStatus"  value="${cardStatus}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
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
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">卡号：</label>
								<div class="col-sm-4">
									<input type="text"  name="search_LIKES_cardNo"  class="search-form-control"   id="cardNo" >
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="form-group">
							<label class="col-sm-2 control-label" style="color: red;">
							已使用卡密数量${cardInUseNum}
							</label>
						</div>
					</div>
				</div>
				<div class="box-footer">
				<c:choose>
						<c:when test="${cardStatus eq 0 }">
								<div class="pull-left">
									<button type="button" onclick="exportAll();" class="btn btn-primary">
										导出
									</button>
							
									<button   type="button" onclick="changeCardStatus('1');" class="btn btn-primary">
										激活
									</button>
								
									<button   type="button" onclick="changeCardStatus('6');"  class="btn btn-primary">
										删除
									</button>
							
									<button  type="button" onclick="changeCardStatus('5');" class="btn btn-primary">
										作废
									</button>
								</div>
						</c:when>
						<c:when test="${cardStatus eq 1 }">
							<div class="pull-left">
										<button  type="button" onclick="changeCardStatus('2');" class="btn btn-primary">
											冻结
										</button>
							</div>
						</c:when>
						<c:when test="${cardStatus eq 2 }">
								<div class="pull-left">
									<button  type="button" onclick="changeCardStatus('1');" class="btn btn-primary">
										解冻
									</button>
									<button  type="button" onclick="changeCardStatus('5');" class="btn btn-primary">
										作废
									</button>
								</div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
				</c:choose>
					<div class="pull-right">
									<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>	
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject"
			retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action=" ${dynamicDomain}/cardInfo/countCardInUse/${createInfoId}">
			<c:if test="${cardStatus eq 0}">
				<jdf:export view="csv" fileName="cardInfo.csv" tooltip="Export CSV"  imageName="csv" />
				<jdf:export view="xls" fileName="cardInfo.xls" tooltip="Export EXCEL" imageName="xls"  />
			</c:if>
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:5%;text-align:center"/>
				<jdf:column property="cardStatus" title="状态" style="width:15%" >
					<jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardStatus}" />
				</jdf:column>
				<jdf:column property="cardNo" title="卡号" style="width:15%" />
				<jdf:column property="passWord" title="密码"  viewsDenied="html"/>
				<jdf:column property="updateTime"  cell="date" title="更新时间" style="width:10%" />
				<jdf:column property="updateUser" title="更新人"  style="width:10%" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
		function exportAll(){
			document.forms.ec.ec_eti.value='ec';
			document.forms.ec.ec_ev.value='xls';
			document.forms.ec.ec_efn.value='cardInfo.xls';
			document.forms.ec.ec_i.value='-999';
			document.forms.ec.ec_p.value='1';
			document.forms.ec.target.value='_blank';
			var createInfoId = '${createInfoId}';
			if(!createInfoId){
				alert('请选择');
				return false;
			}
			ecFormSubmit('ec',' ${dynamicDomain}/cardInfo/page/'+createInfoId,'post');
		}
		
			function changeCardStatus(status){
				$("#cardInfo").attr("action","${dynamicDomain}/cardInfo/updateToPage") ;
				$("#cardStatus").val(status);
				var strSchk = getCheckedValuesString(document.getElementsByName("schk"));
				if(!strSchk){
					alert('请选择');
					return false;
				}
				
				/*var schk = document.getElementsByName("schk");
				if (strSchk == "" || strSchk == null) {
					for (var i=0; i < schk.length; i++) {
						strSchk = appendSplit(strSchk, schk[i].value, ",");
					}
				}*/
				$("#objectIdArray").val(strSchk);
				//alert ($("#cardInfo").attr("action"));
				$("#cardInfo").submit();
			}
			
			function lookAllLog(createInfoId){
				window.location.href ="${dynamicDomain}/cardOperateLog/cardOperateAllLogPage/"+createInfoId;
			}
	</script>
</body>
</html>