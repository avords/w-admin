<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>剩余额度处理策略</title>


<style>
</style>

</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">剩余额度处理策略</h4>
		</div>
		<jdf:form bean="entity" scope="request">
          	<form method="post" action="${dynamicDomain}/welfarePlanOrder/savePolicy?ajax=1"
				class="form-horizontal" id="welfarePlan" name="welfarePlan" >
			<input type="hidden" name="planId" value="${welfarePlan.objectId}"> 
			<div class="box-body">
				<div class="row">
					<div class="col-sm-12 col-md-12">
						<div class="form-group">
							<div class="col-sm-12">
								<input type="radio" name="overplusStrategy" value="1" <c:if test='${welfarePlan.overplusStrategy==1}'>checked="checked"</c:if> >
								剩余额度转换成员工积分(当员工选择截止日期到期后，您可以查看到所有员工的剩余额度情况，当您为其付款后，i福利平台会自动将员工的剩余额度转换成该员工可自由使用的积分。)<font color="red">该策略提供给员工最大的选择权利</font></br>
								<input type="radio" name="overplusStrategy" value="2" <c:if test='${welfarePlan.overplusStrategy==2}'>checked="checked"</c:if> >
								本计划剩余额度累计(当员工选择截止日期到期后，本计划内的剩余额度将纳入下一个计划的额度供员工使用。)<font color="red">该策略可以给忠诚度高的员工更好的选择</font></br>
								<input type="radio" name="overplusStrategy" value="3" <c:if test='${welfarePlan.overplusStrategy==3}'>checked="checked"</c:if> >
								本计划剩余额度作废(当员工选择截止日期到期后，属于本计划的剩余额度将作废。)<font color="red">该策略促使员工积极参与福利计划</font>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="box-footer">
				<div class="row">
					<div class="editPageButton">
						<button type="button" class="btn btn-primary" id="btn">
							<jdf:message code="common.button.save" />
						</button>
						<a href="${dynamicDomain}/welfarePlanOrder/help?ajax=1" class="btn btn-primary" target="_blank" id="help"> 
							帮助
			            </a>
					</div>
				</div>
			</div>
		</div>
	</form>
	</jdf:form>
	</div>
	<script type="text/javascript">
		$(function() {
			$("#btn").bind("click",function(){
				$("#welfarePlan").submit();
				 window.parent.$.colorbox.close();
			});
		});
	</script>
</body>
</html>