<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>商品运营三级分类</title>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <div class="message-right">${message }</div>
             <h4 class="modal-title">商品运营三级分类
				<c:choose>
	                <c:when test="${entity.objectId eq null }">—新增</c:when>
	                <c:otherwise>—修改</c:otherwise>
	            </c:choose>
			</h4>
        </div>
        <jdf:form bean="entity" scope="request">
                <form method="post" action="${dynamicDomain}/productCategory/save" class="form-horizontal" id="ProductCategory">
                    <input type="hidden" name="objectId">
                   	<input type="hidden" name="firstId">
                   	<input type="hidden" name="secondId">
					<input type="hidden" name="thirdId">
                    <input type="hidden" name="layer"  value=3>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
									<label for="thirdId" class="col-sm-5 control-label">三级分类编号</label>                              
									<span class="lable-span">${entity.thirdId}</span>                               
                                </div>
                            </div>                           
                        </div>	
                        <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="name" class="col-sm-5 control-label">三级分类名称</label>
									<div class="col-sm-7">
										<input type="text" class="search-form-control" name="name" maxlength="50">
									</div>
								</div>
							</div>
						</div>
						 <div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="sortNo" class="col-sm-5 control-label">排序</label>
									<div class="col-sm-7">
										<input type="text" class="{sortNoVerify:true} search-form-control" name="sortNo">
									</div>
								</div>
							</div>
						</div>		
						<div class="row">
							<div class="col-sm-12 col-md-12 menuContent">
								<div class="form-group">
									<label for="status" class="col-sm-5 control-label">状态</label>
									<div class="col-sm-7">
										<c:choose>
											<c:when test="${canInvalid || entity.status==2}">
												<jdf:radio dictionaryId="111" name="status"/>
											</c:when>
											<c:otherwise>
												<span class="lable-span">
													<jdf:dictionaryName dictionaryId="111" value="${entity.status}"/>
													<input type="hidden" name="status">
												</span>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div>
						</div> 						
                    </div>
                    <div class="box-footer">
                        <div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary"> 保存
								</button>
							</div> 
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <jdf:bootstrapDomainValidate domain="ProductCategory"/>
</body>
</html>