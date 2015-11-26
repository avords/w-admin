var leftArray = new Array();
var rightArray = new Array();
var lastRightArray = new Array();
var lastLeftArray = new Array();
var currentLeftArray = new Array();

function init(leftSelectId,rightSelectId){                   //初始化左边右边文本框的值
	var leftSelect = document.getElementById(leftSelectId);
	var rightSelect = document.getElementById(rightSelectId);
	for (var i = 0; i < leftSelect.length; i++) {        //左边文本框的值放入leftArray
		leftArray[i] = new Array();
			leftArray[i].text=leftSelect.options[i].text;
			leftArray[i].value=leftSelect.options[i].value;
	}
	for (var i = 0; i < rightSelect.length; i++) {       //右边文本框的值放入rightArray
		rightArray[i] = new Array();
			rightArray[i].text=rightSelect.options[i].text;
			rightArray[i].value=rightSelect.options[i].value;
	}
	lastRightArray = copyArray(rightArray);                     //左边最后文本框的值放入lastRightArray
	lastLeftArray = copyArray(leftArray);
}

function leftToRight(leftDel){                              //把左边文本框的值导入右边
	var temp = new Array();
	for(var i =0;i<leftArray.length;i++){
		var flag = 0;
		for(var j =0;j<leftDel.length;j++){
			if(leftArray[i].value == leftDel[j].value){
				rightArray.push(leftArray[i]);
				flag = 1;
				break;
			}
		}
		if(flag==0){
			temp.push(leftArray[i]);
		}
	}
	leftArray = copyArray(temp);
	selectOptions = copyArray(leftArray);
	lastRightArray=copyArray(rightArray);
	lastLeftArray = copyArray(leftArray);
}

function copyArray(source){
	var target = new Array();
	for(var i=0;i<source.length;i++){
		var kk = target.length;
        target[kk] = new Array();
        target[kk].value=source[i].value;
        target[kk].text=source[i].text;
	}
	return target;
}

function rightToLeft(rightDel){
	var temp = new Array();
	for(var i =0;i<rightArray.length;i++){
		var flag = 0;
		for(var j =0;j<rightDel.length;j++){
			if(rightArray[i].value == rightDel[j].value){
				flag = 1;
				leftArray.push(rightArray[i]);
				break;
			}
		}
		if(flag==0){
			temp.push(rightArray[i]);
		}
	}
	rightArray = temp;
	selectOptions = copyArray(leftArray);
	lastRightArray=copyArray(rightArray);
	lastLeftArray = copyArray(leftArray);
}

function moveIt(oSource, oTarget,direct) {
    if (!oSource.options.length) {
        return;
    }else {
    	var mySld = new Array();
	    var del = new Array();
	    var all = oSource.selectedIndex == -1;
	    for (i = 0; i < oSource.options.length; i++) {
	        if (oSource.options[i].selected||all) {
	            mySld[mySld.length++] = i;
	            var kk = del.length;
	            del[kk] = new Array();
	            del[kk].value=oSource.options[i].value;
	            del[kk].text=oSource.options[i].text;
	        }
	    }
	    for (i = 0; i < mySld.length; i++) {
	        oTarget.options.length++;
	        oTarget.options[oTarget.options.length - 1].text = oSource.options[mySld[i]].text;
	        oTarget.options[oTarget.options.length - 1].value = oSource.options[mySld[i]].value;
	    }
	    for (i = 0; i < mySld.length; i++) {
	        for (j = mySld[i] - i; j < oSource.options.length - 1; j++) {
	            oSource.options[j].text = oSource.options[j + 1].text;
	            oSource.options[j].value = oSource.options[j + 1].value;
	        }
	        oSource.options.length--;
	    }
	    if (oSource.options.length >= 1) {
	        oSource.options.selectedIndex = -1;
	    }
	    if(direct==1){
	    	leftToRight(del);
	    }else if(direct==2){
	    	rightToLeft(del);
	    }
    }
}

function selectMoveAll(s, t) {
    var n = t.options.length;
    t.options.length = n + s.options.length;
    for (i = n; i < t.options.length; i++) {
        t.options[i].text = s.options[i - n].text;
        t.options[i].value = s.options[i - n].value;
    }
    s.options.length = 0;
}

var flag = false;
function doMyFilter(input, select_obj,formType) {
	var input_value = "";
	var doFilterRightArray;
	if(formType == 1){
		input_value=input.options[input.selectedIndex].text;
		doFilterRightArray=copyArray(lastRightArray);
		flag = true;
	}else if(formType == 2){
		input_value=input;
		if(flag){
			doFilterRightArray=copyArray(currentLeftArray);
		}else{
			doFilterRightArray=copyArray(lastRightArray);
		}
	}
	
    if (input_value == "") {
        select_obj.options.length = 0;
        if(formType==1){
			currentLeftArray=copyArray(lastRightArray);
		}
		for (var i = 0; i < lastRightArray.length; i++) {
			var option = new Option(lastRightArray[i].text,lastRightArray[i].value);
			select_obj.options[i] = option;
		}
    }else{
	    var keystr = input_value;
        var new_selectOptions = new Array(); 
        for(var i=0;i<doFilterRightArray.length;i++){
        	if(doFilterRightArray[i].text.indexOf(keystr)!=-1){
        		new_selectOptions[new_selectOptions.length] = doFilterRightArray[i];
        	}
        }
		if(formType==1){
			currentLeftArray=copyArray(new_selectOptions);
		}
		if (select_obj.options != new_selectOptions) {
			select_obj.options.length = 0;
			for (var i = 0; i < new_selectOptions.length; i++) {
				var option = new Option(new_selectOptions[i].text,new_selectOptions[i].value);
	 			select_obj.options[i] = option;
			}
		}
    }
}

function doMyFilterLeft(input, select_obj,formType) {
	var input_value = "";
	var doFilterRightArray;
	if(formType == 1){
		input_value=input.options[input.selectedIndex].text;
		doFilterRightArray=copyArray(lastLeftArray);
		flag = true;
	}else if(formType == 2){
		input_value=input;
		if(flag){
			doFilterRightArray=copyArray(currentRightArray);
		}else{
			doFilterRightArray=copyArray(lastLeftArray);
		}
	}
	
    if (input_value == "") {
    	restoreOption(select_obj,formType);
    }else{
	    var keystr = input_value;
        var new_selectOptions = new Array(); 
        for(var i=0;i<doFilterRightArray.length;i++){
        	if(doFilterRightArray[i].text.indexOf(keystr)!=-1){
        		new_selectOptions[new_selectOptions.length] = doFilterRightArray[i];
        	}
        }
		if(formType==1){
			currentRightArray=copyArray(new_selectOptions);
		}
		if (select_obj.options != new_selectOptions) {
			select_obj.options.length = 0;
			for (var i = 0; i < new_selectOptions.length; i++) {
				var option = new Option(new_selectOptions[i].text,new_selectOptions[i].value);
	 			select_obj.options[i] = option;
			}
		}
    }
}

function restoreOption(select_obj,formType){
	select_obj.options.length = 0;
    if(formType==1){
		currentLeftArray=copyArray(lastLeftArray);
	}
	for (var i = 0; i < lastLeftArray.length; i++) {
		var option = new Option(lastLeftArray[i].text,lastLeftArray[i].value);
		select_obj.options[i] = option;
	}
}


function filterMultSelect(left,right,toLeft,toRight,leftFilterInput,rightFilterInput,leftFilterButton,rightFilterButton){
	init(left,right);
	$("#" + toLeft).bind("click",function(){moveIt(document.getElementById(right),document.getElementById(left),2);});					//左边到右边
	$("#" + toRight).bind("click",function(){moveIt(document.getElementById(left),document.getElementById(right),1);});					//右边到左边
	$("#" + left).bind("dblclick",function(){moveIt(document.getElementById(left),document.getElementById(right),1);});		//left中数据到right中的双击事件
	$("#" + right).bind("dblclick",function(){moveIt(document.getElementById(right),document.getElementById(left),2);});		//right中到left中的双击事件unauthorized
	$("#" + leftFilterInput).bind("keypress",function(event){
		event = event ? event :(window.event ? window.event : null);
		if(event.keyCode==13){
			event.keyCode=9; 
			doMyFilterLeft($(this).val(),document.getElementById(left),2);
			return false;
		}
	});
	
	$("#" + rightFilterInput).bind("keypress",function(event){
		event = event ? event :(window.event ? window.event : null);
		if(event.keyCode==13){
			event.keyCode=9; 
			doMyFilter($(this).val(),document.getElementById(right),2);
			return false;
		}
	});
}