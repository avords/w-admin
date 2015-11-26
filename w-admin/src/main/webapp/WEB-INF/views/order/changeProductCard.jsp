<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡号信息</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
                          卡号信息
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/cardInfo/card/${createInfoId}?ajax=1" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row" style="margin-left: 20px;">
            <br>
            <table class="tableAttr">
              <thead>
                <tr>
                  <th>卡号信息</th>
                </tr>
              </thead>
            </table>
            <hr>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="loginName" class="col-sm-4 control-label">卡号状态：</label>
                <div class="col-sm-8">
                  <select name="search_EQI_cardStatus" class="search-form-control">
                    <option value="">—请选择—</option>
                    <jdf:select dictionaryId="1604" valid="true" />
                  </select>
                </div>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="loginName" class="col-sm-4 control-label">卡号：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_cardNo">
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label for="loginName" class="col-sm-4 control-label">员工姓名：</label>
                <div class="col-sm-8">
                  <input type="text" class="search-form-control" name="search_EQS_staffName">
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="box-footer">
          <a class="pull-left">
            <button type="button" id="returnGoods" class="btn btn-primary">退货
            </button>
          </a>
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
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" 
    filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/cardInfo/card/${createInfoId}?ajax=1">
      <jdf:export view="csv" fileName="user.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
       <jdf:column property="objectId" title="<input type='checkbox'  class='noBorder' name='pchk' onclick='pchkClick()'/>"
					style="width: 4%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
     <c:choose>
        <c:when test="${(currentRowObject.cardStatus==0||currentRowObject.cardStatus==1)&& (currentRowObject.isChangeOrderCard==0||currentRowObject.isChangeOrderCard==null) }">
         <input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
	   </c:when>      
      <c:otherwise>
      &nbsp;
     </c:otherwise>     
     </c:choose>    
    </jdf:column>
    
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:5%;text-align:center" />
        <jdf:column property="cardStatus" title="状态" headerStyle="width:8%;">
          <jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardStatus}" />
        </jdf:column>
        <jdf:column property="cardNo" title="卡号" headerStyle="width:20%;">
        </jdf:column>
        <jdf:column property="staffName" title="发放员工姓名" headerStyle="width:20%;">
        </jdf:column>
      </jdf:row>
    </jdf:table>
  </div>
  
  <script type="text/javascript">
  $("#returnGoods").click(function(){
	    if(confirm("确定要将选中的卡号进行退货处理吗？退货后卡号将作废，不可使用！")){
	  var cards = getCheckedValuesString($("input[name='schk']")).split(",");
		var cardsDiv = $(window.parent.document).find("div[id='orders']");
		cardsDiv.html(
				cards.length+
    		'<input type="hidden" class="search-form-control" name="ids" value="'+cards+'"/>'+
    		'<input type="hidden" name="changeOrderSkus[${index}].changeNum" value="'+cards.length+'"/>'				
   );
	parent.$.colorbox.close();	
}
  });
  </script>
</body>
</html>