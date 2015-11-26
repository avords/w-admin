<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检项目报价审核</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				体检项目报价审核
			</h4>
		</div>
		<jdf:form bean="request"  scope="request">
			<form action="${dynamicDomain}/physicalAudited/auditedPage" method="post"  id="physicaAudited" class="form-horizontal">
				<input type="hidden" name="objectIdArray" id="objectIdArray">
				<input type="hidden" name="rejectReason" id="rejectReason">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">供应商：</label>
								<div class="col-sm-8">
									<select name="search_EQI_supplierId" class="search-form-control"  id="supplierName">
										<option value=""></option>
										<jdf:selectCollection items="supplierList" optionValue="objectId"  optionText="supplierName" />
									</select>
									<!-- 
									<input type="text"  name="search_LIKES_supplierName" class="search-form-control"  id="supplierName">
									 -->
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">一级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_firstItemName" class="search-form-control"  id="firstItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">二级项目：</label>
								<div class="col-sm-8">
									<input type="text"  name="search_LIKES_secondItemName" class="search-form-control"  id="secondItemName">
								</div>	
							</div>
						</div>
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_status"  id="status" class="search-form-control">										
										<option value="">全部</option>
										<jdf:select dictionaryId="111" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-3 col-md-3">
							<div class="form-group">
								<label class="col-sm-4 control-label">审核状态：</label>
								<div class="col-sm-8">
									<select name="search_EQL_auditStatus"  id="auditStatus" class="search-form-control">
										<option value="">全部</option>
										<jdf:select dictionaryId="1605" valid="true" />
									</select>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
				 <!-- 
				 <a href="${dynamicDomain}/physicalPrice/create" class=" pull-left">
						<button type="button" class="btn btn-primary">
							<span class="glyphicon glyphicon-plus"></span>
						</button>
					</a>				 
				  -->
					
					<div class="pull-left">
						<button type="button" class="btn btn-primary" onclick="audited(2);">审核通过</button>
						 
						<button type="button" class="btn btn-primary" onclick="checkBeforeBox();">审核不通过</button>
						 
					</div>
					<div style="display: none">
						<div  id="reject_content" >
							<div class="callout callout-info">
								<h4 class="modal-title">不通过原因</h4>
							</div>
							<div class="box-body">
							<div class="row" >
								<div class="col-sm-12 col-md-12">
									<div class="form-group">
											<label  class="col-sm-4 control-label">不通过原因:</label>
										<div class="col-sm-8">
											<textarea  class="search-form-control"  name="reason"  id="reason" rows="6" cols="10" ></textarea>
										</div>
									</div>
								</div>	
							</div>
							 </div>
							<div class="editPageButton">
								<button type="button"  onclick="confirm(3)" class="btn btn-primary">确定</button>
							</div>
						</div>
					</div>
					
					<div class="pull-right">
						<button type="button" class="btn" onclick="clearForm(this)">
							<i class="icon-remove icon-white"></i>重置
						</button>
						<button type="submit" class="btn btn-primary">查询</button>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>

	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit"  filterRowsCallback="limit"
			sortRowsCallback="limit" action="${dynamicDomain}/physicalAudited/auditedPage">
			<jdf:export view="csv" fileName="physicaAudited.csv" tooltip="Export CSV"  imageName="csv" />
			<jdf:export view="xls" fileName="physicaAudited.xls" tooltip="Export EXCEL"  imageName="xls" />
			<jdf:row>
				<jdf:column property="objectId" title="<input type='checkbox' class='noBorder' name='pchk' onclick='pchkClick()'/>"
							style="width: 5%;text-align: center;" headerStyle="width: 4%;text-align: center;" viewsAllowed="html" sortable="false">
							<input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${currentRowObject.objectId}" />
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" style="width:5%;text-align:center" sortable="false"/>
				<jdf:column property="auditStatus" title="审核状态"  style="width:7%">
					<jdf:columnValue dictionaryId="1605" value="${currentRowObject.auditStatus}" />
				</jdf:column>
				<jdf:column property="supplierName" title="供应商" style="width:10%" />
				<jdf:column property="firstItemName" title="一级项目" style="width:10%">
					 
					<a style="font-size: 14px" href="${dynamicDomain}/physicalPrice/edit/${currentRowObject.objectId}?readonly=1">${currentRowObject.firstItemName}</a>
					 
				</jdf:column>
				<jdf:column property="secondItemName" title="二级项目" style="width:15%" >
					 
					<a style="font-size: 14px" href="${dynamicDomain}/physicalPrice/edit/${currentRowObject.objectId}?readonly=1">${currentRowObject.secondItemName}</a>
					 
				</jdf:column>
				<jdf:column property="supplierPrice" title="供货价" style="width:5%" >
					 
				</jdf:column>
				<jdf:column property="marketPrice" title="门市价" style="width:5%" >
				</jdf:column>
				<jdf:column property="status" title="状态"  style="width:5%">
					<jdf:columnValue dictionaryId="111" value="${currentRowObject.status}" />
				</jdf:column>
				<jdf:column property="updatedBy" title="修改人"  style="width:5%"  />
				<jdf:column property="updatedOn" title="修改时间"  style="width:15%"  >
					<fmt:formatDate value="${currentRowObject.updatedOn }" pattern=" yyyy-MM-dd  HH:mm"/>
				</jdf:column>
			</jdf:row>
		</jdf:table>
	</div>
	
	
	<script type="text/javascript">
			$(document).ready(function(){
				//$("#reject").colorbox(
						//{width:"40%",height : "40%",href:"#reject_content",inline:true});
			});
			
			function checkBeforeBox(){			
				var itemArr  =  getCheckedValuesString(document.getElementsByName("schk"))
				if(!itemArr){
					alert('请选择记录！');
					return ;
				}	
				$.colorbox({width:"50%",height : "50%",href:"#reject_content",inline:true});
			}
			
			function confirm(auditedStatus){
				$("#physicaAudited").attr("action","${dynamicDomain}/physicalAudited/auditedToPage/"+auditedStatus) ;
				$("#rejectReason").val($("#reason").val());
				//alert($("#reason").val());
				var itemArr  =  getCheckedValuesString(document.getElementsByName("schk"));
				if(!itemArr){
					alert('请选择记录！');
					return ;
				}
				if(!$('#reason').val()){
					alert('请输入原因！');
					return ;
				}
				$("#objectIdArray").val(itemArr);
				var objectIds = $("#objectIdArray").val();
				if(!checkStatus(objectIds)){
					 alert("所选项目中有非待审核状态，不能进行审核操作！");
					 return ;
				}
				$("#physicaAudited").submit();
			}
			
			function audited(auditedStatus){
				$("#physicaAudited").attr("action","${dynamicDomain}/physicalAudited/auditedToPage/"+auditedStatus) ;
				var itemArr  =  getCheckedValuesString(document.getElementsByName("schk"));
				if(!itemArr){
					alert('请选择记录！');
					return ;
				}
				
				$("#objectIdArray").val(itemArr);
				var objectIds = $("#objectIdArray").val();
				if(!checkStatus(objectIds)){
					 alert("所选项目中有非待审核状态，不能进行审核操作！");
					 return;
				}
				$("#physicaAudited").submit();
			}
			
			function checkStatus(objectIds){
				var flag = true;
				$.ajax({
	    			url: "${dynamicDomain}/physicalAudited/getStatus?objectIds="+objectIds,
	    			async : false,		
	    			type : 'post',
	    			dataType : 'json',
	    			success :function (data) {
	    			  if(data.flag != 1){
	    				  flag=false;
	    			  }
	    			}
	    		});
				return flag;
			}
	</script>
</body>
</html>