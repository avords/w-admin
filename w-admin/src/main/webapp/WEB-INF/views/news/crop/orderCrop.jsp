<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ include file="../../common/header.jsp"%>
<title><jdf:message code="退换货订单管理" /></title>
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
               width: 600,//DIV层宽度
               height: 600,//DIV层高度
               bgColor: '#ccc',//DIV层背景颜色
               enableRotation: true,//是否允许旋转图片true false
               enableZoom: true,//是否允许放大缩小
               selector: {
                    w:150,//选择器宽度
                    h:150,//旋转高度
                    showPositionsOnDrag:true,//是否显示拖拽的位置洗洗脑
                    showDimetionsOnDrag:false,
                    aspectRatio:true,
                    centered: true,//居中
                    bgInfoLayer:'#fff',
                    borderColor: 'blue',//选择区域边框样式
                    animated: false,
                    maxWidth:600,//最大宽度
                    maxHeight:600,//最大高度
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
               cropzoom.send('${dynamicDomain}/order/picture/saveCrop', 'POST', {'srcFilePath':'${filePath}'}, function(imgRet) {
                   var filePath = '${dynamicDomain}'+imgRet.filePath;
                   if('${type}'=='main'){
                       var img = '<img alt="" src="'+filePath+'" width="100px" height="100px;">';
                       $("#mainPicture",window.parent.document).val(imgRet.filePath);
                       $("#mainImg",window.parent.document).html(img);
                   }else{
                	   var img = '<div style="width: 100px;display: inline-block;"><a style="cursor: pointer;display: block;margin-left: 65px;" class="subDelete" data-path="'+imgRet.filePath+'">删除</a>                 ';
                       img += '<img alt="" src="'+filePath+'" width="100px" height="100px;"></div>';
                       var subPath = $("#subPicture",window.parent.document).val();
                       if(subPath==''){
                           $("#subPicture",window.parent.document).val(imgRet.filePath);
                       }else{
                           $("#subPicture",window.parent.document).val(subPath+','+imgRet.filePath);
                       }
                       $("#subImg",window.parent.document).append(img);
                   }
                   //$("#showLogo",window.parent.document).attr('src',filePath);
                  //$("#logo",window.parent.document).val(imgRet.filePath);
                   //主动关闭colorbox
                   parent.deletePic();
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