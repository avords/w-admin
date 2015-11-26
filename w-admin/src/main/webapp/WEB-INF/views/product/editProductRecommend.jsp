<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品推荐管理</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					商品推荐管理
					<c:choose>
						<c:when test="${entity.objectId eq null }">新增</c:when>
						<c:otherwise>修改</c:otherwise>
					</c:choose>
				</h4>
			</div>
			<form method="post"
				action="${dynamicDomain}/productRecommend/saveToPage" id="ProductRecommend" class="form-horizontal" onsubmit="return vierfi();">
				<input type="hidden" name="objectId">
                <input type="hidden" name="index" id="index" value="0">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="platform" class="col-sm-4 control-label">推荐平台</label>
								<div class="col-sm-8">
									<select name="platform" class="search-form-control" id="platform">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1202" />
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
              <div class="form-group">
                      <label for="page" class="col-sm-4 control-label">推荐页面</label>
                  <div class="col-sm-8">
                   <select name="page" class="form-control" id="page">
                   	 <option value=""></option>
                   	<jdf:selectCollection items="secondCategory" optionValue="pageCode"  optionText="pageName" />
                    </select>
                   </div>
              </div>
          </div>
          <div class="col-sm-4 col-md-4">
              <div class="form-group">
                      <label for="location" class="col-sm-6 control-label">推荐位置</label>
                  <div class="col-sm-6">
                   <select name="location" class="form-control" id="location">
                   	<option value=""></option>
                   	<jdf:selectCollection items="thirdCategory" optionValue="positionCode"  optionText="positionName" /> 
                    </select>
                   </div>
              </div>
          </div>
					</div>
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="title" class="col-sm-4 control-label">大标题</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="title">
								</div>
							</div>
						</div>
						<div class="col-sm-4 col-md-4">
							<div class="form-group">
								<label for="subTitle" class="col-sm-4 control-label">副标题</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="subTitle">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-8 col-md-8">
							<div class="form-group">
								<label for="companyName" class="col-sm-2 control-label">推荐商品</label>
								<div class="col-sm-10">
									<a
										href="${dynamicDomain }/product/productRecommentsTemplate?ajax=1&inputName=productRecommentForms"
										id="enterprise-btn"
										class="pull-left btn btn-primary colorbox-double-template">
										选择商品 </a> <a
										href="${dynamicDomain }/welfarePackage/welfarePackageRecommendTemplate?ajax=1&inputName=welfarePackageRecommentForms"
										id="enterprise-btn"
										class="pull-left btn btn-primary colorbox-double-template">
										选择福利套餐 </a> </a> 
                                        <%-- <a
										href="${dynamicDomain }/physicalPackage/physicalPackageRecommendTemplate?ajax=1&inputName=physicalPackageRecommentForms"
										id="enterprise-btn"
										class="pull-left btn btn-primary colorbox-double-template">
										选择体检套餐 </a> --%>
								</div>
							</div>
						</div>
					</div>
					<div id="productRecommentForms"></div>
					<div id="welfarePackageRecommentForms"></div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary">保存</button>
								<a href="${dynamicDomain}/productRecommend/page" class="btn btn-primary">返回</a>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="ProductRecommend" />
	<script type="text/javascript">
	$(function(){
		 $("#platform").bind("change",function(){
           if($(this).val()){
               $.ajax({
                   url:"${dynamicDomain}/advert/category/secondCategory/" + $(this).val()+"?type=2",
                   type : 'post',
                   dataType : 'json',
                   success : function(json) {
                       $("#page").children().remove();
                       $("#page").append("<option value=''></option>");
                       for ( var i = 0; i < json.secondCategory.length; i++) {
                           $("#page").append("<option value='" + json.secondCategory[i].pageCode + "'>" + json.secondCategory[i].pageName + "</option>");
                       }
                       
                 		$("#page").val("${entity.page}"); 
                 		
                   }
               });
           }
        }).change();
		 
		 	$("#page").bind("change",function(){
 						var page = $("#page").val();
 						var page1 = "${entity.page}";
						if (page == "") {
							page = page1;
						}
              $.ajax({
                  url:"${dynamicDomain}/advert/category/thirdCategory/"+page+"?type=2",
                  type : 'post',
                  dataType : 'json',
                  success : function(json) {
                      $("#location").children().remove();
                      $("#location").append("<option value=''></option>");
                      for ( var i = 0; i < json.thirdCategory.length; i++) {
                          $("#location").append("<option value='" + json.thirdCategory[i].positionCode + "'>" + json.thirdCategory[i].positionName + "</option>");
                      }
                    $("#location").val("${entity.location}"); 
                  }
              });
         
       }).change();
   });
		function deleteProductRecommendDiv(divId)
		{
			$("#" + divId).remove();
		}
		
		function vierfiRecommend(){
			var value1 = $('#productRecommentForms').html();
			var value2 = $('#welfarePackageRecommentForms').html();
			if(value1==''&&value2==''&&value3==''){
				winAlert('推荐内容不能为空');
				return false;
			}
			return true;
		}
		function vierfi(){
			var flag = vierfiRecommend();
			return flag;
		}
	</script>
</body>
</html>