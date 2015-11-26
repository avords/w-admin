<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../common/header.jsp"%>
<title><jdf:message code="福利上传图片设置" /></title>
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
               width: 500,//DIV层宽度
               height: 360,//DIV层高度
               bgColor: '#ccc',//DIV层背景颜色
               enableRotation: true,//是否允许旋转图片true false
               enableZoom: true,//是否允许放大缩小
               selector: {
                    w:150,//选择器宽度
                    h:200,//旋转高度
                    showPositionsOnDrag:true,//是否显示拖拽的位置洗洗脑
                    showDimetionsOnDrag:false,
                    centered: true,//居中
                    bgInfoLayer:'#fff',
                    borderColor: 'blue',//选择区域边框样式
                    animated: false,
                    maxWidth:150,//最大宽度
                    maxHeight:200,//最大高度
                    borderColorHover: 'yellow'//鼠标放到选择器的边框颜色
                },
                image: {
                    source: '${dynamicDomain}${filePath}',
                    width: '${width}',//图片宽度
                    height: '${height}',//图片高度
                    minZoom: 30,//最小放大比例
                    maxZoom: 150//最大放大比例
                 }
           });
          $("#crop").click(function(){//裁剪提交
               cropzoom.send('${dynamicDomain}/welfare/picture/saveCrop', 'POST', {'srcFilePath':'${filePath}'}, function(imgRet) {
                   var filePath = '${dynamicDomain}'+imgRet.filePath;
                   $("#logo",window.parent.document).val(imgRet.filePath);
                   $("#showLogo",window.parent.document).attr('src',filePath);
                   
                   //主动关闭colorbox
                   alert('截图成功!可以关闭窗口查看了！');
                   parent.$.colorbox.close();
               });             
          });
          $("#restore").click(function(){//显示初始状态照片
               $("#generated").attr("src", "${dynamicDomain}${filePath}");
               cropzoom.restore();                    
          });
     });
     </script>
</body>
</html>