<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title><jdf:message code="既往症管理" /></title>
<script type="text/javascript">
var reloadParent = false;
</script>
</head>
<body>
    <div>
        <div class="callout callout-info">
            <h4 class="modal-title">
                <div class="message-right">${message }</div>
                <jdf:message code="既往症管理" />
            </h4>
        </div>
        <jdf:form bean="request" scope="request">
            <form action="${dynamicDomain}/pastDisease/page" method="post"
                class="form-horizontal">
                <div class="box-body">
                    <div class="row">
                        <div class="col-sm-4 col-md-4">
                            <div class="input-group">
                                <div class="input-group-btn">
                                    <label type="button" class="form-lable">既往症名称：</label>
                                </div>
                                <input type="text" class="search-form-control"
                                    name="search_LIKES_name">
                            </div>
                        </div>
                    </div>
                </div>
                <div class="box-footer">
                    <a href="${dynamicDomain}/pastDisease/create?ajax=1" class="btn btn-primary pull-left colorbox-big">新增</a>
                    <a href="javascript:void(0);" class="btn btn-primary pull-left progressBtn" onclick="deletePastDisease();">删除</a>
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
    </div>

    <div>
        <jdf:table items="items" var="currentRowObject" retrieveRowsCallback="limit" filterRowsCallback="limit" sortRowsCallback="limit" action="page">
            <jdf:export view="csv" fileName="既往症管理.csv" tooltip="导出CSV"
                imageName="csv" />
            <jdf:export view="xls" fileName="既往症管理.xls" tooltip="导出EXCEL"
                imageName="xls" />
            <jdf:row>
                <jdf:column alias="" title="<input type='checkbox' id='checkall'>" sortable="false" viewsAllowed="html" headerStyle="width: 2%;text-align:center;" style="text-align:center;">
                    <input type="checkbox" name="checkid" value="${currentRowObject.objectId}" class="option"/>
                </jdf:column>
                <jdf:column alias="common.lable.operate"
                    title="common.lable.operate" sortable="false" viewsAllowed="html"
                    style="width: 10%">
                    <a href="${dynamicDomain}/pastDisease/edit/${currentRowObject.objectId}?ajax=1"
                        class="btn btn-primary btn-mini colorbox-big"> <i
                        class="glyphicon glyphicon-pencil"></i>
                    </a>
                </jdf:column>
                <jdf:column property="sortNo" title="序号" headerStyle="width:20%;" />
                <jdf:column property="name" title="既往症名称" headerStyle="width:20%;"/>
                <jdf:column property="createdOn" title="创建时间" headerStyle="width:15%;" />
                <jdf:column property="creator" title="创建人" headerStyle="width:15%;" />
            </jdf:row>
        </jdf:table>
    </div>
    <script type="text/javascript">
    function getIds(){
        var content = '';
        $(".option:checked").each(function(){
            content =content+$(this).val()+",";
        });
        if(content.indexOf(",")>0){
            content =content.substring(0,content.length-1);
        }
        return content;
    }
    function deletePastDisease(){
        if(window.confirm('你确定要删除吗?')){
            var ids = getIds();
            if(ids==''){
            	winAlert('请选择要删除的记录!');
            	return false;
            }
            $.ajax({
                url:"${dynamicDomain}/pastDisease/deletePastDisease?objectIds="+ids,
                type : 'post',
                dataType : 'json',
                success : function(json) {
                    if(json.result){
                    	winAlertReload('操作成功!');
                    }
                }
            });
        }
    }
    </script>
</body>
</html>