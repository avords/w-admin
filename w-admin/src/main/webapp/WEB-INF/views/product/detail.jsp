<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="../common/taglibs.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="initial-scale=0, user-scalable=1" />
    <title>商品详情 </title>
    <jdf:themeFile file="css/global.css" />
    <jdf:themeFile file="css/gw.main.v1.css" />
    <jdf:themeFile file="css/gw.main.css" />
    <jdf:themeFile file="jquery.1.8.3.min.js" />
    <jdf:themeFile file="jquery.slide.js" />
	 <style type="text/css">
	    .u-desc ul li.u-sel a.z-on {
			  border: 2px solid #FF8063;
			  padding: 4px 14px;
			  color: #666;
			  background: url('${staticDomain}image/ico5.gif') no-repeat 100% 100%;
	     }
	     .u-desc ul li.u-sel a {
			  border: 1px solid #ccc;
			  padding: 5px 15px;
			  color: #666;
			  margin-left: 5px;
		 }
	 </style>
	 <script type="text/javascript">
	 function searchStock(){
		 $('#placeOrder').attr('href',"javascript:void(0);");
         //ajax请求查询sku信息,
         var attributeValueId1 = $('.attributeValueId1.z-on').data('id');
         var attributeValueId2 = $('.attributeValueId2.z-on').data('id');
         attributeValueId1 = typeof(attributeValueId1)== 'undefined'?'':attributeValueId1;
         attributeValueId2 = typeof(attributeValueId2)== 'undefined'?'':attributeValueId2;
         $.ajax({
             url:"${dynamicDomain}/sku/searchStock",
             type : 'post',
             dataType : 'json',
             data:{'attributeValueId1':attributeValueId1,'attributeValueId2':attributeValueId2,'productId':'${product.objectId}'},
             success : function(json) {
                 if(json.result){
                     var stock = json.totalStock;
                     if(typeof(stock)=='undefined'){
                         //查询出来单个sku
                         var name = json.sku.name;
                         var stock = json.sku.stock;
                         var skuId = json.sku.objectId;
                         var marketPrice = json.sku.marketPrice.toFixed(2);
                         var sellPrice = json.sku.sellPrice.toFixed(2);
                         $('#skuName').text(name);
                         $('#skuMarketPrice').html('原价：'+marketPrice+'元&nbsp;&nbsp;'+(Math.round(marketPrice))+'积分');
                         $('#skuSellPrice').text(sellPrice);
                         $('#skuSellPriceScore').text(Math.round(sellPrice));
                         if(stock<='0'){
                             $('#stock').text('该商品已售罄');
                         }else{
                             $('#stock').text('剩余库存'+stock);
                             $('#placeOrder').css('background-color','#FF7F60');
                             $('#placeOrder').css('cursor','pointer');
                         }
                     }else{
                         $('#placeOrder').css('background-color','#A9A9A9');
                         $('#placeOrder').css('cursor','not-allowed');
                         var name = '${product.name}';
                         var stock = json.totalStock;
                         var marketPrice = '${product.marketPrice}';
                         marketPrice = parseFloat(marketPrice).toFixed(2);
                         var sellPrice = '${product.sellPrice}';
                         sellPrice = parseFloat(sellPrice).toFixed(2);
                         $('#skuName').text(name);
                         $('#skuMarketPrice').html('原价：'+marketPrice+'元&nbsp;&nbsp;'+(Math.round(marketPrice))+'积分');
                         $('#skuSellPrice').text(sellPrice);
                         $('#skuSellPriceScore').text(Math.round(sellPrice));
                         if(stock<='0'){
                             $('#stock').text('该商品已售罄');
                         }else{
                             $('#stock').text('剩余库存'+stock);
                         }
                     }
                 }
             }
         });
	 }
	 </script>
</head>
<body>

<div class="gw-bnr"><img src="<jdf:theme/>img/gw.tmp02.gif"></div>

<div id="g-p1-3" class="f-cb">
    <div class="u-img f-fl">
        <div class="u-show" style="padding: 0px;"><img src="${dynamicDomain }${product.mainPicture }" width="330px" height="250px" id="mainPicture"></div>
        <div class="u-slide" id="j-slide">
            <div style="width: 272px;">
                <ul class="f-cb j-sml" style="width:680px;left:-272px;">
                  <li><img src="${dynamicDomain }${product.mainPicture}" width="64px" height="64px" class="z-on"></li>
                  <c:forEach items="${subPics }" var="item" varStatus="status">
                     <li><img src="${dynamicDomain }${item}" width="64px" height="64px"></li>
                  </c:forEach>
                </ul>
            </div>
            </div>
            <c:choose>
            <c:when test="${fn:length(subPics)<=3}">
                <script type="text/javascript">$('#j-slide').zSlide({'auto':false,'size':'${fn:length(subPics)+1}'});</script>
            </c:when>
            <c:otherwise>
                <script type="text/javascript">$('#j-slide').zSlide({'auto':false,'size':'4'});</script>
            </c:otherwise>
            </c:choose>
    </div>
        <div class="u-desc f-fl">
        <h1 id="skuName">${product.name }</h1>
        <p>${welfares }</p>
        <i id="skuMarketPrice">原价：${product.marketPrice }元&nbsp;&nbsp;${product.marketPrice }积分</i>
        <ul>
            <li>促销价: <b id="skuSellPrice">${product.sellPrice }</b>元&nbsp;&nbsp;<b id="skuSellPriceScore">${product.sellPrice }</b>积分</li>
            <c:forEach items="${attrs }" var="item" varStatus="status">
                
		            <li class="u-sel">${item.name }: 
			            <c:choose>
		                    <c:when test="${item.isTogeter==1 }">
				                <c:forEach items="${item.attributeValues }" var="it" varStatus="st">
				                    <a href="javascript:void(0);" data-type="${status.index }" data-id="${it.objectId }" class="f-ib j-sel attributeValueId${status.count }">${it.alias==null?it.name:it.alias }</a>
				                </c:forEach>
			                </c:when>
			                <c:otherwise>
			                    <c:choose>
                                    <c:when test="${status.count==1 }">
                                        <a href="javascript:void(0);" data-type="${status.index }" data-id="${attributeId1 }" class="f-ib j-sel attributeValueId${status.count }">${attributeValue1}</a>
                                    </c:when>
                                    <c:when test="${status.count==2 }">
                                        <a href="javascript:void(0);" data-type="${status.index }" data-id="${attributeId2 }" class="f-ib j-sel attributeValueId${status.count }">${attributeValue2}</a>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                </c:choose>
	                        </c:otherwise>
		                 </c:choose>
		            </li>
            </c:forEach>
            <form id="bookOrderForm" action="#" method="post">
            <li class="f-cb"><span class="f-fl u-lab">数&nbsp;&nbsp;&nbsp;量: </span>
                <a href="javascript:void(0);" data-type="subt" class="f-fl u-subt j-comp">-</a>
                <input type="text" name="count" class="f-fl u-txt j-count" value="1" />
                <a href="javascript:void(0);" data-type="add" class="f-fl u-add j-comp">+</a>
                <u class="f-fl u-over" id="stock"></u>
            </li>
            </form>
        </ul>
        <h5 class="j-res" style="padding: 0px 0px 15px">&nbsp;</h5>
        <h6>
            <a class="f-ib u-cart" onclick="javascript:$('#bookOrderForm').submit();" style="background-color: #A9A9A9;cursor:not-allowed" id="placeOrder">立即下单</a>
        </h6>
    </div>
    <script>
    $(function(){

        // 小图点击
        var _imgList = $('.j-sml > li > img');
        _imgList.click(function(){
            _imgList.removeClass('z-on');
            $(this).addClass('z-on');
            var imgSrc = $(this).attr('src');
            $('#mainPicture').attr('src',imgSrc);
        });
        
        // 数量加减
        $('.j-comp').click(function(){
            var _count = $('.j-count');
            var _this = $(this), _type = _this.attr('data-type');
            var _val = _count.val();
            
            if(_type == 'subt'){
                if(_val <= 1){
                    winAlert('数量不能少于1');
                    return false;
                }
                _val--;
            }else{
                _val++;
            }
            _count.val(_val);
            $('.j-res').text('已选择 '+ _val +' 份').show();
        });
        
     // 选择颜色 尺寸
        var _types = ['',''];
        $('.j-sel').click(function(){
            
            var _this = $(this), _isOn = _this.hasClass('z-on');
            var _type = _this.attr('data-type'), _txt = _this.text();
            if(_isOn){
                _this.removeClass('z-on');
                _types[_type] = '';
            }else{
                _this.addClass('z-on').siblings().removeClass('z-on');
                _types[_type] = _txt;
            }

            if(_types[0] == '' && _types[1] == ''){
                $('.j-res').html('&nbsp;');
            }else{
                var _html = '';
                $.each(_types, function(i, v){
                    if(v != '') _html += ' ，"' + v + '"';
                });
                $('.j-res').text('已选择 ' + _html.substr(2)).show();
            }
            searchStock();
        });
    });
    </script>
</div>

<div id="g-p1-3-d" class="f-cb">
    <h4><span class="f-ib">详细说明</span></h4>
    <div>${product.description }</div>
</div>

<script>
$(function(){

    // 输出列表的样式控制
    $('.j-lst2 > li:nth-child(4n)').css('margin-right',0);
    searchStock();
});
</script>

<script>var isFtFot = false;</script>

</body>
</html>