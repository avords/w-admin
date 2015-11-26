<!DOCTYPE html>
<html lang="zh-CN">
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>

<style type="text/css">
html{height:100%;-overflow-y:scroll;border:0}
body{min-height:100%;-height:100%;position:relative}
body,h1,h2,h3,h4,h5,h6,p,div,dl,dt,dd,ul,ol,li,form,button,input,textarea,th,td,pre,fieldset,img{margin:0;padding:0;border:0;}
h1,h2,h3,h4,h5,h6,select,input,textarea,button,table{font-size:100%;font-weight:normal}
ul,ol,dl{list-style:none}
a,u,a:hover{text-decoration:none;outline:0;}
i,em{font-style:normal}
table{border-collapse:collapse;border-spacing:0}
th{text-align:left;font-weight:normal}
body,textarea,input,button,select{font:12px/1.14 \5FAE\8F6F\96C5\9ED1,arial,\5b8b\4f53;color:#333;outline:0;}

body{background-color:#fff;}

/* <function> */
.f-cb:before,.f-cb:after{content:" ";display:table;}.f-cb:after{clear:both;}.f-cb{*zoom:1;}
.f-ib{display:inline-block;*display:inline;*zoom:1;}/* IE6-7*/
.f-por{position:relative;}
.f-poa{position:absolute;display:block;}
.f-tac{text-align:center;}
.f-tar{text-align:right;}
.f-tal{text-align:left;}
.f-fl{float:left;display:block;}
.f-fr{float:right;display:block;}
.f-dn{display:none;}
.f-db{display:block;}
.f-oh{overflow:hidden;}
.f-fwb{font-weight:700;}
.f-fwn{font-weight:400;}
.f-wsn{white-space:nowrap;word-wrap:normal;}
.f-toe{white-space:nowrap;word-wrap:normal;overflow:hidden;text-overflow:ellipsis;}
.f-wwb{white-space:normal;word-wrap:break-word;word-break:break-all;}

#cenlender{width:640px;border:1px solid #c7c7c7;border-bottom:none;margin:28px;position:relative;}
#cenlender h3{width:100%;height:38px;}
#cenlender h3 a{width:38px;height:38px;background:url(../image/gw.v1.b7.png) no-repeat 14px 10px;}
#cenlender h3 a.rgt{background-position:14px -23px;}
#cenlender h3 a.no{cursor:not-allowed;}
#cenlender h3 a.ok{cursor:pointer;}
#cenlender h3 span{width:554px;text-align:center;line-height:38px;font-size:14px;color:#333;}
#cenlender li{float:left;}
#cenlender ol li{width:90px;height:30px;line-height:30px;background-color:#c7c7c7;color:#fff;text-align:center;font-size:14px;}
#cenlender ol li.on{background-color:#fd6845;}
#cenlender ul li{text-align:center;width:90px;height:38px;font-size:14px;border-right:1px solid #c7c7c7;border-bottom:1px solid #c7c7c7;cursor:not-allowed;}
#cenlender ul li i{display:block;text-align:right;font-size:12px;padding-top:4px;}
#cenlender ul li.off{color:#999;}
#cenlender ul li.on{color:#69f;cursor:pointer;}
#cenlender ul li.no{color:#333;}
#cenlender ul li.no i{color:#999;}
#cenlender ul li.all{color:#fd6845;}
#cenlender ul li.at{color:#008000;background-color:#ffcfc3;font-weight:700;}
#cenlender dl{position:absolute;right:-210px;top:0;width:200px;}
#cenlender dl dt{font-size:18px;font-weight:700;padding-bottom:15px;}
#cenlender dl dd{font-size:15px;line-height:28px;}

</style>
<title>选择体检时间</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					选择体检时间
				</h4>
			</div>
			<form name="form1" method="post" action="${dynamicDomain}/CardExchange/confirmPhysicalDetail" id="appointment" class="form-horizontal" >
				<input type="hidden" name="objectId">
				<div class="box-body">
					
				<div id="cenlender">
					<h3 class="f-cb j-btn">
						<a href="javascript:void(0)" class="f-fl">上一月</a>
						<span class="f-fl"><i></i></span>
						<a href="javascript:void(0);" class="rgt f-fr">下一月</a>
					</h3>
				
					<ol class="f-cb"><li class="on">日</li><li>一</li><li>二</li><li>三</li><li>四</li><li>五</li><li class="on">六</li></ol>
					<ul class="f-cb j-d-list"></ul>
					<input type="hidden"  name="physicalDateStr"  id="physicalDateStr" />
					<dl class="j-d-msg">
						<dt>已预约时间</dt>
					</dl>
				</div>
		</form>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" id="confirmTime">确定所选时间</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary progressBtn">返回</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalSubscribe" />
	
	<script type="text/javascript">
	$(function(){
		
		var isGetRegDate = true;
		// 套餐日期[范围] & 间隔周期
	    var dateCycle  = 5;
		
		var strRegdate = "${strRegdate}"; 
		var regDateFlag ="${regDateFlag}";
		var newDateRange ;
		//var strRegdate = "2015-06-30,2015-07-01,2015-07-02,2015-07-03,2015-07-07,2015-07-08,2015-07-09,2015-07-10";
		// 接口返回的时间串
		//var apiDate = ['2015-06-02', '2015-06-03', '2015-06-04', '2015-06-05', '2015-06-07', '2015-06-13', '2015-06-22', '2015-07-23'];
		var apiDate = strRegdate.split(",");
		// 保存变量
		var jsonTime = {}, passTime = {}, hasDate = 0, Max = 1, strKeep = '';

		// 当前时间 字符串 & 数组
		var date = new Date(), Y = date.getFullYear(), M = date.getMonth() + 1, D = date.getDate();
		var strDate = Y + '-' + _sprintf(M) + '-' + _sprintf(D);
		var aryDate = [Y, M, D];
		
		/* // 基于当前日期重置范围
		var newDateRange = resetDateRange([apiDate[0], apiDate[apiDate.length - 1]], strDate);

		// 1.生成 显示的年月 及 月份左右点击按钮
		createYearMonthHtml(newDateRange, strDate);

		// 2.循环输出天数
		loopDaysForWeek(aryDate); */
		if(regDateFlag=="yes"){
     		 newDateRange = resetDateRange([apiDate[0], apiDate[apiDate.length - 1]], strDate);
     		 
		        // 1.生成 显示的年月 及 月份左右点击按钮
		        createYearMonthHtml(newDateRange, strDate);
		        // 2.循环输出天数
		        loopDaysForWeek(aryDate);
     	}
		else{
     	 // 基于当前日期重置范围
      	 newDateRange = resetDateRange_no(apiDate, strDate);
         // 计算不可预约日期
         passTime = computeOffDate_no(aryDate);
         
         // 1.生成 显示的年月 及 月份左右点击按钮
         createYearMonthHtml(newDateRange, strDate);
         // 2.循环输出天数
         loopDaysForWeek_no(aryDate);
         
         isGetRegDate = false;
     }

		/* 月份左右点击生成日历html */
		$('.j-btn > a').click(function(){

			var _this = $(this), _val = _this.attr('data-v');
			
			if(_val === '0') return false;

			var _y = parseInt(_val.substr(0, 4)), _m = _val.substr(4, 2);

			 createYearMonthHtml(newDateRange, (_y + '-' + _m + '-' + '28'));

		        if(isGetRegDate){
		        	// 2.循环输出天数
		            loopDaysForWeek([_y, parseInt(_m)]);
		        }else{
		        	loopDaysForWeek_no([_y, parseInt(_m)]);
		        }

			// 还原已预约的日期
			var _hasList = jsonTime[_val];
			if(typeof(_hasList) !== 'undefined'){
				var items = '';
				$.each(_hasList, function(i){
					items += ', .d' + i;
				});
				items = items.substr(1);
				$(items).addClass('at').find('i').text('预约成功');
			}
		});

		/* == 函数部分 ============ */

		// [函数] 右侧显示预约时间
		function createRightDateHtml(_str){

			var _html = '<dt>已预约时间</dt>';

			_str = _str.substr(1);
			var _data = _str.split(',');

			var len = 0 , nn = {0:'一', 1:'二', 2:'三'};
		    for(var i in _data){
		    	var rs = _data[i];
		    	_html += '<dd>预约时间：'+ rs.substr(0, 4) + '-' + rs.substr(4, 2) + '-' + rs.substr(6, 2) +'<dd>';
		     	len++;
		    }
		    $('.j-d-msg').html(_html);
		}

		// [函数]处理时间格式[int:20150505 => 2015/05/05]
		function int2time(_int, _char){
			_char = _char || '/'; 
			_int = _int.toString();
			return _int.substr(0, 4) + _char + _int.substr(4, 2) + _char + _int.substr(6);
		}
		
		
	     /************不调用第三方接口排期生成日历所需函数begin************/

	     // [函数]预定范围和当前日期比较，重置范围,_no表示不调用第三方接口时调用该函数
	         function resetDateRange_no(_range, _now){
	             // 组合字符串
	             var _R1 = _range[0].split('-').join(''), _R1 = parseInt(_R1);
	             var _R2 = _range[1].split('-').join(''), _R2 = parseInt(_R2);
	             var _Nn = _now.split('-').join(''), _Nn = parseInt(_Nn);
	             // 比较大小 确定范围
	             var _start = _R1;
	             if(_R1 <= _Nn) _start = _Nn;
	             // 返回起始日期
	             return [_start, _R2];
	         }
	         
	      // 计算周期内(不可预约)的日期[_now:array]，_no表示不调用第三方接口时调用该函数
	         function computeOffDate_no(_date){
	             // 函数计算
	             var _cDate = new Date(_date[0], _date[1], 0),
	                 _total = _cDate.getDate(), _day = _date[2];
	                 _cDate.setDate(_day);
	             // 计算结束值
	             var _week = _cDate.getDay();
	             var _end = _day + dateCycle + 1;
	             if(_week == 0) _end++;
	             // 组装数据
	             var _pass = {}, _isY = true, _isM = true;
	             var _year = _date[0], _month = _date[1];
	             for(_day; _day <= _end;_day++){
	                 if(_day > _total){
	                     if(_isM) _month++, _isM = false;
	                     if(_month > 12){
	                         _month = 1;
	                         if(_isY) _year++, _isY = false;
	                     }
	                 }
	                 var _k1 = _year + _sprintf(_month);
	                 if(typeof(_pass[_k1]) === 'undefined') _pass[_k1] = {};

	                 var _v = _day <= _total ? _day : (_day - _total), _k2 = _sprintf(_v);
	                 _pass[_k1][_k2] = _v;
	             }
	             return _pass;
	         }
	      
	         // [函数]根据年月及是否当月 循环输出天数，_no表示不调用第三方接口时调用该函数
	         function loopDaysForWeek_no(_date){
	             // 根据年月 计算 当月前后空白位 和 月总天数
	             var _ary = computeDays(_date);
	             // 前空位数 & 月总天数 & 尾空位数
	             var _x = _ary[0], _y = _ary[1], _z = _ary[2];
	             // 当月已过期天数 & 结束月的不包含日期 的计算
	             // 例如:1.今天20，当月的20号前 不可选；2.截至6月10号，10号之后的都不可选
	             var _pass = _over = -1;
	             var _ccc = parseInt(_date[0] + _sprintf(_date[1])), 
	                 _fff = Math.floor(newDateRange[0] / 100),
	                 _lll = Math.floor(newDateRange[1] / 100);
	             if(_ccc === _fff) _pass = parseInt(newDateRange[0].toString().substr(6));
	             if(_ccc === _lll) _over = parseInt(newDateRange[1].toString().substr(6));
	             // 循环
	             var _html = '';
	             for(var i = 1, n = (_x + _y + _z); i <= n; i++){
	                 // 前 & 后的空白填补
	                 if((i <= _x) || (i > (_x + _y))){
	                     _html += '<li>&nbsp;</li>';
	                 }else{
	                     var _day = i - _x;
	                     var _class = 'on', _txt = '', _val = '';
	                     // 当前月份不到开始月份
	                     if(_fff > _ccc){
	                         _class = 'off';
	                     }else{
	                         // 当月已过日期 设为 不可选
	                         if((_pass > 0 && _day < _pass) || (_over > 0 && _day > _over)){
	                             _class = 'off';
	                         // 其他都为可预约[包含的不可预约后期处理]
	                         }else{
	                             _txt = '<i>预约</i>';
	                             _val = ' data-v="'+ _date[0] + '-' + _sprintf(_date[1]) + '-' + _sprintf(_day) +'"';
	                         }
	                     }
	                     _html += '<li class="'+ _class +' d'+ _sprintf(_day) +'"'+ _val +'>'+ _day + _txt + '</li>\n';
	                 }
	             }
	             // 创建元素 且 控制样式
	             $('.j-d-list').html(_html).find('li:nth-child(7n)').css({'width':90,'border-right':'none'});
	             // 设置不可预约的日期
	             var _key = _date[0] + _sprintf(_date[1]);
	             var _notList = passTime[_key];
	             if(typeof(_notList) !== 'undefined'){
	                 var items = '';
	                 $.each(_notList, function(i){ items += ', .d' + i; });
	                 items = items.substr(1);
	                 $(items).removeClass('on').addClass('off').find('i').text('不可预约');
	             } 
	         }
	         
	/************不调用第三方接口排期生成日历所需函数end************/
		// [函数]根据年月及是否当月 循环输出天数
		function loopDaysForWeek(_date){

			// 根据年月 计算 当月前后空白位 和 月总天数
			var _ary = computeDays(_date);

			// 前空位数 & 月总天数 & 尾空位数
			var _x = _ary[0], _y = _ary[1], _z = _ary[2];
			
			// 循环, 先设置为不可预约, 后期加上可预约
			var _html = '';
			for(var i = 1, n = (_x + _y + _z); i <= n; i++){

				// 前 & 后的空白填补
				if((i <= _x) || (i > (_x + _y))){

					_html += '<li>&nbsp;</li>';

				}else{
					
					var _day = i - _x;
					var _data = _date[0] + _sprintf(_date[1]) + _sprintf(_day);
					_html += '<li class="off d'+ _sprintf(_day) +'" data-v="'+ _data +'">'+ _day + '<i></i></li>\n';
				}
			}

			// 创建元素
			$('.j-d-list').html(_html).find('li:nth-child(7n)').css({'width':90,'border-right':'none'});

			// 设置可预约的日期
			var _key = _date[0] + _sprintf(_date[1]);
			var okTime = resetApiDate(apiDate, _key);
			var items = '';
			$.each(okTime, function(i, v){
				items += ',.d' + v;
			});
			items = items.substr(1);
			$(items).removeClass('off').addClass('on').find('i').text('可预约');
		}

		// [函数]生成 显示的年月 及 月份左右点击按钮
		function createYearMonthHtml(_range, _strNow){

			// 处理为年月的数值
			var _intStart = Math.floor(_range[0] / 100);
			var _intEnd = Math.floor(_range[1] / 100);
			var _aryNow = _strNow.split('-');
			var _intNow = Math.floor(parseInt(_aryNow.join('')) / 100);

			var _nowMonth = parseInt(_aryNow[1]);
			var _intPrev = _intNext = 0;

			// 向左侧点击
			if(_intNow > _intStart){
				_intPrev = _intNow - 1;
				if(_nowMonth <= 1) _intPrev = _intNow - 100 + 11;
			}

			// 向右侧点击
			if(_intNow < _intEnd){

				var _intNext = _intNow + 1;
				if(_nowMonth >= 12) _intNext = _intNow + 100 - 11;
			}

			var _set = $('.j-btn');
			_set.find('span').html(_nowMonth + '月&nbsp;&nbsp;'+ _aryNow[0] +'年');
			_set.find('a:first').attr('data-v', _intPrev);
			_set.find('a:last').attr('data-v', _intNext);

			// 不可点击样式
			var _noCls = 'no';
			if(_intPrev == 0) _set.find('a:first').addClass(_noCls);
			else _set.find('a:first').removeClass(_noCls);

			if(_intNext == 0) _set.find('a:last').addClass(_noCls);
			else _set.find('a:last').removeClass(_noCls);
		}

		// [函数]预定范围和当前日期比较，重置范围
		function resetDateRange(_range, _now){

			// 组合字符串
			var _R1 = _range[0].split('-').join(''), _R1 = parseInt(_R1);
			var _R2 = _range[1].split('-').join(''), _R2 = parseInt(_R2);
			var _Nn = _now.split('-').join(''), _Nn = parseInt(_Nn);
			
			// 比较大小 确定范围
			var _start = _R1;
			if(_R1 <= _Nn) _start = _Nn;

			// 返回起始日期
			return [_start, _R2];
		}

		// [函数]根据年月获取 当月总天数 && 当月第一天对应的星期值
		function computeDays(_date){

			// 函数计算
			var _cDate = new Date(_date[0], _date[1], 0),  _total = _cDate.getDate();

			// 设置当月第一天
			_cDate.setDate(1);
			var _dayWeek = _cDate.getDay();

			// 计算前后的空白值
			var _first = _dayWeek, _last = 7 - (_first + _total) % 7;

			// 返回总天数 & 月首对应的星期值
			return [_first, _total, _last];
		}

		// 补齐空位
		function _sprintf(_i){
	        return (_i < 10) ? '0' + _i : '' + _i;
	    }

	    // 获取当月的可预约日期[天]
	    function resetApiDate(_apiDate, _ym){
	    	var _retAry = [];
	    	$.each(_apiDate, function(_k, _v){
	    		var _ary = _v.split('-'), _YM = _ary[0] + '' + _ary[1];
	    		if(_YM == _ym) _retAry.push(_ary[2]);
	    	});
	    	return _retAry;
	    }

		// 预约[选中]
		$('body').on('click', '.j-d-list > li', function(){

			var _this = $(this);
			if(!_this.hasClass('on')) return false;

			var _val = _this.attr('data-v');
			var _str = _val.split('-').join('');
			var _k1 = _str.substr(0, 6), _k2 = _str.substr(6);
		
			if(_this.hasClass('at')){
				_this.removeClass('at').find('i').text('可预约');
				delete jsonTime[_k1][_k2];
				strKeep = strKeep.replace(',' + _str, '');
				hasDate--;
			}else{

				if(hasDate >= Max){
					alert('预约时间已达'+ Max +'个！');
					return false;
				}else{
					_this.addClass('at').find('i').text('预约成功');
					// 定义为Json格式
					if(typeof(jsonTime[_k1]) === 'undefined') jsonTime[_k1] = {};

					jsonTime[_k1][_k2] = _str;
					strKeep += ',' + _str;
					hasDate++;
				}
			}

			// 右侧显示预约时间
		    createRightDateHtml(strKeep);
			
		});
		

		// 确认所选
		$('#confirmTime').click(function(){

			// 
			if(hasDate <= 0){
				alert('请选择预约时间');
				return false;
			}else{
				var dateVal = strKeep.substr(1);
				dateVal= dateVal.substr(0, 4) + '-' + dateVal.substr(4, 2) + '-' + dateVal.substr(6, 2);
				$("#physicalDateStr").val(dateVal);
				alert('预约时间选择成功');
				$("#appointment").submit();
			}

			// Do somethings ... eg: ajax
			// ......
		});
		

	});
	</script>

</body>
</html>