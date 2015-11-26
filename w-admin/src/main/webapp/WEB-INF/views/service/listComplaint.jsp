<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="投诉订单查询" /></title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        <jdf:message code="投诉管理" />
      </h4>
    </div>
    <jdf:form bean="request" scope="request">
      <form action="${dynamicDomain}/complaint/page" method="post" class="form-horizontal">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label for="search_GED_recordDate" type="button" class="form-lable">创建时间：</label>
                </div>
                <input style="width: 96px; height: 33px;" type="text" name="search_GED_recordDate" id="search_GED_recordDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_GED_recordDate\')}'})">~ <input style="width: 96px; height: 33px;" type="text" name="search_LED_recordDate" id="search_LED_recordDate" size="14" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'search_LED_recordDate\')}'})">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">订单号：</label>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_subOrderNo">
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">投诉类型：</label>
                </div>
                <select name="search_EQI_complaintType" class="search-form-control">
                  <option value="">—全部—</option>
                  <jdf:select dictionaryId="1117" valid="true" />
                </select>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">投诉状态：</label>
                </div>
                <select name="search_EQS_dealStatus"  id="status" class="search-form-control">
					<option value="">—全部—</option>
					<jdf:select dictionaryId="1118" valid="true" />
				</select>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">投诉人：</label>
                </div>
                <input type="text" class="search-form-control" name="search_EQS_complaintPerson">
              </div>
            </div>
           </div>
            
            <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">投诉人电话：</label>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_complaintMobile">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">供应商编号：</label>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_supplierId">
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="input-group">
                <div class="input-group-btn">
                  <label type="button" class="form-lable">供应商名称：</label>
                </div>
                <input type="text" class="search-form-control" name="search_LIKES_supplierName">
              </div>
            </div>            
            </div>
          	
        </div>
        <div class="box-footer">
          <a href="${dynamicDomain}/complaint/create" class="btn btn-primary pull-left">新建投诉
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
    <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
      <jdf:export view="csv" fileName="投诉订单.csv" tooltip="导出CSV" imageName="csv" />
      <jdf:export view="xls" fileName="投诉订单.xls" tooltip="导出EXCEL" imageName="xls" />
      <jdf:row>
        <jdf:column property="objectId" sortable="false" title="操作" style="width:10%;text-align:center">
          <a class="btn btn-primary" href="${dynamicDomain}/complaint/complaintDetail/${currentRowObject.objectId}">跟进详情</a>
        </jdf:column>
        <jdf:column property="rowcount" sortable="false" cell="rowCount" title="序号" style="width:4%;text-align:center" />      
        <jdf:column property="generalOrderNo" title="总订单号" headerStyle="width:6%;">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;">${currentRowObject.generalOrderNo} </font></a>
        </jdf:column>
        <jdf:column property="subOrderNo" title="子订单号" headerStyle="width:15%;" styleClass="con">
          <a href="${dynamicDomain}/order/view/${currentRowObject.generalOrderId}"> <font style="font-size: 14px; color: blue; text-decoration: underline;" class="conn"> ${currentRowObject.subOrderNo}</font></a>
        </jdf:column>
        
        <jdf:column property="dealStatus" title="状态" headerStyle="width:10%;">
          <jdf:columnValue dictionaryId="1118" value="${currentRowObject.dealStatus}" />
        </jdf:column>
        <jdf:column property="complaintPerson" title="投诉人" headerStyle="width:10%;" />
        <jdf:column property="complaintMobile" title="投诉人电话" headerStyle="width:10%;" />
        <jdf:column property="supplierName" title="供应商名称" headerStyle="width:10%;" />
        <jdf:column property="supplierContact" title="供应商联系方式" headerStyle="width:10%;" />
        <jdf:column property="recordDate" title="创建时间" headerStyle="width:10%;">
          <fmt:formatDate value="${currentRowObject.recordDate}" pattern="yyyy-MM-dd HH:mm:ss" />
        </jdf:column>
        <jdf:column property="userName" title="创建人" headerStyle="width:10%;" />
      </jdf:row>
    </jdf:table>
  </div>
</body>
</html>