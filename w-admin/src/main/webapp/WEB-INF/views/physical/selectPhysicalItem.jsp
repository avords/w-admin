<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn"%>
<%@ taglib uri="http://www.opensymphony.com/sitemesh/decorator" prefix="decorator" %>
<%@ taglib uri="framework" prefix="jdf" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="ibenefit" prefix="ibs" %>
<%@ page language="java" contentType="text/html; charset=utf-8"	pageEncoding="utf-8"%>
 
<title>选择体检项目</title>
</head>
<body>
<div>
		<div class="callout callout-info">
			<h4 class="modal-title">
				选择体检项目
			</h4>
		</div>
	</div>

	<div class="eXtremeTable">
		 <table id="ec_table" border="0" cellspacing="0" cellpadding="0" class="table table-bordered" width="100%">
		 <thead>
		 <tr>
		<td class="tableHeader" style="width: 4%;text-align: center;" ><input type="checkbox" class="noBorder" id="mainCheck" value="0" onclick="selectAllClick()" /></td>
		<td class="tableHeader" style="width:10%;text-align: center;" onmouseover="this.className='tableHeaderSort';this.style.cursor='pointer'" onmouseout="this.className='tableHeader';this.style.cursor='default'"  title="一级项目名称" style="cursor: default;">一级项目名称</td>
		<td class="tableHeader" style="width:10%; text-align: center;" onmouseover="this.className='tableHeaderSort';this.style.cursor='pointer'" onmouseout="this.className='tableHeader';this.style.cursor='default'"  title="二级项目名称">二级项目名称</td>
		<td class="tableHeader" style="width: 5%;text-align: center;"  onmouseover="this.className='tableHeaderSort';this.style.cursor='pointer'" onmouseout="this.className='tableHeader';this.style.cursor='default'"  title="男性">男性</td>
		<td class="tableHeader" style="width: 5%;text-align: center;"  onmouseover="this.className='tableHeaderSort';this.style.cursor='pointer'" onmouseout="this.className='tableHeader';this.style.cursor='default'"  title="女未婚">女已婚</td>
		<td class="tableHeader" style="width: 5%;text-align: center;"  onmouseover="this.className='tableHeaderSort';this.style.cursor='pointer'" onmouseout="this.className='tableHeader';this.style.cursor='default'"  title="女已婚">女未婚</td>
		</tr>
		 </thead>
		   <c:forEach items="${physicalItems }" var="item" varStatus="num">
		 <tbody class="tableBody">
		   <tr class="odd" onmouseover="this.className='highlight'" onmouseout="this.className='odd'">
			<td style="width: 4%;text-align: center;"><input type="checkbox" class="noBorder" name="schk" onclick="schkClick()" value="${item.objectId }" 
			  cval="${item.objectId }_${item.parentItemId}_${item.firstItemName }_${item.secondItemName}_${item.isMan}_${item.isWomanMarried}_${item.isWomanUnmarried}_${item.supplyPriceInfo}"></td>
			<td style="width:10%">${item.firstItemName }</td>
			<td style="width:10%">${item.secondItemName}</td>
			<td style="width:5%"><c:if test="${item.isMan==1}">★</c:if></td>
			<td style="width:5%"><c:if test="${item.isWomanMarried==1}">★</c:if></td>
			<td style="width:5%"><c:if test="${item.isWomanUnmarried==1}">★</c:if></td>
	    </tr>
		 </tbody>
		 </c:forEach>
		</table>
		  <div class="box-footer">
			<div class="row">
				<div class="editPageButton">
						<button type="button" class="btn btn-primary" onclick="addPhItem();">提交</button>		
						<button type="button" class="btn btn-primary" onclick="closeBox()"> 取消</button>
				</div>
								
			</div>
	</div>
		
		
	</div>

<script type="text/javascript">
    function closeBox(){
    	parent.$.colorbox.close();
    }
    
	 function addPhItem(){
		 var selectValues=[];
		 if($('input[name="schk"]:checked').length>0){
			 $('input[name="schk"]:checked').each(function(){
				 var val=$(this).attr("cval");
				 selectValues.push(val);
			 });
			 window.parent.childrenWin(selectValues);	 
		 }else{
			 alert("未选择体检项目");
		 }
	 }
	 
	 //全选
	 function selectAllClick(){
	     var checkval = $("#mainCheck").val();
	     if(checkval == '0'){
	    	 $('input[name="schk"]').attr('checked',true);
	    	 $("#mainCheck").val('1'); 
	     }else if (checkval == '1'){
	    	 $('input[name="schk"]').attr('checked',false);
	    	 $("#mainCheck").val('0'); 	    	 
	     }
	 }
	</script>
	
</body>
</html>