<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检分院详情</title>
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="ajaxfileupload.js" />
<jdf:themeFile file="select2.js"/>
<jdf:themeFile file="fckeditor/ckeditor.js" />
<style>
.upView {
	margin: 7px 0 0 0;
}
</style>

</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">体检分院详情</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="#" class="form-horizontal" id="editForm">
        <input type="hidden" name="objectId">
        <script type="text/javascript">
         objectId = '${entity.objectId}';
        </script>
        <div class="box-body">
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">门店名称：</label>
                <div class="col-sm-8 upView">${supplierShop.shopName}</div>
              </div>
            </div>
             <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">联系电话：</label>
                <div class="col-sm-8 upView">
                	${supplierShop.telephone}
                </div>
              </div>
            </div>
            <%-- <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">婚姻状况:</label>
                <div class="col-sm-8 upView">
                  <c:choose>
					<c:when test="${voEntity.marryStatus eq 1}">
						<span class="f-ib">已婚</span>
					</c:when>
					<c:otherwise>
						<span class="f-ib">未婚</span>
					</c:otherwise>
				</c:choose><br>
                </div>
              </div>
            </div> --%>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">门店地址：</label>
                <div class="col-sm-8 upView">
                	${supplierShop.address}
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label class="col-sm-4 control-label">门店备注：</label>
                <div class="col-sm-8 upView">${supplierShop.remarks}</div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <div class="form-group">
              <!--   <label class="col-sm-2 control-label">门店详情：</label> -->
                <div class="col-sm-10">
                                    <textarea name="details" id="txt" class="search-form-control"></textarea>
                             	<script type="text/javascript">
                            	window.onload = function(){
	                                CKEDITOR.replace( 'txt',{
	                                	height:200,
	                                	filebrowserImageUploadUrl:"${dynamicDomain}/connector/uploadContentFile?ajax=1"
	                                });
	                            };
                      		 	</script>
                                </div>
            </div>
          </div>
          </div>
          <div class="row">
            <div class="editPageButton">
            <button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary progressBtn">返回</button>
            </div>
          </div>
      </form>
    </jdf:form>
  </div>
  <script type="text/javascript">
			$(function() {
				$(".datestyle").datepicker({
					format : 'yyyy-mm-dd'
				});
			});

		</script>
</body>
</html>