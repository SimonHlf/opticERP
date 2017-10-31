<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>新增入库信息</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link href="Module/css/pagination.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="Module/inStore/css/inStoreCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/timeControl/css/ion.calendar.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/inStore/js/inStoreJs.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script type="text/javascript">
var creScroll = true;
var roleName = "${sessionScope.login_user_dep_name}";
var pageSize = 8;
var page_index = 0;
var bTypeId_a = 0;
var pyCode_a = "";
var page_index_p = 0;//选择产品
var pTypeId_a = 0;//产品类别编号
var pyCode_p_a = "";//产品拼音码
var page_index_wh = 0;//货架
var wTypeId_a = 0;//库房类别编号
var whName_a = "";//货架名称
var pageSize_wh = 24;//货架页面每页记录条数
var option_tr = "inStore";//区别供应商的doubleTrClick()

var dbFlag = true;

var sTime_a = "";
var eTime_a = "";
var inStatus_a = -1;
var proId_a = 0;
var whId_a = 0;
var inOrder_a = 0;
var option_a = 0;
var bcId_a = 0;
var contentInfo = "";
$(function(){
	if(roleName == "库房" ){
		
	}else{
		contentInfo = '<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览入库单</a>';
		if(roleName == "财务" || roleName == "董事长"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_in()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
		}
		$("#headFunArea").html(contentInfo);
		selPurchaseTab(2);
	}
	choiceOption("inStoreInp","active","label","insStatusIn","iconFont",function(){
		clearAllInOrderInfo();
		if($("#insStatusIn").val() == 1){
			$(".comHidDiv").hide();
			$("#purchDataDiv").show();
			$(".saveDiv").removeClass("saveDivPos").addClass("saveDivPos1");
			inpTipFocBlur("quePurNumInp","请输入采购单编号","#999","#666");
		}else if($("#insStatusIn").val() == 4){//网购入库
			$(".comHidDiv").hide();
			$("#purchDataDiv").show();
			$(".saveDiv").removeClass("saveDivPos").addClass("saveDivPos1");
			inpTipFocBlur("quePurNumInp","请输入采购单编号","#999","#666");
			getSpecBcInfo(1);
			//获取该外贸公司下所有未完成入库的采购订单
			showUnFiPurOrder();
		}else{
			$(".comHidDiv").show();
			$("#purchDataDiv").hide();
			$(".saveDiv").removeClass("saveDivPos1").addClass("saveDivPos");
			if($(".parScroll").length > 0){
				$(".parScroll").remove();
			}
			if($("#insStatusIn").val() == 0){//期初库存-自动获取专属公司
				getSpecBcInfo(2);
			}
		}
	});
	judgeTime_1();
	$("#inUserId_add").val("${sessionScope.login_real_name}");
	$("#inDate_add").val("${requestScope.inDate}");
	$("#insPeoSpan").html("${sessionScope.login_real_name}");
	$("#insTimeSpan").html("${requestScope.inDate}");
	getSpecBcInfo(2);
});
//到处入库信息到Excel
function downInfoToExcel_in(){
	if(getInOrderCount() > 0){
		var urlStr = "&sTime="+sTime_a+"&eTime="+eTime_a+"&inStatus="+inStatus_a+"&proId="+proId_a;
		urlStr += "&bcId="+bcId_a+"&option="+option_a;
		window.location.href = "inStore.do?action=exportInfoToExcel"+urlStr;
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"没有数据，不能进行导出");
	}
}
//获取采购人员外出采购货物时的专属公司
function getSpecBcInfo(bcType){
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{bcType:bcType},
	      url:"bizcontact.do?action=getSpecBc",
	      success:function (json){
	    	  $("#purVal").attr("alt",json["result"][0].id).val(json["result"][0].bcName);
	      }
	  });
	//自动加载入库单编号
	var insOrder = autoCreateInsOrder();
	if(insOrder != ""){
		var insOrderArray = insOrder.split("_");
		var preSuffix = insOrderArray[0];
		var lastNum = insOrderArray[1];
		$("#preSuffix").val(preSuffix);
		$("#insOrder_add").val(lastNum);
	}
	
}
//新增入库单下选取供应商数据 、选取供应商下商品的数据层弹窗
function showCorrUnProInfDiv(options,whIdVar){
	if(options == 1){//选取供应商
		if($("#insStatusIn").val() != 4){//当是网购入库时，供应商为自动加载
			$(".purDataDiv").show();
			inpTipFocBlur("searInput","请输入往来单位拼音码","#999","#666");
			getCommonType("bType");
			createLeftScroll("corUnCategDataDiv","categDataDivPur","categDataUlPur",options);
			$(".layer").show();
		}
	}else if(options == 2){//选取商品
		$(".proInfoDiv").show();
		getCommonType("pType");
		createLeftScroll("proCategDataDiv","categDataDivPro","categDataUlPro",options);
		inpTipFocBlur("searInput_pro","请输入产品拼音码","#999","#666");
		$(".layer").show();
	}else if(options == 3){//入库货架  
		if($("#insStatusIn").val() == 1 || $("#insStatusIn").val() == 4){//采购、网购入库时选择货架
			$("#selPurPosition").val(whIdVar);
		}
		$(".instWhDataDiv").show();
		getCommonType("wType");
		createLeftScroll("whCategDataDiv","categDataDivWh","categDataUlWh",options);
		inpTipFocBlur("searInput_insWh","请输入货架编号","#999","#666");
		$(".layer").show();
	}else if(options == 4){//浏览入库单时选择公司
		$(".purDataDiv").show();
		inpTipFocBlur("searInput","请输入往来单位拼音码","#999","#666");
		getCommonType("bType");
		createLeftScroll("corUnCategDataDiv","categDataDivPur","categDataUlPur",options);
		$(".layer").show();
	}
}
function closeAlertWin(obj,module){
	page_index = 0;
	bTypeId_a = 0;
	pyCode_a = "";
	page_index_p = 0;//选择产品
	pTypeId_a = 0;//产品类别编号
	pyCode_p_a = "";//产品拼音码
	page_index_wh = 0;//货架
	wTypeId_a = 0;//库房类别编号
	whName_a = "";//货架名称
	if(module == "bc"){//供应商
		$("#searInput").val("请输入往来单位拼音码");
		$("#bsTurnPage").hide();
		$("#dataListTab_un").html("");
		
	}else if(module == "pro"){//产品
		$("#searInput_pro").val("请输入产品拼音码");
		$("#Pagination_pro").hide();
		$("#dataListTab_pro").html("");
	}else if(module == "wh"){//货架
		$("#searInput_insWh").val("请输入货架编号");
		$("#whListUl").html("");
		$("#Pagination_wh").hide();
		//清空数据
		$("#selWhId").val("0").attr("alt","");
		$("#selPurPosition").val("0");
	}
	if($(".parScroll").length > 0){
		$(".parScroll").remove();
		$(".categDataUl").css({"top":0});
	}
	$(obj).hide();
	$(".layer").hide();
}
//浏览入库购单下头部的查询
function changeSearch(options){
	$(".selCondP label").removeClass("active");
	if(options == 1){//根据新增入库单时间查询
		$("#addInsTimSearLab").addClass("active");
		$(".searLayer").animate({"left":599});
		clearOption2();
	}else if(options == 2){//根据入库单号查询
		$("#insNumSearLab").addClass("active");
		$(".searLayer").animate({"left":0});
		inpTipFocBlur("queryInsNum","请输入入库单号","#999","#666");
		clearOption1();
	}
}
//添加单位类别、单位基本信息、产品类别、产品基本信息窗口
function showComAddWin(options){
	$(".closeIcon").hide();
	$(".addNewDataDiv").show().animate({"top":50},function(){
		if(options == 1){//添加仓库类别
			$(".addWhCategDiv").show();
		}else if(options == 2){//添加仓库货架信息
			$(".addWhInfoDiv").show();
		}else if(options == 3){//添加产品类别
			$(".addProCategDiv").show();
		}else if(options == 4){//添加产品基本信息
			$(".addProInfoDiv").show();
			choiceOption("comCategStyInp","active","label","categStyInp","iconFont"); //类别类型
		}
	});
}
function selCategBankWin(options){
	//4:查看仓库类别   1：查看产品类别  2：查看加工工艺
	if(options == 4){
		$(".selWhCategLay").show().animate({"opacity":1});
		var whId = $("#selCateg").attr("alt");
		loadWHTypeList(whId);
		if($(".selCategDiv_wh p").html() == ""){
			$("#nowCateg_wh").html("暂未选择仓库类别");
		}else{
			$("#nowCateg_wh").html($(".selCategDiv_wh p").html());
			matchingHtml($("#selCategWrap_wh li"),$("#nowCateg_wh"));
		}
		if($("#selCategWrap_wh li").length == 0){
			$("#selCategWrap_wh").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无产品类别，请添加</span></div>");
		}
		addLiActive($("#selCategWrap_wh li"),$("#nowCateg_wh"));
	}else if(options == 1){
		$(".selProCategLay").show().animate({"opacity":1});
		if($(".selCategDiv_pro p").html() == ""){//暂未选择产品类别
			$("#nowCateg_pro").html("暂未选择产品类别");
		}else{
			$("#nowCateg_pro").html($(".selCategDiv_pro p").html());
			matchingHtml($("#selCategWrap_pro li"),$("#nowCateg_pro"));
		}
		getProType();
		addLiActive($("#selCategWrap_pro li"),$("#nowCateg_pro"));
		crePorCategScroll();
	}else if(options == 2){
		$(".selProTechLay").show().animate({"opacity":1});
		if($("#madeDepP").html() == ""){//暂未选择加工工艺
			$("#nowCateg_made").html("暂未选择加工工艺");
		}else{
			$("#nowCateg_made").html($("#madeDepP").html());
			matchingHtml($("#selProTechData li"),$("#nowCateg_made"));
		}
		ProcessMade();
	}
}
//根据产品类别数量多少动态创建模拟滚动条
function crePorCategScroll(){
	if($("#selCategUl_pro").height() > $("#selCategWrap_pro").height()){
		//创建模拟滚动条
		var scroll = "<div id='scrollPar_pro' class='parScroll_pro'><div id='scrollSon_pro' class='sonScroll_pro'></div></div>";
		if(creScroll){
			$("#selCategWrap_pro").append(scroll);
			scrollBar("selCategWrap_pro","selCategUl_pro","scrollPar_pro","scrollSon_pro",15);
		}
		creScroll = false;
	}
}
//获取产品类别
function getProType(){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		url:"producttype.do?action=listProductType",
		success:function(json){
			if(json == ""){
				$("#selCategWrap_pro").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无产品类别，请添加</span></div>");
			}else{
				var content = "";
				$.each(json, function(row, obj) {
					var ptId = obj.id;
					var ptName = obj.typeName;
					content+="<li onclick=selProType('"+ptId+"','"+ptName+"');>"+ptName+"</div>";
				});
				$("#selCategUl_pro").html(content);
			}
		}
	});
}
//选择产品类别
function selProType(ptId,ptName){
	$("#nowCateg_pro").html(ptName).attr("alt",ptId);
	
}
//保存选择后的加工工艺  产品类别
function selCagetBankName(options,objNow,strCon){
	//2：选择产品类别 3：选择加工工艺  
	var objNowHtml = objNow.html();
	if(objNowHtml != "" && objNowHtml != strCon){
		if(options == 3){
			$("#madeDepP").text($("#nowCateg_made").text());
			$(".selProTechLay").animate({"opacity":0},function(){$(".selProTechLay").hide();});
		}else if(options == 2){
			$(".selCategDiv_pro p").html($("#nowCateg_pro").html()).attr("alt",$("#nowCateg_pro").attr("alt"));
			$(".selProCategLay").animate({"opacity":0},function(){$(".selProCategLay").hide();});
		}
	}else{
		if(options == 3){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择加工工艺");
		}else if(options == 2){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择产品类别");
		}
	}
}
//分页获取货架列表
function showPageWSList_curr(obj,wtId){
	if(wtId > 0){//按照仓库类别查询
		wTypeId_a = wtId;
		whName_a = "";
	}else{//指定货架查询
		var inputWhName = $("#searInput_insWh").val();
		if(inputWhName == "请输入货架编号"){
			inputWhName = "";
		}
		whName_a = inputWhName;
		wTypeId_a = 0;
	}
	var allCount = getWHCount(wTypeId_a,whName_a);//全部
	$("#categDataUlWh li").removeClass("active");
	$(obj).parent().addClass("active");
    $("#Pagination_wh").pagination(allCount, {
      callback: pageselectCallback_wh,  //PageCallback() 为翻页调用次函数。
      prev_text: "上一页",
      next_text: "下一页 ",
      items_per_page:pageSize_wh,
      current_page:page_index_wh,
      ellipse_text:"...",
      num_edge_entries: 2,       //两侧首尾分页条目数
      num_display_entries: 6	//连续分页主体部分分页条目数
    });
    $("#Pagination_wh").css({
 	 	"left":parseInt(($("#whTurnPage").width() - $("#Pagination_wh").width())/2),
 	 	"top":20
    });
}
//获取货架记录条数
function getWHCount(){
	var count = 0;
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"basic.do?action=getWHSCount",
      data:{whId:wTypeId_a,whsName:escape(whName_a)},
      success:function (json){
      	count = json["result"];
      }
  });
	return count;
}

//获取仓库货架列表
function loadWSList(pageNo,pageSize){
	$.ajax({
      type:"post",
      async:false,
      dataType:"json",
      url:"basic.do?action=getWHSList",
      data:{whId:wTypeId_a,whsName:escape(whName_a),pageNo:pageNo,pageSize:pageSize},
      success:function (json){
      	showWSList(json["wsList"]);
      }
  });
}
//显示仓库货架列表
function showWSList(list){
	var content = "";
	if(list.length > 0){
		$("#Pagination_wh").show();
		for(var i = 0 ; i < list.length ; i++){
			content += "<li id='li_wh_"+list[i].id+"' alt='"+list[i].id+"' class='ellip' altTxt='"+ list[i].whsName +"' title='"+list[i].whTypeInfo.whName+"'>"+list[i].whsName+"</li>";
		}
		$("#whListUl").html(content);
		singleLiClick();//货架单击事件
	}else{
		$("#Pagination_wh").hide();
		$("#whListUl").html("<div class='noRecCon1'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无仓库货架记录</span></div>");
	}
}
//显示出列表数据
function pageselectCallback_wh(page_index_wh,jq){
	loadWSList(page_index_wh+1,pageSize_wh);
}
//单击货架事件
function singleLiClick(){
	$("#whListUl li").each(function(){
		$(this).click(function(){
			$("#whListUl li").removeClass("active");
			$(this).addClass("active");
			if($("#insStatusIn").val() == 1 || $("#insStatusIn").val() == 4){//采购、网购入库时选择货架
				$("#selWhId").val(($(this).attr("alt"))).attr("alt",$(this).html());
			}else{
				$("#selWhId").val(($(this).attr("alt"))).attr("alt",$(this).html()+"  ("+$(this).attr("title")+")");
			}
		});
	});
}
//将刚选中的货架编号赋值且关闭窗口
function selWhInfo(){
	var whVar = "";
	if(option_tr == "listInStore"){
		whVar = "compNaInp";
		$("#"+whVar).attr("alt",$("#selWhId").val()).val($("#selWhId").attr("alt"));
		if($("#"+whVar).val() != ""){
			$("#delOptWh").show();
		}
	}else{
		if($("#insStatusIn").val() == 1 || $("#insStatusIn").val() == 4){//采购、网购入库时选择货架
			whVar = $("#selPurPosition").val();
			$("#"+whVar).attr("alt",$("#selWhId").val()).html($("#selWhId").attr("alt")).removeAttr("title");
		}else{
			whVar = "wtId_add";
			$("#"+whVar).attr("alt",$("#selWhId").val()).val($("#selWhId").attr("alt"));
		}
	}
	closeSelWHWindow("searInput_insWh","selWhId","instWhDataDiv");
}

//清空新增入库单所有信息
function clearAllInOrderInfo(){
	$("#purVal").attr("alt","0").val("");
	$("#insOrder_add").val("");
	$("#proId_add").attr("alt","0").val("");
	$("#proNo_add").val("");
	$("#proUnit_add").val("");
	$("#proSpec_add").val("");
	$("#inNumber_add").val("");
	$("#wtId_add").attr("alt","0").val("");
	$("#inRemark_add").val("");
	
	$("#quePurNumInp").val("请输入采购单编号");
	$("#purNumDataUl").html("");
	$("#detailConTab").html("");
	
	$("#selPurPosition").val("0");//初始选择那条采购详单的入库货架
	
	//隐藏所有错误提示
	$("#corrUnTipDiv").hide();
	$("#insNumTipDiv").hide();
	$("#proNamTipDiv").hide();
	$("#inStNumDiv").hide();
	$("#inStWhDiv").hide();
}
function clearAllInOrderInfo_1(){//网购、采购入库时用
	//更新入库单号
	var insOrder = autoCreateInsOrder();
	if(insOrder != ""){
		var insOrderArray = insOrder.split("_");
		var preSuffix = insOrderArray[0];
		var lastNum = insOrderArray[1];
		$("#preSuffix").val(preSuffix);
		$("#insOrder_add").val(lastNum);
	}
	//更新所有未完成订单列表
	showUnFiPurOrder();
	//清空未完成的采购详细订单列表
	$("#quePurNumInp").val("请输入采购单编号");
	$("#detailConTab").html("");
}
//获取需要实际的入库数量（入库数量必须小于、等于数据库中需要入库的数量）
function getInStoreNum(bcId,proId){
	var activeInNum = 0;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        data:{bcId:bcId,proId:proId},
        url:"inStore.do?action=getRemainNum",
        success:function (json){
        	activeInNum = json["result"];
        }
    });
	return activeInNum;
}
//入库动作
function addInStore(){
	var inStatus = $("#insStatusIn").val().replace(/\s+/g, "");
	var newInNum_tr_flag = true;//新入库数量是否填写标记--采购入库用
	var newWhId_tr_flag = true;//新入库货架是否填写标记--采购入库用
	var nullFlag = false;//采购记录为空标记--采购入库用
	var bcId = $("#purVal").attr("alt").replace(/\s+/g, "");
	var inNo = $("#insOrder_add").val().replace(/\s+/g, "");
	var remark = "";
	var posIdStr = "";//采购子订单编号
	var proIdStr = "";//产品编号
	var newInNumberStr = "";//入库数量
	var whIdStr = "";//货架编号
	var bcFlag = false;//供应商标记--公用
	var noFlag = false;//入库单编号标记--公用
	var proFlag = false;//产品标记--其他入库用
	var inFlag = false;//入库状态--公用
	var whFlag = false;//货架标记--其他入库用
	var finalFlag = false;//最终标记
	var purId = 0;//采购单编号
	if(bcId == "0"){
		$("#corrUnTipDiv").find("p").html("请选择供应商");
		$("#corrUnTipDiv").show();
	}else{
		bcFlag = true;
		$("#corrUnTipDiv").hide();
	}
	if(inNo == ""){
		$("#insNumTipDiv").find("p").html("入库单号不能为空");
		$("#insNumTipDiv").show();
	}else if(checkIsNumeric(inNo)){
		$("#insNumTipDiv").find("p").html("入库单号只能是字母");
		$("#insNumTipDiv").show();
	}else{
		$("#insNumTipDiv").hide();
		noFlag = true;
	}
	if(inStatus == 1 || inStatus == 4){//采购入库、采购人员采购入库
		var num = $("#detailConTab tr").length;//采购产品记录条数
		if(bcFlag && noFlag){
			if(num == 0){
				//alert("需要入库的记录不能为空");
				commonTipInfoFn($("body"),$(".alertWin"),false,"需要入库的记录不能为空");
			}else{
				nullFlag = true;
				$(".cNewInNum").each(function(i){
					if($(".cNewInNum").eq(i).html() == 0){
						newInNum_tr_flag = false;
						return false;
					}
				});
				$(".cWhouseIdClass").each(function(i){
					if($(".cWhouseIdClass").eq(i).attr("alt") == 0){
						newWhId_tr_flag = false;
						return false;
					}
				});
				if(newInNum_tr_flag && newWhId_tr_flag){
					$(".cPosIdClass").each(function(i){
						posIdStr += $(".cPosIdClass").eq(i).attr("alt")+",";
					});
					posIdStr = posIdStr.substring(0,posIdStr.length - 1);
					$(".cProductIdClass").each(function(i){
						proIdStr += $(".cProductIdClass").eq(i).attr("alt")+",";
					});
					proIdStr = proIdStr.substring(0,proIdStr.length - 1);
					$(".cNewInNum").each(function(i){
						newInNumberStr += $(".cNewInNum").eq(i).html()+",";
					});
					newInNumberStr = newInNumberStr.substring(0,newInNumberStr.length - 1);
					$(".cWhouseIdClass").each(function(i){
						whIdStr += $(".cWhouseIdClass").eq(i).attr("alt")+",";
					});
					whIdStr = whIdStr.substring(0,whIdStr.length - 1);
					remark = $("#inRemark_add1").val().replace(/\s+/g, "");
					purId = $("#selPurId").val();
				}else{
					//alert("请填写入库完整信息");
					commonTipInfoFn($("body"),$(".alertWin"),false,"请填写入库完整信息");
				}
			}
		}
		if(bcFlag && noFlag && nullFlag && newInNum_tr_flag && newWhId_tr_flag){
			finalFlag = true;
		}
	}else{
		proIdStr = $("#proId_add").attr("alt").replace(/\s+/g, "");
		newInNumberStr = $("#inNumber_add").val().replace(/\s+/g, "");
		whIdStr = $("#wtId_add").attr("alt").replace(/\s+/g, "");
		remark = $("#inRemark_add").val().replace(/\s+/g, "");
		if(proIdStr == "0"){
			$("#proNamTipDiv").find("p").html("产品不不能为空");
			$("#proNamTipDiv").show();
		}else{
			$("#proNamTipDiv").hide();
			proFlag = true;
		}
		if(newInNumberStr == ""){
			$("#inStNumDiv").find("p").html("入库数量不能为空");
			$("#inStNumDiv").show();
		}else if(!checkIsNumber(newInNumberStr)){
			$("#inStNumDiv").find("p").html("入库数量格式错误");
			$("#inStNumDiv").show();
		}else{
			/**var activeInNum = getInStoreNum(bcId,proIdStr);//数据库中实际需要入库的数量总和
			if(activeInNum == 0){
				$("#inStNumDiv").find("p").html("该产品可能未采购或已全部入库");
				$("#inStNumDiv").show();
			}else if(activeInNum < parseInt(newInNumberStr)){
				$("#inStNumDiv").find("p").html("经查，等待入库总量是"+activeInNum+"。");
				$("#inStNumDiv").show();
			}else{
				$("#inStNumDiv").hide();
				inFlag = true;
			}**/
			inFlag = true;
		}
		if(whIdStr == "0"){
			$("#inStWhDiv").find("p").html("入库货架不能为空");
			$("#inStWhDiv").show();
		}else{
			$("#inStWhDiv").hide();
			whFlag = true;
		}
		if(bcFlag && noFlag && proFlag && inFlag && whFlag){
			finalFlag = true;
		}
	}
	if(finalFlag){
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        data:{posIdStr:posIdStr,purId:purId,bcId:bcId,inNo:$("#preSuffix").val()+"_"+inNo,proIdStr:proIdStr,
	        	inNumberStr:newInNumberStr,whIdStr:whIdStr,inStatus:inStatus,remark:escape(remark)},
	        url:"inStore.do?action=addInStore",
	        success:function (json){
	        	if(json["result"] == "succ"){
	        		//alert("入库成功");
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"入库成功",function(){
	        			if(inStatus == 1 || inStatus == 4){
		        			clearAllInOrderInfo_1();
		        		}else{
		        			clearAllInOrderInfo();
		        		}
	        		});
	        	}else if(json["result"] == "noAbility"){
	        		//alert("你无权操作");
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权操作");
	        	}else{
	        		//alert("入库失败");
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"入库失败");
	        	}
	        }
	    });
	}
	
}
//获取仓库类别列表
function loadWHTypeList(whId){
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:"basic.do?action=getWHSTypeList",
        success:function (json){
        	showWHTypeList(json["wtList"],whId);
        }
    });
}
//显示仓库类别列表
function showWHTypeList(list,whId){
	var content = "";
	if(list != null){
		for(var i = 0 ; i < list.length ; i++){
			if(whId == list[i].id){
				content += "<li class='active'>";
			}else{
				content += "<li>";
			}
			content += "<span onclick=selctWHType('"+list[i].id+"','"+list[i].whName+"')>"+list[i].whName+"</span>";
			content += "</li>";
		}
	}else{
		content = "<div class='noAddCateg margL6'><img src='Module/basicInfo/images/noCategWhRec1.png' alt='暂未添加仓库类别'/></div>";
	}
	$("#selCategUl_wh").html(content);
}
//增加货架时选择仓库类别
function selctWHType(whId,whName){
	$("#nowCateg_wh").html(whName);
	$("#nowCateg_wh").attr("alt",whId);
}
//确定选择仓库类别动作
function selectCateg(){
	var whId = $("#nowCateg_wh").attr("alt");
	var whName = $("#nowCateg_wh").text();
	if(whId == 0){
		//alert("请选择一个仓库类别");
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择一个仓库类别");
	}else{
		$("#selCateg").text(whName);
		$("#selCateg").attr("alt",whId);
		comCanCategBankWin(1);
	}
}
//增加货架时关闭选择仓库类别用
function comCanCategBankWin(options){
	//1:关闭选择仓库类别  2:关闭选择产品类别  3：关闭选择加工工艺层
	if(options == 1){
		$(".selWhCategLay").animate({"opacity":0},function(){$(".selWhCategLay").hide();});
		$("#selCategWrap_wh li").removeClass("active");
	}else if(options == 2){
		$(".selProCategLay").animate({"opacity":0},function(){$(".selProCategLay").hide();});
		$("#selCategWrap_pro li").removeClass("active");
	}else if(options == 3){
		$(".selProTechLay").animate({"opacity":0},function(){$(".selProTechLay").hide();});
		$("#selCategUl_made li").removeClass("active");
	}
}
//入库时添加仓库类别、货架时关闭窗口用
function comCancelAdd(options){
	$(".addNewDataDiv").animate({"top":-400},function(){
		if(options == 5){//关闭添加货架
			$("#whsName_add").val("").attr("alt",0);
			$("#selCateg").text("").attr("alt","0");
			$("#whsRemark_add").val("");
			$("#whNameDiv").hide();
			$("#whCategDiv").hide();
		}else if(options == 6){//关闭添加仓库类别窗口
			$("#whTypeName_add").val("");
			$("#wtRemark_add").val("");
			$("#categWhNaDiv").hide();
		}else if(options == 3){//关闭添加产品类别
			$(".addProCategDiv").hide();
			//清空数据
			$("#proType_add").val("");
			$("#typeRemark_add").val("");
			//隐藏提示层
			$("#categProNaDiv").hide();
		}else if(options == 4){//关闭添加产品基本信息
			$(".addProInfoDiv").hide();
			//清空DIV数据
			clearAllAddProInfo();
		}
		$(".addWhInfoDiv").hide();
		$(".addWhCategDiv").hide();
		$(".addNewDataDiv").hide();
		$(".closeIcon").show();
	});
}
//清空查询条件1
function clearOption1(){
	$("#sTime").val("").attr("placeholder","请选择开始时间");
	$("#eTime").val("").attr("placeholder","请选择结束时间");
	$(".inStoreQue").each(function(i){
		if($(".inStoreQue").eq(i).is(":checked")){
			$(".inStoreQue").eq(i).attr("checked",false);
			$(".inStoreQue").eq(i).parent().removeClass("active");
			$(".inStoreQue").eq(i).parent().find("i").remove();
		}
	});
	$("#insStaInpVal").val("-1");
	$("#proNaInp").val("").attr("alt",0);
	$("#compNaInp").val("").attr("alt",0);
	$("#delOptPro").hide();
	$("#delOptComp").hide();
}
//清空查询条件2
function clearOption2(){
	$("#queryInsNum").val("请输入入库单号");
	$("#sTime").val("${requestScope.sTime}");
	$("#eTime").val("${requestScope.inDate}");
}
//初始入库单
function queryOrder(status){
	if(status == 0){//初始查询近三天的所有入库单
		clearOption1();
		clearOption2();	
	}
	sTime_a = $("#sTime").val().replace(/\s+/g, "");
	eTime_a = $("#eTime").val().replace(/\s+/g, "");
	if(sTime_a > eTime_a){
		//alert("入库时间选择错误");
		commonTipInfoFn($("body"),$(".alertWin"),false,"入库时间选择错误");
	}else{
		inStatus_a = $("#insStaInpVal").val().replace(/\s+/g, "");
		proId_a = $("#proNaInp").attr("alt").replace(/\s+/g, "");
		//whId_a = $("#compNaInp").attr("alt").replace(/\s+/g, "");
		inOrder_a = $("#queryInsNum").val().replace(/\s+/g, "");
		bcId_a = $("#compNaInp").attr("alt").replace(/\s+/g, "");
		option_a = status;
		if(inOrder_a == "请输入入库单号"){
			inOrder_a = "";
		}
		var allCount = getInOrderCount();//全部
	    $("#Pagination_in").pagination(allCount, {
	        callback: pageselectCallback_in,  //PageCallback() 为翻页调用次函数。
	        prev_text: "上一页",
	        next_text: "下一页 ",
	        items_per_page:pageSize,
	        current_page:page_index,
	        ellipse_text:"...",
	        num_edge_entries: 2,       //两侧首尾分页条目数
	        num_display_entries: 6	//连续分页主体部分分页条目数
	    });
	    $("#Pagination_in").css({
	 	 	"left":parseInt(($("#viewTurnPage").width() - $("#Pagination_in").width())/2),
	 	 	"top":0
	    });
		
	}
}
//根据条件获取记录数
function getInOrderCount(){
	var count = 0;
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{sTime:sTime_a,eTime:eTime_a,inStatus:inStatus_a,proId:proId_a,bcId:bcId_a,inOrder:inOrder_a,option:option_a},
	    url:"inStore.do?action=getInOrderCount",
	    success:function (json){
	    	count = json["result"];
	    }
	});
	return count;
}
//分页获取入库记录
function getInStorePageInfo(pageNo,pageSize){
	var content = "";
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{sTime:sTime_a,eTime:eTime_a,inStatus:inStatus_a,proId:proId_a,bcId:bcId_a,
	    	inOrder:inOrder_a,option:option_a,pageNo:pageNo,pageSize:pageSize},
	    url:"inStore.do?action=getInOrderPageInfo",
	    success:function (json){
	    	if(json["result"].length > 0){
	    		$("#Pagination_in").show();
				content = "<ul id=purOrdUl class='outStOrdUl clearfix'>";
				var isObj = json["result"];
				for(var i = 0 ; i < isObj.length ; i++){
					content += "<li class=mainLi>";
					content += "<div class=mainBox>";
					content += "<h3><span>入库单  OutStoring Order</span><em>入库编号："+isObj[i].isi.inONo+"</em></h3>";
					content += "<div class=outStTitDiv>";
					content += "<p>供应商："+isObj[i].isi.businessContactInfo.bcName+"</p>";
					//<p class="outStOrdNum">采购单编号：L-C20170224-01</p>;采购单编号
					content += "</div>";
					content += "<ul class='outStOrdLisTit clearfix'>";
					content += "<li class='listLiWid1'>编号</li>";
					content += "<li class='listLiWid2'>产品名称</li>";
					content += "<li class='listLiWid4'>规格</li>";
					content += "<li class='listLiWid6'>材质</li>";
					content += "<li class='listLiWid3'>单位</li>";
					content += "<li class='listLiWid5'>入库数量</li>";
					content += "<li class='listLiWid6 noBorLi'>入库货架</li>";
					content += "</ul>";
					var issObj = json["result"][i].issList;
					for(var j = 0 ; j < issObj.length ; j++){
						var count = 1;
						content += "<ul class='outStOrdLisCon clearfix'>";
						content += "<li class='listLiWid1'>"+count+"</li>";
						content += "<li class='listLiWid2'>"+issObj[j].productInfo.proName+"</li>";
						content += "<li class='listLiWid4'>"+issObj[j].productInfo.proSpec+"</li>";
						content += "<li class='listLiWid6'>"+issObj[j].productInfo.proCz+"</li>";
						content += "<li class='listLiWid3'>"+issObj[j].productInfo.proUnit+"</li>";
						content += "<li class='listLiWid5'>"+issObj[j].inNumber+"</li>";
						content += "<li class='listLiWid6 noBorLi'>"+issObj[j].whStorageInfo.whsName+"</li>";
						content += "</ul>";
						count++;
					}
					
					var inStatus = isObj[i].isi.inStatus;
					var inStatusTxt = "";
					if(inStatus == 0){
						inStatusTxt = "期初库存";
					}else if(inStatus == 1){
						inStatusTxt = "采购入库";
					}else if(inStatus == 2){
						inStatusTxt = "加工半成品入库  ";
					}else if(inStatus == 3){
						inStatusTxt = "加工成品入库";
					}else if(inStatus == 4){
						inStatusTxt = "网购入库";
					}
					content += "<div class='outStOrdBotDiv'>";
					content += "<p>录入状态："+inStatusTxt+"</p>";
					content += "<p>备注："+isObj[i].isi.remark+"</p>";
					content += "</div>";
					content += "<div class='outStOrdBotDiv1'>";
					content += "<p>入库日期："+getLocalDate(isObj[i].isi.inDate)+"</p>";
					content += "<p>入库人："+isObj[i].isi.userInfo.userName+"</p>";
					content += "</div>";
					content += "</div>";
					content += "</li>";
				}
				content += "</ul>";
	    	}else{
	    		$("#Pagination_in").hide();
	    		content = "<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无入库单记录</span></div>";
	    	}
	    	$("#inOrderListDiv").html(content);
	    	waterFall("purOrdUl","mainLi");
	    }
	});
}
//显示出列表数据
function pageselectCallback_in(page_index,jq){
	getInStorePageInfo(page_index+1,pageSize);
}
//清除条件
function delOption(option){
	if(option == "pro"){
		$("#proNaInp").val("").attr("alt","0");
		$("#delOptPro").hide();
	}else if(option == "comp"){
		$("#compNaInp").val("").attr("alt","0");
		$("#delOptComp").hide();
	}
}
//根据供应商编号获取该供应商所有未完成的采购订单
function showUnFiPurOrder(){
	var bcId = $("#purVal").attr("alt").replace(/\s+/g, "");
	var purNo = $("#quePurNumInp").val().replace(/\s+/g, "");
	if(purNo == "请输入采购单编号"){
		purNo = "";
	}
	var content = "";
	if(bcId != 0){
		$.ajax({
			type:"post",
		    async:false,
		    dataType:"json",
		    data:{bcId:bcId,purNo:purNo},
		    url:"purchase.do?action=getUnFinishInfo",
		    success:function (json){
		    	if(json["result"].length > 0){
		    		content += "<ul id=purNumDataUl class=categDataUl>";
		    		for(var i = 0 ; i < json["result"].length ;i++){
		    			content += "<li onclick=showPurOrder('"+json["result"][i].id+"')><span></span><i class='iconfont icon-mingpian cardIcon'></i><p>"+json["result"][i].purONo+"</p></li>";
		    		}
		    		content += "</ul>";
		    		$("#purNumDataBox").html(content);
		    		createLeftScroll("purNumDataDiv","purNumDataBox","purNumDataUl",100);//左侧滚动条
		    	}else{
		    		content += "<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无记录</span></div>";
		    		$("#purNumDataBox").html(content);
		    	}
		    	
		    }
		});
	}else{
		//alert("请先选择供应商");
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择供应商");
	}
}
//根据采购单号获取未完成的采购单详情
function showPurOrder(purId){
	var content = "";
	var count = 1;
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{purId:purId},
	    url:"purchase.do?action=getUnFinishDetailInfo",
	    success:function (json){
	    	if(json["result"].length > 0){
	    		content += "<input type=hidden id=selPurId value='"+purId+"'/>";
	    		for(var i = 0 ; i < json["result"].length ;i++){
	    			content += "<tr id='pos_tr_"+json["result"][i].posi.id+"' class='cPosIdClass' alt='"+json["result"][i].posi.id+"'>";
	    			content += "<td class='purNumTdWid1' align='center'>"+count+"</td>";
	    			content += "<td class='purNumTdWid2 cProductIdClass' align='center' alt='"+json["result"][i].posi.productInfo.id+"'>"+json["result"][i].posi.productInfo.proName+"</td>";
	    			content += "<td class='purNumTdWid6' align='center'>"+json["result"][i].posi.productInfo.proCz+"</td>";
	    			content += "<td class='purNumTdWid3' align='center'>"+json["result"][i].posi.productInfo.proSpec+"</td>";
	    			content += "<td class='purNumTdWid4' align='center'>"+json["result"][i].posi.proPrice+"</td>";//采购单价
	    			content += "<td id='purNumber_"+json["result"][i].posi.id+"' class='purNumTdWid4' align='center'>"+json["result"][i].posi.proNumber+"</td>";//采购数量
	    			content += "<td id='actNumber_"+json["result"][i].posi.id+"' class='purNumTdWid4' align='center'>"+json["result"][i].posi.proRealNum+"</td>";//实际入库数量
	    			content += "<td id='inNumber_"+json["result"][i].posi.id+"' class='purNumTdWid4 cNewInNum' align='center' ondblclick=editElement(this,'"+json["result"][i].posi.id+"',3,'purInStore')>0</td>";//新入库数据
	    			if(json["result"][i].wsi == undefined){//不存在入库记录
	    				content += "<td class='purNumTdWid5 txtIndTd'><p id='pos_"+json["result"][i].posi.id+"' class='cWhouseIdClass' alt='0'><p>";
	    			}else{
	    				content += "<td class='purNumTdWid5 txtIndTd'><p id='pos_"+json["result"][i].posi.id+"' class='cWhouseIdClass' title='最后一次入库货架记录' alt='"+json["result"][i].wsi.id+"'>"+json["result"][i].wsi.whsName+"<p>";
	    			}
	    			content += "<i class='iconfont icon-more moreIcon posMore3' title='选择货架' onclick=showCorrUnProInfDiv(3,'pos_"+json["result"][i].posi.id+"')></i></td>";
	    			content += "<td class='purNumTdWid1 noBorR' align='center'><i class='iconfont icon-delete deleteIcon' title='删除' onclick=delPurOrder(this);></i></td>";
	    			content += "</tr>";
	    			count++;
	    		}
	    		$("#detailConTab").html(content);
	    		createLeftScroll("rDetailCon","detailConBox","detailConTab",101);//右侧滚动条
	    	}
	    }
	});
}
//清除指定的采购订单行
function delPurOrder(obj){
	if(confirm("是否清除该未完成的采购订单?")){
		$(obj).parent().parent().remove();
		$("#detailConTab tr").each(function(){
			$("#detailConTab tr").removeClass("oddBgColor");
			$("#detailConTab tr:odd").addClass("oddBgColor");
		});
	}
}
</script>
</head>
<body>
	<!-- 头部  -->
	<div class="headWrap">
		<img class="logo fl" src="Module/basicInfo/images/logo.png" alt="镜片车间ERP管理系统"/>
		<div class="perInfoBox fr">
			<div class="perInfo clearfix fl">
				<img class="fl" src="Module/basicInfo/images/user.png"/>
				<p class="timeHello fl"></p>
				<p class="fl">${sessionScope.login_real_name}<span>(${sessionScope.login_user_dep_name})</span></p>
			</div>
			<a class="exit fr" href="javascript:void(0)" title="退出系统" onclick="loginOut();">
				<i class="iconfont icon-tuichu exitIcon"></i>
			</a>
		</div>
	</div>
	<!-- 主体  -->
	<div class="mainWrap clearfix">
		<!-- 左侧导航  -->
		<div class="leftPart">
			<ul>
				<li>
					<span class="navIcon one"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="添加基本信息"/>
				</li>
				<li>
					<span class="navIcon two"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="采购"/>
				</li>
				<li class="active">
					<span class="navIcon three"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="库房入库"/>
				</li>
				<li>
					<span class="navIcon four"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="库房出库"/>
				</li>
				<li>
					<span class="navIcon five"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="材料损耗跟踪"/>
				</li>
			</ul>
		</div>
		<!-- 右侧对应内容  -->
		<div class="rightPart noSmaNav">
			<!-- 头部搜索框 -->
			<div class="searWrap">
				<div class="searBox comMainWid">
					<p id="headFunArea">
						<a id="addNewPurBtn" class="active" href="javascript:void(0)" onclick="selPurchaseTab(1)">新增入库单</a>
						<span>|</span>
						<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览入库单</a>
						<span id="excelS"></span>
					</p>
				</div>
			</div>
			<!-- 新增采购单  -->
			<div class="mainCon comMainWid newAddPurDiv clearfix">
				<!-- 供应商选择、采购编号填写层  -->
				<div class="selBusDiv clearfix">
					<div class="comSelDiv1 fl">
						<input id="insStatusIn" type="hidden" value="0"/>
						<!--  span class="fl">录入状态：</span-->
						<label class="active" for="beginWhInp">
							<input type="radio" id="beginWhInp" class="inStoreInp" name="insStatus" value="0"/>
							<em>期初库存</em>
							<span class="cirSpan"></span>
							<i class="iconfont icon-duihao"></i>
						</label>
						<label for="madInsInp">
							<input type="radio" id="madInsInp" class="inStoreInp" name="insStatus" value="2"/>
							<em>加工半成品入库</em>
							<span class="cirSpan"></span>
						</label>
						<label for="madFullInsInp">
							<input type="radio" id="madFullInsInp" class="inStoreInp" name="insStatus" value="3"/>
							<em>加工成品入库</em>
							<span class="cirSpan"></span>
						</label>
						<label for="littAcc">
							<input type="radio" id="littAcc" class="inStoreInp" name="insStatus" value="4"/>
							<em>网购入库</em>
							<span class="cirSpan"></span>
						</label>
						<label for="purInsInp">
							<input type="radio" id="purInsInp" class="inStoreInp" name="insStatus" value="1"/>
							<em>采购入库</em>
							<span class="cirSpan"></span>
						</label>
						<!-- input提示信息--> 
						<div id="inStStaDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucInStSta" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv margSelT fl">
						<span>供应商：</span>
						<input id="purVal" type="text" disabled="disabled" alt="0"/>
						<i class="iconfont icon-corrUnit comInsIcon pos1" onclick="showCorrUnProInfDiv(1,0)" title="选择供应商"></i>
						<!-- input提示信息 -->
						<div id="corrUnTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucCorUnit" class="iconfont icon-duihao sucInfoIcon2"></i>
					</div>
					<div class="comSelDiv margSelT margSelL fl">
						<span>入库单编号：</span>
						<span id="insOrderInfo">
							<select id="preSuffix">
								<option value="A">A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
								<option value="E">E</option>
								<option value="F">F</option>
								<option value="G">G</option>
								<option value="H">H</option>
								<option value="I">I</option>
								<option value="J">J</option>
								<option value="K">K</option>
								<option value="L">L</option>
							</select>
							<input type="text" id="insOrder_add" class="insInp" maxlength="6"/>
						</span>
						<!-- input提示信息 -->
						<div id="insNumTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucInsNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv margSelL margSelT comHidDiv fl">
						<span>产品名称：</span>
						<input id="proId_add" type="text" disabled="disabled" alt="0"/>
						<i class="iconfont icon-product comInsIcon pos2" onclick="showCorrUnProInfDiv(2,0)" title="选择产品"></i>
						<!-- input提示信息 -->
						<div id="proNamTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucProNam" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv comHidDiv fl">
						<span>产品编号：</span>
						<input id="proNo_add"  type="text" disabled="disabled"/>
						<i id="sucProNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv comHidDiv margSelL fl">
						<span>基本单位：</span>
						<input id="proUnit_add1" type="text" disabled="disabled"/>
						<i id="sucBasUnit" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv comHidDiv margSelL fl">
						<span>产品规格：</span>
						<input id="proSpec_add" type="text" disabled="disabled"/>
						<i id="sucProFormat" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv comHidDiv fl">
						<span>入库数量：</span>
						<input type="text" id="inNumber_add"/>
						<!-- input提示信息 -->
						<div id="inStNumDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucInStNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv margSelL comHidDiv fl">
						<span>入库货架：</span>
						<input id="wtId_add" type="text" alt="0" disabled="disabled"/>
						<i class="iconfont icon-whose comInsIcon pos3" onclick="showCorrUnProInfDiv(3,0)" title="选择货架"></i>
						<!-- input提示信息 -->
						<div id="inStWhDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucInStWh" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<!-- 录入状态为采购入库下的数据层  -->
					<div id="purchDataDiv">
						<div class="dataPart">
							<!-- 头部搜索部分  -->
							<div class="searPart">
								<div class="searchDiv">
									<input type="text" id="quePurNumInp" value="请输入采购单编号" class="searInp fl"/>
									<a href="javascript:void(0)" class="searA fl" title="查询" onclick="showUnFiPurOrder();">
										<i class="iconfont icon-search searIcon"></i>
									</a>
								</div>
							</div>
							<!-- 数据层  -->
							<div class="detailData clearfix">
								<div class="lPurNum purNumDataDiv fl">
									<p class="categTit">
										<i class="iconfont icon-categ categIcon"></i>
										<span>采购单编号</span>
									</p>
									<div id="purNumDataBox" class="categDataDiv1"></div>
								</div>
								<div class="rDetailCon fl">
									<table class="dataTitTab" cellpadding="0" cellspacing="0">
										<tr>
											<td class="purNumTdWid1" align="center">序号</td>
											<td class="purNumTdWid2" align="center">产品名称</td>
											<td class="purNumTdWid6" align="center">材质要求</td>
											<td class="purNumTdWid3" align="center">产品规格</td>
											<td class="purNumTdWid4" align="center">单价(元)</td>
											<td class="purNumTdWid4" align="center">采购数量</td>
											<td class="purNumTdWid4" align="center">已入库数量</td>
											<td class="purNumTdWid4" align="center">入库数量</td>
											<td class="purNumTdWid5" align="center">入库货架</td>
											<td class="purNumTdWid1 noBorR" align="center">操作</td>
										</tr>
									</table>
									<div id="detailConBox">
										<table id="detailConTab" class="dataListTab" cellpadding="0" cellspacing="0"></table>
									</div>
								</div>
							</div>
						</div>
						<div class="botPart clearfix">
							<p class="fl margRp">入库人员：<span id="insPeoSpan"></span></p>
							<p class="fl margRp">入库日期：<span id="insTimeSpan"></span></p>
							<p class="fl">入库备注：<input id="inRemark_add1" type="text" maxlength="20" placeholder="备注不能超过20个字"/></p>
						</div>
					</div>
					<div class="comSelDiv comHidDiv margSelL fl">
						<span>入库人员：</span>
						<input type="text" id="inUserId_add" disabled="disabled"/>
						<i id="sucInStPeo" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv comHidDiv fl">
						<span>入库日期：</span>
						<input type="text" id="inDate_add" disabled="disabled"/>
						<i id="sucInStTim" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					
					<div class="comSelDiv comHidDiv margSelL fl">
						<span>入库备注：</span>
						<input id="inRemark_add" type="text" maxlength="20" placeholder="备注不能超过20个字"/>
						<!-- input提示信息 -->
						<div id="inStRemDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucInStRem" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
				</div>
				<div class="saveDiv saveDivPos">
					<a href="javascript:void(0)" onclick="addInStore();">保存入库信息</a>
				</div>
			</div>
			<!-- 浏览采购单  -->
			<div class="mainCon comMainWid viewPurDiv clearfix">
				<!-- 根据采购订单单号查询、根据新增采购单时间查询  -->
				<div class="queryDiv clearfix">
					<p class="selCondP">
						<label id="addInsTimSearLab" class="active" onclick="changeSearch(1)">
							<span class="cirSpan"></span>
							<span>根据新增入库单时间查询</span>
							<i class="iconfont icon-duihao selSearIcon"></i>
						</label>
						<label id="insNumSearLab" class="marglLab" onclick="changeSearch(2)">
							<span class="cirSpan"></span>
							<i class="iconfont icon-duihao selSearIcon"></i>
							<span>根据入库单号查询</span>
						</label>
						<a href="javascript:void(0)" class="showHideA fr" onclick="showHideQueryBox()">
							<em class="comTransition"></em>
							<span>隐藏</span>
						</a>
					</p>
					<div class="queryPar clearfix">
						<div class="queryBox fl">
							<div class="comQueryDiv timeCon">
								<span>新增入库单时间：</span>
								<input type="text" id="sTime" class="date" placeholder="请选择开始日期"/>&nbsp;&nbsp;
								<input type="text" id="eTime" class="date" placeholder="请选择结束日期"/>
							</div>
							<script src="Module/commonJs/timeControl/js/moment.min.js"></script>
							<script src="Module/commonJs/timeControl/js/moment.zh-cn.js"></script>
							<script src="Module/commonJs/timeControl/js/ion.calendar.min.js"></script>
							<script>
								$('.date').each(function(){
									$(this).ionDatePicker({
										lang: 'zh-cn',
										format: 'YYYY-MM-DD'
									});
								});
							</script>
							<div class="comQueryDiv">
								<input id="insStaInpVal" type="hidden" value="-1"/>
								<span>录入状态：</span>
								<!--label for="fullInsInp">
									<span class="cirSpan"></span>
									<input type="radio" id="madeFuInsInp" class="inStoreQue" name="insStaInp" value="-1"/>
									<span>全部</span>
								</label-->
								<label for="begInsWhInp">
									<span class="cirSpan"></span>
									<input type="radio" id="begInsWhInp" class="inStoreQue" name="insStaInp" value="0"/>
									<span>期初库存</span>
								</label>
								<label for="fullInsInp">
									<span class="cirSpan"></span>
									<input type="radio" id="netInstInp" class="inStoreQue" name="insStaInp" value="4"/>
									<span>网购入库</span>
								</label>
								<label for="purInstInp">
									<span class="cirSpan"></span>
									<input type="radio" id="purInstInp" class="inStoreQue" name="insStaInp" value="1"/>
									<span>采购入库</span>
								</label>
								<label for="madeInsInp">
									<span class="cirSpan"></span>
									<input type="radio" id="madeInsInp" class="inStoreQue" name="insStaInp" value="2"/>
									<span>加工半成品入库</span>
								</label>
								<label for="madeInsInp">
									<span class="cirSpan"></span>
									<input type="radio" id="madeFuInsInp" class="inStoreQue" name="insStaInp" value="3"/>
									<span>加工成品入库</span>
								</label>
							</div>
							<div class="comQueryDiv">
								<!-- 选择产品名称  -->
								<div class="selQueryDiv">
									<span>产品名称：</span>
									<input id="proNaInp" type="text" disabled="disabled" alt="0"/>
									<i id="delOptPro" class="iconfont icon-close clearIcon1" onclick="delOption('pro')" title="清除"></i>
									<i class='iconfont icon-more moreIcon posMore1' title='选择产品' onclick="showCorrUnProInfDiv(2,0)"></i>
								</div>
								<!-- 选择货架编号  -->
								<div class="selQueryDiv margLQu">
									<span>公司名称：</span>
									<input id="compNaInp" class="ellip" type="text" disabled="disabled" alt="0"/>
									<i id="delOptComp" class="iconfont icon-close clearIcon2" onclick="delOption('comp')" title="清除"></i>
									<i class='iconfont icon-more moreIcon posMore2' title='选择公司' onclick="showCorrUnProInfDiv(4,0)"></i>
								</div>
							</div>
							<a class="queryStaBtn" href="javascript:void(0)" onclick="queryOrder(1);">查询</a>
						</div>
						<div class="queryBox fl">
							<p class="searchPurNum fl">
								<input type="text" id="queryInsNum" value="请输入入库单号" class="searInp_purNum fl"/>
								<a href="javascript:void(0)" class="searA fl" title="查询" onclick="queryOrder(2);">
									<i class="iconfont icon-search searIcon"></i>
								</a>
							</p>
						</div>
						<span class="borSpan"></span>
						<!-- 二选一查询条件遮罩层  -->
						<span class="searLayer"></span>
					</div>
				</div>
				<!-- 浏览入库单  -->
				<div class="viewInsInfoDiv" id="inOrderListDiv">
					<ul id="purOrdUl" class="outStOrdUl clearfix"></ul>
				</div>
				<div id="viewTurnPage" class="comTurnPagDiv">
					<div id="Pagination_in" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- 供应商数据层弹窗  -->
	<div class="comAlertDiv purDataDiv">
		<div class="comDataTop">
			<p>选择供应商</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.purDataDiv'),'bc')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput" value="请输入往来单位拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询" onclick="queryBusinessList(0);">
					<i class="iconfont icon-search searIcon"></i>
				</a>
			</div>
		</div>
		<!-- 往来单位类别 单位具体信息数据层  -->
		<div class="comDataDiv clearfix">
			<!-- left 类别数据  -->
			<div class="comLeftData corUnCategDataDiv fl">
				<p class="categTit"><i class="iconfont icon-categ categIcon"></i><span>往来单位类别</span></p>
				<div id="categDataDivPur" class="categDataDiv">
					<ul id="categDataUlPur" class="categDataUl"></ul>
				</div>
			</div>
			<!-- right 详细信息数据  -->
			<div class="comRightData fl">
				<!-- 数据层  -->
				<div class="tabData">
					<table class="dataTitTab" cellpadding="0" cellspacing="0">
						<tr>
							<td class="listDataWid1" align="center">序号</td>
							<td class="listDataWid2" align="center">单位名称</td>
							<td class="listDataWid3" align="center">拼音码</td>
							<td class="listDataWid3" align="center">联系人</td>
							<td class="listDataWid4" align="center">联系电话</td>
							<td class="listDataWid4" align="center">联系手机</td>
							<td class="listDataWid2" align="center">电子邮箱</td>
							<td class="listDataWid5 noBorR" align="center">单位地址</td>
						</tr>
					</table>
					<table id="dataListTab_un" class="dataListTab" cellpadding="0" cellspacing="0">
						<!-- 分页的话一页8条数据  -->
					</table>
				</div>
				<!-- 翻页  -->
				<div id="bsTurnPage" class="comTurnPagDiv">
					<div id="Pagination" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 选择产品数据弹窗  -->
	<div class="comAlertDiv proInfoDiv">
		<div class="comDataTop">
			<p>选择产品</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.proInfoDiv'),'pro')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput_pro" value="请输入产品拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询" onclick="showProductList(0)">
					<i class="iconfont icon-search searIcon"></i>
				</a>
			</div>
			<!-- 增加产品类别层  -->
			<a class="addCategUnitBtn" href="javascript:void(0)" onclick="showComAddWin(3)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加产品类别</span>
			</a>
			<!-- 增加产品基本信息层  -->
			<a class="addCategBtn" href="javascript:void(0)" onclick="showComAddWin(4)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加产品</span>
			</a>
		</div>
		<!-- 产品类别产品具体信息数据层  -->
		<div class="comDataDiv clearfix">
			<!-- left 类别数据  -->
			<div class="comLeftData proCategDataDiv fl">
				<p class="categTit"><i class="iconfont icon-categ categIcon"></i><span>产品类别</span></p>
				<div id="categDataDivPro" class="categDataDiv">
					<ul id="categDataUlPro" class="categDataUl">
						<!-- li下增加active状态为当前选中  -->
					</ul>
				</div>
			</div>
			<!-- right 详细信息数据  -->
			<div class="comRightData fl">
				<!-- 数据层  -->
				<div class="tabData">
					<table class="dataTitTab" cellpadding="0" cellspacing="0">
						<tr>
							<td class="lisDaWid1" align="center">序号</td>
							<td class="lisDaWid2" align="center">产品名称</td>
							<td class="lisDaWid2" align="center">产品编码</td>
							<td class="lisDaWid4" align="center">产品库存</td>
							<td class="lisDaWid2" align="center">产品规格</td>
							<td class="lisDaWid4" align="center">最高价格</td>
							<td class="lisDaWid4 noBorR" align="center">最低价格</td>
						</tr>
					</table>
					<table id="dataListTab_pro" class="dataListTab" cellpadding="0" cellspacing="0">
						<!-- 分页的话一页8条数据  -->
					</table>
				</div>
				
				<div id="proTurnPage" class="comTurnPagDiv">
					<div id="Pagination_pro" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
		<!-- 添加产品类别和产品基本信息遮罩层  -->
		<div class="addNewDataDiv addProData">
			<!-- 添加产品类别  -->
			<div class="addProCategDiv">
				<div class="comCategDiv margT_cate">
					<span>类别名称：</span>
					<input type="text" class="comInp_add" id="proType_add"/>
					<!-- input提示信息  -->
					<div id="categProNaDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="typeTips_add"></p>
					</div>
					<i id="sucProCategNam" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comCategDiv">
					<span>类别备注：</span>
					<input type="text" class="comInp_add" id="typeRemark_add" placeholder="最多不超过20个字" maxlength="20"/>
				</div>
				<a class="saveCategBtn" href="javascript:void(0)" onclick="addCommProType('addProCategDiv','proType_add','typeRemark_add','categProNaDiv','purchase','proType');">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd(3)">取消</a>
			</div>
			<!-- 添加产品基本信息 -->
			<div class="addProInfoDiv">
				<div class="comAddDiv margT">
					<span>产品名称：</span>
					<input type="text" class="comInp_add" id="proName_add"/>
					<!-- input提示信息 -->
					<div id="proNameDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proName_add_tips"></p>
					</div>
					<i id="sucProName" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv margT">
					<span class="fl">产品类别：</span>
					<div class="selCategDiv_pro fl">
						<!-- 将确定的分类增加到p标签里面 -->
						<p id="proTypeId_add" alt="0"></p>
						<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCategBankWin(1)">
							<i class="iconfont icon-fenlei2 classifyIcon"></i>
						</a>
					</div>
					<!-- input提示信息 -->
					<div id="proCategDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proTypeId_add_tips"></p>
					</div>
					<i id="sucProCateg" class="iconfont icon-duihao sucInfoIcon1"></i>
				</div>
				<div class="comAddDiv margT">
					<span>产品编码：</span>
					<input type="text" class="comInp_add" id="proCode_add"/>
					<!-- input提示信息 -->
					<div id="proCodeDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proCode_add_tips"></p>
					</div>
					<i id="sucProCode" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>产品规格：</span>
					<input type="text" class="comInp_add" id="proFormatInfo_add"/>
					<!-- input提示信息 -->
					<div id="proFormatDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proFormatInfo_add_tips"></p>
					</div>
					<i id="sucProFormat" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>基本单位：</span>
					<input type="text" class="comInp_add" id="proUnit_add"/>
					<!-- input提示信息 -->
					<div id="basicUnit" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proUnit_add_tips"></p>
					</div>
					<i id="sucBasicUn" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>材质要求：</span>
					<input type="text" class="comInp_add" id="proMater_add"/>
					<!-- input提示信息 -->
					<div id="materReqDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="proMater_add_tips"></p>
					</div>
					<i id="sucMatReq" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<input id="categStyInp" type="hidden" value=""/>
					<span class="fl">类别类型：</span>
					<label for="categSty_buy" class="categStyLab">
						<input type="radio" id="categSty_buy" name="categStyRad" value="b" class="comCategStyInp"/>
						<em>购进</em>
						<span class="cirSpan"></span>
					</label>
					<label for="categSty_made" class="categStyLab">
						<input type="radio" id="categSty_made" name="categStyRad" value="m" class="comCategStyInp"/>
						<em>制造</em>
						<span class="cirSpan"></span>
					</label>
					<!-- input提示信息 -->
					<div id="proCategStyDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="categStyInp_tips"></p>
					</div>
				</div>
				<div class="comAddDiv">
					<span class="fl">加工工艺：</span>
					<div class="selProTechDiv fl">
						<!-- 将确定的分类增加到p标签里面 -->
						<input type="hidden" id="madDepInp" />
						<p id="madeDepP"></p>
						<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCategBankWin(2)">
							<i class="iconfont icon-fenlei2 classifyIcon"></i>
						</a>
					</div>
					<!-- input提示信息 -->
					<div id="proTechTipDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p></p>
					</div>
					<i id="sucProTech" class="iconfont icon-duihao sucInfoIcon1"></i>
				</div>
				<div class="comAddDiv">
					<span>产品备注：</span>
					<input type="text" class="comInp_add" id="proRemark_add" placeholder="不能超过30字" maxlength="30"/>
				</div>
				<a class="saveCorInfoBtn" href="javascript:void(0)" onclick="addPro();">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd(4)">取消</a>
				<!-- 选择产品类别层  -->
				<div class="selProCategLay">
					<p>当前类别&gt;&gt;<span id="nowCateg_pro"></span></p>
					<div id="selCategWrap_pro">
						<ul id="selCategUl_pro" class="clearfix"></ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selCagetBankName(2,$('#nowCateg_pro'),'暂未选择产品类别')">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(2)">取消</a>
				</div>
				<!-- 选择加工工艺层  -->
				<div class="selProTechLay">
					<p>当前加工工艺&gt;&gt;<span id="nowCateg_made"></span></p>
					<div id="selProTechData">
						<ul id="selCategUl_made" class="clearfix"></ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selCagetBankName(3,$('#nowCateg_made'),'暂未选择加工工艺')">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(3)">取消</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 选择仓库数据弹窗  -->
	<div class="comAlertDiv instWhDataDiv">
		<div class="comDataTop">
			<p>选择货架编号</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.instWhDataDiv'),'wh')"></i>
		</div>
		<div class="searLay">
			<!-- 根据货架编号搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput_insWh" value="请输入货架编号" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询" onclick="showPageWSList_curr(null,0)">
					<i class="iconfont icon-search searIcon"></i>
				</a>
			</div>
			<!-- 增加仓库类别层  -->
			<a class="addCategUnitBtn" href="javascript:void(0)" onclick="showComAddWin(1)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加仓库类别</span>
			</a>
			<!-- 增加仓库货架基本信息层  -->
			<a class="addCategBtn" href="javascript:void(0)" onclick="showComAddWin(2)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加货架</span>
			</a>
		</div>
		<!-- 选择货架类别货架编号具体信息数据层  -->
		<div class="comDataDiv clearfix">
			<!-- left 类别数据  -->
			<div class="comLeftData whCategDataDiv fl">
				<p class="categTit"><i class="iconfont icon-categ categIcon"></i><span>仓库类别</span></p>
				<div id="categDataDivWh" class="categDataDiv">
					<ul id="categDataUlWh" class="categDataUl">
						<!-- li下增加active状态为当前选中  -->
					</ul>
				</div>
			</div>
			<!-- right 详细信息数据  -->
			<div class="comRightData fl">
				<!-- 数据层  -->
				<div id="whListDiv" class="tabData">
					<input type="hidden" id="selPurPosition" value="0"/><!-- 采购入库时对应选择那条采购详单点击的入库货架变量 -->
					<ul id="whListUl" class="selWhDataUl clearfix">
					</ul>
				</div>
				<input type="hidden" id="selWhId" value="0" alt=""/>
				<div id="whTurnPage" class="comTurnPagDiv">
					<div id="Pagination_wh" class="pagination clearfix"></div>
				</div>
				<div class="botDiv">
					<!-- 选中保存按钮  -->
					<a class="saveDataBtn fr" href="javascript:void(0)" onclick="selWhInfo();">确定</a>
				</div>
			</div>
		</div>
		<!-- 添加仓库类别和仓库货架编号遮罩层  -->
		<div class="addNewDataDiv addWhCateg">
			<!-- 添加仓库类别  -->
			<div class="addWhCategDiv">
				<div class="comCategDiv margT_cate">
					<span>类别名称：</span>
					<input type="text" class="comInp_add" id="whTypeName_add"/>
					<!-- input提示信息  -->
					<div id="categWhNaDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p></p>
					</div>
					<i id="sucWhCategNam" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comCategDiv">
					<span>类别备注：</span>
					<input type="text" class="comInp_add" id="wtRemark_add" maxlength="20" placeholder="最多不超过20个字"/>
				</div>
				<a class="saveCategBtn1" href="javascript:void(0)" onclick="addCommWType('addWhCategDiv','whTypeName_add','wtRemark_add','categWhNaDiv','inStore','wt')">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd(6)">取消</a>
			</div>
			<!-- 添加货架基本信息 -->
			<div class="addWhInfoDiv">
				<div class="comAddDiv1 margT1">
					<span>货架名称：</span>
					<input type="text" class="comInp_add" id="whsName_add" alt="0"/>
					<!-- input提示信息 -->
					<div id="whNameDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p>货架名称不能为空</p>
					</div>
					<i id="sucWhName" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv1">
					<span class="fl">仓库类别：</span>
					<div class="selCategDiv_wh fl">
						<!-- 将确定的分类增加到p标签里面 -->
						<p id="selCateg" alt="0"></p>
						<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCategBankWin(4)">
							<i class="iconfont icon-fenlei2 classifyIcon"></i>
						</a>
					</div>
					<!-- input提示信息 -->
					<div id="whCategDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p>仓库类别不能为空</p>
					</div>
					<i id="sucWhCateg" class="iconfont icon-duihao sucInfoIcon1"></i>
				</div>
				<div class="comAddDiv1">
					<span>货架备注：</span>
					<input type="text" class="comInp_add" id="whsRemark_add" maxlength="20" placeholder="最多不超过20个字"/>
				</div>
				<a class="saveWhInfoBtn" href="javascript:void(0)" onclick="addOrEditCommWH('whsName_add','selCateg','whsRemark_add','whNameDiv','whCategDiv','inStore','addNewDataDiv');">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd('5')">取消</a>
				<!-- 选择仓库货架层  -->
				<div class="selWhCategLay">
					<p class="nowCategP">当前类别&gt;&gt;<span id="nowCateg_wh" alt="0"></span></p>
					<div id="selCategWrap_wh">
						<ul id="selCategUl_wh" class="clearfix"></ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selectCateg()">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(1)">取消</a>
				</div>
			</div>
		</div>
	</div>
	<div class="alertWin">
		<i class="iconfont fl"></i>
		<em class="fl"></em>
	</div>
</body>
</html>