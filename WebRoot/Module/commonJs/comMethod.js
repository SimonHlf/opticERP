function getId(id){
	return document.getElementById(id);
}
//input文本框提示信息一个颜色，输入文字另一个颜色
function inpTipFocBlur(inpId,str,colShow,colWrite){
	var oInputId = getId(inpId);
	oInputId.onfocus = function(){
		if(this.value == str){
			this.value = "";
			this.style.color = colWrite;
		}
	};
	oInputId.onblur = function(){
		if(this.value == "" || this.value == str){
			this.value = str;
			this.style.color = colShow;
		}
	};
}
//根据内容高滚动条高等比例增长的封装
function scrollBar(objContainer,objContent,objScrollBox,objScrollBar,wheelNum){
	var containerParent = getId(objContainer); //内容的父级容器
	var content = getId(objContent);  //内容部分
	var scrollBox = getId(objScrollBox); //滚动条的父级容器
	var scrollBar = getId(objScrollBar);//滚动条
	
	var scale = 0;
	var scrollBarHeight=0;
	var maxTop=0;
	var listMaxTop=0;
	var t=0;
	//滚动条比例
	scale = containerParent.clientHeight / content.scrollHeight;
	if(scale > 1){
		scale = 1;
	}
	scrollBarHeight = scale*scrollBox.scrollHeight;
	maxTop = scrollBox.scrollHeight-scrollBarHeight;
	listMaxTop = containerParent.clientHeight-content.scrollHeight;
	scrollBar.style.height=scrollBarHeight+'px';
	if(scale==1){
		scrollBox.style.display="none";
	}
	//fnScroll(); 函数是控制滚动条的高度变化的函数，具体代码
	function fnScroll(){
			
			if( t < 0 ) t = 0;
			if(t > maxTop) t = maxTop;
		
			var scale = t / maxTop;
			
			scrollBar.style.top = t + 'px';
			content.style.top=-scale*(content.offsetHeight-containerParent.clientHeight)+'px';	
	};
	//滚动条拖动
	scrollBar.onmousedown = function(ev){
			
			var ev = ev || event;
			
			var disY = ev.clientY - this.offsetTop;
			
			document.onmousemove = function(ev){
				
				var ev = ev || event;
				
				t = ev.clientY - disY;
							
				fnScroll();	
				
			};
			
			document.onmouseup = function(){
				document.onmouseup = document.onmousemove = null;
			};
			
			return false;	
	};	
	//mouseScroll   //因为 mousewheel 事件 和 DOMMouseScroll 事件下记录鼠标滚轮信息的事件对象不一样，上下滚动的正负值也不一样
	function mouseScroll(ev){
		
		var ev = ev || event;
		var fx = ev.wheelDelta || ev.detail; //变量记录滚轮信息
		var bDown = true;
			
		if( ev.detail ){
			bDown = fx > 0 ? true : false;
		}else{
			bDown = fx > 0 ? false : true;
		}
		
		if( bDown ){ // bDown 这个变量来记录是上还是下  如果向上滚动，bDown 的值为 false, 向下 则为 true;

			t += wheelNum;
		}else{
			t -= wheelNum;
		}
		
		fnScroll();
		
		if( ev.preventDefault ){
			ev.preventDefault();
		}
		
		return false;
	};
	
	//鼠标滚轮效果。鼠标滚轮在 ie / chrome / firefox 下是有兼容问题的。ie 和 chrome 下用的是 mousewheel 事件，而ff下用的 是 DOMMouseScroll 并且 DOMMouseScroll 是只能通过 addEventListener 函数来监听实现的
	containerParent.onmousewheel = mouseScroll;
	
	if(containerParent.addEventListener){
		containerParent.addEventListener('DOMMouseScroll',mouseScroll,false);
	}
}
//动态让模拟弹层居中显示
function calMargLRig(parObj,sonObj,flag,msg){
	var objOuterWid = $(sonObj).outerWidth();
	var objOuterHei = $(sonObj).outerHeight();
	var parWid = $(parObj).width();
	var parHei = $(parObj).height();
	
	if(flag){
		var tmpLay = "<div class='tmpLayer'></div>";
		$(".alertWin").addClass("succBg").removeClass("errBg");
		$(".alertWin i").addClass("icon-smile smileIcon").removeClass("icon-cry cryIcon");
		$("body").append(tmpLay);
		$(".alertWin em").html(msg);
	}else{
		$(".alertWin").addClass("errBg").removeClass("succBg");;
		$(".alertWin i").addClass("icon-cry cryIcon").removeClass("icon-smile smileIcon");
		$(".alertWin em").html(msg);
	}
	$(sonObj).css({
		"left":parseInt((parWid - objOuterWid)/2),
		"top":parseInt((parHei - objOuterHei)/2)
	});
}
//模拟弹层显示和隐藏
function commonTipInfoFn(parObj,obj,flag,msg,fnEnd){
	$(obj).show().stop().animate({opacity:1},600,function(){
		setTimeout(function(){
			$(obj).animate({opacity:0},800,function(){
				$(obj).hide();
				//$(obj).css({"left":0,"top":0});
				$(obj).find("em").html("");
				if($(".tmpLayer").length > 0){
					$(".tmpLayer").remove();
				}
				if(fnEnd){
					fnEnd();
				}
			});
		},800);
	});
	calMargLRig(parObj,obj,flag,msg);
}
/*
 	使用方法：
 		
 		架构：
 				<div class="alertWin">
					<i class="iconfont fl"></i>
					<em class="fl"></em>
				</div>
 			
 		调用：commonTipInfoFn($(".alertWin"));
 			calMargLRig($(模拟弹层所处父级类名),$(".alertWin"));
 				
 		succ:
 			$(".alertWin").addClass("succBg");
 			$(".alertWin i").addClass("icon-smile smileIcon")
 			$(".alertWin em").html("保存成功");
 			
 		err:
 			$(".alertWin").addClass("errBg");
 			$(".alertWin i").addClass("icon-cry cryIcon")
 			$(".alertWin em").html("xxxx不能为空");
 			
 	eg:				
			commonTipInfoFn($(".alertWin"));
			$(".alertWin").addClass("errBg");
			$(".alertWin i").addClass("icon-cry cryIcon");
			$(".alertWin em").html("xxx不能为空");
			calMargLRig($(".checkCategLayer"),$(".alertWin"));
 */
//退出
function loginOut(){
	if(confirm("确定退出系统?")){
		window.location.href = "login.do?action=loginOut";
	}
}
//
function goBasicPage(module){
	window.location.href = "basic.do?action="+module;
}
//根据系统时间判断输入问候
function judgeTime_1(){
	var now = new Date();
	var hour = now.getHours(); 
	if(hour < 6){
		$('.timeHello').html('凌晨好,');
	} else if (hour < 9){
		$('.timeHello').html('早上好,');
	} else if (hour < 12){
		$('.timeHello').html('上午好,');
	} else if (hour < 14){
		$('.timeHello').html('中午好,');
	} else if (hour < 17){
		$('.timeHello').html('下午好,');
	} else if (hour < 19){
		$('.timeHello').html('傍晚好,');
	} else{
		$('.timeHello').html('晚上好,');
	}
	$(".mainWrap").height($(window).height() - $(".headWrap").height());
	leftNavHover();
}
//银行卡号当输入是字母时给删除了
function clearWord(objEnter,objPattern){
	var oBankNum = getId(objEnter);
	var oPattBankNum = getId(objPattern);
	oBankNum.value=oPattBankNum.value.replace(/\D/g,'');
	oPattBankNum.value = oPattBankNum.value.replace(/\D/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");
}
//银行账号的格式化
function bankNumPattern(objEnter,objPattern){
	var oBankNum = getId(objEnter);
	var oPattBankNum = getId(objPattern);
	var oBankTri = getId("bankTri");
	oBankNum.onkeydown=function(e){
		if(!isNaN(this.value.replace(/[ ]/g,""))){         
			setTimeout(function(){
				oPattBankNum.value =oBankNum.value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");//四位数字一组，以空格分割     
			},30);
		}else{         
			if(e.keyCode==8){//当输入非法字符时，禁止除退格键以外的按键输入
				return true;         
			}else{
				return false;        
			}
		}
	};
	oBankNum.onfocus = function(){
		oPattBankNum.style.display="block";
		oBankTri.style.display = "block";
		oPattBankNum.value =oBankNum.value.replace(/\s/g,'').replace(/(\d{4})(?=\d)/g,"$1 ");//四位数字一组，以空格分割     
	};
	oBankNum.onblur = function(){
		oPattBankNum.style.display="none";
		oBankTri.style.display = "none";
	};
}
//自定义日期格式
Date.prototype.format = function(format) {
	   var o = {
	       "M+": this.getMonth() + 1,
	       // month
	       "d+": this.getDate(),
	       // day
	       "h+": this.getHours(),
	       // hour
	       "m+": this.getMinutes(),
	       // minute
	       "s+": this.getSeconds(),
	       // second
	       "q+": Math.floor((this.getMonth() + 3) / 3),
	       // quarter
	       "S": this.getMilliseconds()
	       // millisecond
	   };
	   if (/(y+)/.test(format) || /(Y+)/.test(format)) {
	       format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));
	   }
	   for (var k in o) {
	       if (new RegExp("(" + k + ")").test(format)) {
	           format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
	       }
	   }
	   return format;
	};
//获取当前时间
function getCurrDate(option){
	var date = new Date();
    var seperator1 = "-";
    var seperator2 = ":";
    var year = date.getFullYear();
    var month = date.getMonth() + 1;
    var strDate = date.getDate();
    if (month >= 1 && month <= 9) {
        month = "0" + month;
    }
    if (strDate >= 0 && strDate <= 9) {
        strDate = "0" + strDate;
    }
    var currentdate = "";
    if(option == "date"){
    	currentdate = year + seperator1 + month + seperator1 + strDate;
    }else if(option == "dateTime"){
    	currentdate = year + seperator1 + month + seperator1 + strDate
        + " " + date.getHours() + seperator2 + date.getMinutes()
        + seperator2 + date.getSeconds();
    }else if(option == "year"){
    	currentdate = year;
    }
    return currentdate;
}
//获取日期格式
function getLocalDate_new(nS){
	if(nS != undefined){
		return nS.substring(0,10);
	}else{
		return "";
	}
}
//获取当前年份,上加10年
function getCurrYearArray(){
	var date = new Date();
	var currYear = date.getFullYear();
	var yearArray = new Array();
	var num = 9;
	for(var i = 0 ; i < 10 ; i++){
		yearArray[i] = parseInt(currYear) - num;
		num--;
	}
	/**for(var j = 0 ; j < 10 ; j++){
		yearArray[10+j] = parseInt(currYear) + j;
	}**/
	return yearArray;
}
//获取当前月
function getCurrMonth(){
	var date = new Date();
	var month = date.getMonth() + 1;
	if(month < 10){
		month = "0" + month;
	}
	return month;
}
//获取自定义日期格式
function getLocalDate(nS) { 
	if(nS != undefined){
		return new Date(parseFloat(nS)).format("yyyy-MM-dd");
	}else{
		return "";
	}
}
//获取自定义日期格式1
function getLocalDateTime(nS) { 
	if(nS != undefined){
		return new Date(parseFloat(nS)).format("yyyy-MM-dd hh:mm:ss");
	}else{
		return "";
	}
}
/* 根据父级高度动态创建模拟滚动条 */
function createLeftScroll(bigParBox,parBox,sonBox,options){
	if($("#"+sonBox).height() > $("#"+parBox).height()){
		var scroll = "<div id='scrollPar_"+ options +"' class='parScroll'><div id='scrollSon_"+ options +"' class='sonScroll'></div></div>";
		$("."+bigParBox).append(scroll);
		$(".parScroll").height($("#"+parBox).height());
		scrollBar(parBox,sonBox,"scrollPar_"+options,"scrollSon_"+options,15);
	}
}
/* 模拟radio封装 */
function choiceOption(obj,newClassName,parObj,inpObj,options,fnEnd){
	$("."+obj).each(function(){
		$(this).on("click",function(){
			var newAppendEle = "";
			var FindWord = "";
			$("."+obj).attr("checked",false);
			$(this).attr("checked",true);
			if(options == "imgBg"){//
				newAppendEle = "<b></b>";
				FindWord = "b";
				$("#"+inpObj).html($(this).val());
			}else if(options == "iconFont"){
				newAppendEle = "<i class='iconfont icon-duihao'></i>";
				FindWord = "i";
				$("#"+inpObj).val($(this).val());
				if(fnEnd){
					fnEnd();
				}
			}
			$(this).parent(parObj).addClass(newClassName).append(newAppendEle).siblings().removeClass(newClassName).find(FindWord).remove();
		});
	});
}
//双击转换可编辑状态
function editElement(obj,idStr,options,module){
	//dbFlag 为了防止当创建input文本框后用户如果再不断点击就会把input的html传入元素的文本节点中
	//options 1:单价  2：采购数量、出库数量 3：采购入库  4：新增领料出库
    var oldHtml = obj.innerHTML;
    var newObjInp = document.createElement("input");
    if(dbFlag){
        newObjInp.type = "text";
        newObjInp.value = oldHtml;
        newObjInp.className = "comEditInp";
      	//当创建input时清空原有元素的内容
        obj.innerHTML = "";
     	//设置选择文本的内容或设置光标位置（两个参数：start,end；start为开始位置，end为结束位置；如果开始位置和结束位置相同则就是光标位置）
        newObjInp.setSelectionRange(0, oldHtml.length);
    }
    obj.appendChild(newObjInp);
    dbFlag = false;
  	//设置获得光标
    newObjInp.focus();
    newObjInp.onblur = function(){    
    	var purNumInpReg = checkIsNumber(newObjInp.value); 
    	var proPriceInpReg = checkInputNumberOrFloat(newObjInp.value);
    	obj.innerHTML = this.value == oldHtml ? oldHtml : this.value;
    	if(options == 1){//产品单价
    		if(!proPriceInpReg){
        		commonTipInfoFn($("body"),$(".alertWin"),false,"产品单价应为大于0的小数或整数");
        		obj.innerHTML = "0.00";
    		}
    	}else if(options == 2){//采购数量、出库数量
    		if(module == "sellOut" || module == "pickStOut"){//领料出库、销售出库
    			if(!purNumInpReg){
            		commonTipInfoFn($("body"),$(".alertWin"),false,"出库数量应为大于0的正整数");
            		obj.innerHTML = "0";
        		}else if(parseInt($("#storeNum_"+idStr).html()) < parseInt(newObjInp.value)){
        			commonTipInfoFn($("body"),$(".alertWin"),false,"出库数量不能大于库存量");
        			obj.innerHTML = "0";
        		}	
    		}else if(module == "purchase"){
    			if(!purNumInpReg){
            		commonTipInfoFn($("body"),$(".alertWin"),false,"采购数量应为大于0的正整数");
            		obj.innerHTML = "0";
        		}
    		}
    	}else if(options == 3){//采购入库
    		if(!purNumInpReg){
    			commonTipInfoFn($("body"),$(".alertWin"),false,"入库数量应为大于0的正整数");
        		obj.innerHTML = "0";
    		}else{
    			var purNumber = parseInt($("#purNumber_"+idStr).html().replace(/\s+/g, ""));//采购数量
    			var actNumber = parseInt($("#actNumber_"+idStr).html().replace(/\s+/g, ""));//实际入库数量
    			var remainNumber = purNumber - actNumber;
    			if(newObjInp.value > remainNumber){
    				commonTipInfoFn($("body"),$(".alertWin"),false,"新入库数量不能大于剩余入库数量");
            		obj.innerHTML = "0";
    			}
    		}
    	}
    	dbFlag = true;
    	if(module == "purInStore"){//采购入库
    		
    	}else{
    		var price = parseFloat($("#td_price_"+idStr).html());
        	$("#td_all_price_"+idStr).html((price * parseInt($("#td_num_"+idStr).html())).toFixed(2));
        	var allPrice = 0;
        	$(".cAllPrice").each(function(i){
        		allPrice += parseFloat($(".cAllPrice").eq(i).html());
        	});
        	$("#totaMoney").html(allPrice.toFixed(2));
        	if(module == "sellOut"){//销售出库
        		$("#totalPrice").val(allPrice.toFixed(2));
        	}
    	}
    };
}
//左侧侧边栏导航
function leftNavHover(){
	var oDiv = "<div class='liTxt'><span class='innerSpan'></span><span class='liTxtTri'></span></div>";
	$(".leftPart").append(oDiv);
	$(".leftPart li").each(function(i){
		$(this).hover(function(){
			if(i == 0){
				$(".liTxt").css({"top":0});
			}else{
				$(".liTxt").css({"top":($(".leftPart li").eq(i).height()*i)});
			}
			$(".innerSpan").html($(".hidInp").eq(i).val());
			$(".liTxt").show().stop().animate({"right":-135,"opacity":1});
			
		},function(){
			$(".liTxt").hide().stop().animate({"right":-200,"opacity":0});
		});
		$(this).click(function(){
			if(i == 0){//添加基本信息
				goBasicPage('goProCategoryPage',this);
			}else if(i==1){//采购
				goBasicPage('goPurchasePage',this);
			}else if(i==2){//库房入库
				goBasicPage('goInstorePage',this);
			}else if(i==3){//库房出库
				window.location.href = "outStore.do?action=goPickingOutStore";
			}else if(i==4){//产品损耗跟踪
				window.location.href = "proLoss.do?action=goProLossPage";
			}
		});
	});
}

/** 
 * 将数值四舍五入(保留2位小数)后格式化成金额形式 
 * 
 * @param num 数值(Number或者String) 
 * @return 金额格式的字符串,如'1,234,567.45' 
 * @type String 
 */  
function formatCurrency(num) {  
    num = num.toString().replace(/\$|\,/g,'');  
    if(isNaN(num))  
        num = "0";  
    sign = (num == (num = Math.abs(num)));  
    num = Math.floor(num*100+0.50000000001);  
    cents = num%100;  
    num = Math.floor(num/100).toString();  
    if(cents<10)  
    cents = "0" + cents;  
    for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)  
    num = num.substring(0,num.length-(4*i+3))+','+  
    num.substring(num.length-(4*i+3));  
    return (((sign)?'':'-') + num + '.' + cents);  
}  