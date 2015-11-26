<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="商品审核分配PM" /></title>
<jdf:themeFile file="css/zTree.css" />
<jdf:themeFile file="jquery-1.8.2.min.js" />
<jdf:themeFile file="jquery.ztree.core-3.5.js" />
<jdf:themeFile file="jquery.ztree.excheck-3.5.js" />
<jdf:themeFile file="jquery.ztree.exedit-3.5.js" />
<jdf:themeFile file="css/select2.css" />
<jdf:themeFile file="select2.js"/>
</head>
<body>
    <div>
            <jdf:form bean="entity" scope="request">
             <form method="post" action="${dynamicDomain}/attribute/saveDistribute?ajax=1" class="form-horizontal" id="editForm" onsubmit="return vierify();">
                    <div class="callout callout-info">
                        <div class="message-right" style="margin-right: 30px;font-size: 20px;">${message }</div>
                        <h4 class="modal-title"><jdf:message code="商品审核分配PM" />
                        </h4>
                    </div>
                    <div class="box-body">
                        <div class="row">
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                   <label for="logo"  class="col-sm-2 control-label">选择PM</label>
                                   <div class="col-sm-8">
                                         <select name="userId"  id="userId" style="width:250px;">
                                             <option value="">—请选择—</option>
                                             <jdf:selectCollection items="users" optionValue="objectId" optionText="userName"/>
                                         </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                         <div class="row">
                          <input type="hidden" id="categoryIds" name="categoryIds"/>
                            <div class="col-sm-12 col-md-12">
                                <div class="form-group">
                                      <label for="status" class="col-sm-2 control-label">商品运营分类</label>
                                      <div class="col-sm-10 col-md-10">
                                        <ul id="tree" class="ztree" style="height: 300px;border: 1px solid grey;"></ul>
                                      </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="box-footer">
                        <div class="row">
                            <div class="editPageButton">
                                <button type="button" class="btn btn-primary" id="submitButton">
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
    $('#userId').select2();
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
            },
            callback: {
                beforeClick: beforeClick,
                onCheck: onCheck
            }
        };
  //zTree说明:
    //这里没有样式之类的东西,需要看到还需要引人几个css 和 imp 之类的东西.
    //可以去看zTree的demo 和 API

    var nodes =${nodes};
  //初始化方法
    $(document).ready(function() {
        $.fn.zTree.init($("#tree"), setting, nodes);
        //树1 数据 生成
        tree = $.fn.zTree.getZTreeObj("tree");
        tree.expandAll(false);
        tree.setting.check.chkboxType = { "Y" : "ps", "N" : "ps"};
    });
  
    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("treeDemo");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    
    function onCheck(e, treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree"),
        nodes = zTree.getCheckedNodes(true),
        text = "";
        val = "";
        for (var i=0, l=nodes.length; i<l; i++) {
            text += nodes[i].name + ",";
            if(nodes[i].layer=='3'){
            	val +=nodes[i].id + ",";
            }
        }
        if (text.length > 0 ) text = text.substring(0, text.length-1);
        $("#categoryIds").val(val);
    }
    
    function vierify(){
    	var userId = $('#userId').val();
    	var cate = $('#categoryIds').val();
    	if(userId==''){
    		winAlert('PM人不能为空');
    		return false;
    	}
    	if(cate==''){
    		winAlert('商品运营分类不能为空');
    		return false;
    	}
    	return true;
    }
    $(function(){
    	$('#submitButton').click(function(){
    		$('#editForm').submit();
    		parent.$.colorbox.close();
    	});
    });
    </script>
</body>
</html>