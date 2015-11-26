<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/simple_header.jsp"%>
<title>编辑属性</title>
<jdf:themeFile file="css/bootstrap.min.css" />
<jdf:themeFile file="css/jquery-ui-1.10.0.custom.min.css" />
<jdf:themeFile file="css/colorbox.css" />
<jdf:themeFile file="css/font-awesome.min.css" />
<jdf:themeFile file="css/AdminLTE.min.css" />
<jdf:themeFile file="css/morris.css" />
<jdf:themeFile file="css/daterangepicker-bs3.css" />
<jdf:themeFile file="css/skins/skin-blue.min.css" />
<jdf:themeFile file="css/jquery-jvectormap-1.2.2.css" />
<%-- <jdf:themeFile file="css/font-awesome.min.css" /> --%>
<jdf:themeFile file="css/ionicons.min.css" />
<jdf:themeFile file="css/dataTables.bootstrap.css" />
<jdf:themeFile file="css/extremecomponents.css" />
<jdf:themeFile file="css/skins/WdatePicker.css" />
<jdf:themeFile file="css/common.css" />
<jdf:themeFile file="css/zTree.css" />
<jdf:themeFile file="jquery-1.8.2.min.js" />
<jdf:themeFile file="jquery.metadata.js" />
<jdf:themeFile file="jquery.validate.min.js" />
<jdf:themeFile file="additional-methods.js" />
<jdf:themeFile file="jquery.validate_zh.js" />
<jdf:themeFile file="jquery.ztree.core-3.5.js" />
<jdf:themeFile file="jquery.ztree.excheck-3.5.js" />
<jdf:themeFile file="jquery.ztree.exedit-3.5.js" />
<jdf:themeFile file="jquery.alert.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">福利商城三级分类
				<c:choose>
	                <c:when test="${entity.objectId eq null }">—新增</c:when>
	                <c:otherwise>—修改</c:otherwise>
	            </c:choose>
			</h4>
		</div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/productMallCategory/save" class="form-horizontal" id="myForm">
				<input type="hidden" name="objectId"> 
				<input type="hidden" name="firstId"> 
				<input type="hidden" name="secondId">
				<input type="hidden" name="thirdId"> 
				<input type="hidden" name="layer" value=3> 
				<input type="hidden" name="selelctedIds" id="selelctedIds">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="thirdId" class="col-sm-2 control-label">三级分类编号</label>
								<span class="lable-span">${entity.thirdId}</span>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="name" class="col-sm-2 control-label">三级分类名称</label>
								<div class="col-sm-6">
									<input type="text" class="search-form-control" name="name" maxlength="50">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="sortNo" class="col-sm-2 control-label">排序</label>
								<div class="col-sm-6">
									<input type="text" class="sortNoVerify search-form-control" name="sortNo">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="status" class="col-sm-2 control-label">所属平台</label>
								<div class="col-sm-6">
									<span class="lable-span"><jdf:dictionaryName dictionaryId="1114" value="${firstProductMallCategory.platform }"/></span>
								</div>
							</div>
						</div>
					</div>
					
					<div class="row">
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="status" class="col-sm-2 control-label">状态</label>
								<div class="col-sm-6">
									<jdf:radio dictionaryId="111" name="status"/>
								</div>
								<script type="text/javascript">
									//新增时不能无效
									<c:if test="${empty entity.objectId}">
									$($("[name='status']")[1]).parent().hide();
									</c:if>
								</script>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-10 col-md-10">
							<div class="form-group">
								<label for="search" class="col-sm-2 control-label">运营分类名称</label>
								<div class="col-sm-4">
									<input type="text" id="search" class="search-form-control">
								</div>
								<div class="col-sm-2">
									<button type="button" class="btn btn-primary" onclick="doSearch()">
										<span class="glyphicon glyphicon-search"></span>搜索
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5 col-md-5">
							<div class="form-group">
								<label class="col-sm-4 control-label">未选择列表</label>
							</div>
						</div>
						<div class="col-sm-2 col-md-2">
						</div>
						<div class="col-sm-5 col-md-5">
							<div class="form-group">
								<label class="col-sm-4 control-label">已选择列表</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5 col-md-5">
							<ul id="leftTree" class="ztree form-group" style="height: 300px;border: 1px solid grey;margin-left: 30px;"></ul>
						</div>
						<div class="col-sm-2 col-md-2">
							<div style="vertical-align: middle;margin-top: 50px;text-align: center;">
								<button type="button" class="btn btn-default" onclick="addRole()">>></button><br><br>
								<button type="button" class="btn btn-default" onclick="delRole()"><<</button>
							</div>
						</div>
						<div class="col-sm-5 col-md-5">
							<ul id="rightTree" class="ztree" style="height: 300px;border: 1px solid grey;margin-right: 30px;"></ul>
						</div>
					</div>
					<script type="text/javascript">
						var setting = {
							view : {
								expandSpeed : "",
								fontCss: getFontCss
							},			
							check : {
								enable : true
							},
							data : {
								simpleData : {
									enable : true
								}
							}
						};
					
						
						//数据右移动
						function addRole() {
							leftTree = $.fn.zTree.getZTreeObj("leftTree");
							rightTree = $.fn.zTree.getZTreeObj("rightTree");
							//移动方法
							//右移时leftTree 在第一个参数,rightTree第二个参数
							//表示leftTree移动致rightTree
							moveTreeNode(leftTree, rightTree);
						}
					
						//数据左移动
						function delRole() {
							leftTree = $.fn.zTree.getZTreeObj("leftTree");
							rightTree = $.fn.zTree.getZTreeObj("rightTree");
							//移动方法 参数相反
							moveTreeNode(rightTree, leftTree);
						}
						
						function getTopNode(node){
							if(node.getParentNode==null){
								return node;
							}else{
								return getTopNode(node.getParentNode);
							}
						}
					
						function moveFromTop(node,leftTree, rightTree){
							var children = node.children;
							var checkStatus = node.getCheckStatus();
							//刷新
							//if(checkStatus.checked){
								zTreeDataAddNode(node,rightTree);
							//}
							//半选中的不删除
							if(!checkStatus.half){
								zTreeDataDelete(node, leftTree);
							}
							if(children!=null && children.length>0){
								for ( var i = children.length- 1; i >=0  ; i--) {
									checkStatus = children[i].getCheckStatus();
									if(checkStatus.checked){
										moveFromTop(children[i], leftTree ,rightTree);
									}
								}
							}
						}
						
						function moveTreeNode(leftTree, rightTree) {
							var nodes = leftTree.getCheckedNodes(); //获取选中需要移动的数据
							for ( var i = nodes.length- 1; i >=0  ; i--) { //把选中的数据从根开始一条一条往右添加
								var node = nodes[i];
								//根节点开始移动
								if(node.pId==null){
									moveFromTop(node, leftTree, rightTree);
								}
							}
							//把选中状态改为未选择
							leftTree.checkAllNodes(false);
						}
					
						function move(node,rightTree){
							//移动父节点
							if(node!=null){
								if(node.pId!=null){
									move(node.getParentNode(),rightTree);
								}
								zTreeDataAddNode(node,rightTree);
							}
						}
						
						//树数据移动方法
						function zTreeDataAddNode(node, rightTree) {
							var nodes = rightTree.transformToArray(rightTree.getNodes());//获取需要添加数据的树下面所有节点数据
							var newNode = {id:node.id,pId:node.pId,name:node.name};
							if (nodes.length > 0 || node.pId !=null) {
								//这个循环判断是否已经存在,true表示不存在可以添加,false存在不能添加
								var isadd = true;
								for ( var j = 0; j < nodes.length; j++) {
									if (node.id == nodes[j].id) {
										isadd = false;
										break;
									}
								}
								//找到父亲节点
								var i = 0;
								var flag = false;
								for (i; i < nodes.length; i++) {
									if (node.pId == nodes[i].id) {
										flag = true;
										break;
									}
								}
					
								//同时满足两个条件就加进去,就是加到父亲节点下面去
								if (flag && isadd) {
									rightTree.addNodes(nodes[i], newNode);
								} else if (isadd) {
									//如果rightTree 里面找不到,也找不到父亲节点.就把自己作为一个根add进去
									rightTree.addNodes(null, newNode);
								}
							} else {
								//树没任何数据时,第一个被加进来的元素
								rightTree.addNodes(null, newNode);
							}
						}
					
						//数据移除
						function zTreeDataDelete(node,leftTree) {
							leftTree.removeNode(node);
						}
					
						//zTree说明:
						//这里没有样式之类的东西,需要看到还需要引人几个css 和 imp 之类的东西.
						//可以去看zTree的demo 和 API
					
						var leftNodes =${leftNodes};
						var rightNodes =${rightNodes};
						//初始化方法
						$(document).ready(function() {
							$.fn.zTree.init($("#leftTree"), setting, leftNodes);
							$.fn.zTree.init($("#rightTree"), setting, rightNodes);
							//树1 数据 生成
							leftTree = $.fn.zTree.getZTreeObj("leftTree");
							rightTree = $.fn.zTree.getZTreeObj("rightTree");
							leftTree.expandAll(true);
							rightTree.expandAll(true);
							leftTree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps"};
						});
						
						var nodeList;
						function doSearch(){
							updateNodes(false);
							var key = $("#search").val();
							if(key!=""){
								nodeList = leftTree.getNodesByParamFuzzy("name", key);
								updateNodes(true);
							}
						}
						
						function updateNodes(highlight) {
							if(nodeList){
								var zTree = $.fn.zTree.getZTreeObj("leftTree");
								for( var i=0, l=nodeList.length; i<l; i++) {
									nodeList[i].highlight = highlight;
									zTree.updateNode(nodeList[i]);
								}
							}
						}
						
						function getFontCss(treeId, treeNode) {
							return (!!treeNode.highlight) ? {color:"#A60000", "font-weight":"bold"} : {color:"#333", "font-weight":"normal"};
						}
					
						$("#search").bind("keypress",function(event){
							event = event ? event :(window.event ? window.event : null);
							if(event.keyCode==13){
								event.keyCode=9; 
								doSearch();
								return false;
							}
						});
					</script>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" onclick="save();" class="btn btn-primary">确定</button>
							<a href="${dynamicDomain}/productMallCategory/thirdpage?search_EQL_secondId=${secondId}&firstId=${firstId}&name=${name}&platform=${platform}" class="btn btn-primary">返回</a>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="ProductMallCategory" />
	<script type="text/javascript">
	function save() {
		rightTree = $.fn.zTree.getZTreeObj("rightTree");
		var nodes = rightTree.transformToArray(rightTree.getNodes()); //获取需要添加数据的树下面所有节点数据

		//如果有多个数据需要遍历,找到strs 属于那个父亲节点下面的元素.然后把自己添加进去
		var values = "";
		if (nodes.length > 0) {
			//这个循环判断是否已经存在,true表示不存在可以添加,false存在不能添加
			for ( var j = 0; j < nodes.length; j++) {
				var node = nodes[j];
				if(node.children==null || node.children.length==0){
					values += node.id + ",";
				}
				
			}
		}
		if(values.length==0){
			winAlert("请至少选择一个分类");
			return false;
		}
		$("#selelctedIds").val(values);
		$("#myForm").submit();
	}
	</script>
</body>
</html>