<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>企业信息</title>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				企业信息
			</h4>
		</div>
	</div>
	<jdf:form bean="request" scope="request">
			<form action="${dynamicDomain}/company/innerCompany?ajax=1" method="post" class="form-horizontal">
			 <input type="hidden" name="inputName" value="${inputName }">	
				<div class="box-body">
					<div class="row">
						<div class="col-sm-4 col-md-4">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="search_LIKES_companyName" class="form-lable">企业名称：</label>
								</div>
								<input type="text" class="search-form-control"
									name="search_LIKES_companyName">
							</div>
						</div>
					</div>
				</div>
				<div class="box-footer">
                    <div class="pull-left">
                      <button type="button" class="btn btn-primary" id="selectCompany">
                                                                                    选择
                      </button>
                    </div>
					<div class="pull-right">
							<button type="button" class="btn" onclick="clearForm(this)">
								<i class="icon-remove icon-white"></i>重置
							</button>
						<button type="submit" class="btn btn-primary">查询
						</button>
					</div>
				</div>
			</form>
		</jdf:form>
	<div>
		<jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit"
			sortRowsCallback="limit" action="innerCompany?ajax=1">
			<jdf:row>
				<jdf:column alias="common.lable.operate" title="<input type='checkbox' style='margin-left:9px;;' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;">
					<input type="checkbox" name="checkid" id="checkid" value="${currentRowObject.objectId}">
				</jdf:column>
				<jdf:column property="rowcount" cell="rowCount" title="序号" headerStyle="width: 4%" style="text-align:center" sortable="false" />
				<jdf:column property="companyName" title="企业名称" headerStyle="width:20%;" >
					<div class="text-ellipsis" style="width: 120px;" title="${currentRowObject.companyName}">
					${currentRowObject.companyName}</div>
				</jdf:column>
				<jdf:column property="linker" title="联系人" headerStyle="width:20%;" />
			</jdf:row>
		</jdf:table>
	</div>
	<script type="text/javascript">
	$("#checkall").click( 
			function(){ 
				if(this.checked){ 
					$("input[name='checkid']").each(function(){this.checked=true;}); 
				}else{ 
					$("input[name='checkid']").each(function(){this.checked=false;});
				} 
		});
		$("#checkid").click(function(){ 
			$("#checkall").attr("checked",false);	
		});
		
		//选择
		$("#selectCompany").click(function(){ 
	        var id="";
		 	if($("input[type='checkbox'][name='checkid']").is(':checked')){
				$("input[name='checkid']:checked").each(function(){
					id+=this.value+",";
				}); 
				var ids=id.substring(0,id.lastIndexOf(","));
				if(ids!=""){
					$(window.parent.document).find("input[name='${inputName}Id']").val(ids);
				}else{
					$(window.parent.document).find("input[name='${inputName}Id']").val(companyId);
				}
				$.ajax({
	                url:"${dynamicDomain}/supplier/getInnerCompany/" + ids,
	                type : 'post',
	                dataType : 'json',
	                success : function(json) {
	                	$(window.parent.document).find("input[name='${inputName}Name']").val(json.result);
	                	parent.$.colorbox.close();
	                }
	            });
			}else{
				alert("请勾选企业");
			} 
		});
	
	function setCompany(companyId,companyName){
		var names=$(window.parent.document).find("input[name='${inputName}Name']").val();
		if(names!=""){
			names=names+","+companyName;
			$(window.parent.document).find("input[name='${inputName}Name']").val(names);
		}else{
			$(window.parent.document).find("input[name='${inputName}Name']").val(companyName);
		}
		var ids=$(window.parent.document).find("input[name='${inputName}Id']").val();
		if(ids!=""){
			ids=ids+","+companyId;
			$(window.parent.document).find("input[name='${inputName}Id']").val(ids);
		}else{
			$(window.parent.document).find("input[name='${inputName}Id']").val(companyId);
		}
		parent.$.colorbox.close();
	}
	</script>
</body>
</html>