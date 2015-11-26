<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="规格参数选择" /></title>
<jdf:themeFile file="ajaxfileupload.js" />
</head>
<body>
    <div>
            <jdf:form bean="entity" scope="request">
             <form method="post" action="${dynamicDomain}/insureSpec/saveAttributeValue/${attributeValueId }?ajax=1" class="form-horizontal" id="editForm">
                    <div class="callout callout-info">
                        <div class="message-right">${message }</div>
                        <h4 class="modal-title"><jdf:message code="规格参数选择" />
                        </h4>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">启用参数</label>
                                   <div class="col-sm-8" id="useParam">
                                        <c:forEach items="${usingPara }" var="item" varStatus="status">
                                           <input type="checkbox" name="useParam_item" value="${item.value }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                   </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="useParam_1" style="display: none;">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">年龄阶段</label>
                                   <div class="col-sm-10">
                                   <input type="hidden" name="age_objectId" value="${ageRange.objectId }">
                                       保险术语：<input name="age_alias" value="${ageRange.alias }">&nbsp;&nbsp;
                                     <c:choose>
                                      <c:when test="${ageRange.isRadio==1 }">
	                                       <input type="radio" name="age_option" value="1" checked="checked">单选&nbsp;&nbsp;
	                                       <input type="radio" name="age_option" value="0">复选
                                       </c:when>
                                       <c:otherwise>
                                           <input type="radio" name="age_option" value="1">单选&nbsp;&nbsp;
                                           <input type="radio" name="age_option" value="0" checked="checked">复选
                                       </c:otherwise>
                                     </c:choose>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-11" id="age">
                                      <c:choose>
                                      <c:when test="${ageRange.isRadio==1 }">
                                        <c:forEach items="${ageDictionary }" var="item" varStatus="status">
                                           <input type="radio" name="age_item" value="${item.value }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                      </c:when>
                                      <c:otherwise>
                                        <c:forEach items="${ageDictionary }" var="item" varStatus="status">
                                           <input type="checkbox" name="age_item" value="${item.value }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                      </c:otherwise>
                                      </c:choose>
                                   </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="useParam_2" style="display: none;">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">职业类别</label>
                                   <div class="col-sm-10">
                                   <input type="hidden" name="job_objectId" value="${jobRange.objectId }">
                                       保险术语：<input name="job_alias" value="${jobRange.alias }">&nbsp;&nbsp;
                                     <c:choose>
                                      <c:when test="${jobRange.isRadio==1 }">
                                           <input type="radio" name="job_option" value="1"  checked="checked">单选&nbsp;&nbsp;
                                           <input type="radio" name="job_option" value="0">复选
                                       </c:when>
                                       <c:otherwise>
                                           <input type="radio" name="job_option" value="1">单选&nbsp;&nbsp;
                                           <input type="radio" name="job_option" value="0" checked="checked">复选
                                       </c:otherwise>
                                     </c:choose>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-11" id="job">
                                    <c:choose>
                                      <c:when test="${jobRange.isRadio==1 }">
                                        <c:forEach items="${jobDictionary }" var="item" varStatus="status">
                                           <input type="radio" name="job_item" value="${item.value }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${jobDictionary }" var="item" varStatus="status">
	                                           <input type="checkbox" name="job_item" value="${item.value }">${item.name }&nbsp;&nbsp;
	                                        </c:forEach>
                                        </c:otherwise>
                                        </c:choose>
                                   </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="useParam_3" style="display: none;">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">社保类别</label>
                                   <div class="col-sm-10">
                                   <input type="hidden" name="social_objectId" value="${socialRange.objectId }">
                                       保险术语：<input name="social_alias" value="${socialRange.alias }">&nbsp;&nbsp;
                                     <c:choose>
                                      <c:when test="${socialRange.isRadio==1 }">
                                           <input type="radio" name="social_option" value="1" checked="checked">单选&nbsp;&nbsp;
                                           <input type="radio" name="social_option" value="0">复选
                                       </c:when>
                                       <c:otherwise>
                                           <input type="radio" name="social_option" value="1">单选&nbsp;&nbsp;
                                           <input type="radio" name="social_option" value="0" checked="checked">复选
                                       </c:otherwise>
                                     </c:choose>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-11" id="social">
                                      <c:choose>
                                      <c:when test="${socialRange.isRadio==1 }">
                                        <c:forEach items="${socialDictionary }" var="item" varStatus="status">
                                           <input type="radio" name="social_item" value="${item.value }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <c:forEach items="${socialDictionary }" var="item" varStatus="status">
	                                           <input type="checkbox" name="social_item" value="${item.value }">${item.name }&nbsp;&nbsp;
	                                        </c:forEach>
                                        </c:otherwise>
                                        </c:choose>
                                   </div>
                                </div>
                            </div>
                        </div>
                        <div class="row" id="useParam_4" style="display: none;">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="name"  class="col-sm-2 control-label">不参保病史</label>
                                   <div class="col-sm-10">
                                   <input type="hidden" name="disease_objectId" value="${pastDiseaseRange.objectId }">
                                       保险术语：<input name="disease_alias" value="${pastDiseaseRange.alias }">&nbsp;&nbsp;
                                     <c:choose>
                                      <c:when test="${socialRange.isRadio==1 }">
                                           <input type="radio" name="disease_option" value="1" checked="checked">单选&nbsp;&nbsp;
                                           <input type="radio" name="disease_option" value="0">复选
                                       </c:when>
                                       <c:otherwise>
                                           <input type="radio" name="disease_option" value="1">单选&nbsp;&nbsp;
                                           <input type="radio" name="disease_option" value="0" checked="checked">复选
                                       </c:otherwise>
                                     </c:choose>
                                   </div>
                                   <div class="col-sm-1"></div>
                                   <div class="col-sm-11" id="disease">
                                     <c:choose>
                                      <c:when test="${socialRange.isRadio==1 }">
                                        <c:forEach items="${pastDiseaseList }" var="item" varStatus="status">
                                           <input type="radio" name="disease_item" value="${item.objectId }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
                                      </c:when>
                                      <c:otherwise>
                                        <c:forEach items="${pastDiseaseList }" var="item" varStatus="status">
                                           <input type="checkbox" name="disease_item" value="${item.objectId }">${item.name }&nbsp;&nbsp;
                                        </c:forEach>
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
                                <button type="button" class="btn btn-primary" onclick="sumitForm();">
                                        <jdf:message code="common.button.save"/>
                                </button>
                            </div>
                        </div>
                        </div>
                </form>
            </jdf:form>
    </div>
<script type="text/javascript">
var ageRadio = '';
var ageCheckbox = '';
<c:forEach items="${ageDictionary }" var="item" varStatus="status">
 ageRadio = ageRadio+'<input type="radio" name="age_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
 ageCheckbox = ageCheckbox+'<input type="checkbox" name="age_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
</c:forEach>
var jobRadio = '';
var jobCheckbox = '';
<c:forEach items="${jobDictionary }" var="item" varStatus="status">
jobRadio = jobRadio +'<input type="radio" name="job_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
jobCheckbox = jobCheckbox +'<input type="checkbox" name="job_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
</c:forEach>
var socialRadio = '';
var socialCheckbox = '';
<c:forEach items="${socialDictionary }" var="item" varStatus="status">
socialRadio = socialRadio +'<input type="radio" name="social_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
socialCheckbox = socialCheckbox +'<input type="checkbox" name="social_item" value="${item.value }">${item.name }&nbsp;&nbsp;';
</c:forEach>
var diseaseRadio = '';
var diseaseCheckbox = '';
<c:forEach items="${pastDiseaseList }" var="item" varStatus="status">
diseaseRadio = diseaseRadio+'<input type="radio" name="disease_item" value="${item.objectId }">${item.name }&nbsp;&nbsp;';
diseaseCheckbox = diseaseCheckbox+'<input type="radio" name="disease_item" value="${item.objectId }">${item.name }&nbsp;&nbsp;';
</c:forEach>
$(function(){
	$('input[name="useParam_item"]').click(function(){
		$('input[name="useParam_item"]').each(function(){
			var type = $(this).val();
			if($(this).is(':checked')){
				$('#useParam_'+type).show();
			}else{
				$('#useParam_'+type).hide();
			}
		});
	});
	//单复选的切换
	bindAgeRadioSwitch();
	bindJobRadioSwitch();
	bindSocialRadioSwitch();
	bindDiseaseRadioSwitch();
	//编辑设置选中
	setUseParam();
	setAge();
	setJob();
	setSocial();
	setDisease();
});

function setUseParam(){
	if('${specUsing.isAge}'=='1'){
		$("#useParam input[value='1']").trigger("click");
	}
    if('${specUsing.isJob}'=='1'){
    	$("#useParam input[value='2']").trigger("click");
    }
    if('${specUsing.isSocial}'=='1'){
    	$("#useParam input[value='3']").trigger("click");
    }
    if('${specUsing.isDisease}'=='1'){
    	$("#useParam input[value='4']").trigger("click");
    }
}

function setAge(){
	<c:forEach items="${ageUsing }" var="item" varStatus="status">
	  $("#age input[value='${item}']").attr('checked','checked');
    </c:forEach>
}
function setJob(){
    <c:forEach items="${jobUsing }" var="item" varStatus="status">
      $("#job input[value='${item}']").attr('checked','checked');
    </c:forEach>
}
function setSocial(){
    <c:forEach items="${socialUsing }" var="item" varStatus="status">
      $("#social input[value='${item}']").attr('checked','checked');
    </c:forEach>
}
function setDisease(){
    <c:forEach items="${pastDiseaseUsing }" var="item" varStatus="status">
      $("#disease input[value='${item}']").attr('checked','checked');
    </c:forEach>
}
function bindAgeRadioSwitch(){
	$('input[name="age_option"]').click(function(){
		if($(this).val()=='1'){
			$('#age').html(ageRadio);
		}else{
			$('#age').html(ageCheckbox);
		}
	});
}
function bindJobRadioSwitch(){
    $('input[name="job_option"]').click(function(){
        if($(this).val()=='1'){
            $('#job').html(jobRadio);
        }else{
            $('#job').html(jobCheckbox);
        }
    });
}
function bindSocialRadioSwitch(){
    $('input[name="social_option"]').click(function(){
        if($(this).val()=='1'){
            $('#social').html(socialRadio);
        }else{
            $('#social').html(socialCheckbox);
        }
    });
}
function bindDiseaseRadioSwitch(){
    $('input[name="disease_option"]').click(function(){
        if($(this).val()=='1'){
            $('#disease').html(diseaseRadio);
        }else{
            $('#disease').html(diseaseCheckbox);
        }
    });
}

function sumitForm(){
	if($('input[name="useParam_item"]:checked').length==0){
		winAlert('请选择一个要启用的参数');
		return false;
	}
	$('#editForm').submit();
}
</script>
</body>
</html>