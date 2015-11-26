<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="../common/header.jsp"%>
<title>体检预约</title>
</head>
<body>
	<div>
		<jdf:form bean="entity" scope="request">
			<div class="callout callout-info">
				<div class="message-right">${message }</div>
				<h4 class="modal-title">
					填写体检信息
				</h4>
			</div>
			<form name="form1" method="post" action="${dynamicDomain}/CardExchange/appointment1Confirm" id="appointment" class="form-horizontal" >
				<input type="hidden" name="objectId">
				<div class="box-body">
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="userName" class="col-sm-4 control-label">姓名</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control required"  id="userName" name="userName" maxlength="10" value="${pSubscribe.userName}">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="sex" class="col-sm-4 control-label">婚姻状况</label>
								<div class="col-sm-8">
									<jdf:radio dictionaryId="1215" name="marryStatus" />
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="certificateType" class="col-sm-4 control-label">证件类型</label>
								<div class="col-sm-8">
									<select name="certificateType" class="form-control"id="certificateType">
										<option value="">—请选择—</option>
										<jdf:select dictionaryId="1306"/>
									</select>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="certificateNo" class="col-sm-4 control-label">证件号码</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control certificateNo" name="certificateNo" id="certificateNo"  maxlength="18" onblur="nunber();">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="certificateType" class="col-sm-4 control-label">生日号码</label>
								<div class="col-sm-3">
									<select name="YYYY" onchange="YYYYMM(this.value)" class="search-form-control required" id="YYYY">  
										<option value=""></option>  
									</select>
								</div>	
								<div class="col-sm-3">
									 <select name="MM" onchange="MMDD(this.value)" class="search-form-control required month" id="MM">  
										<option value=""></option>  
									 </select> 
								</div>	
								<div class="col-sm-2">
									 <select name="DD" class="search-form-control required" id="DD">  
										<option value=""></option>  
									 </select>
								</div>	
							</div>
						</div>
						
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="cellphoneNo" class="col-sm-4 control-label">手机号码</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control phone"  name="cellphoneNo" value="${pSubscribe.cellphoneNo}">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="email" class="col-sm-4 control-label">电子邮件</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control email" name="email" value="${pSubscribe.email}">
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="postCode" class="col-sm-4 control-label">邮编</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control isZipCode" name="postCode" value="${pSubscribe.postCode}">
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="elecReport" class="col-sm-4 control-label">体检报告</label>
								<div class="col-sm-8">
									<a href="#" id="agreement">我已阅读并同意《体检报告服务授权协议》</a><br>
									<label><input type="checkbox"   name="elecReport"  id="elec"  value="1" >电子报告</label>
									<label><input type="checkbox"   name="paperReport"  id="paper"  value="1"  >纸质报告</label>
								</div>	
								 
							</div>
						</div>
						
					</div>
					
					<div class="row">
						<div class="col-sm-6 col-md-6">
							<div class="form-group">
								<label for="remark" class="col-sm-4 control-label">备注</label>
								<div class="col-sm-8">
									<textarea rows="3" cols="36" name="remark"
										class="search-form-control"></textarea>
								</div>
							</div>
						</div>
						<div class="col-sm-6 col-md-6" id="postAddress">
							<div class="form-group">
								<label for="postAddress" class="col-sm-4 control-label">邮寄地址</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control" name="postAddress" id="address" required="required">
								</div>
								<!-- <label for="postCode" class="col-sm-4 control-label">联系电话</label>
								<div class="col-sm-8">
									<input type="text" class="search-form-control"name="postCode">
								</div> -->
							</div>
						</div>
					</div>
					<div class="box-footer">
						<div class="row">
							<div class="editPageButton">
								<button type="button" class="btn btn-primary progressBtn" onclick="subForm();">保存</button>
								<button type="button" onclick="javascript:history.go(-1)" class="btn btn-primary">返回</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</jdf:form>
	</div>
	<jdf:bootstrapDomainValidate domain="PhysicalSubscribe" />
	<script language="JavaScript"><!--
	$(function(){  
		
		strYYYY = document.form1.YYYY.outerHTML;  
		strMM = document.form1.MM.outerHTML;  
		strDD = document.form1.DD.outerHTML;  
		MonHead = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];  
		  
		//先给年下拉框赋内容  
		var y = new Date().getFullYear();  
		var str = strYYYY.substring(0, strYYYY.length - 9);  
		for (var i = (y-100); i < (y+1); i++) //以今年为准，前30年，后30年  
			{  
				str += "<option value='" + i + "'> " + i + "</option>\r\n";  
			}  
			document.form1.YYYY.outerHTML = str +"</select>";  
		  
		//赋月份的下拉框  
		var str = strMM.substring(0, strMM.length - 9);  
		for (var i = 1; i < 13; i++)  
			{  
				str += "<option value='" + i + "'> " + i + "</option>\r\n";  
			}  
			document.form1.MM.outerHTML = str +"</select>";  
		  
			document.form1.YYYY.value = y;  
			document.form1.MM.value = new Date().getMonth() + 1;  
			var n = MonHead[new Date().getMonth()];  
			if (new Date().getMonth() ==1 && IsPinYear(YYYYvalue)) n++;  
			writeDay(n); //赋日期下拉框  
			document.form1.DD.value = new Date().getDate();  
			}  );
		function YYYYMM(str) //年发生变化时日期发生变化(主要是判断闰平年)  
			{  
			var MMvalue = document.form1.MM.options[document.form1.MM.selectedIndex].value;  
			if (MMvalue == "")
			{
				DD.outerHTML = strDD;
				return;
			}  
			var n = MonHead[MMvalue - 1];  
			if (MMvalue ==2 && IsPinYear(str)) n++;  
				writeDay(n)  
			}  
		function MMDD(str) //月发生变化时日期联动  
			{  
				var YYYYvalue = document.form1.YYYY.options[document.form1.YYYY.selectedIndex].value;  
			if (str == "")
			{
				DD.outerHTML = strDD; return;
				}  
			var n = MonHead[str - 1];  
			if (str ==2 && IsPinYear(YYYYvalue)) n++;  
				writeDay(n)  
			}  
		function writeDay(n) //据条件写日期的下拉框  
			{  
				var s = strDD.substring(0, strDD.length - 9);  
				for (var i=1; i<(n+1); i++)  
					s += "<option value='" + i + "'> " + i + "</option>\r\n";  
				document.form1.DD.outerHTML = s +"</select>";  
			}  
		function IsPinYear(year)//判断是否闰平年  
			{ 
				return(0 == year%4 && (year%100 !=0 || year%400 == 0))
			} 
    </script>
 <script>
function chckUserName(){
	var ele = $('input[name="userName"');
	var val = $.trim(ele.val());
	if(val.length==0){
		alert('姓名必填');
		return false ;
	}else if(val.length>10){
		alert('最多10个字符');
		return false ;
	}else{
		return true;
	}
}


function isCnNewID(cid){  
    var arrExp = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2];//加权因子  
    var arrValid = [1, 0, "X", 9, 8, 7, 6, 5, 4, 3, 2];//校验码  
    if(/^\d{17}\d|x$/i.test(cid)){  
        var sum = 0, idx;  
        for(var i = 0; i < cid.length - 1; i++){  
            // 对前17位数字与权值乘积求和  
            sum += parseInt(cid.substr(i, 1), 10) * arrExp[i];  
        }  
        // 计算模（固定算法）  
        idx = sum % 11;  
        // 检验第18为是否与校验码相等  
       if(arrValid[idx] == cid.substr(17, 1).toUpperCase()){
    	   var year = cid. substr(6,4);
   		   var month = cid. substr(10,2);
   		   var day = cid. substr(12,2);
	   	   $("#YYYY").val(year);
	   	   $("#MM").val(parseInt(month));
		   $("#DD").val(parseInt(day)); 
		   return true;
       }else{
    	   alert("请输入正确的身份证号码！");
           return false;
       }
       
    }else{  
    	alert("请输入正确的身份证号码！");
        return false;  
    }  
}

function checkPhone(sender){
	var reg = /^(13[0-9]|15[0-9]|177|18[0-9])\d{8}$/ ;
	var ele =  $('input[name="cellphoneNo"]');
	var val = $.trim(ele.val()); 
	var arr = val.match(reg);
	if(!arr){
		alert('不合法手机号');
		return false ;
	}else{
		return true;
	 }		
} 

function nunber(){ 
	var certificateType = $("#certificateType").val();
	if(!certificateType){
		alert('请选择证件分类');
		return false;
	}
	var idcard=$("#certificateNo").val();
	if(certificateType == 1){
		//校验长度，类型 
		 if(isCardNo(idcard) === false) 
		 { 
			 alert("您输入的身份证号码不正确，请重新输入"); 
			 return false; 
		 } 
		 //检查省份 
		 else if(checkProvince(idcard) === false) 
		 { 
			 alert("您输入的身份证号码不正确，请重新输入"); 
		  return false; 
		 } 
		 //校验生日 
		 else if(checkBirthday(idcard) === false) 
		 { 
			 alert("您输入的身份证号码不正确，请重新输入"); 
		  return false; 
		 } 
		 //检验位的检测 
		 else if(checkParity(idcard) === false) 
		 { 
			 alert("您输入的身份证号码不正确，请重新输入"); 
		  return false; 
		 }
		 else{ 
			 if(certificateType == 1){
				 if(idcard.length == 18){
					 var year = idcard. substr(6,4);
			 		 var month = idcard. substr(10,2);
			 		 var day = idcard. substr(12,2);
				   	 $("#YYYY").val(year);
					// $('select.month option[value="'+parseInt(month)+'"]').prop('selected',true);
					 //$('select.date option[value="'+parseInt(day)+'"]').prop('selected',true); 
					 $("#MM").val(parseInt(month));
					 $('#DD').val(parseInt(day));
				 }
				 else{
					 var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/; 
				     var arr_data = card.match(re_fifteen); 
				     var year = arr_data[2]; 
				     var month = arr_data[3]; 
				     var day = arr_data[4]; 
				     $("#YYYY").val("19"+year);
					 $("#MM").val(parseInt(month));
					 $("#DD").val(parseInt(day));
					 
				 }
			 }
			 
			 
		  return true; 
		 } 
	}else{
		if(idcard.length  == 0){
			alert('请输入证件号码！');
			return  false;
		}
		else{
			return true;
		}
	}
	 
	 
	} 
	 
	//身份证省的编码 
	var vcity={ 11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古", 
	        21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏", 
	        33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南", 
	        42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆", 
	        51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃", 
	        63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外" 
	       }; 
	 
	//检查号码是否符合规范，包括长度，类型 
	function isCardNo(card){ 
	 //身份证号码为15位或者18位，15位时全为数字，18位前17位为数字，最后一位是校验位，可能为数字或字符X 
	 var reg = /(^\d{15}$)|(^\d{17}(\d|X)$)/; 
	 if(reg.test(card) === false){ 
	  //alert("demo"); 
	  return false; 
	 } 
	 return true; 
	} 
	 
	//取身份证前两位,校验省份 
	function checkProvince(card){ 
	 var province = card.substr(0,2); 
	 if(vcity[province] == undefined){ 
	  return false; 
	 } 
	 return true; 
	} 
	 
	//检查生日是否正确 
	function checkBirthday(card){ 
	 var len = card.length; 
	 //身份证15位时，次序为省（3位）市（3位）年（2位）月（2位）日（2位）校验位（3位），皆为数字 
	 if(len == '15'){  
	     var re_fifteen = /^(\d{6})(\d{2})(\d{2})(\d{2})(\d{3})$/; 
	     var arr_data = card.match(re_fifteen); 
	     var year = arr_data[2]; 
	     var month = arr_data[3]; 
	     var day = arr_data[4]; 
	     var birthday = new Date('19'+year+'/'+month+'/'+day); 
	     return verifyBirthday('19'+year,month,day,birthday); 
	 } 
	 //身份证18位时，次序为省（3位）市（3位）年（4位）月（2位）日（2位）校验位（4位），校验位末尾可能为X 
	 if(len == '18'){ 
	     var re_eighteen = /^(\d{6})(\d{4})(\d{2})(\d{2})(\d{3})([0-9]|X)$/; 
	     var arr_data = card.match(re_eighteen); 
	     var year = arr_data[2]; 
	     var month = arr_data[3]; 
	     var day = arr_data[4]; 
	     var birthday = new Date(year+'/'+month+'/'+day); 
	     return verifyBirthday(year,month,day,birthday); 
	 } 
	 return false; 
	} 
	 
	//校验日期 
	function verifyBirthday(year,month,day,birthday){ 
	 var now = new Date(); 
	 var now_year = now.getFullYear(); 
	 //年月日是否合理 
	 if(birthday.getFullYear() == year && (birthday.getMonth() + 1) == month && birthday.getDate() == day) 
	 { 
	     //判断年份的范围（3岁到100岁之间) 
	     var time = now_year - year; 
	     if(time >= 3 && time <= 100) 
	     { 
	         return true; 
	     } 
	     return false; 
	 } 
	 return false; 
	} 
	 
	//校验位的检测 
	function checkParity(card){ 
	 //15位转18位 
	 card = changeFivteenToEighteen(card); 
	 var len = card.length; 
	 if(len == '18'){ 
	     var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
	     var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
	     var cardTemp = 0, i, valnum; 
	     for(i = 0; i < 17; i ++) 
	     { 
	         cardTemp += card.substr(i, 1) * arrInt[i]; 
	     } 
	     valnum = arrCh[cardTemp % 11]; 
	     if (valnum == card.substr(17, 1)) 
	     { 
	         return true; 
	     } 
	     return false; 
	 } 
	 return false; 
	} 
	 
	//15位转18位身份证号 
	function changeFivteenToEighteen(card){ 
	 if(card.length == '15') 
	 { 
	     var arrInt = new Array(7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2); 
	     var arrCh = new Array('1', '0', 'X', '9', '8', '7', '6', '5', '4', '3', '2'); 
	     var cardTemp = 0, i;   
	     card = card.substr(0, 6) + '19' + card.substr(6, card.length - 6); 
	     for(i = 0; i < 17; i ++) 
	     { 
	         cardTemp += card.substr(i, 1) * arrInt[i]; 
	     } 
	     card += arrCh[cardTemp % 11]; 
	     return card; 
	 } 
	 return card; 
	} 


function subForm() {
	if(chckUserName() && nunber() && checkPhone()){
		/* var elem = $('input[name="email"]') ;
		var email = $.trim(elem.val()); 
		if(email && !checkEmail()){
			return ;
		}	 */	
		$("#appointment").submit();
		
	}
	else{
		return;
	}
	
}
</script>
<script type="text/javascript">
$(function(){
	var birthday = "${pSubscribe.birthday}";
	var eleReport = "${pSubscribe.elecReport}";
	var paperReport = "${pSubscribe.paperReport}";
	var postAddress = "${pSubscribe.postAddress}";
	$('input[name=elecReport]').attr('checked',true);
	if(eleReport == 1){
		$('input[name=elecReport]').attr('checked',true);
	}
	if(paperReport == 1 || paperReport == 2 ){
		$('input[name=paperReport]').attr('checked',true);
		$("#address").val(postAddress);
		$("#postAddress").show();
		
	}else{
		$("#postAddress").hide();
	}
	var data = new Date(birthday);  
    var year = data.getFullYear();  //获取年
    var month = data.getMonth() + 1;    //获取月
    var day = data.getDate(); //获取日
    $("#YYYY").val(year);
    $("#MM").val(parseInt(month));
    $("#DD").val(parseInt(day)); 
	$("#agreement").bind("click",function(){
				var userName  = $("#userName").val();
				var certificateNo  = $("#certificateNo").val();
				var url='${dynamicDomain}/CardExchange/viewAgreement?ajax=1&userName='+userName+"&certificateNo="+certificateNo;
				$.colorbox({
					opacity : 0.2,
					href : url,
					fixed : true,
					width : "50%",
					height : "100%",
					iframe : true,
					onClosed : function() {
						if (false) {
							location.reload(false);
						}
					},
					overlayClose : false
				}); 
          
        })
        
        $("#paper").bind("click",function(){
          	if($("#paper").is(':checked')){
          		$("#postAddress").show();
          	}
          	else{
          		$("#postAddress").hide();
          	}
        })
})


	</script>
	
	<script type="text/javascript">
	
	</script>
    
</body>
</html>