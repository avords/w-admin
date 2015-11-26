  
	  Array.prototype.remove = function(s) {
          for (var i = 0; i < this.length; i++) {
              if (s == this[i])
                  this.splice(i, 1);
          }
      }

	  function endWith(str,toStr){
	    	if(str==null||str==""||toStr.length==0||str.length>toStr.length)
	    	  return false;
	    	if(toStr.substring(toStr.length-str.length)==str)
	    	  return true;
	    	else
	    	  return false;
	    	return true;
		}
		
		function startWith (str,toStr){     
			  var reg=new RegExp("^"+str);     
			  return reg.test(toStr);        
			}
      function makePrice(priceStr){
      	 var allSupResMap =  new Map();
      	//检查下ID&供应商ID&男性&女未婚&女已婚&门市价格&供货价&供应商名称|检查下ID&供应商ID&男性&女未婚&女已婚&价格|检查下ID&供应商ID&男性&女未婚&女已婚&价格|
      	//var priceStr = "6&2601&1&0&0&100.0&85.0&上海可口可乐有限公司|5&2601&1&1&0&60.0&40.0&上海可口可乐有限公司|9&2601&1&1&1&120.0&50.0&上海可口可乐有限公司|42&2601&1&1&1&80.0&100.0&上海可口可乐有限公司|7&2601&1&1&1&800.0&100.0&上海可口可乐有限公司";
      	var recs=priceStr.split("|"); //字符分割 
      	var itms = new Array();
      	for (var i = 0; i < recs.length; i++) {
//				alert(recs[i]);
				var res = recs[i].split("&");
				var itemId = res[0];
				var supId = res[1];
				var isMan = res[2];
				var isFelUnmarried = res[3];
				var isFelMarried = res[4];
				var msPrice = res[5];
				var supPrice = res[6];
				var supName = res[7];
//				Object a = new Object();
				var itm=new Object();
				itm.itemId = itemId;
				itm.supId = supId;
				itm.isMan = isMan;
				itm.isFelUnmarried = isFelUnmarried;
				itm.isFelMarried = isFelMarried;
				itm.msPrice = msPrice;
				itm.supPrice = supPrice;
				itm.supName = supName;
				itms.push(itm);
			}
      	//找出供应商相同的放入map
      	 var supMap =  makeMap(1,itms);
      	supMap.each(function(key,value,index){
      		var supResMap =  new Map();
               var supAllItem = supMap.get(key);
               // 找出性别相同放入Map
          	 var manMap = makeMap(2,supAllItem);
          	 var manResMap = new Map();
          			 var manAllItem = manMap.get("1");
              		 var msPrice = sumPrice(1,manAllItem);
              		 var supPrice = sumPrice(2,manAllItem);
              		 manResMap.put("msPrice",msPrice);
              		 manResMap.put("supPrice",supPrice);
//             		console.log("供应商Id:"+key+"男性门市价格："+msPrice);
//             		console.log("供应商Id:"+key+"男性供货价格："+supPrice);	 
          	 supResMap.put("manResMap",manResMap);
          	 var felUnmarriedMap = makeMap(3,supAllItem);
          	 var felUnmarriedResMap = new Map();
          			var felUnmarriedAllItem = felUnmarriedMap.get("1");
             		 var msPrice = sumPrice(1,felUnmarriedAllItem);
             		 var supPrice = sumPrice(2,felUnmarriedAllItem);
//             		 alert("供应商Id:"+key+"未婚女性:"+felUnmarriedkey+"门市价格："+msPrice);
//             		 alert("供应商Id:"+key+"未婚女性:"+felUnmarriedkey+"供货价格："+supPrice);
//   					console.log("供应商Id:"+key+"未婚女性门市价格："+msPrice);
//            		console.log("供应商Id:"+key+"未婚女性供货价格："+supPrice);
             		 felUnmarriedResMap.put("msPrice",msPrice);
             		 felUnmarriedResMap.put("supPrice",supPrice); 
          	 supResMap.put("felUnmarriedResMap",felUnmarriedResMap);
          	 
          	 var felMarriedMap = makeMap(4,supAllItem);
          	 var felMarriedResMap = new Map();
          	 var felMarriedAllItem = felMarriedMap.get("1");
              var msPrice = sumPrice(1,felMarriedAllItem);
              var supPrice = sumPrice(2,felMarriedAllItem);
//              		 alert("供应商Id:"+key+"已婚:"+felMarriedkey+"门市价格："+msPrice);
//              		 alert("供应商Id:"+key+"已婚:"+felMarriedkey+"供货价格："+supPrice);
//    		console.log("供应商Id:"+key+"已婚门市价格："+msPrice);
//             console.log("供应商Id:"+key+"已婚供货价格："+supPrice);
              felMarriedResMap.put("msPrice",msPrice);
              felMarriedResMap.put("supPrice",supPrice);
          	 supResMap.put("felMarriedResMap",felMarriedResMap);
          	 allSupResMap.put(key,supResMap);
           });
      	return allSupResMap;
      }
      
      //1 门市价格  2供货价
      function sumPrice(priceType,items){
      	var allPrice  = 0;
      if(items != null &&items != "" &&typeof(items) != undefined ){
      	for (var i = 0; i < items.length; i++) {
      		var item = items[i];
      		if(priceType==1){
      			allPrice = (allPrice + parseInt(item.msPrice));
      		}
				if(priceType==2){
					allPrice = (allPrice + parseInt(item.supPrice));
      		}
      	}
      }
      	return allPrice;
      }
      /*****************根据Key值放入不同map****************/
      function makeMap(keyType,itms){
      	 var supMap = new Map();
       	for (var j = 0; j < itms.length; j++) {
       		var itm = itms[j];
       		var supItems = new Array();
       		
       		var key = "";
       		if(keyType == 1){
       			key = itm.supId+"_"+itm.supName;
       		}
       		if(keyType == 2){
       			key = itm.isMan;
       		}
       		if(keyType == 3){
       			key = itm.isFelUnmarried;
       		}
       		if(keyType == 4){
       			key = itm.isFelMarried;
       		}
       		if(supMap.get(key) != null){
       			supItems = supMap.get(key);
       		}
       		supItems = addItm(itm,supItems);
       		supMap.remove(key);
       		supMap.put(key,supItems);
			}
       	return supMap;
      }
      
      function addItm(itm,toItems){
      	var contain = false;
      	for (var j = 0; j < toItems.length; j++) {
      		var cmpitms = toItems[j];
      		if(cmpitms.itemId== itm.itemId
     				&&cmpitms.supId== itm.supId
     				&&cmpitms.isMan== itm.isMan
     				&&cmpitms.isFelUnmarried== itm.isFelUnmarried
     				&&cmpitms.isFelMarried== itm.isFelMarried
     				&&cmpitms.msPrice== itm.msPrice
     				&&cmpitms.supPrice== itm.supPrice
     				&&cmpitms.supName== itm.supName){
      			contain = true;
      		}
      	}
      	if(!contain){
      		toItems.push(itm);
      	}
      	return toItems;
      }
      