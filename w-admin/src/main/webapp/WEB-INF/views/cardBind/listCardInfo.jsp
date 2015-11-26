<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<title>卡密信息</title>
</head>
<body>
<div>
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
								<label class="col-sm-3 control-label">绑定套餐：</label>
								<label class="col-sm-9 control-label">${wpackage.packageName }</label>
							</div>
						</div>
				</div>
				<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">生成份数：</label>
								<label class="col-sm-9 control-label">${not empty wpackage.totalCardNum?wpackage.totalCardNum:0}份</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">已绑定：</label>
								<label class="col-sm-9 control-label">${not empty wpackage.cardBindNum?wpackage.cardBindNum:0}份</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">未绑定：</label>
								<label class="col-sm-9 control-label">${not empty wpackage.cardNotBindNum?wpackage.cardNotBindNum:0}份</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-7 col-md-7">
							<div class="form-group">
								<label class="col-sm-3 control-label">有效期：</label>
								<label class="col-sm-9 control-label">
									<fmt:formatDate value="${wpackage.startDate}" pattern=" yyyy-MM-dd  HH:mm:ss"/>
										至
									<fmt:formatDate value="${wpackage.endDate}"  pattern=" yyyy-MM-dd HH:mm:ss"/>
								</label>
							</div>
						</div>
					</div>
						<div class="row">
							<div class="col-sm-7 col-md-7">
								<label class="col-sm-3  control-label">操作日志：</label>
								<div class="form-group">
									<c:forEach items="${data }" var="cardOperateLog" varStatus="num">
										<label class="col-sm-3 control-label"></label><label class="col-sm-9 control-label"">${cardOperateLog.operateUserName } &nbsp;&nbsp;&nbsp; <fmt:formatDate value="${cardOperateLog.operateTime}" pattern=" yyyy-MM-dd  HH:mm:ss"/>&nbsp;&nbsp;&nbsp;${cardOperateLog.operateRemark}</label>	
									</c:forEach>
								</div>
							</div>
					   </div>
				      <c:if test="${not empty data  &&  fn:length(data)>0}">
					   <div class="row">
						   <div class="col-sm-7 col-md-7">
						        <label class="col-sm-3  control-label">&nbsp;&nbsp;&nbsp;&nbsp;</label>
								<div class="form-group">
									<button onclick="lookAllLog(${packageID});" class="btn btn-primary">
										查看全部日志
									</button>
								</div>
							</div>
					    </div>
				       </c:if>
		</div>
		
		<div class="callout callout-info">
			<h4 class="modal-title">
					<div class="message-right">${message }</div>
						卡号绑定信息
			</h4>
		</div>
				<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/cardBind/handlePageCardInfo"  method="post"  id="cardInfo"
				class="form-horizontal">
				<input type="hidden" name="cardStatus" id="cardStatus">
				<input type="hidden" name="packageID" id="packageID" value="${packageID}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label class="col-sm-4 control-label">绑定状态：</label>
								<div class="col-sm-8">
									<select name="search_EQI_bindStatus" class="search-form-control"  id="bindStatus">
										<option value="1">—全部—</option>
										<option value="2">已绑定</option>
										<option value="3">未绑定</option>
									</select>
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
									<input type="text"  name="search_LIKES_mobile"  class="search-form-control"   id="mobile" >
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="pull-left">
						<button type="button" id="saveBtn" class="btn btn-primary" onclick="saveAllWithNo();">保存</button>
					</div>
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
			sortRowsCallback="limit" action=" ${dynamicDomain}/cardBind/handlePageCardInfo">
			
			 <jdf:row>
			  <input type="hidden" value="${currentRowObject.cardNo}" id="${currentRowObject.cardObjectId}card">
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder j-chk-all' />"
							style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
				<input type="checkbox" class="noBorder"  <c:if test="${!currentRowObject.effectiveCard}"> disabled="disabled" </c:if> name="schk" onclick="schkClick()" value="${currentRowObject.cardObjectId}" />
						
							
				</jdf:column>
				<jdf:column property="cardStatus" title="卡密状态" style="width:15%" >
				<jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardStatus}" />
				</jdf:column>
				<jdf:column property="cardNo" title="卡号" style="width:15%" />
				<jdf:column property="phone" title="手机号码" style="width:15%" >
							  <input type="hidden" value="${currentRowObject.cardNo}" id="cardNum_${currentRowObject.cardObjectId}">
							  <input type="hidden" value="${currentRowObject.effectiveCard}" id="cardStatus_${currentRowObject.cardObjectId}">
				<input type="text" id="mobile_${currentRowObject.cardObjectId}" <c:if test="${!currentRowObject.effectiveCard}"> disabled="disabled" </c:if> value="${currentRowObject.mobile}"  ></jdf:column>
				<jdf:column property="remark" title="备注"  style="width:15%" ><input type="text"  id="remark_${currentRowObject.cardObjectId}" <c:if test="${!currentRowObject.effectiveCard}"> disabled="disabled" </c:if> value="${currentRowObject.remark}"  ></jdf:column>
				<jdf:column property="updateTime" title="更新时间" style="width:10%">
				     <fmt:formatDate value="${currentRowObject.updateTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</jdf:column>
				<jdf:column property="updateUserName" title="更新人"  style="width:10%" />
			</jdf:row>
		</jdf:table> 
</div>
<form action="${dynamicDomain}/cardBind/savaCardBindPhone" method="post" id="saveForm">
	<input type="hidden" name="packageID" value="${packageID}">
	<input type="hidden" name="arrayCardStr" value="" id="saveStr">
</form>
<script>
function lookAllLog(packageID){
	window.location.href ="${dynamicDomain}/cardBind/loadAllLog?packageID="+packageID;
}

//保存绑定
function saveAllWithNo(){
	var strSchk = getCheckedValuesString(document.getElementsByName("schk")); 
	if(strSchk != null && strSchk != '' && typeof(strSchk) != 'undefined' ){
		var strSchkinfo=strSchk.split(",");//获取选中的id进行分割，根据id获取对应手机号码和备注信息
		var checkRes = true;
		var saveStr = "";
		for (var i = 0; i < strSchkinfo.length; i++) {
			var cid=strSchkinfo[i];
			var phone=$("#mobile_"+cid).val();
			var remark=$("#remark_"+cid).val();
			var cardNum=$("#cardNum_"+cid).val();
			checkRes = checkBindData(cardNum,phone,remark);
			if( !checkRes ){
				break;
			}
			saveStr +=makeSaveStr(cid,cardNum,phone,remark);
		}
		if(checkRes){
			$("#saveBtn").attr("disabled",true);
			$("#saveStr").val(saveStr);
			$("#saveForm").submit();
		}
	}else{
		winAlert("温馨提示:请选择要保存的记录");
	}
	
}

//验证数据
function checkBindData(cardNo,mobile,remark){
	if(mobile != null && mobile != '' && typeof(mobile) != 'undefined' ){
		if(!(/^1[3|4|5|7|8][0-9]\d{4,8}$/.test(mobile))){ 
			winAlert("温馨提示:"+cardNo+"绑定的手机号码格式不正确");
			return false;
		}
	}else{
		winAlert("温馨提示:"+cardNo+"绑定的手机号码不能为空");
		return false;
	}
	if(remark != null && remark != '' && typeof(remark) != 'undefined' ){
		if(remark.length > 150){
			winAlert("温馨提示:"+cardNo+"对应的备注信息过长");
			return false;
		}
	}
	return true;
}


//拼装数据
function makeSaveStr(cardId,cardNo,mobile,remark){
	var resStr = cardId+"#_#"+cardNo;
	if(mobile != null && mobile != '' && typeof(mobile) != 'undefined' ){
		resStr += "#_#mobile"+mobile;
	}
	if(remark != null && remark != '' && typeof(remark) != 'undefined' ){
		resStr += "#_#remark"+remark;
	}
	resStr+="_#_";
	return resStr;
}


  
  $('.j-chk-all').click(function(){
	var _this = $(this);
	var _chlid = $('input:checkbox[name="schk"]').filter(function(){
		return !$(this).is(':disabled');
	});

	var _bool = _this.is(':checked') ? true : false;
	_chlid.prop('checked', _bool);
  });
</script>
</body>
</html>