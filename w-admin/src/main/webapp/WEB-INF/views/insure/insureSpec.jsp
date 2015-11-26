<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="保险商品规格设置" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
            <jdf:form bean="entity" scope="request">
             <form method="post" action="${dynamicDomain}/pastDisease/save?ajax=1" class="form-horizontal" id="editForm">
                    <div class="callout callout-info">
                        <div class="message-right">${message }</div>
                        <h4 class="modal-title"><jdf:message code="保险商品规格设置" />
                        </h4>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">一级分类</label>
                                   <div class="col-sm-8">
                                        <input type="text" class="form-control" name="name" value="${firstCategory.name }" readonly="readonly">
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">二级分类</label>
                                   <div class="col-sm-8">
                                    <select id="category2" class="form-control">
                                        <c:forEach items="${secondCategorys }" var="item" varStatus="status">
                                            <option value="${item.secondId }">${item.name }</option>
                                        </c:forEach>
                                    </select>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">三级分类</label>
                                   <div class="col-sm-8">
                                         <select id="category3" class="form-control">
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="spec">
                        </div>
                    </div>
<!--                     <div class="box-footer"> -->
<!--                         <div class="row"> -->
<!--                             <div class="editPageButton"> -->
<!--                                 <button type="submit" class="btn btn-primary"> -->
<%--                                         <jdf:message code="common.button.save"/> --%>
<!--                                 </button> -->
<!--                             </div> -->
                                
<!--                         </div> -->
<!--                         </div> -->
                    </div>
                </form>
            </jdf:form>
    </div>
    <script type="text/javascript">
    $(function(){
    	$("#category2").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/productCategory/thirdCategory/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        $("#category3").children().remove();
                        $("#category3").append('<option>请选择</option>');
                        for ( var i = 0; i < json.thirdCategory.length; i++) {
                            $("#category3").append("<option value='" + json.thirdCategory[i].objectId + "'>" + json.thirdCategory[i].name + "</option>");
                        }
                        //$("#category3").val('${param.search_EQL_categoryId}').change();
                    }
                });
            }
         }).change();
    	
    	$("#category3").bind("change",function(){
            if($(this).val()){
                $.ajax({
                    url:"${dynamicDomain}/attribute/getAttrs/" + $(this).val(),
                    type : 'post',
                    dataType : 'json',
                    success : function(json) {
                        var content ='';
                        for ( var i = 0; i < json.attributes.length; i++) {
                        	var attributeValues = '<select class="form-control attribute-value">';
                        	for(var j = 0;j<json.attributes[i].attributeValues.length;j++){
                        		attributeValues = attributeValues+'<option value="'+json.attributes[i].attributeValues[j].objectId+'">'+json.attributes[i].attributeValues[j].attributeValue+'</option>';
                        	}
                        	attributeValues = attributeValues+'</select>';
                            content = content +'<div class="col-sm-12 col-md-12">'+
							                            '<div class="form-group">'+
							                            '<label for="name"  class="col-sm-2 control-label">'+json.attributes[i].name+'</label>'+
							                            '<div class="col-sm-3">'+
							                            attributeValues+
							                            '</div>'+
							                            '<div class="col-sm-3"><a class="btn btn-primary colorbox-big">编辑</a></div>'+
							                         '</div>'+
							                     '</div>';
                        }
                        $('#spec').html(content);
                        bindAttributeValue();
                        bindColorbox();
                    }
                });
            }
         }).change();
    });
    
    function bindAttributeValue(){
    	$(".attribute-value").bind("change",function(){
            if($(this).val()){
                $(this).parent().next().find('a').attr('href','${dynamicDomain}/insureSpec/editAttributeValue/'+$(this).val()+'?ajax=1');
            }
         }).change();
    }
    
    function bindColorbox(){
    	$(".colorbox-big").colorbox({
            opacity : 0.2,
            fixed : true,
            width : "65%",
            height : "90%",
            iframe : true,
            close:"",
            onClosed : function() {
                if (false) {
                    location.search=location.search.replace(/message.*&/,"");
                }
            },
            overlayClose : false
        });
    }
    </script>
</body>
</html>