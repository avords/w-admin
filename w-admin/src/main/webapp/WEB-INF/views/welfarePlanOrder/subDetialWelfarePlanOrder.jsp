<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>子订单详情</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">订单详情</h4>
    </div>
    <div class="box-body">
          <div class="row" >
              <table class="table table-bordered" >
                <thead>
                  <tr>
                    <th width="30%">子计划名称(发放时间)</th>
                    <th width="20%">额度(元)</th>
                    <th width="15%">选择员工数量</th>
                    <th width="20%">金额(元)</th>
                    <th width="15%">订单状态</th>
                  </tr>
                </thead>
                  <tbody>
                    <tr >
                      <td colspan="5">
                       <b >
                       ${welfareSubPlan.welfareItemName } - ${welfareSubPlan.name }
                       	(<fmt:formatDate value="${welfareSubPlan.publishDate}" pattern="yyyy-MM-dd HH:mm:ss" />)
                       	</b>
                      </td>
                     </tr>
                      <c:set var="pCount" scope="request" value="0"/>
                     <c:forEach items="${welfareSubPlan.welfareSubPlanItems}" var="item" varStatus="status">
                     <c:set var="pCount" scope="request" value="${pCount+item.price*item.count}"/>
                     <tr >
                      <td > ${item.goodsName} </td>
                      <td> ${item.price} </td>	
                      <td> ${item.count} </td>
                      <td>${item.price*item.count} </td>
                      <td>
                      	<c:if test="${item.subOrderState!=null}">
                      	<jdf:dictionaryName dictionaryId="1400" value="${item.subOrderState}" />
                      	</c:if>
					  </td>
                    </tr>
                    </c:forEach>
                    <tr >
                      <td colspan="3"></td>
                      <td colspan="2">
                     	 小计:${pCount}
                      </td>
                     </tr>
                  </tbody>
              </table>
          </div>
          <div class="row">
            <div class="editPageButton">
              <a href="${dynamicDomain}/welfarePlanOrder/list" class="btn btn-primary">返回 </a>
            </div>
          </div>
  </div>
<script type="text/javascript">
$(function(){
});
</script>
</body>
</html>