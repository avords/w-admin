<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品分类属性管理" /></title>
<style>
.tableAttr{
 border-collapse:separate;
 border-spacing:8px; 
}
</style>
</head>
<body>
    <div>
           <jdf:form bean="entity" scope="request">
			         <form method="post" action="${dynamicDomain}/attribute/save?ajax=1" class="form-horizontal" id="editForm" onsubmit="return customeValid();">
			        <div class="callout callout-info">
			            <div class="message-right">${message }</div>
			            <h4 class="modal-title"><jdf:message code="商品分类属性管理" />
			            <c:choose>
			                <c:when test="${entity.objectId eq null }">—编辑</c:when>
			                <c:otherwise>—编辑</c:otherwise>
			            </c:choose>
			            </h4>
			        </div>
                    <div class="box-body">
                        <div class="row">
                            <input name="categoryId" type="hidden" id="categoryId" value="${thirdCategory.objectId }">
                            <input name="thirdId" type="hidden" id="categoryId" value="${thirdCategory.thirdId }">
                            <div class="col-sm-4 col-md-4">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <label for="logo"  class="form-lable">一级分类：</label>
                                    </div>
                                    <input type="text" class="form-control" name="firstName" readonly="readonly" value="${thirdCategory.firstName }">
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <label for="logo"  class="form-lable">二级分类：</label>
                                    </div>
                                    <input type="text" class="form-control" name="secondName" readonly="readonly" value="${thirdCategory.secondName }">
                                </div>
                            </div>
                            <div class="col-sm-4 col-md-4">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <label for="logo"  class="form-lable">三级分类：</label>
                                    </div>
                                   <input type="text" class="form-control" name="name" readonly="readonly" value="${thirdCategory.name }">
                                </div>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-sm-6 col-md-6">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <label for="logo"  class="form-lable">规格1：</label>
                                    </div>
                                    <input type="hidden" class="form-control" name="attributeObjectId1" value="${attribute1.objectId }">
                                    <input type="text" class="form-control" name="name1" value="${attribute1.name }">
                                </div>
                                <div class="row" style="margin-left: 20px;">
                                  <table class="tableAttr">
                                     <thead>
                                         <tr>
                                             <th width="49%">子规格</th> <th width="40%">排序</th> <th></th>
                                         </tr>
                                     </thead>
                                     <tbody>
                                       <c:forEach var="item" items="${attributeValue1}" varStatus="num">
                                         <tr>
                                             <td>
                                                 <input type="hidden" name="objectId1" value="${item.objectId }">
                                                 <input type="text"  name="attributeValue1" value="${item.attributeValue }">
                                             </td> 
                                             <td><input type="text"  name="sortNo1" value="${item.sortNo}"></td>
                                             <td><input type="button" data-id="${item.objectId }" value="删除" class="delete-value"/></td>
                                         </tr>
                                        </c:forEach>
                                         <tr>
                                           <td></td>
                                           <td></td>
                                           <td><input type="button" value="添加" class="create-value1"/></td>
                                       </tr>
                                     </tbody>
                                  </table>
                                </div>
                            </div>
                            <div class="col-sm-6 col-md-6">
                                <div class="input-group">
                                    <div class="input-group-btn">
                                        <label for="logo"  class="form-lable">规格2：</label>
                                    </div>
                                    <input type="hidden" class="form-control" name="attributeObjectId2" value="${attribute2.objectId }">
                                    <input type="text" class="form-control" name="name2" value="${attribute2.name }">
                                </div>
                                <div class="row" style="margin-left: 20px;">
                                  <table class="tableAttr">
                                     <thead>
	                                     <tr>
	                                         <th width="49%">子规格</th> <th width="40%">排序</th> <th></th>
	                                     </tr>
                                     </thead>
                                     <tbody>
                                         <c:forEach var="item" items="${attributeValue2}" varStatus="num">
                                         <tr>
                                             <td>
                                                 <input type="hidden" name="objectId2" value="${item.objectId }">
                                                 <input type="text"  name="attributeValue2" value="${item.attributeValue }">
                                             </td> 
                                             <td><input type="text"  name="sortNo2" value="${item.sortNo}"></td>
                                             <td><input type="button" data-id="${item.objectId }" value="删除" class="delete-value"/></td>
                                         </tr>
                                        </c:forEach>
                                         <tr>
                                           <td></td>
                                           <td></td>
                                           <td><input type="button" value="添加" class="create-value2"/></td>
                                       </tr>
                                     </tbody>      
                                  </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="submit" class="btn btn-primary">
                                        <jdf:message code="common.button.save"/>
                                </button>
                            </div>
                                
                        </div>
                        </div>
                    </div>
                </form>
            </jdf:form>
    </div>
    <script type="text/javascript">
    function calculation1(){
    	var count = $("input[name='sortNo1']").length;
    	return count;
    }
    function calculation2(){
        var count = $("input[name='sortNo2']").length;
        return count;
    }
    $(function(){
        $('.delete-value').click(function(){
        	//如果有商品则不删除
        	if(!confirm('你确定要删除此规格吗?')){
        		return false;
        	}
        	var obj = $(this);
        	var id = $(this).data('id');
        	if(id!=''){
        		$.ajax({
        	          url:'${dynamicDomain}/attribute/deleteValue/'+id,
        	          type : 'post',
        	          async : false,
        	          dataType : 'json',
        	          success : function(json) {
        	        	  if(json.result){
        	        		  obj.parent().parent().remove();
        	        	  }
        	        	  winAlert(json.message); 
        	          }
        	      });
        	}else{
        		$(this).parent().parent().remove();
        	}
        });
        $('.create-value1').click(function(){
        	var count = calculation1();
        	if(count>=12){
        		winAlert('子规格不能多于12个');
        		return false;
        	}
            var str = '<tr>'+
                '<td>'+
		            '<input type="hidden" name="objectId1">'+
		            '<input type="text"  name="attributeValue1">'+
		        '</td>'+
		        '<td><input type="text"  name="sortNo1"></td>'+
		        '<td><input type="button" value="删除" class="delete-value"/></td>'+
                '</tr>';
            $(this).parent().parent().before(str);
            $('.delete-value').click(function(){
                $(this).parent().parent().remove();
            });
        });
        
        $('.create-value2').click(function(){
        	var count = calculation2();
            if(count>=12){
                winAlert('子规格不能多于12个');
                return false;
            }
            var str = '<tr>'+
            '<td>'+
                '<input type="hidden" name="objectId2">'+
                '<input type="text"  name="attributeValue2">'+
            '</td>'+
            '<td><input type="text"  name="sortNo2"></td>'+
            '<td><input type="button" value="删除" class="delete-value"/></td>'+
            '</tr>';
        $(this).parent().parent().before(str);
        $('.delete-value').click(function(){
            $(this).parent().parent().remove();
        });
        });
        
        if('${param.result}'=='true'){
            parent.winAlert('操作成功');
            parent.$.colorbox.close();
        }
    });
    function verifiSortNo1(){
    	var sort1 = new Array();
    	 $("input[name='sortNo1']").each(function(){
    		 sort1.push($(this).val());
         });
    	 for(var i=0;i<sort1.length;i++){
    		 if(sort1[i]==''){
    			 winAlert('排序不能为空！');
    			 return false;
    		 }
    		 if(!/^\d+(\.\d)?$/.test(sort1[i])){
    			 winAlert('排序必须输入最多一位小数');
    			 return false;
    		}
    	 }
    	 return true;
    }
    function verifiSortNo2(){
        var sort2 = new Array();
         $("input[name='sortNo2']").each(function(){
             sort2.push($(this).val());
         });
         for(var i=0;i<sort2.length;i++){
             if(sort2[i]==''){
                 winAlert('排序不能为空！');
                 return false;
             }
             if(!/^\d+(\.\d)?$/.test(sort2[i])){
                 winAlert('排序必须输入最多一位小数');
                 return false;
               }
         }
         return true;
    }
    function verification1(){
        var name1 = $("input[name='name1']").val();
        if(name1==''){
            winAlert('规格1名字不能为空！');
            return false;
        }
        var att1 = new Array();
        $("input[name='attributeValue1']").each(function(){
            att1.push($(this).val());
        });
        if(att1.length==0){
            winAlert('必须填写子规格1!');
            return false;
        }
        for(var i=0;i<att1.length;i++){
            if(att1[i]==''){
                winAlert('子规格1不能为空！');
                return false;
            }
            for(var j=i+1;j<att1.length;j++){
                if(att1[i]==att1[j]){
                    winAlert('子规格1不能重复！');
                    return false;
                }
            }
        }
        return true;
    }
    function verification2(){
        var name2 = $("input[name='name2']").val();
        if(name2==''){
            return true;
        }
        var att2 = new Array();
        $("input[name='attributeValue2']").each(function(){
            att2.push($(this).val());
        });
        if(att2.length==0){
            winAlert('必须填写子规格2!');
            return false;
        }
        for(var i=0;i<att2.length;i++){
            if(att2[i]==''){
                winAlert('子规格2不能为空！');
                return false;
            }
            for(var j=i+1;j<att2.length;j++){
                if(att2[i]==att2[j]){
                    winAlert('子规格2不能重复！');
                    return false;
                }
            }
        }
        return true;
    }
    function customeValid(){
    	var flag = verification1()&&verifiSortNo1()&&verification2()&&verifiSortNo2();
    	return flag;
    }
    </script>
</body>
</html>