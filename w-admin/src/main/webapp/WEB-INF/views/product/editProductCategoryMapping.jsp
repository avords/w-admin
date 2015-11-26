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
		leftTree.expandAll(false);
		leftTree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps"};
	});

	function getData() {
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
		}
		$("#selelctedIds").val(values);
		$("#editForm").submit();
	}
</script>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<form method="post" action="${dynamicDomain}/productCategoryMapping/saveMapping?ajax=1" class="form-horizontal" id="editForm">
				<input type="hidden" name="selelctedIds" id="selelctedIds">
				<input type="hidden" name="mallCategoryId" value="${entity.objectId}">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-5 col-md-5">
							<div class="input-group">
								<div class="input-group-btn">
									<label for="name" class="btn btn-flat">商品运营分类名称：</label>
								</div>
								<input type="text" name="search">
							</div>
							<div class="pull-right">
								<button type="button" class="btn btn-primary">
									<span class="glyphicon glyphicon-search"></span>搜索
								</button>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5 col-md-5">
							未选择列表
						</div>
						<div class="col-sm-2 col-md-2">
						</div>
						<div class="col-sm-5 col-md-5">
							已选择列表
						</div>
					</div>
					<div class="row">
						<div class="col-sm-5 col-md-5">
							<ul id="leftTree" class="ztree" style="height: 300px;border: 1px solid grey;"></ul>
						</div>
						<div class="col-sm-2 col-md-2">
							<div style="vertical-align: middle;margin-top: 50px;text-align: center;">
								<button type="button" class="btn btn-default" onclick="addRole()">>></button><br><br>
								<button type="button" class="btn btn-default" onclick="delRole()"><<</button>
							</div>
						</div>
						<div class="col-sm-5 col-md-5">
							<ul id="rightTree" class="ztree" style="height: 300px;border: 1px solid grey;"></ul>
						</div>
					</div>
				</div>
				<div class="box-footer">
					<div class="row">
						<div class="editPageButton">
							<button type="button" onclick="getData();">确定</button>
							<a href="${dynamicDomain}/productMallCategory/editMallThirdCategory" class="back-btn">返回</a>
						</div>
					</div>
				</div>
			</div>
		</form>
	</jdf:form>
</div>
</body>
</html>