<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>菜单管理</title>
<jdf:themeFile file="css/zTree.css" />
<jdf:themeFile file="jquery.ztree.all-3.5.min.js" />
<SCRIPT type="text/javascript">
	var setting =
	{
		async :
		{
			enable : true,
			url : "${dynamicDomain}/menu/getChildren?ajax=1",
			autoParam : [ "id", "name=n", "level=lv" ]
		},
		view :
		{
			expandSpeed : "",
			addHoverDom : addHoverDom,
			removeHoverDom : removeHoverDom,
			selectedMulti : false,
			fontCss : getFontCss
		},
		edit :
		{
			enable : true,
			editNameSelectAll : true,
			showRemoveBtn : showRemoveBtn,
			showRenameBtn : false
		},
		callback :
		{
			beforeDrag : beforeDrag,
			beforeRemove : beforeRemove,
			onRemove : onRemove,
			onClick : onClick
		},
		data :
		{
			simpleData :
			{
				enable : true
			}
		}
	};

	var root = ${root};
	$(document).ready(function()
	{
		$.fn.zTree.init($("#menuTree"), setting, root);
	});

	var log, className = "dark";
	function beforeDrag(treeId, treeNodes)
	{
		return false;
	}
	function beforeRemove(treeId, treeNode)
	{
		className = (className === "dark" ? "" : "dark");
		var zTree = $.fn.zTree.getZTreeObj("menuTree");
		zTree.selectNode(treeNode);
		var currentNodeId = treeNode.id;
		var result = false;
		$.ajax(
		{
			url : '${dynamicDomain}/menu/deleteCurrentMenu/' + currentNodeId,
			type : 'post',
			data : "date=" + (new Date().getDate()),
			dataType : 'json',
			async:false, 
			success : function(json)
			{
				if (!json.node)
				{
					winAlert("删除失败!");
				}else{
					result = true;
					winAlert("删除成功!");
				}
			}
		});
		return result;
	}

	function onRemove(e, treeId, treeNode)
	{
		return false;
	}
	function getFontCss(treeId, treeNode)
	{
		return (!!treeNode.highlight) ?
		{
			color : "#000",
			"font-weight" : "bold"
		} :
		{
			color : "#000",
			"font-weight" : "normal"
		};
	}
	//添加分类
	function addHoverDom(treeId, treeNode)
	{
		if (!treeNode.isParent)
		{
			return;
			/* var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
				return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
					+ "' title='add node' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_" + treeNode.tId);
			if (btn)
				btn.bind("click", function()
				{
					var zTree = $.fn.zTree.getZTreeObj("menuTree");
					zTree.addNodes(treeNode,
					{
						id : null,
						pId : treeNode.id,
						name : "按钮-请完善页面按钮信息",
						type:'btn'
					});
					return false;
				}); */
		}else{
			var sObj = $("#" + treeNode.tId + "_span");
			if (treeNode.editNameFlag || $("#addBtn_" + treeNode.tId).length > 0)
				return;
			var addStr = "<span class='button add' id='addBtn_" + treeNode.tId
					+ "' title='add node' onfocus='this.blur();'></span>";
			sObj.after(addStr);
			var btn = $("#addBtn_" + treeNode.tId);
			if (btn)
				btn.bind("click", function()
				{
					var zTree = $.fn.zTree.getZTreeObj("menuTree");
					zTree.addNodes(treeNode,
					{
						id : null,
						pId : treeNode.id,
						name : "请完善新增菜单信息"
					});
					return false;
				});
		}
	};

	function showRemoveBtn(treeId, treeNode)
	{
		return !treeNode.isParent||treeNode.canDel;
	}

	function removeHoverDom(treeId, treeNode)
	{
		$("#addBtn_" + treeNode.tId).unbind().remove();
	};

	function onClick(event, treeId, treeNode, clickFlag)
	{
		$("#submitBtn").attr("disabled",false);
		var currentNodeId = treeNode.id;
		var currentNodeType = treeNode.type;
		var parentNode = treeNode.getParentNode();
		/* if(currentNodeType=="btn"){
			$("#submitMenuLinkBtn").attr("disabled",false);
			$("#menuDiv").hide();
			$("#menuLinkDiv").show();
		//获取父节点
		}else  */
			if (currentNodeType == 0 || currentNodeType == 1
				|| parentNode.type == 0)
		{
			$(".menuContent").hide();
		} else
		{
			$(".menuContent").show();
		}
		if (currentNodeId == null)
		{
			$("input[name='name']").val("");
			$("input[name='orderId']").val("");
			$("input[name='url']").val("");
			$("input[name='parentId']").val(parentNode.id);
			$("#menuId").val("");
			$("input[name='type']").val(parentNode.type + 1);
		} else
		{
			//将数据写入到表单
			$.ajax(
			{
				url : '${dynamicDomain}/menu/getCurrentMenu/' + currentNodeId,
				type : 'post',
				data : "date=" + (new Date().getDate()),
				dataType : 'json',
				success : function(json)
				{
					$("input[name='name']").val(json.node.name);
					$("input[name='orderId']").val(json.node.orderId);
					$("input[name='url']").val(json.node.url);
					$("input[name='parentId']").val(json.node.parentId);
					$("#menuId").val(json.node.objectId);
					$(":radio[name=status][value='" + json.node.status + "']").attr("checked", "true");
					$("input[name='type']").val(json.node.type);
					$("textarea[name='remark']").val(json.node.remark);
					refreshParentPage(true);
				}
			});
		}
	}
</SCRIPT>
</HEAD>

<body>
	<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				<div class="message-right">${message }</div>
				菜单管理
			</h4>
		</div>
	</div>
	<div class="content_wrap">
		<div class="zmenuTreeBackground left panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title">
					所属平台
					<jdf:radio dictionaryId="1112" name="menu_platform" />
				</h3>
			</div>
			<ul id="menuTree" class="ztree"></ul>
		</div>
		<div class="right panel panel-default" id="menuDiv">
			<div class="panel-heading">
				<h3 class="panel-title" style="padding: 6px;">菜单信息</h3>
			</div>
			<jdf:form bean="entity" scope="request">
				<form method="post" action="${dynamicDomain}/menu/saveToTree"
					class="form-horizontal" id="Menu" onsubmit="return verification();">
					<input type="hidden" name="objectId" id="menuId"> 
                    <input type="hidden" name="parentId"> 
                    <input type="hidden" name="platform"
						value="${platform }"> <input type="hidden" name="type">
					<div class="box-body">
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="name" class="col-sm-3 control-label">菜单名称</label>
									<div class="col-sm-6">
										<input type="text" class="search-form-control required {maxlength:50}" name="name">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-12 menuContent">
								<div class="form-group">
									<label for="url" class="col-sm-3 control-label">菜单地址</label>
									<div class="col-sm-6">
										<input type="text" class="search-form-control required {maxlength:50}" name="url"
											id="url">
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-12">
								<div class="form-group">
									<label for="orderId" class="col-sm-3 control-label">菜单顺序</label>
									<div class="col-sm-6">
										<input type="text" class="search-form-control sortNoVerify required" name="orderId"
											id="orderId">
									</div>
								</div>
							</div>
						</div>
						<div class="col-sm-12 col-md-12">
							<div class="form-group">
								<label for="status" class="col-sm-3 control-label">是否使用</label>
								<div class="col-sm-6">
									<jdf:radio dictionaryId="111" name="status" />
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-sm-12 col-md-12 menuContent">
								<div class="form-group">
									<label for="remark" class="col-sm-3 control-label">备注</label>
									<div class="col-sm-6">
										<textarea rows="5" cols="36" name="remark" class="search-form-control {maxlength:250}"></textarea>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="submit" class="btn btn-primary" validateMethod="verification()" id="submitBtn" disabled="disabled">确认</button>
							</div>

						</div>
					</div>
				</form>
			</jdf:form>
		</div>
    <div class="right panel panel-default" id="menuLinkDiv" style="display: none;">
      <div class="panel-heading">
        <h3 class="panel-title" style="padding: 6px;">页面按钮信息</h3>
      </div>
      <jdf:form bean="entity" scope="request">
        <form method="post" action="${dynamicDomain}/menuLink/saveToTree"
          class="form-horizontal" id="MenuLink">
          <input type="hidden" name="objectId" id="menuLinkId"> 
          <input type="hidden" name="menuId"> 
          <div class="box-body">
            <div class="row">
              <div class="col-sm-12 col-md-12">
                <div class="form-group">
                  <label for="name" class="col-sm-3 control-label">按钮名称</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="remark" required:true>
                  </div>
                </div>
              </div>
            </div>
            <div class="row">
              <div class="col-sm-12 col-md-12 menuContent">
                <div class="form-group">
                  <label for="url" class="col-sm-3 control-label">按钮地址</label>
                  <div class="col-sm-6">
                    <input type="text" class="search-form-control" name="url" id="url">
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="box-footer">
            <div class="row">
              <div class="editPageButton">
                <button type="submit" class="btn btn-primary" id="submitMenuLinkBtn" disabled="disabled">确认</button>
              </div>

            </div>
          </div>
        </form>
      </jdf:form>
    </div>
	</div>
	<script type="text/javascript">
		$("#Menu").validate();
		function verification(){
			var result = false;
			$.ajax({
				url : "${dynamicDomain}/menu/isUnique?ajax=1&objectId="+$("#menuId").val()+"&name="+$("input[name='name']").val()+"&platform="+$('input[name="menu_platform"]:checked').val(),
				type : "post",
	            dataType : "json",
	            async:false,
	            success : function(json) {
	            	if(!json){
	            		winAlert("菜单名称已经存在");
	            	}else{
	            		if($("#Menu").valid()){
	            			result = true;
	            		}
	            	}
	            }
	        });
			return result;
		}
		$(":radio[name=menu_platform][value='${platform}']").attr("checked","true");
		$(document)
				.ready(
						function()
						{
							$("input[name='menu_platform']")
									.change(
											function()
											{

												var platform = $(
														'input[name="menu_platform"]:checked')
														.val();
												window.location.href = "${dynamicDomain}/menu/menuTree/"
														+ platform;
											});
						});
		
		
	</script>
</body>
</html>