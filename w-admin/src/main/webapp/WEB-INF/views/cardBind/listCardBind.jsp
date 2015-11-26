<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<title><jdf:message code="卡密绑定管理" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message}</div>
       卡密绑定管理
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/cardBind/listCardBind" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
	          <div class="col-sm-4 col-md-4">
	              <div class="form-group">
	                <label class="col-sm-4 control-label">套餐编号：</label>
	                <div class="col-sm-8">
	                  	<input type="text" class="search-form-control" name="search_LIKES_packageNo" id="packageNo">
	                </div>
	              </div>
	            </div>
	            
	            <div class="col-sm-4 col-md-4">
	              <div class="form-group">
	                <label class="col-sm-4 control-label">套餐名称：</label>
	                <div class="col-sm-8">
	                  	<input type="text" class="search-form-control" name="search_LIKES_packageName" id="packageName">
	                </div>
	              </div>
	            </div>
            
	            <div class="col-sm-4 col-md-4">
					<div class="form-group">
						<label class="col-sm-4 control-label">生成日期：</label>
						<div class="col-sm-4">
							<input name="search_GED_createDate" id="search_GED_createDate" type="text" onclick="WdatePicker({maxDate:'#F{$dp.$D(\'search_LED_createDate\')}'})" class="search-form-control">
						</div>	
						<div class="col-sm-4">
							<input name="search_LED_createDate" id="search_LED_createDate" type="text" onclick="WdatePicker({minDate:'#F{$dp.$D(\'search_GED_createDate\')}'})" class="search-form-control">
						</div>
					</div>
				</div>
          </div>  
          
          
          <div class="row">
				<div class="col-sm-4 col-md-4">
					<div class="form-group">
						<label class="col-sm-4 control-label">是否有效：</label>
						<div class="col-sm-8">
							<input type="radio"   name="isExpire"  id ="isExpire0"  value=0>有效
							<input type="radio"   name="isExpire"  id ="isExpire1"  value=1>无效（已过期）
						</div>	
					</div>
				</div>
		  </div>
                
 
          <div class="box-footer">
              <a href="javascript:void(0);" class="btn btn-primary pull-left" onclick="exportCard();">
                   	卡密绑定导出
              </a>
              <a href="${dynamicDomain}/cardBind/importCardBindDialog?ajax=1" class="colorbox btn btn-primary">
                                                              卡密绑定导入
              </a>
              

            <div class="pull-right">
              <button type="button" class="btn" onclick="clearForm(this)"><i class="icon-remove icon-white"></i>重置</button>
              <button type="submit" class="btn btn-primary">查询</button>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  
   
   <div>
		<jdf:table items="items" var="currentRowObject"  retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="${dynamicDomain}/cardBind/listCardBind">
			<jdf:export view="csv" fileName="cardBind.csv" tooltip="Export CSV"
				imageName="csv" />
			<jdf:export view="xls" fileName="cardBind.xls" tooltip="Export EXCEL"
				imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="选择" style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
				
				
				<c:if test="${currentRowObject.effective}">
					<input type="radio" class="option" name="checkId" value="${currentRowObject.objectId}" />
				</c:if>
				<c:if test="${!currentRowObject.effective}">
					<input type="radio" class="option" name="checkId" disabled="disabled" value="${currentRowObject.objectId}" />
				</c:if>
				</jdf:column>
				
				<jdf:column alias="common.lable.operate" title="common.lable.operate" sortable="false" viewsAllowed="html" style="width: 10%;text-align:center">
					<a
						href="${dynamicDomain}/cardBind/handlePageCardInfo?packageID=${currentRowObject.objectId}"
						class="btn btn-primary "> <i class="icon-pencil icon-white"></i>查看详情
					</a>
				</jdf:column>
				
 				<jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center"/>
				<jdf:column property="packageNo" title="套餐编号" style="width:10%" />
				<jdf:column property="packageName" title="套餐名称" style="width:20%" />
				<jdf:column property="totalCardNum" title="生成份数" style="width:8%" />
				<jdf:column property="cardBindNum" title="已绑定" style="width:5%" />
				<jdf:column property="cardNotBindNum" title="未绑定" style="width:5%" />
				<jdf:column property="1"   title="有效期"   style="width:17%" >
					<fmt:formatDate value="${currentRowObject.startDate}" pattern=" yyyy-MM-dd "/>
						至
					<fmt:formatDate value="${currentRowObject.endDate}" pattern=" yyyy-MM-dd "/>
				</jdf:column>
				<jdf:column property="bindInfoUpdateUser"  title="更新人" style="width:10%"  />
				<jdf:column property="bindInfoUpdateDate" title="更新时间"  cell="date"  style="width:10%" />
			</jdf:row>
		</jdf:table>
	</div>
 

  <script type="text/javascript">
  	//卡密绑定导出
	function exportCard(){
		var radioId = $("input[name='checkId']:checked").val() ;
		if(radioId==null || radioId==""){
			winAlert("请先选择套餐") ;
			return false ;
		} 
		
	    var url = "${dynamicDomain}/cardBind/exportCard?packageId="+radioId ;
	    document.location.href = url;
	}

	
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