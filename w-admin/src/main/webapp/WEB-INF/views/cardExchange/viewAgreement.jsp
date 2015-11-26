<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检报告服务授权协议</title>
<style>

</style>
</head>
<body>
	<div>
		<div class="callout callout-info" style="height: 35px;">
			<div class="message-right">${message}</div>
			<h4 class="modal-title">体检报告服务授权协议:</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="#" class="form-horizontal reject" id="editForm" >
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<div class="col-sm-12">
									<textarea class="col-sm-4 control-label" style="font-size:15px;overflow-x:hidden;" rows="22" cols="80" name="remark"  id="remark" readonly="readonly">
							          本协议是您（本人_${userName}_, 证件号${certificateNo}）与本体检服务公司（上海瀚乾信息技术服务有限公司）之间
							   就体检报告服务相关事宜所订立的契约，请您仔细阅读本服务协议，您点击"同意"按钮后，本协议即构成对双方有约束力的法律文件。
							  本人 ${userName}, 身份证_${certificateNo}  兹委托_上海瀚乾信息技术服务有限公司司代其本人行使以下体检报告委托
							  事项。								
							  
							        委托服务事项包括如下：
								  1.本公司将在您完成体检服务后，为您所在体检服务机构代为提供体检报告书相关服务。
								  2.您可以通过本公司提供的体检服务平台进行电子体检报告书的在线查阅及下载服务。
								  3.本公司将为您提供纸质体检报告书的寄送服务。
								  4.本公司因纸质体检报告书配送过程中所产生的额外寄送费用，需由您个人自行承担。
								  
							       保密申明
								  1.本公司将对您个人信息及体检报告严格执行保密义务，在任何时候均不会查阅，转载，
								     下载任何关于您本人的相关信息。
								  2.除您体检报告所归属的体检机构外，本公司在任何时候均不会以任何形式将您的体检报
								     告信息披露给任何第三方。
								  3.如您的体检报告中发现重大疾病或急性传染疾病时，本公司有义务协助体检机构与您建
								     立联系，且此情况下不再适用保密范畴。
								     
							      温馨提醒：请您仔细阅读本服务协议，您通过本平台预约将视为您本人已充分知晓个人
							      权利，及了解此次授权可能面临的风险，本协议即构成对双方有约束力的法律文件。
									</textarea>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
						<!-- <button type="button" class="btn btn-primary" onclick="agree();">
								同意
						</button>
						<button type="button" class="btn btn-primary" onclick="refuse();">
								拒绝
						</button> -->
						<button type="button" class="btn btn-primary progressBtn" onclick="comeBack();">
								返回
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<script type="text/javascript">
		function agree(){
			parent.$('#elec').attr('checked','checked');
			parent.$('#paper').attr('checked','checked');
			parent.$("#postAddress").show();
			window.parent.$.colorbox.close();
		}
		function refuse(){
			parent.$('#elec').attr('checked',false);
			parent.$('#paper').attr('checked',false);
			parent.$("#postAddress").hide();
			window.parent.$.colorbox.close();
		}
		function comeBack(){
			window.parent.$.colorbox.close();
		}
	</script>
</body>
</html>