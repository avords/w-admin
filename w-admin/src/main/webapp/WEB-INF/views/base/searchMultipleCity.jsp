<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>编辑属性</title>
<jdf:themeFile file="css/zTree.css" />
<jdf:themeFile file="jquery-1.8.2.min.js" />
<jdf:themeFile file="jquery.ztree.core-3.5.js" />
<jdf:themeFile file="jquery.ztree.excheck-3.5.js" />
<jdf:themeFile file="jquery.ztree.exedit-3.5.js" />
<script type="text/javascript">
	var setting = {
		view : {
			expandSpeed : ""
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
		var leftTree = null,rightTree = null;
		try{
			leftTree = $.fn.zTree.getZTreeObj("leftTree");
			rightTree = $.fn.zTree.getZTreeObj("rightTree");
		}catch(ex){
			//window.console&&console.log(ex);
		}
		
		//移动方法
		//右移时leftTree 在第一个参数,rightTree第二个参数
		//表示leftTree移动致rightTree
		if(rightTree&&leftTree)
			moveTreeNode(leftTree, rightTree);
	}

	//数据左移动
	function delRole() {
		var leftTree = null,rightTree = null;
		try{
			leftTree = $.fn.zTree.getZTreeObj("leftTree");
			rightTree = $.fn.zTree.getZTreeObj("rightTree");
		}catch(ex){
			//window.console&&console.log(ex);
		}
		
		//移动方法 参数相反
		if(rightTree &&leftTree)
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
			for(var i= children.length-1;i >=0 ;i--){
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
	var leftNodes = [<c:forEach items="${leftCities}" var="left" varStatus="status">{"id":${left.objectId},"pId":"${left.parentId}","name":"${left.name}","open":false}<c:if test="${!status.last}">,</c:if></c:forEach>];
	var rightNodes = [<c:forEach items="${rightCities}" var="left" varStatus="status">{"id":${left.objectId},"pId":"${left.parentId}","name":"${left.name}","open":false}<c:if test="${!status.last}">,</c:if></c:forEach>];
	//初始化方法
	$(document).ready(function() {
		try{
			$.fn.zTree.init($("#leftTree"), setting, leftNodes);
			$.fn.zTree.init($("#rightTree"), setting, rightNodes);
			//树1 数据 生成
			leftTree = $.fn.zTree.getZTreeObj("leftTree");
			leftTree.expandAll(false);
			leftTree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps"};
		}catch(ex){
			//window.console && console.log(ex);
		}
	});

	function getData() {
		var rightTree = null;
		try{
			rightTree = $.fn.zTree.getZTreeObj("rightTree");
		}catch(ex){
			//window.console&&console.log(ex);
		}
		if(!rightTree){
			//window.console&&console.log('rightTree is null.');
			return false;
		}
		var nodes = rightTree.transformToArray(rightTree.getNodes()); //获取需要添加数据的树下面所有节点数据

		//如果有多个数据需要遍历,找到strs 属于那个父亲节点下面的元素.然后把自己添加进去
		var ids = "";
		var names = "";
		if (nodes.length > 0) {
			//这个循环判断是否已经存在,true表示不存在可以添加,false存在不能添加
			for ( var j = 0; j < nodes.length; j++) {
				var node = nodes[j];
				if(node.children==null || node.children.length==0){
					ids += node.id + ",";
					names += node.name + ",";
				}
				
			}
		}
		
		var id = "${param.areaIds}";
		var name = "${param.areaNames}";
		if(id==""){
			id="areaIds";
		}
		if(name==""){
			name = "areaNames";
		}
		parent.$("#" + id).val(ids);
		parent.$("#" + name).val(names);
		parent.$.colorbox.close();
	}
</script>
</head>
<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				选择区域
			</h4>
		</div>
		<div class="box-body">
			<div class="row">
				<div class="col-sm-5 col-md-5">未选择列表</div>
				<div class="col-sm-2 col-md-2"></div>
				<div class="col-sm-5 col-md-5">已选择列表</div>
			</div>
			<div class="row">
				<div class="col-sm-5 col-md-5">
					<ul id="leftTree" class="ztree"
						style="height: 300px; border: 1px solid grey;"></ul>
				</div>
				<div class="col-sm-2 col-md-2">
					<div
						style="vertical-align: middle; margin-top: 50px; text-align: center;">
						<button type="button" class="btn btn-default" onclick="addRole()">>></button>
						<br>
						<br>
						<button type="button" class="btn btn-default" onclick="delRole()"><<</button>
					</div>
				</div>
				<div class="col-sm-5 col-md-5">
					<ul id="rightTree" class="ztree"
						style="height: 300px; border: 1px solid grey;"></ul>
				</div>
			</div>
		</div>
		<div class="box-footer">
			<div class="row">
				<div class="editPageButton">
					<button type="button" onclick="getData();">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>