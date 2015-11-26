<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>计划详情</title>
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">计划详情</h4>
    </div>
    <div class="box-body">
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">总金额：</label> 
                <span class="">
                <fmt:formatNumber type="number" value="${allPayment}" pattern="0.00" maxFractionDigits="2"/>元
                </span>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">下单时间：</label> 
                <span class=""> <fmt:formatDate value="${orderList[0].bookingDate}" pattern="yyyy-MM-dd HH:mm:ss" /></span>
              </div>
            </div>
          </div>

          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">创建名：</label> 
                <span class=""> 
                	${loginName}
                </span>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">付款方式：</label> 
                <span class=""> 
                	<c:forEach items="${payWayList}" var="item">
						<c:if test="${item==1}">
							线下支付
						</c:if>
						<c:if test="${item==2}">
							线上支付
						</c:if>
						<c:if test="${item==3}">
							积分支付
						</c:if>
                	</c:forEach>
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">基础信息</label> 
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">年份：</label> 
                <span class=""> 
                	${welfarePlan.year}
                </span>
              </div>
            </div>
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">计划名称：</label> 
                <span class=""> 
                	${welfarePlan.name}
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">员工选择期限：</label> 
                <span class=""> 
                	<fmt:formatDate value="${welfarePlan.beginSelectDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                	~
                	<fmt:formatDate value="${welfarePlan.endSelectDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-2 control-label">计划说明：</label> 
                <span class=""> 
                	${welfarePlan.planDescription}
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
                <label class="col-sm-3 control-label">剩余额度处理策略：</label> 
                <span class="col-sm-3 control-label"> 
                	<c:if test="${welfarePlan.overplusStrategy==1}">
                		剩余额度转换成员工积分
                	</c:if>
                	<c:if test="${welfarePlan.overplusStrategy==2}">
                		本计划剩余额度累计
                	</c:if>
                	<c:if test="${welfarePlan.overplusStrategy==3}">
                		本计划剩余额度作废
                	</c:if>
                </span>
                <c:if test="${welfarePlan.status==0 || welfarePlan.status==5}">
	               	<a href="#" class="btn btn-primary" id="editPolicy"> 
						修改余额策略
		            </a>
                </c:if>
                <c:if test="${welfarePlan.status>=15}">
		            <button type="button" class="btn btn-primary" id="expUserSelected">
						导出员工选择
					</button>
                </c:if>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-6 col-md-6">
              <div class="form-group">
                <label class="col-sm-4 control-label">额度分配</label> 
                <span class=""> 
                </span>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">发放总人数：</label> 
                <span class=""> 
                	${welfarePlan.headCount}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">发放额度：</label> 
                <span class=""> 
                	${welfarePlan.totalAmount}
                </span>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-6 control-label">最低发放额度：</label> 
                <span class=""> 
                	${welfarePlan.minGrantQuota}
                </span>
              </div>
            </div>
          </div>
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
                <c:forEach items="${welfareSubPlanList}" var="welfareSubPlan">
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
                </c:forEach>
              </table>
          </div>
          <div class="row">
            <div class="editPageButton">
              <a href="${dynamicDomain}/welfarePlanOrder/page" class="btn btn-primary">返回 </a>
            </div>
          </div>
  </div>
  <form action="${dynamicDomain}/welfarePlanOrder/exportUserSelect/${welfarePlan.objectId}" method="post" class="form-horizontal" id="form1">
  </form>
<script type="text/javascript">
$(function(){
	$("#editPolicy").click(function(){
		var url = "${dynamicDomain}/welfarePlanOrder/editPolicy/${welfarePlan.objectId }?ajax=1";
		//toUrl(url);
		$.colorbox({
			href:url,
			opacity:0.2,
			fixed:true,
			width:"40%",
			height:"65%", 
			iframe:true,
			onClosed:function(){ 
				if(true){
					parent.location.reload(true);
				}
			},
			close:"",
			overlayClose:false
		});
	});
	
	$("#expUserSelected").bind("click",function(){
		$("#form1").submit();
		
	});
});
</script>
</body>
</html>