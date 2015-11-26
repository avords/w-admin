function setCookie(sName, sValue){
    var expires = new Date();
    expires.setTime(expires.getTime() + 3 * 30 * 24 * 60 * 60 * 1000);
    document.cookie = sName + "=" + escape(sValue) + ";expires=" + expires.toGMTString(); + ";";
}

function getCookie(sName){
    var aCookie = document.cookie.split("; ");
    for (var i=0; i < aCookie.length; i++){
            var aCrumb = aCookie[i].split("=");
            if (sName == aCrumb[0])
            return unescape(aCrumb[1]);
    }
    return null;
}

function toMenu(index){
    if(index==0) parent.workFrame.location.href= appRoot + "/main";
    else if(index==1) PopWin(appRoot + "/user/changePassword",500,300,"","","no");
}
    
window.onbeforeunload = function(e) {
    e = e||window.event;
    var n = e.screenX - window.screenLeft;
    var b = n > document.documentElement.scrollWidth-20;
    if(b && e.clientY < 0 || e.altKey){
        logOut(2);
    }
}
var endDate = null;
function setEndDate(){
	endDate = (new Date()).getTime() + (timeoutOfLogout * 60 * 1000);
}	
setEndDate();
function timOut(){
    var currentDate = (new Date()).getTime();
    if(currentDate>=endDate){
        logOut(3);
    }
}

$(document).keydown(function(event){ 
	setEndDate();
}).mousemove(function(e){
	setEndDate();
});

window.setInterval(timOut,60*1000);

function logOut(logOutType){
    $.cookie('menusf','',{ expires:0,path:'/'}); // 删除 菜单缩放cookie
    $.cookie('firstLevelMenu','',{ expires:0,path:'/'}); // 删除 菜单缩放cookie
    $.cookie('secondLevelMenu','',{ expires:0,path:'/'}); // 删除 菜单缩放cookie
    window.parent.location = appRoot + "/login/in/out?logoutFrom="+logOutType;
}

function index(){
    window.parent.location = appRoot + "/index";
}

var TopNum, Bigns = false;
var GoTopTimeOut;

$(function(){
	try{
		$("[moduleId=" + currentModuleId + "]").parent().addClass("active");
	}catch(e){
	}
	
	 //置顶标签
	$(window).scroll(function(){
		TopNum = $(this).scrollTop();
		if ( TopNum > 0) {
	      $('#topimg').show('slow').attr('title', '点此回到顶部');
	      $('#topimg').css({'position':'fixed', 'bottom':20, 'right':'10px' });
			// $('#topimg').css({'position':'fixed', 'bottom':120, 'left':($(this).width() - $('div.main').width())/2 + $('div.main').width()});
		}else{
			$('#topimg').hide('slow');
		}
	 });
	 $('#topimg').click(function(){
		if ( !Bigns ) {
		 $(this).attr('title', '再点此停止回到顶部');
		 Bigns = true;
		 GoTop();
		}else{
		 $(this).attr('title', '点此回到顶部');
		 Bigns = false;
		 clearTimeout(GoTopTimeOut);
		}
	 });
});

function GoTop(){
	$(window).scrollTop(TopNum-=10);
	GoTopTimeOut = setTimeout('GoTop()', 5);
	if ( TopNum <= 0 ){
		clearTimeout(GoTopTimeOut);
		Bigns = false;
	}
}

var msgTimer;
function showMessage(msg,last){
	var messageBox = $('#messageBox');
	messageBox.text(msg);
	messageBox.show();
	if(msgTimer!=null){
    	 window.clearTimeout(msgTimer);
    }
    if(last){
    	msgTimer = window.setTimeout("$('#messageBox').hide('slow')", last);
    }
}
