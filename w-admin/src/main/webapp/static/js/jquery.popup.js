/**
 * 基于Jquery的弹窗 需加载对应的样式
 * 2015-03-11 Tony.zeng (intval@163.com)
 */
;$(function(){

	// 开启弹窗
	$('.j-pop-open').click(function(){
		try{
			var _this = $(this), _data = _this.attr('data-pop'), _ary = _data.split(',');
			if(_ary[1] == '1') doMask(true); // 是否开启遮罩
			doPopUp(_ary[0], true, _ary[1], _ary[2], _ary[3]);
		}catch(e){}
	});

	// 关闭弹窗
	$('.j-pop-cancel').click(function(){
		try{
			var _this = $(this), _data = _this.parent().parent().find('.j-pop-data').val(), _ary = _data.split(',');
			if(_ary[1] === '1') doMask(false); // 是否关闭遮罩
			doPopUp(_ary[0], false);
		}catch(e){
		}
	});

	// 提交弹窗
	$('.j-pop-sure').click(function(){
		var _this = $(this), _data = _this.parent().parent().find('.j-pop-data').val(), _ary = _data.split(',');
		if(_ary[2] != '0'){
			var _go = callbackPop(_ary[2]);
			if(_go){
				if(_ary[1] === '1') doMask(false); // 是否关闭遮罩
				doPopUp(_ary[0], false);
			}
		}
	});

	// 确定的回滚函数
	function callbackPop(_funcName){
		eval('var bool = '+ _funcName +'();');
		return bool;
	}

	// 操作弹窗
	function doPopUp(_id, _bool, _lev, _call, _pos){
		var _pop = $('#j-pop-' + _id);
		if(_bool){
			var _zv = _pos || 'vam';
			var _lv = _lev || '0';
			var _callback = _call || '0';
			_pop.css('z-index', 1001 + parseInt(_lev)).show().find('td').addClass('z-' + _pos).find('.j-pop-data').val(_id + ',' + _lv + ',' + _callback);
		}else{
			_pop.hide();
		}
	}

	// 操作遮罩
	function doMask(_bool){
		var _id = 'm-mask', _mask = $('#' + _id);
		if(_bool){
			if(_mask.length === 1){
				_mask.show();
			}else{
				$('<div id="'+ _id +'"></div>').appendTo('body').css('opacity','.2');
			}
		}else{
			_mask.hide();
		}
	}
});