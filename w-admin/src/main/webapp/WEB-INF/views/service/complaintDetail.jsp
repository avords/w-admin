<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>投诉详情</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <h4 class="modal-title">
        <div class="message-right">${message }</div>
        投诉详情
      </h4>
    </div>
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉编号：</label>
                <div class="col-sm-8">
                  <span>${complaint.objectId}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉类型：</label>
                <div class="col-sm-8">
                  <span><jdf:columnValue dictionaryId="1117" value="${complaint.complaintType}" /><br> </span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉来源：</label>
                <div class="col-sm-8">
                  <span> <jdf:columnValue dictionaryId="1107" value="${complaint.complaintSource}" /></span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label type="button" class="col-sm-4 control-label">所属订单：</label>
                <div class="col-sm-8">
                  <span>${complaint.subOrderNo}</span>
                </div>
              </div>
            </div>
          </div>
          <div class="panel panel-default" style="width: 100%; min-height: 100px;">
            <div class="panel-heading">订单信息</div>

            <table class="table table-bordered table-hover">
              <thead>
                <tr>
                  <th>订单号</th>
                  <th>商品ID</th>
                  <th>商品名称</th>
                  <th>商品数量</th>
                </tr>
              </thead>
              <tbody>
                <c:forEach items="${orderSkus}" var="orderSku">
                  <tr>
                    <td>${orderSku.subOrderId}</td>
                    <td>${orderSku.productId}</td>
                    <td>${orderSku.name}</td>
                    <td>${orderSku.productCount}</td>
                  </tr>
                </c:forEach>
              </tbody>
              <tfoot>
                <tr>
                  <th></th>
                  <th></th>
                  <th></th>
                  <th></th>
                </tr>
              </tfoot>
            </table>
          </div>
          <div class="panel panel-default" style="width: 100%; min-height: 100px;">
            <div class="panel-heading">
              <h3 class="panel-title" style="padding: 6px;">投诉信息</h3>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉原因：</label>
                <div class="col-sm-8">
                  <span>${complaint.complaintContent}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉人：</label>
                <div class="col-sm-8">
                  <span>${complaint.complaintPerson}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉人电话：</label>
                <div class="col-sm-8">
                  <span>${complaint.complaintMobile}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">投诉人邮箱：</label>
                <div class="col-sm-8">
                  <span>${complaint.complaintEmail}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">记录人：</label>
                <div class="col-sm-8">
                  <span>${complaint.userName}</span>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label"> 记录时间：</label>
                <div class="col-sm-8">
                  <span><fmt:formatDate value="${complaint.recordDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
                </div>
              </div>
            </div>

            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">处理结果：</label>
                <div class="col-sm-8">
                  <span><jdf:columnValue dictionaryId="1118" value="${complaint.dealStatus}" /></label>
                </div>
              </div>
            </div>
          </div>

          <div class="panel panel-default" style="width: 100%; min-height: 100px;">
            <div class="panel-heading">
              <h3 class="panel-title" style="padding: 6px;">处理结果</h3>
            </div>
            <c:forEach items="${ComplaintDetailUserVOes}" var="complaintDetail">
              <div class="col-sm-4 col-md-4">
                <div class="form-group">
                  <label class="col-sm-4 control-label">处理人：</label>
                  <div class="col-sm-8">
                    <span>${complaintDetail.userName }</label>
                  </div>
                </div>
              </div>

              <div class="col-sm-4 col-md-4">
                <div class="form-group">
                  <label class="col-sm-4 control-label">处理时间：</label>
                  <div class="col-sm-8">
                    <span><fmt:formatDate value="${complaintDetail.dealTime }" pattern="yyyy-MM-dd HH:mm:ss" /></label>
                  </div>
                </div>
              </div>
              <div class="col-sm-9 col-md-9">
                <div class="form-group">
                  <label class="col-sm-2 control-label">处理详情：</label>
                  <div class="col-sm-10">
                    <span>${complaintDetail.dealDetail}</span>
                  </div>
                </div>
              </div>
            </c:forEach>
          </div>

          <c:if test="${complaint.dealStatus != '3'}">
          <form action="${dynamicDomain}/complaint/followUp" method="post" class="form-horizontal" id="complaintdetailform">
         <input type="hidden" value="${complaintId}" name=complaintId id="complaintId" />
            <div class="panel panel-default" style="width: 100%; min-height: 100px;">
              <div class="panel-heading">
                <h3 class="panel-title" style="padding: 6px;">跟进详情</h3>
              </div>
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label class="col-sm-2 control-label">处理结果：</label>
                  <div class="col-sm-10">
                    <input type="checkbox" id="closed" name="closed" value="3" />已结案 
                    </div>
                </div>
              </div>
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label class="col-sm-2 control-label">跟进详情：</label>
                  <div class="col-sm-10">
                    <textarea rows="5" class="search-form-control {maxlength:250,required:true}" cols="20" style="width: 360px" name="dealDetail" id="dealDetail"></textarea>
                  </div>
                </div>
              </div>
                  <div class="editPageButton">
                    <button type="submit" class="btn btn-primary">提交</button>
                    <button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary">返回</button>
                  </div>
            </div>
             </form>
          </c:if>
  </div>
<script type="text/javascript">
$("#complaintdetailform").validate();
</script>
</body>
</html>