<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../common/header.jsp"%>
<title><jdf:message code="福利套餐上传图片设置" /></title>
<jdf:themeFile file="jquery.cropzoom.js" />
</head>
<body>
     <div class="crop"> 
        <div id="cropzoom_container"></div> 
        <%--         <div id="preview"><img id="generated" src="${dynamicDomain}${filePath}"  /></div>  --%>
        <div class="page_btn"> 
	        <input type="button" class="btn" id="crop" value="剪切照片" /> 
	        <input type="button" class="btn" id="restore" value="照片复位" /> 
        </div> 
        <div class="clear"></div> 
     </div> 
<script type="text/javascript">  
$(function() {
	var cropzoom = $('#cropzoom_container').cropzoom({
		width : '${width}', //图片宽度
		height : '${height}',//图片高度
		bgColor : '#ccc',//DIV层背景颜色
		enableRotation : false,//是否允许旋转图片true
		enableZoom : true,//是否允许放大缩小
		enableResize:false,
		selector : {
			w : '300',//选择器宽度
			h : '300',//选择器高度
			showPositionsOnDrag : true,//是否显示拖拽的位置
			showDimetionsOnDrag : false,
			centered : true,//居中
			aspectRatio:true,
			bgInfoLayer : '#fff',
			borderColor : 'blue',//选择区域边框样式
			animated : false,
			borderColorHover : 'yellow'//鼠标放到选择器的边框颜色
		},
		image : {
			source : '${dynamicDomain}${filePath}',
			width : '${width}',//图片宽度
			height : '${height}',//图片高度
			minZoom : 30,//最小放大比例
			maxZoom : 150
		//最大放大比例
		}
	});
	$("#crop").click(
			function() {//裁剪提交
				cropzoom.send(
						'${dynamicDomain}/welfare/picture/saveCrop','POST', {
							'srcFilePath' : '${filePath}'
						}, function(imgRet) {
							var filePath = '${dynamicDomain}' + imgRet.filePath;
							$("#showPackageImg", window.parent.document).attr('src', filePath);
							$("#packageImgUrl", window.parent.document).val(imgRet.filePath);
							//主动关闭colorbox
							alert('截图成功!可以关闭窗口查看了！');
							parent.$.colorbox.close();
						});
			});
	$("#restore").click(function() {//显示初始状态照片
		$("#generated").attr("src", "${dynamicDomain}${filePath}");
		cropzoom.restore();
	});
});
</script>
</body>
</html>