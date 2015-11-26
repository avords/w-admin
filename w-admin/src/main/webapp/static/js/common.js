var isBusyFlag = false;

if (typeof String.prototype.endsWith !== 'function') {
	String.prototype.endsWith = function(suffix) {
		return this.indexOf(suffix, this.length - suffix.length) !== -1;
	};
}

String.prototype.trim = function() {
	return this.replace(/(^\s*)|(\s*$)/g, "");
};

function toUrl(url) {
	window.location = url;
}

function ecFormSubmit(formId, action, method) {
	try {
		if (formId == null) {
			formId = "ec";
		}
		if (action != "") {
			$("#" + formId).attr("action", action);
		}
		if (method != "") {
			$("#" + formId).attr("method", method);
		}
		var cdr = $("input[name='ec_crd']");
		if (cdr.val() == -999) {
			var total = $("#ec_tc").val();
			if (total == undefined) {
				cdr.val("0");
			} else if (total != "") {
				cdr.val(total.replace(",", ""));
			}
		}
	} catch (e) {
	}
	$("#" + formId).submit();
}

function toDeleteUrl(url) {
	if (confirm(sureToDelete)) {
		window.location = url;
	}
}

function toUrl(url,tip) {
	if (confirm(tip)) {
		window.location = url;
	}
}

var selectNames = new Array();
var selectOptions = new Array();
var filterValues = new Array();
var includeText = new Array();
/**
 * 添加包括的内容
 */
function addIncludeText(in_text) {
	includeText[includeText.length] = in_text;
}
/**
 * 清空已备份选项数据
 */
function clearBackupOption(select_obj) {
	// 查出已备份数据
	var index_new = -1;
	for (var i = 0; i < selectNames.length; i++) {
		if (select_obj.name == selectNames[i]) {
			index_new = i;
			break;
		}
	}
	// 清空已备份的数据
	selectOptions[index_new] = null;
	selectNames[index_new] = null;
	filterValues[index_new] = null;
}
/**
 * 备份选项数据
 */
function backupOption(input_value, select_obj, index, filterProperty) {
	// 检查选项是否已有备份
	if (index > 0 && selectOptions[index] != null) {
		retrun;
	}
	var backup_selectOptions = new Array(select_obj.options.length);
	for (var i = 0; i < backup_selectOptions.length; i++) {
		backup_selectOptions[i] = select_obj.options[i];
	}
	var index_new = selectNames.length;
	selectNames[index_new] = select_obj.name;
	selectOptions[index_new] = backup_selectOptions;
}
/**
 * 还原选项数据
 */
function restoreOption(input_value, select_obj, index, filterProperty) {
	if (index < 0) {
		retrun;
	}
	var backup_selectOptions = selectOptions[index];
	if (backup_selectOptions == null) {
		return;
	}
	if (backup_selectOptions.length != select_obj.options.length) {
		select_obj.options.length = 0;
		for (var i = 0; i < backup_selectOptions.length; i++) {
			select_obj.options[i] = backup_selectOptions[i];
		}
	}
	filterValues[index] = "";
	// 设置缺省选中
	if (select_obj.options.length >= 1) {
		select_obj.options[0].selected = true;
	}
	if (select_obj.onchange) {
		select_obj.onchange(select_obj);
	}
}
/**
 * 过滤选项数据
 */
function doFilter(input_value, select_obj, index, filterProperty) {
	if (input_value == "") {
		return;
	}
	// 过滤内容，缺省大小写不敏感
	var caseSensitive = false;
	var keystr = input_value;
	if (!caseSensitive) {
		keystr = keystr.toUpperCase();
	}

	// 备份下拉框中已选中的value值
	var selected_option_value;
	if (select_obj.selectedIndex >= 0) {
		selected_option_value = select_obj.options[select_obj.selectedIndex].value;
	}

	// 如果有备份，取备份中的数据来过滤
	var index_new = -1;
	for (var i = 0; i < selectNames.length; i++) {
		if (select_obj.name == selectNames[i]) {
			index_new = i;
			break;
		}
	}
	var filter_Options;
	if (index_new == -1) {
		filter_Options = select_obj.options;
	} else {
		filter_Options = selectOptions[index_new];
	}
	// 过滤
	var new_selectOptions = new Array(0);
	var selectLength = filter_Options.length;
	for (var i = 0; i < selectLength; i++) {
		// 取得需要搜索的属性内容
		var searchText = eval("filter_Options[i]." + filterProperty);
		if (!caseSensitive) {
			searchText = searchText.toUpperCase();
		}
		var include = false;
		for (var j = 0; j < includeText.length; j++) {
			if (searchText == includeText[i]) {
				include = true;
				break;
			}
		}
		if (include || searchText.indexOf(keystr) != -1) {
			new_selectOptions[new_selectOptions.length] = filter_Options[i];
		}
	}
	// 如果过滤出内容(20060619)
	if (select_obj.options != new_selectOptions) {
		select_obj.options.length = 0;
		for (var i = 0; i < new_selectOptions.length; i++) {
			select_obj.options[i] = new_selectOptions[i];
		}
		// 设置缺省选中，如果已有备份的value值则搜索并选中
		if (selected_option_value != "") {
			for (var i = 0; i < select_obj.length; i++) {
				if (selected_option_value == select_obj.options[i].value) {
					select_obj.options[i].selected = true;
				} else {
					select_obj.options[i].selected = false;
				}
			}
		}
		// 如果还未选中，则设置第一个为选中
		if (select_obj.options.length >= 1 && select_obj.selectedIndex == -1) {
			select_obj.options[0].selected = true;
		}
		if (select_obj.onchange) {
			select_obj.onchange(select_obj);
		}
	}
	// 备份过滤命令
	filterValues[index] = input_value;
}
/**
 * 通过特定值过滤下拉选项框中内容 input_value 过滤值 select_obj 需要做过滤的下拉框
 */
function fireFilter(input_value, select_obj, filterProperty) {
	if (select_obj == null || select_obj.disabled) {
		return;
	}
	// 缺省通过Option对象的text属性来做过滤
	if (!filterProperty) {
		filterProperty = "text";
	}
	var input_value = input_value.trim();
	// 检查选项是否有备份
	var index = -1;
	for (var i = 0; i < selectNames.length; i++) {
		if (select_obj.name == selectNames[i]) {
			index = i;
			break;
		}
	}

	// 判断需要作的动作
	var action = new Array();
	if (index == -1) {
		action[action.length] = "backupOption";
	}
	if (input_value == "" && index >= 0) {
		action[action.length] = "restoreOption";
	}
	if (input_value != "") {
		action[action.length] = "doFilter";
	}
	for (var i = 0; i < action.length; i++) {
		eval(action[i] + "(input_value,select_obj,index,filterProperty)");
	}
}

function selectMove(index) {
	index = index || "";
	var leftToRight = "leftToRight" + index;
	var rightToLeft = "rightToLeft" + index;
	var allLeftToRight = "allLeftToRight" + index;
	var allRightToLeft = "allRightToLeft" + index;
	var selected = "selected" + index;
	var unSelected = "unSelected" + index;
	$(document).ready(function() {
		$('#' + leftToRight).click(function() {
			var $options = $('#' + selected + ' option:selected');
			var $remove = $options.remove();
			$remove.appendTo('#' + unSelected);
		});

		$('#' + rightToLeft).click(function() {
			var $removeOptions = $('#' + unSelected + ' option:selected');
			$removeOptions.appendTo('#' + selected);
		});

		$('#' + allLeftToRight).click(function() {
			var $options = $('#' + selected + ' option');
			$options.appendTo('#' + unSelected);
		});

		$('#' + allRightToLeft).click(function() {
			var $options = $('#' + unSelected + ' option');
			$options.appendTo('#' + selected);
		});

		$('#' + selected).dblclick(function() {
			var $options = $('option:selected', this);
			$options.appendTo('#' + unSelected);
		});

		$('#' + unSelected).dblclick(function() {
			$('#' + unSelected + ' option:selected').appendTo('#' + selected);
		});
	});
}

function deleteCookie(name, path, domain) {
	var expires = new Date();
	expires.setTime(-1);
	setCookie(name, "", expires, path, domain, false);
}

function setCookie(name, value, expiry, path, domain, secure) {
	var nameString = name + "=" + value;
	var expiryString = (expiry == null) ? "" : " ;expires = "
			+ expiry.toGMTString();
	var pathString = (path == null) ? "" : " ;path = " + path;
	var domainString = (path == null) ? "" : " ;domain = " + domain;
	var secureString = (secure) ? ";secure" : "";
	document.cookie = nameString + expiryString + pathString + domainString
			+ secureString;
}

function getCookie(sName) {
	var aCookie = document.cookie.split("; ");
	for (var i = 0; i < aCookie.length; i++) {
		var aCrumb = aCookie[i].split("=");
		if (sName == aCrumb[0])
			return unescape(aCrumb[1]);
	}
	return null;
}

function getParameterMap(form) {
	var p = document.forms[form].elements;
	var map = new Object();
	for (var x = 0; x < p.length; x++) {
		var key = p[x].name;
		var val = p[x].value;
		var curVal = map[key];
		if (curVal) {
			curVal[curVal.length] = val;
		} else {
			map[key] = [ val ];
		}
	}
	return map;
}

function setFormAction(form, action, method) {
	if (action) {
		document.forms[form].setAttribute('action', action);
	}
	if (method) {
		document.forms[form].setAttribute('method', method);
	}
	document.forms[form].ec_eti.value = '';
}

/**
 * 输入你希望根据页面高度自动调整高度的iframe
 */
function dyniframesize(dyniframe, minHeight) {
	var theHeigh = 0;
	dyniframe.height = theHeigh;
	if (dyniframe.Document) {
		var bHeight = dyniframe.contentWindow.document.body.scrollHeight;
		var dHeight = dyniframe.contentWindow.document.documentElement.scrollHeight;
		theHeigh = Math.max(bHeight, dHeight);
	} else {
		var bHeight = dyniframe.contentDocument.body.scrollHeight;
		var dHeight = dyniframe.contentDocument.documentElement.scrollHeight;
		theHeigh = Math.max(bHeight, dHeight);
	}
	if (theHeigh > minHeight) {
		dyniframe.height = theHeigh;
	} else {
		dyniframe.height = minHeight;
	}
}

/**
 * 输入你希望根据页面高度自动调整高度的iframe
 */
function dyniframesizeBoth(dyniframe, minHeight, minWidth) {
	dyniframe.height = 0;
	dyniframe.width = 0;
	var theHeigh = 0;
	var theWidth = 0;
	if (dyniframe.Document) {
		theHeigh = dyniframe.Document.body.scrollHeight;
		theWidth = dyniframe.Document.body.scrollWidth;
	} else {
		theHeigh = dyniframe.contentDocument.body.offsetHeight;
		theWidth = dyniframe.contentDocument.body.offsetWidth;
	}
	if (theWidth > minWidth) {
		dyniframe.width = theWidth;
	} else {
		dyniframe.width = minWidth;
	}
	if (theHeigh > minHeight) {
		dyniframe.height = theHeigh;
	} else {
		dyniframe.height = minHeight;
	}
}

function iframeAutoFit(inDocument) {
	if (inDocument) {
		var documentSrc = inDocument.src.toString();
		if ((documentSrc.indexOf("http://") == -1 || documentSrc
				.indexOf(rootUrl) == 0)) {
			try {
				dyniframesize(inDocument, minHeight, "100%");
			} catch (e) {
				// nothing to do
			}
		}
	}
}

function isNeedValidate(e) {
	return e.val() != undefined;
}

function getElementValue(e) {
	var name = e.attr("name");
	if (e.is(":radio")) {
		var v = $("input[name='" + name + "']:checked").val();
		return v == undefined ? "" : v;
	} else if (e.is(":checkbox")) {
		var v = $("input[name='" + name + "']:checked").val();
		return v == undefined ? "" : v;
	} else {
		return e.val();
	}
}

function strToDate(str) {
	var arys = new Array();
	arys = str.split('-');
	var newDate = new Date(arys[0], arys[1] - 1, arys[2]);
	return newDate;
}

function deleteData() {
	if (confirm("确定要删除此数据吗?")) {
		return true;
	}
	return false;
}

/**
 * validation
 */
function isNull(str) {
	if (null == str || "" == str.trim()) {
		return true;
	} else {
		return false;
	}
};

function isFloat(str) {
	var patrn = /^([+-]?)\d*\.\d+$/;
	return patrn.test(str);
};

function isInteger(str) {
	var patrn = /^([+-]?)(\d+)$/;
	return patrn.test(str);
};

function isPlusInteger(str) {
	var patrn = /^([+]?)(\d+)$/;
	return patrn.test(str);
};

function isMinusInteger(str) {
	var patrn = /^-(\d+)$/;
	return patrn.test(str);
};

function isDigit(str) {
	var patrn = /^\d+$/;
	return patrn.test(str);
};

function isChinese(str) {
	var patrn = /[\u4E00-\u9FA5\uF900-\uFA2D]+$/;
	return patrn.test(str);
};

function isAcsii(str) {
	var patrn = /^[\x00-\xFF]+$/;
	return patrn.test(str);
};

function isEmail(str) {
	var patrn = /^[\w-]+@[\w-]+(\.[\w-]+)+$/;
	return patrn.test(str);
};

function isBusy() {
	if (isBusyFlag) {
		return true;
	} else {
		isBusyFlag = true;
		return false;
	}
}
function resetBusy() {
	isBusyFlag = false;
}

/**
 * 点击列表head的checkbox引发的操作：全选子checkbox或者反全选
 */
function pchkClick(schk, pchk) {
	schk = schk || "schk";
	pchk = pchk || "pchk";
	var _subcheck = $(":checkbox[name='" + schk + "']");
	var _pcheck = $(":checkbox[name='" + pchk + "']");
	var p = _pcheck.attr("checked");
	if (!p) {
		p = false;
	} else {
		p = true;
	}
	if (_subcheck == undefined) {
		return;
	}
	if (_subcheck.length == undefined) {
		_subcheck.attr("checked", p);
	} else {
		_subcheck.each(function() {
			$(this).attr("checked", p);
		});
	}
}

/**
 * 点击子checkbox引发的操作：如当前子checkbox都选中，那么点击子checkbox使父checkbox选中取消
 */
function schkClick(schk, pchk) {
	schk = schk || "schk";
	pchk = pchk || "pchk";
	var _subcheck = $(":checkbox[name='" + schk + "']");
	var _pcheck = $(":checkbox[name='" + pchk + "']");
	if (_subcheck == undefined) {
		return;
	}
	var flag = true;
	if (_subcheck.length == undefined) {
		_pcheck.attr("checked", _subcheck.attr("checked"));
	} else {
		_subcheck.each(function() {
			if (!$(this).attr("checked")) {
				_pcheck.attr("checked", false);
				flag = false;
			}
		});
		if (flag == true) {
			_pcheck.attr("checked", true);
		}
	}
}

/**
 * 获得复选框的值,以split分隔的字符串
 */
function getCheckedValuesString(checkItem, split) {
	if (split == null) {
		split = ",";
	}
	var str = null;
	if (typeof (checkItem) == 'undefined')
		return null;
	if (typeof (checkItem.length) == 'undefined') {
		if (checkItem.checked == true)
			return appendSplit(str, checkItem.value, split);
		else
			return null;
	}
	str = "";
	for (i = 0; i < checkItem.length; i++) {
		if (checkItem[i].checked == true) {
			str = appendSplit(str, checkItem[i].value, split);
		}
	}
	if (str == "") {
		return null;
	}
	return str;
}

/**
 * 拼凑字符串的分隔符,如果是第一个,则不加分隔符,否则加分隔符
 */
function appendSplit(str, strAppend, split) {
	if (str == null || str == "") {
		return strAppend;
	} else {
		return str + split + strAppend;
	}
}

Date.prototype.format = function(mask) {
	var d = this;
	var zeroize = function(value, length) {
		if (!length)
			length = 2;
		value = String(value);
		for (var i = 0, zeros = ''; i < (length - value.length); i++) {
			zeros += '0';
		}
		return zeros + value;
	};

	return mask
			.replace(
					/"[^"]*"|'[^']*'|\b(?:d{1,4}|m{1,4}|yy(?:yy)?|([hHMstT])\1?|[lLZ])\b/g,
					function($0) {
						switch ($0) {
						case 'd':
							return d.getDate();
						case 'dd':
							return zeroize(d.getDate());
						case 'ddd':
							return [ 'Sun', 'Mon', 'Tue', 'Wed', 'Thr', 'Fri',
									'Sat' ][d.getDay()];
						case 'dddd':
							return [ 'Sunday', 'Monday', 'Tuesday',
									'Wednesday', 'Thursday', 'Friday',
									'Saturday' ][d.getDay()];
						case 'M':
							return d.getMonth() + 1;
						case 'MM':
							return zeroize(d.getMonth() + 1);
						case 'MMM':
							return [ 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
									'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' ][d
									.getMonth()];
						case 'MMMM':
							return [ 'January', 'February', 'March', 'April',
									'May', 'June', 'July', 'August',
									'September', 'October', 'November',
									'December' ][d.getMonth()];
						case 'yy':
							return String(d.getFullYear()).substr(2);
						case 'yyyy':
							return d.getFullYear();
						case 'h':
							return d.getHours() % 12 || 12;
						case 'hh':
							return zeroize(d.getHours() % 12 || 12);
						case 'H':
							return d.getHours();
						case 'HH':
							return zeroize(d.getHours());
						case 'm':
							return d.getMinutes();
						case 'mm':
							return zeroize(d.getMinutes());
						case 's':
							return d.getSeconds();
						case 'ss':
							return zeroize(d.getSeconds());
						case 'l':
							return zeroize(d.getMilliseconds(), 3);
						case 'L':
							var m = d.getMilliseconds();
							if (m > 99)
								m = Math.round(m / 10);
							return zeroize(m);
						case 'tt':
							return d.getHours() < 12 ? 'am' : 'pm';
						case 'TT':
							return d.getHours() < 12 ? 'AM' : 'PM';
						case 'Z':
							return d.toUTCString().match(/[A-Z]+$/);
							// Return quoted strings with the surrounding quotes
							// removed
						default:
							return $0.substr(1, $0.length - 2);
						}
					});
};


function viewPage(formId) {
	var theForm = formId == null ? $("form:first") : $("#" + formId);
	var items = $("input,select,textarea,chechbox", theForm);
	items
			.each(function() {
				var name = this.name;
				var type = this.type;
				if (type == "text") {
					var value = $('[name=' + name + ']').val();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "textarea") {
					var value = $('[name=' + name + ']').val();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "select-one") {
					var value = $('[name=' + name + ']')
							.find('option:selected').text();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "radio") {
					var ckEle = $("input[name='" + name + "']:checked");
					if (ckEle != undefined) {
						var title = ckEle.next().first().text();
						var ckEles = $("input[name='" + name + "']");
						var nSpan = "<span>" + title + "</span>";
					}
					$(this).next().remove();
					$(this).parent().append(nSpan);
					$(this).remove();
				}
				if (type == "checkbox") {
					var ckEle = $("input[name='" + name + "']:checked");
					if (ckEle != undefined) {
						var title = ckEle.next().first().text();
						var ckEles = $("input[name='" + name + "']");
						var nSpan = "<span>" + title + "</span>";
					}
					$(this).next().remove();
					$(this).parent().append(nSpan);
					$(this).remove();
				}
			});
}

function viewForm(formId) {
	var theForm = formId == null ? $("form:first") : $("#" + formId);
	var items = $("input,select,textarea,chechbox", theForm);
	items
			.each(function() {
				var name = this.name;
				var type = this.type;
				if (type == "text") {
					var value = $('[name=' + name + ']').val();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "textarea") {
					var value = $('[name=' + name + ']').val();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "select-one") {
					var value = $('[name=' + name + ']')
							.find('option:selected').text();
					$('[name=' + name + ']').replaceWith(
							"<span>" + value + "</span>");
				}
				if (type == "radio") {
					var ckEle = $("input[name='" + name + "']:checked");
					if (ckEle != undefined) {
						var title = ckEle.next().first().text();
						var ckEles = $("input[name='" + name + "']");
						var nSpan = "<span>" + title + "</span>";
					}
					$(this).next().remove();
					$(this).parent().append(nSpan);
					$(this).remove();
				}
				if (type == "checkbox") {
					var ckEle = $("input[name='" + name + "']:checked");
					if (ckEle != undefined) {
						var title = ckEle.next().first().text();
						var ckEles = $("input[name='" + name + "']");
						var nSpan = "<span>" + title + "</span>";
					}
					$(this).next().remove();
					$(this).parent().append(nSpan);
					$(this).remove();
				}
			});
}

// The flag to control the list page refresh event after the pop up page closed.
var reloadParent = true;
var inProcess = "";
$(function() {
	try{
		$(".colorbox").colorbox({
			opacity : 0.2,
			fixed : true,
			width : "55%",
			height : "75%",
			iframe : true,
			close:"",
			onClosed : function() {
				if (reloadParent) {
					location.search=location.search.replace(/message.*&/,"");
				}
			},
			overlayClose : false
		});
	}catch(e){
		
	}
	try{
		$(".colorbox-big").colorbox({
			opacity : 0.2,
			fixed : true,
			width : "65%",
			height : "90%",
			iframe : true,
			close:"",
			onClosed : function() {
				if (reloadParent) {
					location.search=location.search.replace(/message.*&/,"");
				}
			},
			overlayClose : false
		});
	}catch(e){
		
	}
	try{
	$(".colorbox-mini").colorbox({
		opacity : 0.2,
		fixed : true,
		innerWidth : "28%",
		innerHeight : "80%",
		iframe : false,
		close:"",
		onClosed : function() {
			if (reloadParent) {
				location.search=location.search.replace(/message.*&/,"");
			}
		},
		overlayClose : false
	});
	}catch(e){
		
	}
	
	try{
		$(".colorbox-mini-iframe").colorbox({
			opacity : 0.2,
			fixed : true,
			innerWidth : "28%",
			innerHeight : "80%",
			iframe : true,
			close:"",
			onClosed : function() {
				if (reloadParent) {
					location.search=location.search.replace(/message.*&/,"");
				}
			},
			overlayClose : false
		});
		}catch(e){
			
	}
	try{
	$(".colorbox-double").colorbox({
		opacity : 0.2,
		fixed : false,
		innerWidth : "56%",
		innerHeight : "90%",
		iframe : false,
		close:"",
		onClosed : function() {
			location.search=location.search.replace(/message.*&/,"");
		},
		overlayClose : false
	});
	}catch(e){
		
	}
	try{
	$(".colorbox-double-norefresh").colorbox({
		opacity : 0.2,
		fixed : false,
		innerWidth : "56%",
		innerHeight : "90%",
		iframe : false,
		close:"",
		onClosed : function() {
			if (reloadParent) {
//				location.reload(true);
			}
		},
		overlayClose : false
	});
	}catch(e){
		
	}
	try{
	$(".colorbox-template").colorbox({
		opacity : 0.2,
		fixed : true,
		innerWidth : "39%",
		innerHeight : "80%",
		iframe : true,
		close:"",
		onClosed : function() {
			if (reloadParent) {
//				location.reload(true);
			}
		},
		overlayClose : true
	});
	}catch(e){
		
	}
	try{
	$(".colorbox-double-template").colorbox({
		opacity : 0.2,
		fixed : false,
		innerWidth : "69%",
		innerHeight : "80%",
		iframe : true,
		close:"",
		onClosed : function() {
			if (reloadParent) {
//				location.reload(true);
			}
		},
		overlayClose : true
	});
	}catch(e){
		
	}
	try {
		if(inProcess==""){
			inProcess = "...";
		}
		var messageBox = $('#messageBox');
		if (messageBox.text().trim() != "") {
			messageBox.show();
		} else {
			messageBox.hide();
		}
		$(":submit").not(".noProgress").click(function(event){
			event.preventDefault();			
			if($(":disabled.excluede").length){
				return false;
			}
			var form = $(this).closest("form");
			var valid = true;
			if(form){
				try{
					valid = form.valid();
				}catch(e){
				}
			}
			if(valid){
				try{
					valid = customeValid();
				}catch(e){
				}
			}
			if(valid){
				var method =  $(this).attr("validateMethod");
				if(method){
					try{
						valid = eval(method);
					}catch(e){
					}
				}
			}
			if(valid){
				refreshParentPage(true);
				var text = $(this).html();
				if(text.trim().length>0){
					text = text.trim() + inProcess;
				}
				$(this).attr("disabled", true).html(text);
				form.submit();
			}
		});

		// The specific progress button
		var progressBtn = $("#progressBtn");
		if (!progressBtn.val()) {
			progressBtn = $(".progressBtn");
		}
		progressBtn.click(function() {
			var form = $(this).closest("form");
			var valid = true;
			if(form){
				try{
					valid = form.valid();
				}catch(e){
				}
			}
			if(valid){
				try{
					valid = customeValid();
				}catch(e){
				}
			}
			if(valid){
				var method =  $(this).attr("validateMethod");
				if(method){
					try{
						valid = eval(method);
					}catch(e){
					}
				}
			}
			if(valid){
				var text = $(this).html();
				if(text.trim().length>0){
					text = text.trim() + inProcess;
				}
				$(this).attr("disabled", true).html(text);
			}
		});
	} catch (e) {
	}
});

function refreshParentPage(bool) {
	try {
		parent.reloadParent = bool;
	} catch (e) {
	}
}

function clearForm(ele) {
	$(ele).closest("form").find(':input').each(function() {
		switch (this.type) {
		case 'password':
		case 'select-multiple':
		case 'select-one':
		case 'text':
		case 'textarea':
			$(this).val('');
			break;
		case 'checkbox':
		case 'radio':
			this.checked = false;
		}
	});
}

var msgTimer;
function showMessage(msg, last) {
	var messageBox = $('#messageBox');
	messageBox.text(msg);
	messageBox.show();
	if (msgTimer != null) {
		window.clearTimeout(msgTimer);
	}
	if (last) {
		msgTimer = window.setTimeout("$('#messageBox').hide('slow')", last);
	}
}

function mixLenCheck(s) { 
	var len=0;
	for(var i=0;i<s.length;i++) { 
		if ((s.charCodeAt(i)>=0) && (s.charCodeAt(i)<=255)) {
			len += 1;
		}else {
			len += 2;
		}
	}
	return len; 
}