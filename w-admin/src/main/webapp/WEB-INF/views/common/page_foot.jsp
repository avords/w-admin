 <%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<script type="text/javascript">
     var url = '${menuURL}';
     if(url == ''){
         url = window.location.pathname;
     }
     $("#sidebar .nav li a").each(function (e){
         var u = this.href;
         var currentUrl = u;
         if(u.lastIndexOf('?')>0){
              currentUrl = u.substring(0, u.lastIndexOf('?'));
         }
         if(u.lastIndexOf('#')>0){
             currentUrl = currentUrl+'#';
         }
         if(currentUrl.endsWith(url)){
             $(this).parent().addClass("active");
             $(this).parent().parent().parent("li").addClass("active open");
             return false;
         }
     });
 </script>