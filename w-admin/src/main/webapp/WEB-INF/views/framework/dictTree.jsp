<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>字典管理</title>
<jdf:themeFile file="css/zTree.css" />
<jdf:themeFile file="jquery.ztree.all-3.5.min.js" />
</head>
<body>
	<div>
		<div class="callout callout-info">
			<div class="message-right">${message }</div>
			<h4 class="modal-title">字典管理</h4>
		</div>
		<div class="zmenuTreeBackground left panel panel-default" style="width: 99%">
			<ul id="topicTree" class="ztree"></ul>
			<input type="hidden" id="changed" name="changed" />
		</div>
	</div>
	<div id="addArea" style="display: none;" class="panel">
		<div class="panel-content">
			<form action="" id="dictForm" class="form-horizontal">
				<input type="hidden" name="id" id="dict_id" /> <input type="hidden"
					name="parentId" id="dict_parentId" /> <input type="hidden"
					name="objectId" id="dict_objectId" /> <input type="hidden"
					name="sortId" id="dict_sortId" /> <input type="hidden" name="type"
					id="dict_type" />
				<div class="row-fluid">
					<div class="span10">
						<div id="messageBox" class="alert alert-info"
							style="display: none">${message}</div>
					</div>
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="dictionaryId"><jdf:message
									code="system.lable.dict.dictionary_id" /></label>
							<div class="controls">
								<input type="text" name="dictionaryId" id="dict_dictionaryId"
									class="input-small">
							</div>
						</div>
					</div>
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="name"><jdf:message
									code="system.lable.dict.name" /></label>
							<div class="controls">
								<input type="text" name="name" id="dict_name"
									class="input-small">
							</div>
						</div>
					</div>
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="value"><jdf:message
									code="system.lable.dict.value" /></label>
							<div class="controls">
								<input type="text" name="value" id="dict_value"
									class="input-small">
							</div>
						</div>
					</div>
					<div class="span5">
						<div class="control-group">
							<label class="control-label" for="status">是否有效	</label>
              				<div class="controls">
								<select name="status" id="dict_status" value="1">
									<option value=""></option>
									<jdf:select dictionaryId="109" />
								</select>
							</div>
						</div>
					</div>
					<div class="span10">
						<div class="control-group">
							<label class="control-label" for="remark"><jdf:message
									code="system.lable.dict.remark" /></label>
							<div class="controls">
								<input type="text" name="remark" id="dict_remark">
							</div>
						</div>
					</div>
					<div class="span10 pull-right">
						<div class="btn-toolbar pull-right" style="font-size: medium;">
							<button type="button" class="btn btn-primary"
								onclick="saveDict()">
								<i class="icon-save icon-white"></i>
								<jdf:message code="common.button.save" />
							</button>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="text/javascript">
        var setting = {
            async: {
                enable: true,
                url:"${dynamicDomain}/dict/getChildren?ajax=1",
                autoParam:["id", "name=n", "level=lv"]
            },
            view: {
            	expandSpeed:"",
                addHoverDom: addHoverDom,
                removeHoverDom: removeHoverDom,
                selectedMulti: false
            },
            edit: {
                enable: true,
                editNameSelectAll: true,
                showRenameBtn: false,
                showRemoveBtn:false
            },
            data: {
                simpleData: {
                    enable: true,
                    pIdKey: "parentId"
                }
            }
        };

        function filter(treeId, parentNode, childNodes) {
            if (!childNodes) return null;
            for (var i=0, l=childNodes.length; i<l; i++) {
                childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
            }
            return childNodes;
        }
        function beforeRemove(treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("topicTree");
            zTree.selectNode(treeNode);
            return confirm("Confirm delete Node  -- " + treeNode.name + " ？");
        }       
        function beforeRename(treeId, treeNode, newName) {
            if (newName.length == 0) {
                alert("Node Name can not be empty.");
                return false;
            }
            return true;
        }

        var newCount = 1;
        function addHoverDom(treeId, treeNode) {
            var sObj = $("#" + treeNode.tId + "_span");
            if ($("#addBtn_"+treeNode.id).length>0) return;
            var addStr = "<span class='button add' id='addBtn_" + treeNode.id + "' title='add node' onfocus='this.blur();'></span>";
            addStr += "<span class='button edit' id='editBtn_" + treeNode.id + "' title='edit node' onfocus='this.blur();'></span>";
            sObj.append(addStr);
            var btn = $("#addBtn_"+treeNode.id);
            if (btn) btn.bind("click", function(){
            	currentObjectId = "";
                $("#dict_id").val("");
                $("#dict_objectId").val("");
                $("#dict_parentId").val(treeNode.id);
                $("#dict_name").val("");
                $("#dict_status").val("");
                $("#dict_sortId").val(1);
                $("#dict_remark").val("");
                $("#dict_dictionaryId").val("");
                $("#dict_type").val("2");
                $("#dict_value").val("");
                currentNode = treeNode;
                $("#addArea").dialog({height: 400,width:300,resizable:false});
            	
            });
            
            var btn2 = $("#editBtn_"+treeNode.id);
            if (btn2) btn2.bind("click", function(){
                currentObjectId = treeNode.id;
                 $("#dict_objectId").val(currentObjectId);
                $("#dict_parentId").val(treeNode.parentId);
                $("#dict_id").val(treeNode.primaryKey);
                currentNode = treeNode;
                $("#dict_name").val(treeNode.realName);
                $("#dict_dictionaryId").val(treeNode.dictionaryId);
                $("#dict_value").val(treeNode.value);
                $("#dict_status").val(treeNode.status?1:0);
                $("#dict_remark").val(treeNode.remark=="null"?"暂无":treeNode.remark);
                $("#dict_sortId").val(treeNode.sortId);
                $("#dict_type").val(treeNode.type); 
                $("#addArea").dialog({height: 400,width:300,resizable:false});
                
            });
            
        };
        
        function removeHoverDom(treeId, treeNode) {
            $("#addBtn_"+treeNode.id).unbind().remove();
            $("#editBtn_"+treeNode.id).unbind().remove();
        };
        
        var root = ${root};
        $(document).ready(function(){
            $.fn.zTree.init($("#topicTree"), setting, root);
        });
        
        var count=0; 
        var lastName; 
        function doSearch(){ 
        	if(count==0){ 
       			lastName=document.getElementById("search_str").value; 
        	} 
        	if(lastName!=document.getElementById("search_str").value){ 
       			count=0; 
        		lastName=document.getElementById("search_str").value; 
        	} 
        	var treeObj = $.fn.zTree.getZTreeObj("topicTree"); 
	        var nodes =   treeObj.transformToArray(treeObj.getNodesByParamFuzzy("name", lastName, null)); 
            for(i = count; i < nodes.length; i++) { 
        		count++; 
        		if(count>=nodes.length){ 
        			count=0; 
        		} 
        		if(nodes[i].name.indexOf(lastName)!=-1){ 
        			treeObj.selectNode(nodes[i]); 
        			//auto open
        			treeObj.expandNode(nodes[i], false,false , false); 
        			return false; 
        		} 
       		} 
        } 
       </script>
	<script>
		var currentNode;
		var tree;
		var needSave; 
		var currentObjectId;
		function saveDict(){
			var name = $("#dict_name").val();
			var dictionaryId = $("#dict_dictionaryId").val();
			var value = $("#dict_value").val();
			if(dictionaryId=='null'){
				dictionaryId = '';
			}
			
			if(isNull(name)){
				showMessage("Name can not be empty");
				return;
			}
			if(!isInteger(value)){
				showMessage("Value should be Integer");
				return;
			}
			var params = $("#dictForm").serialize();
   			$.ajax({
				url:"${dynamicDomain}/dict/treeSave",
				type : 'post',
				dataType : 'json',
				data:params,
				success : function(msg) {
					if (msg.result) {
						var dict = msg.entity;
						var zTree = $.fn.zTree.getZTreeObj("topicTree");
						//add
						if (currentObjectId == "") {
							zTree.addNodes(currentNode, {
								"id" : dict.objectId,
								"rel" : "file",
								"parentId" : dict.parentId,
								"dictionaryId" : dict.dictionaryId,
								"name" : name+":"+value,
								"status" : dict.status,
								"sortId" : dict.sortId,
								"remark" : dict.remark,
								"type" : dict.type,
								"realName" : dict.name,
								"value" : dict.value
							});
						} else {
							//edit
							currentNode.dictionaryId = dict.dictionaryId;
							currentNode.name =  dict.name+":"+dict.value;
							currentNode.realName = dict.name;
							currentNode.primaryKey = dict.id;
							currentNode.status = dict.status;
							currentNode.remark = dict.remark;
							currentNode.value = dict.value;
							zTree.updateNode(currentNode);
						}
						showMessage("保存成功", 5000);
					} else {
						showMessage("保存失败", 5000);
					}
				},
				error: function(XMLHttpRequest, textStatus, errorThrown) {
					winAlert("系统异常，请联系管理员");
	      		}
			});

			$("#addArea").dialog("close");
		}

		function saveOrder() {
			var menu = $(tree).plugins.checkbox.get_checked();
			var ids = "";
			for (i = 0; i < menu.size(); i++) {
				ids += menu[i].id + ";";
			}
			alert(ids);
		}
		
	</script>

</body>
</html>