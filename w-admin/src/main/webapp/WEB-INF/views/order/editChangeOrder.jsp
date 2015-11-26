
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>新增退换货订单</title>

<style>
.upView {
	margin: 7px 0 0 0;
}
</style>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
  <div>
    <div class="callout callout-info">
      <div class="message-right">${message }</div>
      <h4 class="modal-title">新增退换货订单</h4>
    </div>
    <jdf:form bean="entity" scope="request">
      <form method="post" action="${dynamicDomain}/changeOrder/save" class="form-horizontal" name="fm" id="editForm" enctype="multipart/form-data">
        <input type="hidden" name="objectId"> <input type="hidden" name="subOrderId" value="${subOrder.objectId}"> <input type="hidden" name="changeNo" value="${entity.changeNo}">
        <div class="box-body">
          <div class="row">
            <div class="col-sm-3 col-md-3">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">订单信息</label>
              </div>
            </div>
          </div>
          <hr>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label"><p>订单编号：</p></label>
                <div class="col-sm-8">
                  <c:if test="${entity.changeNo==null}">
                    <input type="text" class="search-form-control" id="subOrderNo" name="subOrderNo" value="${subOrder.subOrderNo}">
                  </c:if>
                  <c:if test="${entity.changeNo !=null}">
                   <input type="text" class="search-form-control" id="subOrderNo" name="subOrderNo" value="${subOrder.subOrderNo}" disabled="disabled">
                  </c:if>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="aa" class="col-sm-4 control-label">退换货类型：</label>
                <div class="col-sm-8">
                  <c:if test="${entity.changeNo==null}">
                    <label><input type="radio" name="changeType" value="1" />退货</label>
                    <label><input type="radio" name="changeType" value="2" />换货</label>
                  </c:if>
                  <c:if test="${entity.changeNo!=null && entity.changeType==1}">
                    <label><input type="radio" name="changeType" value="1" />退货</label>
                  </c:if>
                  <c:if test="${entity.changeNo!=null && entity.changeType==2}">
                    <label><input type="radio" name="changeType" value="2" />换货</label>
                  </c:if>
                </div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <div class="col-sm-4">
                  <c:if test="${entity.changeNo==null}">
                    <button type="button" onClick="determine();" class="btn btn-primary progressBtn">确定</button>
                  </c:if>
                  <c:if test="${entity.changeNo==null}">
                  </c:if>
                </div>
              </div>
            </div>
          </div>
          <br>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">退换货商品：</label>
                <div class="col-sm-8 upView">
                  <font style="color: red"> </font>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">总订单号：</label>
                <div class="col-sm-8 upView">${order.generalOrderNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">子订单号：</label>
                <div class="col-sm-8 upView">${subOrder.subOrderNo}</div>
              </div>
            </div>
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">实付金额：</label>
                <div class="col-sm-8 upView">
                  <c:if test="${subOrder.actuallyAmount!=null && subOrder.actuallyIntegral!=null}">
                ${subOrder.actuallyAmount}元 +${subOrder.actuallyIntegral}积分
                </c:if>
                  <c:if test="${subOrder.actuallyAmount!=null && subOrder.actuallyIntegral==null}">
                ${subOrder.actuallyAmount}元
                </c:if>
                  <c:if test="${subOrder.actuallyAmount==null && subOrder.actuallyIntegral!=null}">
                ${subOrder.actuallyIntegral}积分
                </c:if>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-12 col-md-12">
              <table class="table table-bordered table-hover">
                <thead>
                  <tr>
                    <th>商品系统编号</th>
                    <th>商品ID</th>
                    <th>商品名称</th>
                    <th>商品类型</th>
                    <th>规格属性</th>
                    <th>数量</th>
                    <th>单价</th>
                    <th>小计</th>
                    <th>实付积分</th>
                    <th>实付金额</th>
                    <th>开票金额</th>
                    <th>退换货数量</th>
                    <th>退款金额</th>
                    <th>操作</th>
                  </tr>
                </thead>
                <c:choose>
                  <c:when test="${entity.changeNo==null}">
                    <c:forEach items="${subOrder.orderProductList}" var="orderproduct" varStatus="num">
                      <tbody>
                        <tr>
                          <td>${orderproduct.productNo} <input type="hidden" name="isChangeProduct" value="${orderproduct.isChangeProduct}"></td>
                          <td>${orderproduct.productId} <input type="hidden" name="changeOrderSkus[${num.index }].skuId" value="${orderproduct.productId}" />
                          </td>
                          <td>${orderproduct.name}</td>
                          <td>
                          <c:choose>
                           <c:when test="${orderproduct.productType==1}">
                                                                                      实物商品
                           </c:when>
                           <c:when test="${orderproduct.productType==2}">
                                                                                      实体卡券
                           </c:when>
                           <c:when test="${orderproduct.productType==3}">
                                                                                      电子卡券
                           </c:when>
                            <c:when test="${orderproduct.productType==21}">
                                                                                      福利实体兑换券
                           </c:when>
                            <c:when test="${orderproduct.productType==22}">
                                                                                      福利电子兑换券
                           </c:when>
                            <c:when test="${orderproduct.productType==31}">
                                                                                      体检实体兑换券
                           </c:when>
                           <c:when test="${orderproduct.productType==32}">
                                                                                      体检电子兑换券
                           </c:when>
                           <c:when test="${orderproduct.productType==41}">
                                                                                      生活服务
                           </c:when>
                          </c:choose>                          
                          </td>
                          <td><c:choose>
                              <c:when test="${orderproduct.attribute1!=null && orderproduct.attribute2!=null}">
                                                                                                 颜色：${orderproduct.attribute2}，尺寸：${orderproduct.attribute1}
                             </c:when>
                             <c:when test="${orderproduct.attribute1==null && orderproduct.attribute2!=null}">
                                                                                                 颜色：${orderproduct.attribute2}
                             </c:when>
                             <c:when test="${orderproduct.attribute1!=null && orderproduct.attribute2==null}">
                                                                                                尺寸：${orderproduct.attribute1}
                             </c:when>
                             <c:otherwise>
                             </c:otherwise>
                            </c:choose> 
                            </td>
                          <td>${orderproduct.productCount}</td>
                          <td id="price_${num.index }">${orderproduct.productPrice}</td>
                          <td>${orderproduct.productCount*orderproduct.productPrice}</td>
                          <td></td>
                          <td>${orderproduct.productCount*orderproduct.productPrice}</td>
                          <td>${orderproduct.productCount*orderproduct.productPrice}</td>
                          <td>
                            <c:if test="${subOrder.subOrderState !=2}">
                              <c:choose>
                                <c:when test="${changeType==1 && (orderproduct.productType!=22 && orderproduct.productType!=32) && orderproduct.isChangeProduct==1}">
                                  <input class="returnGo" size="5" name="changeOrderSkus[${num.index}].changeNum" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="0" id="numl_${num.index }" />
                                </c:when>
                                <c:when test="${changeType==2 && (orderproduct.productType!=22 && orderproduct.productType!=32) && orderproduct.isChangeProduct==1}">
                                  <input size="5" name="changeOrderSkus[${num.index}].changeNum" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="0" id="numl_${num.index}" />
                                </c:when>
                                <c:when test="${ORDER_PRODUCT_RETURN&&(orderproduct.productType==22 || orderproduct.productType==32) && orderproduct.isChangeProduct==1}">
                                  <div id="orders" class="col-sm-8" style="margin-left: 5px;"></div>
                                </c:when>
                               </c:choose>
                              </c:if>
                            <c:if test="${subOrder.subOrderState ==2}">
                              <c:choose>
                                <c:when test="${changeType==1 && (orderproduct.productType!=22 && orderproduct.productType!=32) && orderproduct.isChangeProduct==1}">
                                  <input class="returnGo" size="5" name="changeOrderSkus[${num.index}].changeNum1" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="${orderproduct.productCount}" id="numl_${num.index }"  disabled="disabled"/>
                                  <input type="hidden" class="returnGo" size="5" name="changeOrderSkus[${num.index}].changeNum" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="${orderproduct.productCount}" id="numl_${num.index }" />
                                </c:when>
                                <c:when test="${changeType==2 && (orderproduct.productType!=22 && orderproduct.productType!=32) && orderproduct.isChangeProduct==1}">
                                  <input size="5" name="changeOrderSkus[${num.index}].changeNum1" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="${orderproduct.productCount}" id="numl_${num.index}"  disabled="disabled"/>
                                  <input type="hidden" size="5" name="changeOrderSkus[${num.index}].changeNum" max="${orderproduct.productCount-orderproduct.returnQuantity}" data-index="${num.index }" value="${orderproduct.productCount}" id="numl_${num.index}"  />                                  
                                </c:when>
                              </c:choose>
                            </c:if>
                           </td>  
                         <c:if test="${subOrder.subOrderState !=2}">       
                          <td id="total_${num.index }"></td>
                         </c:if>
                         <c:if test="${subOrder.subOrderState ==2 && changeType!=2}"> 
                         <td>${orderproduct.productCount*orderproduct.productPrice}</td>
                         </c:if>
                          <td><c:if test="${ORDER_PRODUCT_RETURN && (orderproduct.productType==22 || orderproduct.productType==32) && orderproduct.isChangeProduct==1}">
                              <a href="${dynamicDomain}/changeOrder/cardInfo/?productId=${orderproduct.productId}&subOrderId=${orderproduct.subOrderId}&ajax=1&inputName=orders&num.index=${num.index}" class="colorbox-template pull-left">
                                <button type="button" class="btn btn-primary">退货</button>
                              </a>
                            </c:if>
                          </td>
                        </tr>
                      </tbody>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <c:forEach items="${changeOrderSkus}" var="ordersku" varStatus="num">
                      <tbody>
                        <tr>
                          <td><input type="hidden" name="changeOrderSkus[${num.index}].objectId" value="${ordersku.objectId}"> ${ordersku.productNo}</td>
                          <td>${ordersku.skuId} <input type="hidden" name="changeOrderSkus[${num.index }].skuId" value="${ordersku.skuId}" />
                          </td>
                          <td>${ordersku.name}</td>
                          <td id="type_${num.index }"><jdf:dictionaryName dictionaryId="1101" value="${ordersku.productType }" /></td>
                          <td>${ordersku.attribute}</td>
                          <td>${ordersku.productCount}</td>
                          <td id="price_${num.index }">${ordersku.productPrice}</td>
                          <td>${ordersku.productCount*ordersku.productPrice}</td>
                          <td></td>
                          <td>${ordersku.productCount*ordersku.productPrice}</td>
                          <td>${ordersku.productCount*ordersku.productPrice}</td>
                          <td>
                         <c:if test="${subOrder.subOrderState !=2}">     
                          <c:choose>
                              <c:when test="${ordersku.productType==1 || ordersku.productType==21 || ordersku.productType==31}">
                                <input size="5" class="returnGo" name="changeOrderSkus[${num.index}].changeNum" max="${ordersku.productCount-ordersku.returnQuantity+ordersku.changeNum}" data-index="${num.index}" value="${ordersku.changeNum}" required="true" id="numl" />
                              </c:when>
                              <c:when test="${ordersku.productType==22 || ordersku.productType==32}">
                                <div id="orders" class="col-sm-8" style="margin-left: 5px;">
                                  ${ordersku.changeNum} <input type="hidden" class="search-form-control" name="ids" value="${ids}" /> <input type="hidden" name="changeOrderSkus[${num.index}].changeNum" value="${ordersku.changeNum}">
                                </div>
                              </c:when>
                              <c:otherwise>
                              </c:otherwise>
                            </c:choose>
                          </c:if>
                          <c:if test="${subOrder.subOrderState ==2}">  
                          <c:choose>
                              <c:when test="${ordersku.productType==1 || ordersku.productType==21 || ordersku.productType==31}">
                                <input size="5" class="returnGo" name="changeOrderSkus[${num.index}].changeNum1" max="${ordersku.productCount-ordersku.returnQuantity+ordersku.changeNum}" data-index="${num.index}" value="${ordersku.changeNum}" required="true" id="numl" disabled="disabled"/>
                                <input type="hidden" size="5" class="returnGo" name="changeOrderSkus[${num.index}].changeNum" max="${ordersku.productCount-ordersku.returnQuantity+ordersku.changeNum}" data-index="${num.index}" value="${ordersku.changeNum}" required="true" id="numl" />                               
                              </c:when>
                              
                              <c:otherwise>
                              </c:otherwise>
                            </c:choose>
                          </c:if>
                            </td>
                          <td id="total_${num.index }">${ordersku.changeMount}</td>
                          <td><c:if test="${ordersku.productType==22 || ordersku.productType==32 }">
                              <a href="${dynamicDomain}/changeOrder/cardInfo/?productId=${ordersku.skuId}&subOrderId=${subOrder.objectId}&ajax=1&inputName=orders&num.index=${num.index}&changeNo=${entity.changeNo}" class="colorbox-template pull-left">
                                <button type="button" class="btn btn-primary">退货</button>
                              </a>
                            </c:if></td>
                        </tr>
                      </tbody>
                    </c:forEach>
                  </c:otherwise>
                </c:choose>
              </table>
            </div>
          </div>
          <br> <br> <br> <br>
          <div class="row">
            <div class="col-sm-4 col-md-4">
              <div class="form-group">
                <label for="platform" class="col-sm-4 control-label">退换货单详情</label>
              </div>
            </div>
          </div>
          <hr>
          <c:if test="${entity.changeNo!=null}">
            <div class="row">
              <div class="col-sm-4 col-md-4">
                <div class="form-group">
                  <label for="platform" class="col-sm-4 control-label">退换货单号：</label>
                  <div class="col-sm-8 upView">${entity.changeNo}</div>
                </div>
              </div>
              <div class="col-sm-4 col-md-4">
                <div class="form-group">
                  <label for="platform" class="col-sm-4 control-label">订单状态：</label>
                  <div class="col-sm-8 upView">
                    <c:choose>
                      <c:when test="${entity.orderStatus==1}">
                                                             待审核
                  </c:when>
                      <c:when test="${entity.orderStatus==2}">
                                                            同意
                  </c:when>
                    </c:choose>
                  </div>
                </div>
              </div>
            </div>
          </c:if>
          <br>
          <div class="row">
            <div class="col-sm-8 col-md-8">
              <div class="form-group">
                <label for="logo" class="col-sm-2 control-label">上传图证：</label> 
                <input name="subPicture" type="hidden" id="subPicture">
                <div class="col-sm-10">
                  <span class="detail-picture" id="subImg"> 
                   <c:forEach items="${changeOrderExplas}" var="item" varStatus="status">
                      <div style="width: 100px; display: inline-block;">
                        <c:if test="${view!=1 }">
                          <a style="cursor: pointer; display: block; margin-left: 65px;" class="subDelete" data-path="${item.imagId}">删除</a>
                        </c:if>
                        <img alt="" src="${dynamicDomain}${item.imagId}" width="100px" height="100px;">
                      </div>
                    </c:forEach>
                  </span> 
                  <span> 
                  <input type="file" name="uploadFile" id="uploadFile" style="display: inline;"> 
                  <input type="button" value="上传" onclick="ajaxFileUpload();" id="uploadButton">
                  </span>
                </div>
              </div>
            </div>
          </div>
          <div class="row">
            <div class="col-sm-8 col-md-8">
              <div class="form-group">
                <label for="returnInfo" class="col-sm-2 control-label">退换货说明</label>
                <div class="col-sm-10">
                  <textarea onkeyup="checkLen(this)" style="width: 700px; height: 100px;" name="returnInfo"></textarea>
                  <span style="color: red">(退换货说明最多输入200个字符, 您还可以输入 <span id="count">200</span> 个)
                  </span>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div class="row">
          <div class="editPageButton">
            <button type="button" class="btn btn-primary progressBtn" onClick="isSave();">保存</button>
            <a href="${dynamicDomain}/changeOrder/page">
              <button type="button" class="btn progressBtn">返回</button>
            </a>
          </div>
        </div>
      </form>
    </jdf:form>
  </div>
  <jdf:bootstrapDomainValidate domain="ChangeOrder" />
  <script type="text/javascript">
			function isSave() {
				var  subOrderNo=$("#subOrderNo").val();
				 if(subOrderNo==''){
					 $("#subOrderNo").focus();
					 $("p").css({
						 "color":"#dd4b39",
					 });
					 }
				var subOrderId = $("input[name='subOrderId']").val();
				var changeNo = $("input[name='changeNo']").val();
				$.ajax({
					async : false,
					url : "${dynamicDomain}/changeOrder/PendChangeOrder",
					type : 'post',
					dataType : 'json',
					data : {
						'subOrderId' : subOrderId,
						'changeNo' : changeNo
					},
					success : function(msg) {
						if (msg.result == true) {
							alert("该订单存在待审核的退换货订单，不能再新增退换货单！");
						} else {
							$("#editForm").submit();
						}
					}
				});
			}

			$('.returnGo').blur(function() {
				var index = $(this).data('index');
				var num = $(this).val();
				var price = $('#price_' + index).text();
				var total = num * price;
				$('#total_' + index).text(total);

			});

			$('input[id^=numl_]').blur(function() {
				var num = $(this).val();
				if (!(/(^[0-9]\d*$)/.test(num))) {
					alert("只能输入正整数");
					$(this).focus();
				}
			});

			function determine() {
				$("#editForm").attr("action",
						"${dynamicDomain}/changeOrder/determine");
				if($("#subOrderNo").val()==''){
					$("#subOrderNo").val('');				
			     }else{
				   $("#subOrderNo").val($("#subOrderNo").val());
			    }
				$("#editForm").submit();

			}

			function checkLen(obj) {
				var maxChars = 200;//最多字符数 
				if (obj.value.length > maxChars)
					obj.value = obj.value.substring(0, maxChars);
				var curr = maxChars - obj.value.length;
				document.getElementById("count").innerHTML = curr.toString();
			}

			function ajaxFileUpload() {

				if ($("#uploadFile").val() == ''){
					alert('请选择上传文件');
					return false;
				}

				var subPicture = $('#subPicture').val();
				var array = new Array();
				array = subPicture.split(",");
				if (array.length >= 3) {
					alert("退换货图证不能大于3张");
					$("input[name='uploadFile']").val('');
					return false;
				}

				$.ajaxFileUpload({
							url : '${dynamicDomain}/order/picture/uploadProduct?ajax=1',
							secureuri : false,
							fileElementId : 'uploadFile',
							dataType : 'json',
							success : function(json, status) {
								if (json.result) {
									var filePath = json.filePath;
									var width = json.width;
									var height = json.height;
									var url = '${dynamicDomain}/order/picture/productCrop?ajax=1&filePath='
											+ filePath
											+ "&width="
											+ width
											+ "&height=" + height + "&type=sub";
									$.colorbox({
										opacity : 0.2,
										href : url,
										fixed : true,
										width : "65%",
										height : "85%",
										iframe : true,
										onClosed : function() {
											if (false) {
												location.reload(true);
											}
										},
										overlayClose : false
									});
								}
							},
							error : function(data, status, e)//服务器响应失败处理函数
							{
								alert(e);
							}
						});
				return false;
			}

			//图片删除

			$(function() {
				$('#changeType${changeType}').attr('checked', 'checked');
				$("#editForm").validate();
				deletePic();
			});

			function deletePic() {
				$('.subDelete').click(function() {
					var subPicture = $(this).data('path');
					var obj = $(this);
					$.ajax({
						url : "${dynamicDomain}/order/picture/deletePicture",
						type : 'post',
						dataType : 'json',
						data : {
							'filePath' : subPicture
						},
						success : function(json) {
							obj.parent().remove();
							//更新子图路径
							var paths = '';
							$('.subDelete').each(function() {
								var path = $(this).data('path');
								if (paths == '') {
									paths = path;
								} else {
									paths = paths + ',' + path;
								}
							});
							$('#subPicture').val(paths);
						}
					});
				});
			}
		</script>
</body>
</html>