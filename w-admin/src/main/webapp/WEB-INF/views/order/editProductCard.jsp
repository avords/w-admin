<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡号发放信息</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
                        卡号发放信息
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/cardInfo/orderCard?createInfoId=${createInfoId}&productId=${productId}&subOrderId=${subOrderId}&ajax=1" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row" style="margin-left: 20px;">
            <table class="tableAttr">
              <thead>
                <tr>
                  <th>总分数：</th>
                  <td>${productCount}</td>
                  <td width="10%">&nbsp;&nbsp;</td>
                  <td width="10%">&nbsp;&nbsp;</td>
                  <th>已发放：</th>
                  <td>${sendedCount}</td>
                  <td width="10%">&nbsp;&nbsp;</td>
                  <td width="10%">&nbsp;&nbsp;</td>
                  <th>剩余份数：</th>
                  <td>${productCount-sendedCount}</td>
                </tr>
              </thead>
            </table>
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
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="${dynamicDomain}/cardInfo/orderCard?ajax=1">
      <jdf:export view="csv" fileName="user.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="user.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>   
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:5%;text-align:center" />
        <jdf:column property="cardStatus" title="状态" headerStyle="width:8%;">
           <jdf:columnValue dictionaryId="1604" value="${currentRowObject.cardStatus}" />
        </jdf:column>
        <jdf:column property="cardNo" title="卡号" headerStyle="width:20%;">
        </jdf:column>
       <jdf:column property="staffName" title="线上发放的员工" headerStyle="width:20%;">
       
        </jdf:column>
      </jdf:row>
    </jdf:table>
    
    <div><p style="color:red">线下发放，卡密下载日志记录：</p></div>
    <div></div>
    
    
  </div>
  <script type="text/javascript">
			
		</script>
</body>
</html>