var categFlag = true;
var topNum = 0;
//根据系统时间判断输入问候
function judgeTime(options){
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
	if($(window).width() < 1400 && $(window).width() >1280){
		$(".comMainWid").width(1100);
		if(options == "addCateg"){//添加商品类别
			$(".mainCon li").css({"margin-left":30});
		}else if(options == "addProInfo"){//添加商品信息
			$(".categUlBox li").css({"margin-left":12});
			$(".listWid1").removeClass("bigWid1").addClass("midWid1");
			$(".listWid2").removeClass("bigWid2").addClass("midWid2");
		}else if(options == "addCorrUnit"){//添加业务往来单位类别，单位信息
			$(".categUlBox li").css({"margin-left":12});
			$(".lsWid1_un").removeClass("bigWid1_un").addClass("midWid1_un");
			$(".lsWid2_un").removeClass("bigWid2_un").addClass("midWid2_un");
			$(".lsWid3_un").removeClass("bigWid3_un").addClass("midWid3_un");
		}else if(options == "addWhouseCateg"){
			$(".lsWid1_wh").removeClass("bigWid1_wh").addClass("midWid1_wh");
			$(".lsWid2_wh").removeClass("bigWid1_wh").addClass("midWid1_wh");
			$(".lsWid3_wh").removeClass("bigWid1_wh").addClass("midWid1_wh");
			$(".lsWid4_wh").removeClass("bigWid1_wh").addClass("midWid2_wh");
		}
	}else if($(window).width() < 1279){
		$(".comMainWid").width(1000);
		if(options == "addProInfo"){//添加商品信息
			$(".categUlBox li").css({"margin-left":13});
			$(".listWid1").removeClass("bigWid1 midWid1").addClass("smallWid1");
			$(".listWid2").removeClass("bigWid2 midWid2").addClass("smallWid2");
		}else if(options == "addCorrUnit"){//添加业务往来单位类别，单位信息
			$(".categUlBox li").css({"margin-left":13});
			$(".lsWid1_un").removeClass("bigWid1_un midWid1_un").addClass("smWid1_un");
			$(".lsWid2_un").removeClass("bigWid2_un midWid2_un").addClass("smWid2_un");
			$(".lsWid3_un").removeClass("bigWid3_un midWid3_un").addClass("smWid3_un");
		}else if(options == "addWhouseCateg"){
			$(".lsWid1_wh").removeClass("bigWid1_wh midWid1_wh").addClass("smallWid1_wh");
			$(".lsWid2_wh").removeClass("bigWid1_wh midWid1_wh").addClass("smallWid1_wh");
			$(".lsWid3_wh").removeClass("bigWid1_wh midWid1_wh").addClass("smallWid1_wh");
			$(".lsWid4_wh").removeClass("bigWid1_wh midWid2_wh").addClass("smallWid1_wh");
		}
	}
	if(options == "addCateg"){//添加商品类别
		inpTipFocBlur("searInput","请输入产品类别拼音码","#999","#666");	
	}else if(options == "addProInfo"){//添加商品信息
		inpTipFocBlur("searInput","请输入产品拼音码","#999","#666");	
	}else if(options == "addCorrUnit"){//添加业务往来单位信息
		inpTipFocBlur("searInput","请输入单位拼音码","#999","#666");	
	}else if(options == "addWhouseCateg"){//添加货架信息
		inpTipFocBlur("searInput","请输入货架名称","#999","#666");
	}
	//动态计算类别层的宽度
	$(".categUlBox").width($(".comMainWid").width() - $(".titP").width()-2);
	if($(".mainCon li").length == 0){
		$(".noInfoDiv").show();
	}else{
		if(options == "addCateg"){
			$(".mainConWrap").height($(".mainWrap").height() - 70);
		}
	}
	leftNavHover();
}
//onload进来判断产品类别的高度是否够创建模拟滚动条
function checkCategUlHei(){
	var parHei = $("#categUlBox").height();
	var sonHei = $("#categUl").height();
	var scrollStr = "<div id='scrollPar' class='parScroll scrollWid1'><div id='scrollSon' class='sonScroll scrollWid1'></div></div>";
	//检测是否已经添加产品类别
	if(sonHei > parHei){
		$(".setBtn").css({"right":5});
		$("#categUlBox").append(scrollStr);
		scrollBar("categUlBox","categUl","scrollPar","scrollSon",15);
	}
	var oldColor = "";
	var aLi = $(".listCon li");
	$(".listCon li:odd").addClass("listBg");
	for(var i=0;i<aLi.length;i++){
		aLi[i].onmouseover = function(){
			oldColor = this.style.color;
			this.style.background = "#f3f3f3";
		};
		aLi[i].onmouseout = function(){
			this.style.background = oldColor;
		};
	}
}

//新增 编辑产品基本信息弹窗下的选择查看产品类别
function selCateg(options){	
	$(".checkCategLayer").show().animate({"opacity":0.9});
	if(options == "addProInfo"){
		listPt("addPro");
	}else if(options == "addCorrUint"){
		listBizType("addBiz");
	}else if(options == "addWhCateg"){
		var whId = $("#selCateg").attr("alt");
		$("#nowCateg_wh").attr("alt",whId);
		$("#nowCateg_wh").text($("#selCateg").text());
		loadWHTypeList("select",whId);
	}
	/*$("#selCategUl li").each(function(i){
		if($("#selCategUl li").eq(i).html() == $(".selCategDiv p").html()){
			$("#selCategUl li").eq(i).addClass("active");
		}
	});*/
	var parHei = $("#selCategWrap").height();
	var sonHei = $("#selCategUl").height();
	if(sonHei > parHei){
		if(categFlag){
			$("#selCategWrap").append(scrollStr);
			scrollBar("selCategWrap","selCategUl","scrollPar_1","scrollSon_1",15);
		}
		categFlag = false;
	}
}
//编辑产品类别层/业务单位类别层
function editCategWin(type){
	$(".layer").show();
	$(".editCategWin").show();
	if(type == "whouse"){
		loadWHTypeList("edit");
	}else if(type =="biz"){
		listBizType("updateBizType");
	}else if(type =="product"){
		listPt("updateProType");
	}
}
function closeEditCategWin(){
	$(".layer").hide();
	$(".editCategWin").hide();
}
//检测编辑产品类别层/业务往来类别层高度动态创建模拟滚动条
function checkEditCategHei(){
	var parHei = $("#editConDiv").height();
	var sonHei = $("#eiitConUl").height();
	var scrollStr = "<div id='scrollPar_2' class='parScroll scrollWid1'><div id='scrollSon_2' class='sonScroll scrollWid1'></div></div>";
	if(sonHei > parHei){
		if(categFlag){
			$("#editConDiv").append(scrollStr);
			scrollBar("editConDiv","eiitConUl","scrollPar_2","scrollSon_2",15);
		}
		categFlag = false;
	}
	$(".editCon li").each(function(i){
		$(this).hover(function(){
			$(".editCon li a").eq(i).stop().animate({"top":0},300);
		},function(){
			$(".editCon li a").eq(i).stop().animate({"top":-35},300);
		});
	});
}

//close添加/编辑产品基本信息/单位基本信息/货架基本信息弹窗
function closeAddProdWin(){
	$(".addNewProDiv").hide();
	$(".layer").hide();
	$(".tipDiv").hide();
	$(".tipDiv p").html("");
}

//新增 编辑产品基本信息/单位基本信息/货架基本信息弹窗下的关闭类别数据层
function closeSelCategWin(){
	$(".checkCategLayer").animate({"opacity":0},function(){
		$(".checkCategLayer").hide();
	});
}
//新增 编辑产品基本信息/单位基本信息/货架基本信息 弹窗下的增加产品类别
function addNewCateg(){
	$(".addCategBox").show().animate({"top":0});
}
function cancelAddCateg(options){
	if(options == "addProInfo"){
		topNum = 380;
	}else if(options == "addCorrUnInfo"){
		topNum = 512;
	}else if(options == "addWhCategInfo"){
		topNum = 248;
		//清空数据
		$("#wtName_add2").val("");
		$("#wtRemark_add2").val("");
		$("#wtNameDiv_wt2").hide();
	}
	$(".addCategBox").animate({"top":-topNum},function(){
		$(".addCategBox").hide();
		$(".tipDiv").hide();
		$(".tipDiv p").html("");
	});
}
//增加单位类别/货架类别弹窗
function showAddCategWin(){
	$(".layer").show();
	$(".addCategDiv").show();
}
//关闭新增业务单位类别/新增产品类别/新增货架类别弹窗
function closeAddCategWin(){
	$(".layer").hide();
	$(".addCategDiv").hide();
	$(".tipDiv").hide();
	$(".tipDiv p").html("");
}