<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>设置佣金</title>
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
			<h4 class="modal-title">设置佣金</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/brandCommission/saveToPage" class="form-horizontal" id="BrandCommission" >
				<input type="hidden" name="objectId">
				<input type="hidden" name="supplierBrandId" id="supplierBrandId" value="${supplierBrandId}">
				<input type="hidden" name="supplierId" id="supplierId" value="${param.supplierID}">
				<input type="hidden" name="commissionWay" id="commissionWay">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label  for="brandId" class="col-sm-4 control-label"> <input type="radio" name="commissionWays" value="1" checked="checked">按订单总额</label>
								<div class="col-sm-8">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<table class="form-group">
							    <thead>
							    <tr class="col-sm-12 col-md-12">
                                        <th class="col-sm-7"></th>
                                        <th class="col-sm-6">
                                            <label for="percent" class="control-label col-sm-12" >佣金比例</label>
                                        </th> 
                                    </tr>
							    </thead>
                            	<tbody>
                                	<c:forEach var="item" items="${brandCommissions}" varStatus="num">
                                	<tr class="col-sm-12 col-md-12">
                                		<td class="col-sm-3"></td>
                                        <td class="col-sm-3"><input type="hidden" name="commissionId" value="${item.objectId}">
                                        <input type="text" class="search-form-control" name="moneyStart" readonly="readonly" id="moneyStart_${num.index }" value="${item.moneyStart}"></td>
                                        <td class="col-sm-3"><input type="text" class="search-form-control" name="moneyStop" readonly="readonly" id="moneyStop_${num.index }" value="${item.moneyStop}"></td>
                                        <td class="upView">元</td>
                                     	<td><input type="text" class="search-form-control" name="percent" value="${item.percent}"></td>
                                     	<td class="upView">%</td>
                                    </tr>
                                    </c:forEach>
                                    <tr>
                                       <td><button type="button" class="create-value glyphicon glyphicon-plus btn btn-primary pull-right"/></button></td>
                                       <td class="col-sm-1"><button type="button" class="delete-value glyphicon glyphicon-trash btn btn-danger pull-right"/></button></td>
                                   	</tr>
                            	</tbody>
                            </table>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label  for="brandId" class="col-sm-4 control-label"> <input type="radio" name="commissionWays" value="2">按订单数量</label>
								<div class="col-sm-8">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="brandId" class="col-sm-4 control-label">每笔收取</label>
								<div class="col-sm-4">
									<input type="text" class="search-form-control decimal2" name="moneyper" id="moneyper" value="${moneyper}">
								</div>
								<div class="col-sm-1 upView">元</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="editPageButton">
						<button type="button" class="btn btn-primary" onclick="addWays();">
							提交
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="BrandCommission" />
	<script type="text/javascript">
	$(document).ready(function() {
		var val=$("#commissionWay").val();
		if(val==""){
			$("input[name='commissionWays']:eq(0)").attr("checked","checked");
		}else if(val=="1"){
            $("input[name='commissionWays']:eq(0)").attr("checked","checked");
		}else if(val=="2"){
			$("input[name='commissionWays']:eq(0)").removeAttr("checked");
            $("input[name='commissionWays']:eq(1)").attr("checked","checked");
		}
	});
	
	$(function(){
		$('.delete-value').click(function(){
            $(this).parent().parent().prev().remove();
        });
		
        $('.create-value').click(function(){
        	var count = calculation1();
        	if(count==0){
        		var str = '<tr class="col-sm-12 col-md-12">'
    	            +'<td class="col-sm-3">'+'</td> '
                	+'<td class="col-sm-3">'
    	            +'<input type="hidden" name="commissionId">'
    	            +'<input type="text" class="search-form-control" id="moneyStart_0" name="moneyStart" value="0"></td>'
                    +'<td class="col-sm-3"><input type="text" class="search-form-control" id="moneyStop_0" name="moneyStop"></td>'
                    +'<td class="upView">元</td>'
                    +'<td><input type="text" class="search-form-control" name="percent"></td>'
                    +'<td class="upView">%</td>'
                    +'</tr>';
        		$(this).parent().parent().before(str);
        	}else{
        		var lastStart=$(this).parent().parent().prev().find("input[name='moneyStart']").val();
        		var lastStop=$(this).parent().parent().prev().find("input[name='moneyStop']").val();
        		$(this).parent().parent().prev().find("input[name='moneyStop']").attr("readonly","readonly");
        		if(lastStop==""){
        			alert("该行的金额结束不能为空");
        			return false;
        		}else if(parseInt(lastStart,10)>=parseInt(lastStop,10)){
        			alert("结束金额不能小于开始金额");
        			return false;
        		}
        		var str = '<tr class="col-sm-12 col-md-12">'
    	            +'<td class="col-sm-3">'
    	            +'</td> '
                	+'<td class="col-sm-3">'
                	+'<input type="hidden" name="commissionId">'
    	            +'<input type="text" class="search-form-control" readonly="readonly" name="moneyStart"  value="'+lastStop+'"></td>'
                    +'<td class="col-sm-3"><input type="text" class="search-form-control" name="moneyStop"></td>'
                    +'<td class="upView">元</td>'
                    +'<td><input type="text" class="search-form-control" name="percent"></td>'
                    +'<td class="upView">%</td>'
                    +'</tr>';
                $(this).parent().parent().before(str);
        	}
    	});
    });
	
	function calculation1(){
    	var count = $("input[name='percent']").length;
    	return count;
    }
	
	function verifyMoney(){
    	var start = new Array();
    	var end = new Array();
    	var per = new Array();
    	 $("input[name='moneyStart']").each(function(){
    		 start.push($(this).val());
         });
    	 $("input[name='moneyStop']").each(function(){
    		 end.push($(this).val());
         });
    	 $("input[name='percent']").each(function(){
    		 per.push($(this).val());
         });
    	 for(var i=0;i<start.length;i++){
    		 if(start[i]=='' || end[i]==''){
    			 alert('总额范围不能为空');
    			 return false;
    		 }
    		 if(per[i]==''){
    			alert('百分比不能为空');
	    		return false;
    		 }
    		 if(parseInt(start[i],10)>=parseInt(end[i])){
    			 var j=Number(i)+1;
    			 alert('新增的第'+j+'行结束金额不能小于或等于开始金额');
    			 return false;
    		 }
    		 
    	 }
    	 return true;
    }
	
	function addWays(){
		var radio = $("input[type='radio'][name='commissionWays']:checked").val();
		if(radio=="1"){
			var count = calculation1();
	    	if(count==0){
	    		alert('佣金比例不能为空');
	    		return false;
	    	}else{
	    		var flag = verifyMoney();
	    		if(flag==true){
	    			$('#commissionWay').val(radio);
	    			if(confirm("您确定提交吗？")){
	    	   			$.ajax({  
	    	   			    url:"${dynamicDomain}/brandCommission/saveToPage",
	    	   				type : 'post',
	    	   				data : $('#BrandCommission').serialize(),
	    	   				dataType : 'json',
	    	   				success : function(msg) {
	    	   					if(msg.result==true){
	    	   						var url="${dynamicDomain}/supplier/edit/"+$("#supplierId").val()+"?message=操作成功";
			   						window.parent.location.href=url;
	    	   					}
	    	   				}
	    	   			});
	    	   		}	 
	    		}
	    	}
		}else{
			var per=$('#moneyper').val();
			if(per==""){
				alert('每笔收取不能为空');
	    		return false;
			}else{
				$('#commissionWay').val(radio);
				if(confirm("您确定提交吗？")){
		   			$.ajax({  
		   			    url:"${dynamicDomain}/brandCommission/saveToPage",
		   				type : 'post',
		   				data : $('#BrandCommission').serialize(),
		   				dataType : 'json',
		   				success : function(msg) {
		   					if(msg.result==true){
		   						var url="${dynamicDomain}/supplier/edit/"+$("#supplierId").val()+"?message=操作成功";
		   						window.parent.location.href=url;
		   					}
		   				}
		   			});
		   		}	 
			}
		}
	}
	</script>
</body>
</html>