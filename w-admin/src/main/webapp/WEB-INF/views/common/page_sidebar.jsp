<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<aside class="main-sidebar">
	<section class="sidebar">
		<ul class="sidebar-menu">
        <li  class="treeview">
          <a href="javascript:clickIndex('${dynamicDomain}')">
            <i class="glyphicon glyphicon-home"></i>
            <span>首页</span>
          </a>
          <ul class="treeview-menu"></ul>
        </li>
        ${treeHtml }</ul>
		<script type="text/javascript">
		function logMenuClick(logData){
			  
			  $.ajax({
				  url:"${dynamicDomain}/log?ajax=1",
				  type:'post',
				  dataType:'json',
				  data:logData,
				 
				  success:function(data){		
					  
				  },
				  error:function(errorData){
					 
				  }
			  });
		}
		
			function clickIndex(url){
				$.cookie('menusf', "",
				{
					path : '/'
				});
				$.cookie('submenusf', "",
				{
					path : '/'
				});
				window.location.href = url;
			}
			function clickSubMenu(menuId,parentId, fullUrl,parentName,menuName)
			{
				$.cookie('menusf', "#menuli_" + parentId,
				{
					path : '/'
				});
				$.cookie('firstLevelMenu', parentName,
				{
					path : '/'
				});
				$.cookie('secondLevelMenu', menuName,
						{
							path : '/'
						});
				$.cookie('submenusf', "#menu_" + menuId,
						{
							path : '/'
						});
				$("#menuli_" + parentId).addClass("active");
				
				url = fullUrl.replace('${dynamicDomain}','');
				var logData = {
						'menuId': menuId,
						'menuName':menuName,
						'parentId':parentId,
						'parentName':parentName,
						'url':url
						};
				logMenuClick(logData);
				window.location.href = fullUrl;
			}

			
			
			function clickMenu(parentId)
			{
// 				$(".treeview").removeClass("active");
				$("#menuli_" + parentId).toggleClass("active");
			}
			//保存缩放菜单状态
			$(function()
			{
				if (typeof ($.cookie('menusf')) != "undefined")
				{
					$($.cookie('menusf')).addClass("active");
					$($.cookie('submenusf')).css("background","#fff");
				}
			});
		</script>
	</section>
</aside>