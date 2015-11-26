<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>卡密预生成</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/cardCreateInfo/saveToPage" id="CardCreateInfo">
			<!-- <input type="hidden" name="createUser" value="admin"> -->
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="itemName"  class="col-sm-4 control-label">项目大类</label>
								<div class="col-sm-8">
									<select name="bigItems" class="search-form-control"  id="bigItems">
										<!-- <option value="">全部</option> -->
										<jdf:selectCollection items="bigItems" optionValue="objectId"  optionText="itemName" />
									</select>
								</div>	
							</div>
						</div>
					</div>	
					<div class="row">
						<div class="col-sm-6  col-md-6">
							<div class="form-group">
								<label for="subItems" class="col-sm-4 control-label">项目分类</label>
								<div class="col-sm-8">
									<select name="subItems"  id="subItems" class="search-form-control">
										<!-- <option value="">全部</option> -->
									</select>
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
									<label class="col-sm-4 control-label">选择套餐<span class="not-null">*：</span></label>
								 
									<div class="col-sm-6">
											<input type ="hidden" name="packageId" id="hiddenPackageId"/>
											<input type ="hidden" name="availableCount" id="availableCount"/>
											<input type="text" class="search-form-control" id="packageName" name="packageName" onchange="renewDate(this)" readonly="readonly">
											<span for="packageId" generated="true" class="error"></span> 
									</div>
									<div class="col-sm-2">
										<button type="button" id="selectPackage" class="btn btn-primary">选择</button>
										<!-- 
										<a href="/w-admin/cardCreateInfo/packageList?ajax=1" 											 
											id="enterprise-btn" 
											class="pull-left btn btn-primary colorbox-template cboxElement">选择</a>
										-->	
									</div>
									<!-- -
									<select name="packageId" onchange="renewDate(this)"  id="packageId" class="search-form-control">
										<option value=""></option>
									</select>
									-->
								 
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cardAmount" class="col-sm-4 control-label">生成数量<span class="not-null">*：</span></label>
								<div class="col-sm-8">
									<input type="number" max="1000" min="1" data-holdNum="-1" data-leftNum="-1" class="search-form-control" name="cardAmount" id="cardAmount">
								</div>	 
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<!-- 
							
							<div class="form-group">
								<label for="startDate" class="col-sm-4 control-label">有效期</label>
								<div class="col-sm-4">
									<input   name="startDate"  type="text" id="startDateId" onClick="WdatePicker({readOnly:true,maxDate:'#F{$dp.$D(\'startDateId\',{d:-1});}'})" class="search-form-control"/>
								</div>
								<div class="col-sm-4">
									<input  name="endDate"  type="text"  id="endDateId"   onClick="WdatePicker({readOnly:true,minDate:'#F{$dp.$D(\'endDateId\',{d:1});}'})" class="search-form-control"/>
								</div>	
							</div>
							
							-->
							<div class="form-group">
								<label for="startDate" class="col-sm-4 control-label">有效期</label>
								<div class="col-sm-4">
									<input   name="startDate"  type="text" id="startDateId"  readonly class="search-form-control"/>
								</div>
								<div class="col-sm-4">
									<input  name="endDate"  type="text"  id="endDateId"  readonly class="search-form-control"/>
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label class="col-sm-4 control-label">备注：</label>
								<div class="col-sm-8">
									<textarea  name="remark"   class="search-form-control" maxlength="250" rows="10"  cols="100"></textarea>
								</div>	
							</div>
						</div>
					</div>
				</div>
					
				<div class="box-footer"> 
					<div class="row">
						<div class="editPageButton">
							<button type="button" class="btn btn-primary submit-btn" id="creatCardsBtn">提交</button>
				              <button type="button" class="btn btn-primary" onclick="location.href='cardCreateInfopage'">取消</button>
						</div>
					</div>
				</div>
					</form>
	</jdf:form>
	</div>
	<!--
	<jdf:bootstrapDomainValidate domain="CardCreateInfo" />
	-->
	<script type="text/javascript">
	
	function chckFiled(){
		return true;
	}
	
		function renewDate(obj){
			
			var startDateVal = $(obj).find('option:selected').attr('data-startDate');
			var endDateVal = $(obj).find('option:selected').attr('data-endDate');
			
			$('#startDateId').val(startDateVal);	
			$('#endDateId').val(endDateVal);	
			
		}
		
		var itemIdStr = "";
		
		$(document).ready(function () {	
			
			$("#selectPackage").click(function () {	
				
				var bigItemId = $('select[name="bigItems"]').val(); 
            	var subItemId = $('select[name="subItems"]').val();
            	if(!subItemId){
            		alert('本项目大类下没有项目分类，无法选择套餐');
            		return ;
            	}
            	
	 			$.colorbox({
	 				opacity : 0.2,
	 				href:   "${dynamicDomain}/cardCreateInfo/queryPackageList?ajax=1&init=1&bigItemId="+bigItemId+"&subItemId="+subItemId,
	                fixed : true,
	                width : "80%",
	                height : "90%",
	                iframe : true,
	                onClosed : function() {

	                },
	                overlayClose : false
	 			});
	 			
		     });
			
			
			$('#creatCardsBtn').click(function(){				
				var target = $('input[name="cardAmount"]');
				var cardNum = target.val();
				
				var packageId = $('#hiddenPackageId').val();
				if(!packageId){
					alert('请先选择套餐');
					return ;
				}
				var ret = /^\d+$/.test(cardNum);
				if(!ret){
					alert('生成数量必须是数字');
					return ;
				}
				cardNum = parseInt(cardNum);
				
				//var max = parseInt(target.attr('data-holdNum'));
				var max = parseInt(target.attr('data-leftNum'));
				if(!cardNum){
					alert('请输入生成数量');
					return ;
				}				
				if(cardNum>max){
					alert('数量不能超过实际库存：'+max);
					return ;
				}
				if(cardNum<1){
					alert('数量不能为0');
					return ;
				}
				
				
				$('form#CardCreateInfo').submit();
				$(this).prop('disabled',true);
				
			});
			
	        //一级下拉联动二级下拉
	        $("#bigItems").change(function () {
	        	selectBigItem(); 
			}); 
	       
	        $("#bigItems").trigger('change');
	        
	        
	        
	        $('select[name="subItems"]').change(function(){
	        	itemIdStr = $(this).val();  
	        });
	        
	        
			function selectBigItem(){  
            	var bigItemId = $('select[name="bigItems"]').val(); 
            	 
            	$.ajax({
           			//url: "${dynamicDomain}/cardCreateInfo/getSecondMenu/"+bigItemId,
           			url: "${dynamicDomain}/cardCreateInfo/getSecondMenu2",
           			type : 'post',
           			dataType : 'json',
           			data:{parentItemId:bigItemId},
           			success :function (data) {
           			  data = data.secondItems;
           			  var target = $("#subItems");
           			  //var str = '<option value="-1">全部</option>';
           			  var str = ''; 
           			  itemIdStr = '';
           			  for(var i=0;data && data.length && i<data.length;i++){
           				   var obj = data[i];
           				   str +=  '<option value="' +obj.objectId+'">' + obj.itemName +'</option>';
           				   if(!itemIdStr){
           						itemIdStr += obj.objectId;
           				   }else{
           						itemIdStr += ',' + obj.objectId;
           				   } 
           			  }
           			  target.html(str);
           			  
           			}
      	 		});
	        }
	        
	        function renderWelFarePackage(){
	        	
	        	$('#startDateId').val('');
	        	$('#endDateId').val('');
	        	
	        	$('select[name="packageId"]').empty();
            	
	        	$('select[name="packageId"]').append($("<option/>").text("--请选择--").attr("value","-1"));
            	
            	var bigItems = $('select[name="bigItems"]').val();
            	var subItems = $('select[name="subItems"]').val();
            	
            	$.ajax({
           			url: "${dynamicDomain}/welfarePackage/getWelfarePackageByCondition",
           			data:{
           					bigItemId:bigItems,
           					subItemId:subItems
           			},
           			type : 'post',
           			dataType : 'json',
           			success :function (data) {
           			  data = data.welfareList;
           			  for(var i=0;i<data.length && i<data.length;i++){
           				   var obj = data[i];
           				   var d1 = new Date(obj.startDate.time).format('yyyy-MM-dd');
           				   var d2 = new Date(obj.endDate.time).format('yyyy-MM-dd');
                           $('select[name="packageId"]').append("<option value='" +obj.objectId + "' data-startDate='" + d1 + "' data-endDate='" + d2  +"'>" + obj.packageName+"</option>");
           			  }
           			  
           			}
      	 		});
	        }
	        
	        
	        
	});
	</script>
</body>
</html>