function getAreaChildren(child,parent){
	var code = $(parent).val();
	if(code && code!=""){
		$.ajax({
			url: appRoot  + '/area/getChildren/' + code,
			type : 'post',
			dataType : 'json',
			success : function(data) {
				 var name = $("#" + child + "");
			     name.children().remove();
			     var options = "<option value=''>全国</option>";
				 for(var i=0;i<data.areas.length;i++){
					options +=("<option value='" +data.areas[i].areaCode + "'>" + data.areas[i].name+"</option>");
				 }
				 name.append(options).val("").change();
			}
		});
	}else{
		var name = $("#" + child + "");
		name.empty().val("").change();
	}
}

function initDefaultArea(areaCode){
	var first = "province";
	var second = "city";
	var third = "_areaCode";
	initArea(areaCode,first,second,third);
}

function initArea(areaCode,first,second,third){
	if(areaCode.length>=2){
		var code = areaCode.substr(0,2);
		$("#" + first).val(code);
		$.ajax({
			url: appRoot  + '/area/getChildren/' + code,
			type : 'post',
			dataType : 'json',
			success : function(data) {
				 var name = $("#" + second + "");
			     name.children().remove();
			     var options = "<option value=''>全国</option>";
				 for(var i=0;i<data.areas.length;i++){
					options +=("<option value='" +data.areas[i].areaCode + "'>" + data.areas[i].name+"</option>");
				 }
				 name.append(options);
				 name.val(code);
				 if(areaCode.length>=4){
					 code = areaCode.substr(0,4);
					 name.val(code);
					 $.ajax({
						url: ROOT_URL + '/area/getChildren/' + code,
						type : 'post',
						dataType : 'json',
						success : function(data) {
							 var name = $("#" + third + "");
						     name.children().remove();
						     var options = "<option value=''></option>";
							 for(var i=0;i<data.areas.length;i++){
								options +=("<option value='" +data.areas[i].areaCode + "'>" + data.areas[i].name+"</option>");
							 }
							 name.append(options);
							 name.val(areaCode);
						}
					 });
				 }
			}
		});
	}
}

function fillProvince() {
    aCity = areaData.split(",");
    var j = 1;
    for (i = 1; i <= aCity.length; i++) {
        if (aCity[i - 1].substring(2, 6) == "0000") {
            document.getElementById("province").options[j] = new Option(aCity[i - 1].substring(7, aCity[i - 1].length), aCity[i - 1].substring(0, 6));
            j++;
        }
    }
}
function setCity(provinceCode) {
    var j = 1;
    var provinceCode = provinceCode / 10000;
    for (i = 1; i <= aCity.length; i++) {
        if (aCity[i - 1].substring(0, 2) == provinceCode && aCity[i - 1].substring(2, 6) != "0000" && aCity[i - 1].substring(4, 6) == "00") {
            document.getElementById("city").options[j] = new Option(aCity[i - 1].substring(7, aCity[i - 1].length), aCity[i - 1].substring(0, 6));
            j++;
        }
    }
    document.getElementById("city").length = j;
    setCounty('000000');
}
function setCounty(cityCode) {
    var j = 1;
    var cityCode = cityCode / 100;
    for (i = 1; i <= aCity.length; i++) {
        if (aCity[i - 1].substring(0, 4) == cityCode && aCity[i - 1].substring(4, 6) != "00") {
            document.getElementById("county").options[j] = new Option(aCity[i - 1].substring(7, aCity[i - 1].length), aCity[i - 1].substring(0, 6));
            j++;
        }
    }
    document.getElementById("county").length = j;
}
function setArea() {
    for (i = 1; i <= document.getElementById("province").length; i++) {
        if (document.getElementById("province").options[i - 1].value.substring(0, 2) == document.getElementById("area").value.substring(0, 2)) {
            document.getElementById("province").selectedIndex = i - 1;
        }
    }
    setCity(document.getElementById("province").value);
    for (i = 1; i <= document.getElementById("city").length; i++) {
        if (document.getElementById("city").options[i - 1].value.substring(0, 4) == document.getElementById("area").value.substring(0, 4)) {
            document.getElementById("city").selectedIndex = i - 1;
        }
    }
    setCounty(document.getElementById("city").value);
    for (i = 1; i <= document.getElementById("county").length; i++) {
        if (document.getElementById("county").options[i - 1].value == document.getElementById("area").value) {
            document.getElementById("county").selectedIndex = i - 1;
        }
    }
}