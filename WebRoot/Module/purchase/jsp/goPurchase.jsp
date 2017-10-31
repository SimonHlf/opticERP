<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>新增采购信息</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link href="Module/css/pagination.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="Module/purchase/css/purchaseCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/timeControl/css/ion.calendar.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/purchase/js/goPurchaseJs.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script type="text/javascript">
var roleName = "${sessionScope.login_user_dep_name}";
var creScroll = true;
var creScrll_pur = true;
var dbFlag = true;
var parHeight = 0;
var pageSize = 8;
var page_index = 0;
var bTypeId_a = 0;
var pyCode_a = "";
var page_index_p = 0;//选择产品
var pTypeId_a = 0;//产品类别编号
var pyCode_p_a = "";//产品拼音码
//---------------------浏览采购订单页面用---------------------------//
var sTime_a = "";
var eTime_a = "";
var inStatus_a = -1;//全部
var payStatus_a = -2;//全部
var purOrder_a = 0;
var option_a = 0;
var page_index_pur = 0;//采购单
var bcId_a = 0;//单位名称
var option_tr = "purchase";//区别供应商的doubleTrClick()
$(function(){
	judgeTime_1();
	if(roleName == "采购" ){
		bankNumPattern("bankAcc","pattbBankNum");
		choiceOption("payStatusRad","active","label","payStatusInp","iconFont");//付款状态
		choiceOption("inVoiceRad","active","label","invoInp_hid","iconFont");//有无发票
		getSysTime($("#madeTimeP"));
	}else{
		var contentInfo = '<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览采购单</a>';
		if(roleName == "财务" || roleName == "董事长"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_pur()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
		}
		$("#headFunArea").html(contentInfo);
		selPurchaseTab(2);
	}
});

//查看付款记录
function showPayHistory(poId){
	$("#payHisLayerDiv_"+poId).show().height($("#payRecordDiv_"+poId).height() - 41);
	$("#payHisListDiv_"+poId).height($("#payHisLayerDiv_"+poId).height() - 105);
	if($("#payHisListUl_"+poId).height() > $("#payHisListDiv_"+poId).height()){
		var scroll = "<div id='scrollPar_"+poId+"' class='parScrollHis'><div id='scrollSon_"+poId+"' class='sonScrollHis'></div></div>";
		$("#payHisListDiv_"+poId).append(scroll);
		$("#scrollPar_"+poId).height($("#payHisListDiv_"+poId).height());
		scrollBar("payHisListDiv_"+poId,"payHisListUl_"+poId,"scrollPar_"+poId,"scrollSon_"+poId,15);
	}
	$("#payHisListDiv_"+poId +" li:odd").addClass("oddColor");
	
};
//新增采购单下选取供应商数据 、选取供应商下商品的数据层弹窗
function showCorrUnProInfDiv(options){
	if(options == 1){//选取供应商
		if($("#payStatusInp").val() != 1){//采购付时不能点击供应商
			getCommonType("bType");
			$(".purDataDiv").show();
			inpTipFocBlur("searInput","请输入往来单位拼音码","#999","#666");
			createLeftScroll("corUnCategDataDiv","categDataDivPur","categDataUlPur",options);
			$(".layer").show();
		}
	}else if(options == 2){//选取商品
		getCommonType("pType");
		$(".proInfoDiv").show();
		createLeftScroll("proCategDataDiv","categDataDivPro","categDataUlPro",options);
		inpTipFocBlur("searInput_pro","请输入产品拼音码","#999","#666");
		$(".layer").show();
	}
}
//关闭选取供应商 选取产品弹窗的公共关闭
function closeAlertWin(obj,option){
	$(obj).hide();
	$(".layer").hide();
	if($(".parScroll").length > 0){
		$(".parScroll").remove();
		$(".categDataUl").css({"top":0});
	}
	if(option == "selBus"){
		$("#dataListTab_un").html("");
		$("#searInput").val("请输入往来单位拼音码");
		$("#bsTurnPage").hide();
	}else if(option == "selPro"){
		$("#dataListTab_pro").html("");
		$("#searInput_pro").val("请输入产品拼音码");
		$("#selAllPro").attr("checked",false);
		$(".selAllLab").find("i").remove();
		$(".selAllTxt").html("全选");
		$("#Pagination_pro").hide();
	}
	
}
//添加单位类别、单位基本信息、产品类别、产品基本信息窗口
function showComAddWin(options){
	$(".closeIcon").hide();
	$(".addNewDataDiv").show().animate({"top":50},function(){
		if(options == 1){//添加单位类别
			$(".addCorrUnDiv").show();
		}else if(options == 2){//添加单位基本信息
			$(".addCorrUnInfo").show();
		}else if(options == 3){//添加产品类别
			$(".addProCategDiv").show();
		}else if(options == 4){//添加产品基本信息
			$(".addProInfoDiv").show();
			choiceOption("comCategStyInp","active","label","categStyInp","iconFont");//有无发票
		}
	});
}
//取消添加单位类别、单位基本信息、产品类别、产品基本信息窗口
function comCancelAdd(options){
	$(".addNewDataDiv").animate({"top":-400},function(){
		if(options == 1){//关闭添加单位类别
			$(".addCorrUnDiv").hide();
			clearAddBtInfo();
		}else if(options == 2){//关闭添加单位基本信息
			$(".addCorrUnInfo").hide();
			clearAddBcInfo();
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
		$(".addNewDataDiv").hide();
		$(".closeIcon").show();
	});
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
function selCategBankWin(options){
	//1:查看产品类别   2:查看单位类别  3:选择银行 4:查看加工工艺
	if(options == 1){
		$(".selProCategLay").show().animate({"opacity":1});
		if($(".selCategDiv_pro p").html() == ""){//暂未选择银行
			$("#nowCateg_pro").html("暂未选择产品类别");
		}else{
			$("#nowCateg_pro").html($(".selCategDiv_pro p").html());
			matchingHtml($("#selCategWrap_pro li"),$("#nowCateg_pro"));
		}
		getProType();
		addLiActive($("#selCategWrap_pro li"),$("#nowCateg_pro"));
		crePorCategScroll();
	}else if(options == 2){
		$(".selCategLay").show().show().animate({"opacity":1});;
		if($(".selCategDiv_un p").html() == ""){//暂未选择单位类别
			$("#nowCateg_unit").html("暂未选择单位类别");
		}else{
			$("#nowCateg_unit").html($(".selCategDiv_un p").html());
			matchingHtml($("#selCategWrap_un li"),$("#nowCateg_unit"));
		}
		getCommonType("selBtype");
		addLiActive($("#selCategWrap_un li"),$("#nowCateg_unit"));
	}else if(options == 3){
		$(".selBankLay").show().show().animate({"opacity":1});;
		if($(".selBankDiv p").html() == ""){//暂未选择银行
			$("#nowBank").html("尚未选择开户银行");
		}else{
			$("#nowBank").html($(".selBankDiv p").html());
			$(".com_BankRdio").each(function(i){
				if($("#nowBank").html() != "" && $(".com_BankRdio").eq(i).val() == $("#nowBank").html()){
					$(".com_BankRdio").parent().removeClass("active");
					$(this).parent().addClass("active");
					$(this).parent().append("<b></b>");
				}
			});
		}
		choiceOption("com_BankRdio","active","li","nowBank","imgBg");
	}else if(options == 4){
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
function comCanCategBankWin(options){
	//1:关闭选择产品类别   2:关闭选择单位类别  3:关闭选择银行  4:关闭加工工艺数据层
	if(options == 1){
		$(".selProCategLay").animate({"opacity":0},function(){$(".selProCategLay").hide();});
		$("#selCategWrap_pro li").removeClass("active");
	}else if(options == 2){
		$(".selCategLay").animate({"opacity":0},function(){$(".selCategLay").hide();});
		$("#selCategWrap_un li").removeClass("active");
	}else if(options == 3){
		$(".selBankLay").animate({"opacity":0},function(){$(".selBankLay").hide();});
		if($(".bankMidWinDiv li > b").length > 0){
			$(".bankMidWinDiv li").removeClass("active");
			$(".bankMidWinDiv li").find("b").remove();
		}
	}else if(options == 4){
		$(".selProTechLay").animate({"opacity":0},function(){$(".selProTechLay").hide();});
		$("#selCategUl_made li").removeClass("active");
	}
}
//浏览采购单下头部的查询
function changeSearch(options){
	$(".selCondP label").removeClass("active");
	if(options == 1){//根据新增采购单时间查询
		$("#addPurTimSearLab").addClass("active");
		$(".searLayer").animate({"left":599});
		clearOption2();
	}else if(options == 2){//根据采购单号查询
		$("#purNumSearLab").addClass("active");
		$(".searLayer").animate({"left":0});
		inpTipFocBlur("queryPurNum","请输入采购单号","#999","#666");
		clearOption1();
	}
}
function delOption(){
	$("#unNaInp").val("").attr("alt","0");
	$("#delOptComp").hide();
}
//保存选择后的业务单位类别,开户银行
function selCagetBankName(options,objNow,strCon){
	//options 1:选择单位类别  2：选择产品类别   3：选择开户银行 4:选择加工工艺
	var objNowHtml = objNow.html();
	if(objNowHtml != "" && objNowHtml != strCon){
		if(options == 1){
			$(".selCategDiv_un p").html($("#nowCateg_unit").html());
			$(".selCategLay").animate({"opacity":0},function(){$(".selCategLay").hide();});
			$("#bcTypeId_add").attr("alt",$("#nowCateg_unit").attr("alt"));
			
		}else if(options == 2){
			$(".selCategDiv_pro p").html($("#nowCateg_pro").html()).attr("alt",$("#nowCateg_pro").attr("alt"));
			$(".selProCategLay").animate({"opacity":0},function(){$(".selProCategLay").hide();});
		}else if(options == 3){
			$(".selBankDiv p").html($("#nowBank").html());
			$(".selBankLay").animate({"opacity":0},function(){$(".selBankLay").hide();});
		}else if(options == 4){
			$("#madeDepP").text($("#nowCateg_made").text());
			$(".selProTechLay").animate({"opacity":0},function(){$(".selProTechLay").hide();});
		}
	}else{
		if(options == 1){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择单位类别");
		}else if(options == 2){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择产品类别");
		}else if(options == 3){
			commonTipInfoFn($("body"),$(".alertWin"),false,"尚未选择开户银行");
		}else if(options == 4){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择加工工艺");
		}
	}
}
//新增采购单记录
function addNewPurRec(options){
	var bcId = $("#purVal").attr("alt");
	if(bcId == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择供应商");
	}else{
		var flag = false;
		if(options == 0){//表示首次进来页面暂无采购记录列表
			flag = true;
		}else{
			if($("#proName").html() == ""){
				flag = false;
			}else{
				flag = true;
			}
		}
		if(flag){
			var strTrTd = "<tr id=nullTr>";
			var oldColor = "";
			var num = $("#purListTable tr").length + 1;
			strTrTd += "<td class='purListWid1' align='center'>"+ num +"</td>";//序号
			strTrTd += "<td class='purListWid5' align='center'></td>";//产品编号
			strTrTd += "<td class='purListWid2' align='center'><p id='proName'></p><i class='iconfont icon-more moreIcon posMore' onclick=showCorrUnProInfDiv(2) title='选择产品'></i></td>";
			strTrTd += "<td class='purListWid3' align='center'></td>";//规格
			strTrTd += "<td class='purListWid7' align='center'></td>";//材质
			strTrTd += "<td class='purListWid4' align='center'>0.00</td>";//单价
			strTrTd += "<td class='purListWid4' align='center'></td>";//采购数量
			strTrTd += "<td class='purListWid6' align='center'></td>";//基本单位
			strTrTd += "<td class='purListWid4 cAllPrice' align='center'>0.00</td>";//总价
			strTrTd += "<td class='purListWid1' align='center'><i class='iconfont icon-delete deleteIcon' title='删除' onclick=clearCurrPro(this);></i></td>";//删除
			strTrTd += "</tr>";
			num++;
			$("#purListTable").append(strTrTd);
			$("#purListTable tr:odd").addClass("oddBgColor");//增加隔行换色
			checkPurListLen();
		}else{
			
		}
	}
}
//检测新增采购单有无记录
function checkPurListLen(){
	if($(".purListTab tr").length != 0){
		$(".noRecDiv").hide();
		$(".addTrDiv").show();
	}
}
//自动生成采购订单编号
function autoCreatePurOrder(){
	var purOrderNum = "";
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    url:"purchase.do?action=getPoNum",
	    success:function (json){
	    	purOrderNum = json["result"];
	    }
	});
	return purOrderNum;
}
//添加单位类别
function addBsType(){
	var typeName = $("#typeName_add").val().replace(/\s+/g, "");
	var remark = $("#typeRemark_add").val().replace(/\s+/g, "");
	if(typeName == ""){
		$("#categNameDiv").show();
		$("#cateNameInfo").html("类别名称不能为空");
	}else if(typeName.length >= 8){
		$("#categNameDiv").show();
		$("#cateNameInfo").html("类别名称长度不能超过8位");
	}else{
		if(checkExistBsType("typeName_add")){
			$("#categNameDiv").show();
			$("#cateNameInfo").html("该类别已存在");
		}else{
			$("#categNameDiv").hide();
			$("#cateNameInfo").html("");
			$.ajax({
				type:"post",
			    async:false,
			    dataType:"json",
			    data:{btName:escape(typeName),btRemark:escape(remark)},
			    url:"bizcontact.do?action=addBizType",
			    success:function (json){
			    	if(json==true){
		        		commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
		        			comCancelAdd(1);
							//刷新往来单位类别列表
							getCommonType("bType");
		        		});
					}else{
			    		commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
					}
			    }
			});
		}
	}
}
//选择往来单位动作
function selectBsTypeInfo(btId){
	$("#nowCateg_unit").attr("alt",btId);
}
//增加往来单位
function addBizContact(){
	var bcName = $("#bcName_add").val().replace(/\s+/g, ""); 
	var bcTypeID = $("#bcTypeId_add").attr("alt").replace(/\s+/g, ""); 
	var bcPy = $("#bcPyCode_add").val().replace(/\s+/g, ""); 
	var bcAddress = $("#bcAddress_add").val().replace(/\s+/g, ""); 
	var bcContact =$("#bContact_add").val().replace(/\s+/g, ""); 
	var bcTel = $("#bcTel_add").val().replace(/\s+/g, ""); 
	var bcMobile = $("#bcMobile_add").val().replace(/\s+/g, ""); 
	var bcFax =$("#bcFax_add").val().replace(/\s+/g, ""); 
	var bcEmail = $("#bcEmail_add").val().replace(/\s+/g, ""); 
	var bcBankName = $("#bcBankName_add").text().replace(/\s+/g, ""); 
	var bcBankNo = $("#bankAcc").val().replace(/\s+/g, ""); 
	var bcNameFlag = false;
	var bcTypeFlag = false;
	var bcContactFlag = false;
	var bcTelFlag = false;
	var bcMobileFlag = false;
	var bcFaxFlag = false;
	var bcBankFlag = false;
	var bcEmailFlag = false;
	if(bcName == ""){
		$("#compNameDiv").show();
		$("#bcNameInfo").html("单位名称不能为空");
	}else{
		if(checkExistBc("bcName_add")){
			$("#compNameDiv").show();
			$("#bcNameInfo").html("已存在该单位");
			bcNameFlag = false;
		}else{
			$("#compNameDiv").hide();
			bcNameFlag = true;
		}
	}
	if(bcTypeID == "0"){
		$("#compCategDiv").show();
		$("#bcTypeIdInfo").html("单位类别不能为空");
	}else{
		$("#compCategDiv").hide();
		bcTypeFlag = true;
	}
	if(bcContact == ""){
		$("#compContDiv").show();
		$("#bContactInfo").html("单位联系人不能为空");
	}else if(checkInputStr(bcContact,"xm")){
		$("#compContDiv").show();
		$("#bContactInfo").html("单位联系人必须为2-8位中文");
	}else{
		$("#compContDiv").hide();
		bcContactFlag = true;
	}
	if(bcTel != ""){
		if(checkInputStr(bcTel,"tel")){
			$("#compTelDiv").show();
			$("#bcTelInfo").html("单位联系电话格式错误");
		}else{
			$("#compTelDiv").hide();
			bcTelFlag = true;
		}
	}else{
		$("#compTelDiv").hide();
		bcTelFlag = true;
	}
	if(bcMobile != ""){
		if(checkInputStr(bcMobile,"mobile")){
			$("#compPhoneDiv").show();
			$("#bcMobileInfo").html("单位联系手机格式错误");
		}else{
			$("#compPhoneDiv").hide();
			bcMobileFlag = true;
		}
	}else{
		$("#compPhoneDiv").hide();
		bcMobileFlag = true;
	}
	if(bcFax != ""){
		if(checkInputStr(bcFax,"tel")){
			$("#compFaxDiv").show();
			$("#bcFaxInfo").html("单位传真格式错误");
		}else{
			$("#compFaxDiv").hide();
			bcFaxFlag = true;
		}
	}else{
		$("#compFaxDiv").hide();
		bcFaxFlag = true;
	}
	if(bcBankName != "" && bcBankNo == ""){
		$("#compBankNaDiv").hide();
		$("#compBankNum").show();
		$("#bcBankNumInfo").html("银行卡号不能为空");
	}else if(bcBankName == "" && bcBankNo != ""){
		$("#compBankNum").hide();
		$("#compBankNaDiv").show();
		$("#bcBankNameInfo").html("开户银行不能为空");
	}else{
		$("#compBankNum").hide();
		$("#compBankNaDiv").hide();
		bcBankFlag = true;
	}
	if(bcEmail != ""){
		if(checkInputStr(bcEmail,"email")){
			$("#compEmailDiv").show();
			$("#bcEmailInfo").html("单位电子邮箱格式错误");
		}else{
			$("#compEmailDiv").hide();
			bcEmailFlag = true;
		}
	}else{
		$("#compEmailDiv").hide();
		bcEmailFlag = true;
	}
	if(bcNameFlag && bcTypeFlag && bcContactFlag && bcTelFlag && bcMobileFlag && bcFaxFlag && bcBankFlag && bcEmailFlag){
		$.ajax({
			type:"post",
		    async:false,
		    dataType:"json",
		    data:{bcName:escape(bcName),bcPy:bcPy,bcTypeID:bcTypeID,bcAddress:escape(bcAddress),bcContact:escape(bcContact),bcTel:bcTel,bcMobile:bcMobile,
		    	bcFax:bcFax,bcEmail:bcEmail,bcBankName:escape(bcBankName),bcBankNo:bcBankNo},
		    url:"bizcontact.do?action=addBizContact",
		    success:function (json){
		    	if(json){
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
	        			comCancelAdd(2);
	        		});
		    	}else{
		    		commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败");
		    	}
		    }
		});
	}
}
//清空添加往来单位的信息
function clearAddBcInfo(){
	$("#bcName_add").val(""); 
	$("#bcTypeId_add").attr("alt","0"); 
	$("#bcTypeId_add").text("");
	$("#bcPyCode_add").val(""); 
	$("#bcAddress_add").val(""); 
	$("#bContact_add").val(""); 
	$("#bcTel_add").val(""); 
	$("#bcMobile_add").val(""); 
	$("#bcFax_add").val(""); 
	$("#bcEmail_add").val(""); 
	$("#bcBankName_add").text(""); 
	$("#bankAcc").val(""); 
	$("#compNameDiv").hide();
	$("#compCategDiv").hide();
	$("#compContDiv").hide();
	$("#compTelDiv").hide();
	$("#compPhoneDiv").hide();
	$("#compFaxDiv").hide();
	$("#compBankNum").hide();
	$("#compBankNaDiv").hide();
	$("#compEmailDiv").hide();
}
//清空添加单位类别信息
function clearAddBtInfo(){
	$("#typeName_add").val("");
	$("#typeRemark_add").val("");
	$("#categNameDiv").hide();
}
//自动创建拼音码
function autoAddPyCode(){
	var bcName = $("#bcName_add").val().replace(/\s+/g, ""); 
	if(bcName != ""){
		$.ajax({
			type:"post",
		    async:false,
		    dataType:"json",
		    data:{bcName:escape(bcName)},
		    url:"bizcontact.do?action=getPinyinCode",
		    success:function (json){
		    	$("#bcPyCode_add").val(json);
		    }
		});
	}
}
//清空添加产品类别DIV数据
function clearAddProTypeInfo(){
	$("#proTypeName");
}
//单击行选择复选框事件
function selPro(index){
	if($("#"+index).is(":checked")){
		$("#"+index).attr("checked",false);
		$("#"+index).parent().find("i").remove();
		$("#"+index).parent().parent().parent().removeClass("oddBgColor1");
	}else{
		$("#"+index).attr("checked",true);
		$("#"+index).parent().append("<i class='iconfont icon-duihao choiceAct'></i>");
		$("#"+index).parent().parent().parent().addClass("oddBgColor1");
	}
}
//选择产品下的全选
function selectAllPro(){
	if(!$("#selAllPro").is(":checked")){
		$("#selAllPro").attr("checked",false);
		$(".selAllLab").find("i").remove();
		$("#dataListTab_pro tr input").attr("checked",false);
		$("#dataListTab_pro tr i").remove();
		$("#dataListTab_pro tr").removeClass("oddBgColor1");
		$(".selAllTxt").html("全选");
	}else{
		$("#selAllPro").attr("checked",true);
		$(".selAllLab").append("<i class='iconfont icon-duihao choiceAct'></i>");
		$("#dataListTab_pro tr input").attr("checked",true);
		if($("#dataListTab_pro tr i").length > 0){
			$("#dataListTab_pro tr i").remove();
		}
		$("#dataListTab_pro tr input").parent().append("<i class='iconfont icon-duihao choiceAct'></i>");
		$("#dataListTab_pro tr").addClass("oddBgColor1");
		$(".selAllTxt").html("取消");
	}
}
//将选择的产品插入采购订单列表中
function insertProList(){
	var trNum = $("#dataListTab_pro tr").length;
	if(trNum == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择产品类别");
	}else{
		var obj = $("input[name='proId']:checked"); 
		if(obj.length > 0){
			var selecProInfo = "";
			for(var i = 0; i < obj.length; i++){ 
				selecProInfo += obj[i].value + ":";
			}
			if(selecProInfo != ""){
				selecProInfo = selecProInfo.substring(0,selecProInfo.length - 1);
			}
			closeAlertWin($(".proInfoDiv"),"selPro");
			//将选择的产品编号插入采购订单列表中
			$("#nullTr").remove();
			var num = $("#purListTable tr").length + 1;
			var proArray = selecProInfo.split(":");
			for(var i = 0 ; i < proArray.length ; i++){
				var strTrTd = "<tr>";
				var oldColor = "";
				var proInfo = proArray[i].split(",");
				strTrTd += "<td class='purListWid1' align='center'>"+ num++ +"</td>";//序号
				strTrTd += "<td class='purListWid5' align='center'>"+proInfo[1]+"</td>";//产品编号
				strTrTd += "<td class='purListWid2' align='center'><p id='proName_"+proInfo[0]+"' class='proIdClass' alt='"+proInfo[0]+"'>"+proInfo[2]+"</p><i class='iconfont icon-more moreIcon posMore' onclick='showCorrUnProInfDiv(2)' title='选择产品'></i></td>";
				strTrTd += "<td class='purListWid3' align='center'>"+proInfo[3]+"</td>";//规格
				strTrTd += "<td class='purListWid7' align='center'>"+proInfo[4]+"</td>";//材质
				strTrTd += "<td id='td_price_"+proInfo[0]+"' class='purListWid4 proPriceClass' align='center' ondblclick=editElement(this,'"+proInfo[0]+"',1,'purchase')>"+proInfo[5]+"</td>";//单价
				strTrTd += "<td id='td_num_"+proInfo[0]+"' class='purListWid4 proNumClass' align='center' ondblclick=editElement(this,'"+proInfo[0]+"',2,'purchase')>0</td>";//采购数量
				strTrTd += "<td class='purListWid6' align='center'>"+proInfo[6]+"</td>";//基本单位
				strTrTd += "<td id='td_all_price_"+proInfo[0]+"' class='purListWid4 cAllPrice' align='center'>0.00 </td>";//总价
				strTrTd += "<td class='purListWid1' align='center'><i class='iconfont icon-delete deleteIcon' title='删除' onclick=clearCurrPro(this);></i></td>";//删除
				strTrTd += "</tr>";
				$("#purListTable").append(strTrTd);
				$("#purListTable tr:odd").addClass("oddBgColor");//增加隔行换色
			}
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择产品");
		}
	}
}
//删除产品
function clearCurrPro(obj){
	$(obj).parent().parent().remove();
	//重新统计总金额
	var allPrice = 0;
	$(".cAllPrice").each(function(i){
		allPrice += parseFloat($(".cAllPrice").eq(i).html());
	});
	$("#totaMoney").html(allPrice.toFixed(2));
	$("#purListTable tr").each(function(){
		$("#purListTable tr").removeClass("oddBgColor");
		$("#purListTable tr:odd").addClass("oddBgColor");
	});
}
//提交采购订单
function addPurOrder(){
	var bcId = $("#purVal").attr("alt");//供应商编号
	var totalMoney = $("#totaMoney").html();//采购总价
	var payOption = $("#payStatusInp").val().replace(/\s+/g, "");//付款人
	var payStatus = -2;//财务未付款
	var invoiceStatus = $("#invoInp_hid").val().replace(/\s+/g, "");
	var num = $("#purListTable tr").length;//采购产品记录条数
	var allPrice_tr_flag = true;
	var proIdStr = "";
	var proPriceStr = "";
	var proNumStr = "";
	$(".cAllPrice").each(function(i){
		if($(".cAllPrice").eq(i).html() == 0.00){
			allPrice_tr_flag = false;
			return false;
		}
	});
	if(payOption == 1){//采购付款
		payStatus = 2;
	}else if(payOption == 2){//财务付
		payStatus = -1;
	}
	if(bcId == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择供应商");
	}else if(num == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"采购记录不能为空");
	}else if(!allPrice_tr_flag){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写产品完整信息");
	}else if(payOption == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择付款人");
	}else if(invoiceStatus == -1){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择发票状态");
	}else{
		$(".proIdClass").each(function(i){
			proIdStr += $(".proIdClass").eq(i).attr("alt")+",";
		});
		proIdStr = proIdStr.substring(0,proIdStr.length - 1);
		$(".proPriceClass").each(function(i){
			proPriceStr += $(".proPriceClass").eq(i).html()+",";
		});
		proPriceStr = proPriceStr.substring(0,proPriceStr.length - 1);
		$(".proNumClass").each(function(i){
			proNumStr += $(".proNumClass").eq(i).html()+",";
		});
		proNumStr = proNumStr.substring(0,proNumStr.length - 1);
		var posStr = proIdStr + ":" + proPriceStr + ":" + proNumStr;//采购订单详情列表(格式为商品编号,单价,采购数量 )
		//获取采购订单中详细数据信息
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			data:{bId:bcId,pTotalMoney:totalMoney,payStatus:payStatus,invoiceStatus:invoiceStatus,posStr:posStr},
			url:"purchase.do?action=addPurchaseOrder",
			success:function(json){
				if(json["result"] == "succ"){
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"增加采购订单成功",function(){
	        			window.location.reload();
	        		});
				}else if(json["result"] == "fail"){
					commonTipInfoFn($("body"),$(".alertWin"),false,"增加采购订单失败");
				}else if(json["result"] == "noAbility"){
					commonTipInfoFn($("body"),$(".alertWin"),false,"您无权执行此操作");
				}
			}
		});
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
//清空查询条件1
function clearOption1(){
	$("#sTime").val("").attr("placeholder","请选择开始时间");
	$("#eTime").val("").attr("placeholder","请选择结束时间");
	$(".comStrogStaInp").each(function(i){
		if($(".comStrogStaInp").eq(i).is(":checked")){
			$(".comStrogStaInp").eq(i).attr("checked",false);
			$(".comStrogStaInp").eq(i).parent().removeClass("active");
			$(".comStrogStaInp").eq(i).parent().find("i").remove();
		}
	});
	$("#storgStatInp").val("-1");
	$(".payStaInput").each(function(i){
		if($(".payStaInput").eq(i).is(":checked")){
			$(".payStaInput").eq(i).attr("checked",false);
			$(".payStaInput").eq(i).parent().removeClass("active");
			$(".payStaInput").eq(i).parent().find("i").remove();
		}
	});
	$("#payStatInp").val("-2");
	$("#unNaInp").val("").attr("alt",0);
	$("#delOptComp").hide();
}
//清空查询条件2
function clearOption2(){
	$("#queryPurNum").val("请输入采购单号");
	$("#sTime").val("${requestScope.sTime}");
	$("#eTime").val("${requestScope.eTime}");
}
//查询订单(0:初始查询,1：组合条件查询,2:采购单号查询)
function queryOrder(status){	
	if(status == 0){//初始查询
		clearOption1();
		clearOption2();
	}
	sTime_a = $("#sTime").val().replace(/\s+/g, "");
	eTime_a = $("#eTime").val().replace(/\s+/g, "");
	if(sTime_a > eTime_a){
		commonTipInfoFn($("body"),$(".alertWin"),false,"采购时间选择错误");
	}else{
		inStatus_a = $("#storgStatInp").val().replace(/\s+/g, "");
		payStatus_a = $("#payStatInp").val().replace(/\s+/g, "");
		purOrder_a = $("#queryPurNum").val().replace(/\s+/g, "");
		bcId_a = $("#unNaInp").attr("alt").replace(/\s+/g, "");
		option_a = status;
		if(purOrder_a == "请输入采购单号"){
			purOrder_a = "";
		}
		var allCount = getPurOrderCount();//全部
		$("#Pagination_pur").pagination(allCount, {
	        callback: pageselectCallback_pur,  //PageCallback() 为翻页调用次函数。
	        prev_text: "上一页",
	        next_text: "下一页 ",
	        items_per_page:pageSize,
	        current_page:page_index_pur,
	        ellipse_text:"...",
	        num_edge_entries: 2,       //两侧首尾分页条目数
	        num_display_entries: 6	//连续分页主体部分分页条目数
	    });
	    $("#Pagination_pur").css({
	   	 	"left":parseInt(($("#purTurnPage").width() - $("#Pagination_pur").width())/2),
	   	 	"top":0
	    });
	}
}
//根据查询条件获取采购单记录数(option="init"时表示初始查询)
function getPurOrderCount(){
	var count = 0;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{sTime:sTime_a,eTime:eTime_a,inStatus:inStatus_a,
			payStatus:payStatus_a,purOrder:purOrder_a,option:option_a,bcId:bcId_a},
		url:"purchase.do?action=getPurchaseOrderCount",
		success:function(json){
			count = json["result"];
		}
	});
	return count;
}
//根据查询条件分页获取采购单记录列表(option="init"时表示初始查询)
function getPurOrderList(pageNo,pageSize){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{sTime:sTime_a,eTime:eTime_a,inStatus:inStatus_a,payStatus:payStatus_a,
			purOrder:purOrder_a,option:option_a,bcId:bcId_a,pageNo:pageNo,pageSize:pageSize},
		url:"purchase.do?action=getPurchaseOrderPageInfo",
		success:function(json){
			if(json["result"].length > 0){
				$("#Pagination_pur").show();
				var content = "";
				for(var i = 0 ; i < json["result"].length ; i++){
					content += "<li class=mainLi>";
					content += "<div id='payRecordDiv_"+json["result"][i].po.id+"' class='mainBox'>";
					content += "<h3><span>采购单 Purchasing Order</span><em>制单日期："+getLocalDate(json["result"][i].po.purDate)+"</em></h3>";
					content += "<div class=purTitDiv>";
					content += "<p class=purName>TO："+json["result"][i].po.businessContactInfo.bcName+"</p>";
					content += "<p class=purOrdNa>FROM："+json["result"][i].po.userInfo.userName+"</p>";
					content += "<p class=purOrdNum>采购编号："+json["result"][i].po.purONo+"</p>";
					content += "</div>";
					//获取采购订单详细信息列表
					var posObj = json["result"][i].posList;
					content += "<ul class='purOrdLisTit clearfix'>";
					content += "<li class=listLiWid1>编号</li>";
					content += "<li class=listLiWid2>物料名称</li>";
					content += "<li class=listLiWid3>材质</li>";
					content += "<li class=listLiWid4>规格</li>";
					content += "<li class=listLiWid3>数量</li>";
					content += "<li class=listLiWid3>入库量</li>";
					content += "<li class=listLiWid3>单价(元)</li>";
					content += "<li class='listLiWid3 noBorLi'>总价(元)</li>";
					content += "</ul>";
					var count = 1;
					for(var j = 0 ; j < posObj.length ; j++){
						content += "<ul class='purOrdLisCon clearfix'>";
						content += "<li class=listLiWid1>"+count+"</li>";
						content += "<li class=listLiWid2>"+posObj[j].productInfo.proName+"</li>";
						content += "<li class=listLiWid3>"+posObj[j].productInfo.proCz+"</li>";
						content += "<li class=listLiWid4>"+posObj[j].productInfo.proSpec+"</li>";
						content += "<li class=listLiWid3>"+posObj[j].proNumber+"</li>";
						content += "<li class=listLiWid3>"+posObj[j].proRealNum+"</li>";
						content += "<li class=listLiWid3>"+posObj[j].proPrice+"</li>";
						content += "<li class='listLiWid3 noBorLi'>"+posObj[j].proTotalMoney+"</li>";
						content += "</ul>";
						count++;
					}
					content += "<div class=purOrdBotDiv>";
					var inStatus = json["result"][i].po.status;
					var payStatus = json["result"][i].po.payStatus;
					var inStatusTxt = "";
					var payStatusTxt = "";
					if(inStatus == 0){
						inStatusTxt = "采购中";
					}else if(inStatus == 1){
						inStatusTxt = "部分入库";
					}else if(inStatus == 2){
						inStatusTxt = "全部入库";
					}
					if(payStatus == -1){
						payStatusTxt = "未付款";
					}else if(payStatus == 0){
						payStatusTxt = "未付清";
					}else if(payStatus == 1){
						payStatusTxt = "财务已付";
					}else if(payStatus == 2){
						payStatusTxt = "采购已付未报账";
					}else if(payStatus == 3){
						payStatusTxt = "采购已付已报账";
					}
					
					content += "<p class=storgStaP>入库状态："+inStatusTxt+"</p>";
					content += "<p class=storgStaP>付款状态："+payStatusTxt+"</p>";
					if(roleName == "财务"){
						var totalMoney = json["result"][i].po.purTotalMoney;
						var payedMoney = json["result"][i].po.purRealMoney;
						//<!-- 未付款状态下的付款按钮  -->
						if(payStatus == -1 || payStatus == 0){
							content += "<a class=finPayBtn href=javascript:void(0) onclick=goPay('"+json["result"][i].po.id+"','"+json["result"][i].po.purONo+"',"+totalMoney+","+payedMoney+","+payStatus+",'singelPay')>去付款</a>";
						}else if(payStatus == 2){
							//<!-- 未报账状态下的去报账按钮  -->
							content += "<a class=finAccPayBtn href=javascript:void(0) onclick=goReimbursement('"+json["result"][i].po.id+"',"+inStatus+");>去报账</a>";
						}
					}
					content += "</div>";
					content += "<div class=purOrdBotDiv1>";
					content += "<p class=actualPay>";
					content += "<span>实付金额："+formatCurrency(json["result"][i].po.purRealMoney)+"元</span>";
					content += "<i class='iconfont icon-payHistory viewPayHisIcon' title=查看付款记录  onclick=showPayHistory('"+json["result"][i].po.id+"');></i><i class='iconfont icon-excel exOut' title=导出excel></i></p>";
					content += "<p>总金额："+formatCurrency(json["result"][i].po.purTotalMoney)+"元</p>";
					content += "</div>";
					content += "<div id='payHisLayerDiv_"+json["result"][i].po.id+"' class=payHisLayer>";
					content += "<div class=payHisTit>";
					content += "<p class=payHisNum>采购单编号："+json["result"][i].po.purONo+"</p>";
					content += "<p class=payHisAcc>实付金额："+formatCurrency(json["result"][i].po.purRealMoney)+"元</p>";
					content += "</div>";
					content += "<p class=payHisLisTit>";
					content += "<span class='widOne'>付款时间</span>";
					content += "<span class='widOne'>付款金额(元)</span>";
					content += "<span class='widOne'>付款备注</span>";
					content += "</p>";
					content += "<div id=payHisListDiv_"+json["result"][i].po.id+" class=comPayHisDiv>";
					
					content += "<ul id=payHisListUl_"+json["result"][i].po.id+">";
					//获取采购订单详细信息列表
					var ppObj = json["result"][i].ppList;
					if(ppObj.length != 0){
						for(var k = 0 ; k < ppObj.length ; k++){
							var payOption = ppObj[k].payOption;
							if(payOption == "cgp"){
								payOption = "采购付款";
							}else{
								payOption = "财务付款";
							}
							content += "<li><p class='widOne'>"+getLocalDate(ppObj[k].payDate)+"</p><p  class='widOne'>"+ppObj[k].payMoney+"</p><p  class='widOne'>"+payOption+"</p></li>";
						}
						content += "</ul>";
					}else{
						content += "<div class='noPayHisDiv'><i class='iconfont icon-noListRec'></i><p>暂无付款记录</p></div>";	
					}
					content += "</div>";
					content += "<div class=closePayLayDiv><i class='iconfont icon-guanbi payHisClose' title=关闭  onclick=closePayLayDiv("+json["result"][i].po.id+")></i></div>";
					content += "</div>";
					content += "</div>";
					content += "</li>";
				}
				$("#purOrdUl").html(content);
				waterFall("purOrdUl","mainLi");
				
				//显示统计层
				$(".totSp").html(formatCurrency(json["tjInfo"][0][0])+"元");
				$(".actSp").html(formatCurrency(json["tjInfo"][0][1])+"元");
				$(".noPaySp").html(formatCurrency((json["tjInfo"][0][0] * 100 - json["tjInfo"][0][1] * 100) / 100)+"元");
				if(bcId_a != 0){//只能是一个公司的付账动作
					$("#payInfo").show();
				}else{
					$("#payInfo").hide();
				}
				$(".payStatisDiv").show();
			}else{
				$("#Pagination_pur").hide();
				$("#purOrdUl").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无采购订单记录</span></div>");
				$("#purOrdUl").height($(".noRecCon").height());
			}
		}
	});
}
//显示出列表数据
function pageselectCallback_pur(page_index_pur,jq){
	getPurOrderList(page_index_pur+1,pageSize);
}
//关闭付款记录窗口
function closePayLayDiv(poId){
	$("#payHisLayerDiv_"+poId).hide();
}
//关闭去付款窗口
function closePayWindow(){
	$(".layer").hide();
	$(".goPayDiv").hide();
	$("#currPayMoney").val("");
	$("#allMoney").html("");
	$("#payedMoney").html("");
	$("#noPayedMoney").html("");
	$("#poId_pay").val(0);
	$("#winInfo").html("付款窗口");
	//刷新订单列表数据
	queryOrder(option_a);
}
//去付款
function goPay(poId,poNum,allMoney,payedMoney,payStatus,option){
	if(roleName == "财务"){
		$("#winInfo").attr("alt",option);
		if($(".noPaySp").html() != "0.00元"){
			if(option == "allPay"){//点击统一付款按钮
				$("#allMoney").html($(".totSp").html().replace(new RegExp(/(,)/g),"").split("元")[0]);
				$("#payedMoney").html($(".actSp").html().replace(new RegExp(/(,)/g),"").split("元")[0]);
				$("#noPayedMoney").html($(".noPaySp").html().replace(new RegExp(/(,)/g),"").split("元")[0]);
				$("#poId_pay").val(0);
				$("#winInfo").html("付款窗口");
				$(".layer").show();
				$(".goPayDiv").show();
			}else{
				if(payStatus == -1 || payStatus == 0){//只有未付款或者未付清才能进行付款
					var noPayMoney = toDecimal(parseFloat(allMoney) - parseFloat(payedMoney));
					$("#allMoney").html(allMoney);
					$("#payedMoney").html(payedMoney);
					$("#noPayedMoney").html(noPayMoney);
					$("#poId_pay").val(poId);
					$("#winInfo").html("付款窗口(订单编号："+poNum+")");
					$(".layer").show();
					$(".goPayDiv").show();
				}else{
		    		commonTipInfoFn($("body"),$(".alertWin"),false,"订单状态为未付款或者未付清时才能进行付款操作");
				}
			}
		}
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权执行此操作");
	}
}
//付款
function payMoney(){
	var poId = $("#poId_pay").val();
	var noPayMoney = $("#noPayedMoney").html();
	var currPayMoney = $("#currPayMoney").val();
	var option = $("#winInfo").attr("alt");
	
	/**全部付款多出的参数**/
	var bcId = $("#unNaInp").attr("alt");
	var sDate = $("#sTime").val();
	var eDate = $("#eTime").val();
	var inStatus = $("#storgStatInp").val();
	var payStatus = $("#payStatInp").val();
	
	
	if(currPayMoney == ""){
		$(".goPayTipInfo").show();
		$("#payTipInfo").html("请输入当前打款金额!");
	}else if(!checkInputNumberOrFloat(currPayMoney)){
		$(".goPayTipInfo").show();
		$("#payTipInfo").html("打款金额只能是正整数或两位以内的小数!");
	}else if(parseFloat(currPayMoney) > parseFloat(noPayMoney)){
		$(".goPayTipInfo").show();
		$("#payTipInfo").html("打款金额不能大于应付金额!");
	}else{
		$(".goPayTipInfo").hide();
		//增加付款记录并修改订单实际付款总额、付款状态
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			data:{poId:poId,currPayMoney:currPayMoney,option:option,bcId:bcId,
				sDate:sDate,eDate:eDate,inStatus:inStatus,payStatus:payStatus},
			url:"purchase.do?action=addPayPurchaseInfo",
			success:function(json){
				if(json["result"] == "succ"){
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"付款成功",function(){
	        			closePayWindow();
	        		});
				}else if(json["result"] == "fail"){
					//alert("付款失败!");
					commonTipInfoFn($("body"),$(".alertWin"),false,"付款失败");
				}else if(json["result"] == "noAbility"){
					commonTipInfoFn($("body"),$(".alertWin"),false,"您无权执行此操作");
				}
			}
		});
	}
}
//去报账Reimbursement
function goReimbursement(poId,inStatus){
	if(inStatus == 2){
		$(".layer").show();
		$(".accountDiv").show();
		$("#poId_bz").val(poId);
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"订单状态为全部入库才能进行报账操作");
	}
}
//关闭报账窗口
function closeBzWindow(){
	$(".layer").hide();
	$(".accountDiv").hide();
	$("#poId_bz").val(0);
	//刷新订单列表数据
	queryOrder(option_a);
}
//执行报账
function execReimbursement(){
	var poId = $("#poId_bz").val().replace(/\s+/g, "");;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{poId:poId},
		url:"purchase.do?action=execReimbursement",
		success:function(json){
			if(json["result"]){
        		commonTipInfoFn($("body"),$(".alertWin"),true,"报账成功",function(){
        			closeBzWindow();
        		});
			}else{
				commonTipInfoFn($("body"),$(".alertWin"),false,"报账失败",function(){
					closeBzWindow();
				});
			}
		}
	});
}
//付款人点击事件
function selPayOption(obj){
	if($(obj).val() == 1){//采购外出采购（外贸）
		//获取采购人员外出采购货物时的专属公司
		$.ajax({
		      type:"post",
		      async:false,
		      dataType:"json",
		      data:{bcType:$(obj).val()},
		      url:"bizcontact.do?action=getSpecBc",
		      success:function (json){
		    	  $("#purVal").attr("alt",json["result"][0].id).val(json["result"][0].bcName);
		      }
		  });
		//自动加载入库单编号
		$("#purOrderNum").val(autoCreatePurOrder());
	}else{//
		$("#purVal").attr("alt","0").val("");
		$("#purOrderNum").val("");
	}
}
//导出Excel
function downInfoToExcel_pur(){
	if(option_a == "0" || option_a == "1"){
		//查询时候存在数据
		if(getPurOrderCount() > 0){
			var urlVar = "&sTime="+sTime_a+"&eTime="+eTime_a+"&inStatus="+inStatus_a;
			urlVar += "&payStatus="+payStatus_a+"&option=1&bcId="+bcId_a;
			window.location.href = "purchase.do?action=exportPurInfoToExcel"+urlVar;
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"没有数据，不能进行导出");
		}
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"根据采购单号查询结果不能导出Excel");
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
				<li class="active">
					<span class="navIcon two"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="采购"/>
				</li>
				<li>
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
						<a id="addNewPurBtn" class="active" href="javascript:void(0)" onclick="selPurchaseTab(1)">新增采购单</a>
						<span>|</span>
						<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览采购单</a>
						<span id="excelS"></span>
					</p>
				</div>
			</div>
			<!-- 新增采购单  -->
			<div class="mainCon comMainWid newAddPurDiv clearfix">
				<!-- 供应商选择、采购编号填写层  -->
				<div class="selBusDiv clearfix">
					<div class="comSelDiv margRSel fl">
						<span>供应商：</span>
						<input id="purVal" type="text" disabled="disabled" alt="0"/>
						<i class="iconfont icon-corrUnit corrUnIcon" onclick="showCorrUnProInfDiv(1)" title="选择供应商"></i>
						<!-- input提示信息 -->
						<div id="corrUnTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucCorUnit" class="iconfont icon-duihao sucInfoIcon2"></i>
					</div>
					<div class="comSelDiv fl">
						<span>采购单编号：</span>
						<input type="text" id="purOrderNum" disabled="disabled"/>
						<!-- input提示信息 -->
						<div id="purNumTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucPurNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
				</div>
				<!-- 采购详情数据层  -->
				<div class="purListDataDiv">
					<table class="purListTit" cellpadding="0" cellspacing="0">
						<tr>
							<td class="purListWid1" align="center">序号</td>
							<td class="purListWid5" align="center">产品编码</td>
							<td class="purListWid2" align="center">产品名称</td>
							<td class="purListWid3" align="center">产品规格</td>
							<td class="purListWid7" align="center">材质</td>
							<td class="purListWid4" align="center">产品单价(元)</td>
							<td class="purListWid4" align="center">采购数量</td>
							<td class="purListWid6" align="center">基本单位</td>
							<td class="purListWid4" align="center">总价(元)</td>
							<td class="purListWid1 noBorR" align="center">操作</td>
						</tr>
					</table>
					<table id="purListTable" class="purListTab" cellpadding="0" cellspacing="0"></table>
					<div class="noRecDiv">
						<a href="javascript:void(0)" onclick="addNewPurRec(0)">
							<i class="iconfont icon-noRecord noRecIcon"></i>
							<span>单击增加采购记录</span>
						</a>
					</div>
					<div class="addTrDiv">
						<img class="addTrBtn" src="Module/purchase/images/addPic.png" alt="增加产品" onclick="addNewPurRec(1)"/>
					</div>
				</div>
				<!-- 采购数据汇总层  -->
				<div class="subPurDataDiv">
					<div class="margL fr">
						<input id="invoInp_hid" type="hidden" value="-1"/>
						<span class="fl">发票：</span>
						<label for="hasInvoInp" class="invoLab">
							<input type="radio" id="hasInvoInp" name="invoiceInp" class="inVoiceRad" value="0"/>
							<em>无</em>
							<span class="cirSpan"></span>
						</label>
						<label for="noInvoInp" class="invoLab marglLab">
							<input type="radio" id="noInvoInp" name="invoiceInp" class="inVoiceRad" value="1"/>
							<em>有</em>
							<span class="cirSpan"></span>
						</label>
					</div>
					<div class="margL fr">
						<input id="payStatusInp" type="hidden" value="0"/>
						<span class="fl">付款人：</span>
						<label for="purPayInp" class="payStatusLab">
							<input type="radio" id="purPayInp" name="payStatusInp" class="payStatusRad" value="1" onclick="selPayOption(this)"/>
							<em>采购付</em>
							<span class="cirSpan"></span>
						</label>
						<label for="financeInp" class="payStatusLab marglLab">
							<input type="radio" id="financeInp" name="payStatusInp" class="payStatusRad" value="2" onclick="selPayOption(this)"/>
							<em>财务付</em>
							<span class="cirSpan"></span>
						</label>
					</div>
					<div class="margL fr">
						<span class="fl">总金额：</span>
						<p id="totaMoney" class="fl">0.00</p>
						<span class="fl">元</span>
					</div>
					<div class="margL fr">
						<span class="fl">制单日期：</span>
						<p id="madeTimeP" class="fl"></p>
					</div>
					<div class="margL1 fr">
						<span class="fl">制单人：</span>
						<p class="fl">${sessionScope.login_real_name}</p>
					</div>
				</div>
				<!-- 采购数据提交按钮  -->
				<a class="submitPurBtn fr" href="javascript:void(0)" onclick="addPurOrder();">提交</a>
			</div>
			<!-- 浏览采购单  -->
			<div class="mainCon comMainWid viewPurDiv clearfix">
				<!-- 根据采购订单单号查询、根据新增采购单时间查询  -->
				<div class="queryDiv clearfix">
					<p class="selCondP">
						<label id="addPurTimSearLab" class="active" onclick="changeSearch(1)">
							<span class="cirSpan"></span>
							<span>根据新增采购单时间查询</span>
							<i class="iconfont icon-duihao selSearIcon"></i>
						</label>
						<label id="purNumSearLab" class="marglLab" onclick="changeSearch(2)">
							<span class="cirSpan"></span>
							<i class="iconfont icon-duihao selSearIcon"></i>
							<span>根据采购单号查询</span>
						</label>
						<a href="javascript:void(0)" class="showHideA fr" onclick="showHideQueryBox()">
							<em class="comTransition"></em>
							<span>隐藏</span>
						</a>
					</p>
					<div class="queryPar clearfix">
						<div class="queryBox fl">
							<div class="comQueryDiv timeCon">
								<span>新增采购单时间：</span>
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
								<input id="storgStatInp" type="hidden" value="-1"/>
								<span>入库状态：</span>
								<label for="purIngInp">
									<span class="cirSpan"></span>
									<input type="radio" id="purIngInp" class="comStrogStaInp" name="storStaInp" value="0"/>
									<span>采购中</span>
								</label>
								<label for="storLitInp">
									<span class="cirSpan"></span>
									<input type="radio" id="storLitInp" class="comStrogStaInp" name="storStaInp" value="1"/>
									<span>部分入库</span>
								</label>
								<label for="storAllInp">
									<span class="cirSpan"></span>
									<input type="radio" id="storAllInp" class="comStrogStaInp" name="storStaInp" value="2"/>
									<span>全部入库</span>
								</label>
							</div>
							<div class="comQueryDiv">
								<input id="payStatInp" type="hidden" value="-2"/>
								<span>付款状态：</span>
								<label for="noPayInp">
									<span class="cirSpan"></span>
									<input type="radio" id="noPayInp" class="payStaInput" name="payStaInp" value="-1"/>
									<span>未付款</span>
								</label>
								<label for="payLitInp">
									<span class="cirSpan"></span>
									<input type="radio" id="payLitInp" class="payStaInput" name="payStaInp" value="0"/>
									<span>未付清</span>
								</label>
								<label for="finPayAlreInp">
									<span class="cirSpan"></span>
									<input type="radio" id="finPayAlreInp" class="payStaInput" name="payStaInp" value="1"/>
									<span>财务已付</span>
								</label>
								<label for="purPayNoSubInp">
									<span class="cirSpan"></span>
									<input type="radio" id="purPayNoSubInp" class="payStaInput" name="payStaInp" value="2"/>
									<span>采购已付未报账</span>
								</label>
								<label for="purPaySubYesInp">
									<span class="cirSpan"></span>
									<input type="radio" id="purPaySubYesInp" class="payStaInput" name="payStaInp" value="3"/>
									<span>采购已付已报账</span>
								</label>
							</div>
							<div class="comQueryDiv">
								<!-- 选择公司名称  -->
								<div class="selQueryDiv">
									<span>单位名称：</span>
									<input id="unNaInp" type="text" disabled="disabled" alt="0"/>
									<i id="delOptComp" class="iconfont icon-close clearIcon" title="清除" onclick="delOption()"></i>
									<i class='iconfont icon-more moreIcon posMore1' title='选择单位' onclick="showCorrUnProInfDiv(1)"></i>
								</div>
							</div>
							<a class="queryStaBtn" href="javascript:void(0)" onclick="queryOrder(1);">查询</a>
						</div>
						<div class="queryBox fl">
							<p class="searchPurNum fl">
								<input type="text" id="queryPurNum" value="请输入采购单号" class="searInp_purNum fl"/>
								<a href="javascript:void(0)" class="searA fl" title="查询" onclick="queryOrder(2)">
									<i class="iconfont icon-search searIcon"></i>
								</a>
							</p>
						</div>
						<span class="borSpan"></span>
						<!-- 二选一查询条件遮罩层  -->
						<span class="searLayer"></span>
					</div>
				</div>
				<!-- 应付款 实付款 未付款数据统计  -->
				<div class="payStatisDiv">
					<p>根据系统统计您的应付款总额：<span class="totSp">1000元</span>，实付款总额：<span class="actSp">800元</span>，未付款金额：<span class="noPaySp">200元</span></p>
					<div id="payInfo" style="display:none;"><a href="javascript:void(0)" onclick="goPay(0,'',0,0,0,'allPay')">付款</a></div>
				</div>
				<!-- 浏览采购单 -->
				<div class="viewPurDiv">
					<ul id="purOrdUl" class="purOrdUl clearfix"></ul>
				</div>
				<div id="purTurnPage" class="comTurnPagDiv">
					<div id="Pagination_pur" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- 选择产品数据弹窗  -->
	<div class="comAlertDiv proInfoDiv">
		<div class="comDataTop">
			<p>选择产品</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.proInfoDiv'),'selPro')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput_pro" value="请输入产品拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询"  onclick="showProductList(null,0);">
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
					<ul id="categDataUlPro" class="categDataUl"></ul>
				</div>
			</div>
			<!-- right 详细信息数据  -->
			<div class="comRightData fl">
				<!-- 数据层  -->
				<div class="tabData">
					<table class="dataTitTab" cellpadding="0" cellspacing="0">
						<tr>
							<td class="lisDaWid1" align="center">选择</td>
							<td class="lisDaWid1" align="center">序号</td>
							<td class="lisDaWid2" align="center">产品名称</td>
							<td class="lisDaWid3" align="center">产品库存</td>
							<td class="lisDaWid3" align="center">产品规格</td>
							<td class="lisDaWid3" align="center">产品均价</td>
							<td class="lisDaWid3" align="center">最高价格</td>
							<td class="lisDaWid3 noBorR" align="center">最低价格</td>
						</tr>
					</table>
					<table id="dataListTab_pro" class="dataListTab" cellpadding="0" cellspacing="0">
						<!-- 分页的话一页8条数据  -->
					</table>
				</div>
				<div id="proTurnPage" class="comTurnPagDiv">
					<div id="Pagination_pro" class="pagination clearfix"></div>
				</div>
				<div class="botDiv">
					<label class="selAllLab">
						<span class="checkSpan"></span>
						<input type="checkbox" id="selAllPro"  onclick="selectAllPro()"/>
						<span class="selAllTxt">全选</span>
					</label>
					<!-- 选中保存按钮  -->
					<a class="saveDataBtn fr" href="javascript:void(0)" onclick="insertProList();">选择</a>
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
				<!--  a class="cancelBtn" href="javascript:void(0)" onclick="closeAddProTypeWindow('addProCategDiv','proType_add','typeRemark_add','categProNaDiv','purchase')">取消</a-->
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
						<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCategBankWin(4)">
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
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(1)">取消</a>
				</div>
				<!-- 选择加工工艺层  -->
				<div class="selProTechLay">
					<p>当前加工工艺&gt;&gt;<span id="nowCateg_made"></span></p>
					<div id="selProTechData">
						<ul id="selCategUl_made" class="clearfix"></ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selCagetBankName(4,$('#nowCateg_made'),'暂未选择加工工艺')">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(4)">取消</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 供应商数据层弹窗  -->
	<div class="comAlertDiv purDataDiv">
		<div class="comDataTop">
			<p>选择业务往来单位</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.purDataDiv'),'selBus')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput" value="请输入往来单位拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询"  onclick="queryBusinessList(null,0)">
					<i class="iconfont icon-search searIcon"></i>
				</a>
			</div>
			<!-- 增加往来单位类别层  -->
			<a class="addCategUnitBtn" href="javascript:void(0)" onclick="showComAddWin(1)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加单位类别</span>
			</a>
			<!-- 增加单位基本信息层  -->
			<a class="addCategBtn" href="javascript:void(0)" onclick="showComAddWin(2)">
				<i class="iconfont icon-tianjia addCaIcon fl"></i>
				<span class="fl">添加单位</span>
			</a>
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
				<!-- 选中保存按钮  -->
				<!-- 翻页  -->
				<div id="bsTurnPage" class="comTurnPagDiv">
					<div id="Pagination" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
		<!-- 添加往来单位类别 单位基本信息遮罩层  -->
		<div class="addNewDataDiv addPurData">
			<!-- 添加往来单位类别  -->
			<div class="addCorrUnDiv">
				<div class="comCategDiv margT_cate">
					<span>类别名称：</span>
					<input type="text" class="comInp_add" id="typeName_add"/>
					<!-- input提示信息  -->
					<div id="categNameDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="cateNameInfo"></p>
					</div>
					<i id="sucCategNam" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comCategDiv">
					<span>类别备注：</span>
					<input type="text" class="comInp_add" id="typeRemark_add"/>
				</div>
				<a class="saveCategBtn" href="javascript:void(0)" onclick="addBsType();">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd(1)">取消</a>
			</div>
			<!-- 添加往来单位基本信息 -->
			<div class="addCorrUnInfo">
				<div class="comAddDiv margT">
					<span>单位名称：</span>
					<input type="text" class="comInp_add" id="bcName_add" onBlur="autoAddPyCode();"/>
					<!-- input提示信息 -->
					<div id="compNameDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcNameInfo"></p>
					</div>
					<i id="sucCompName" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv margT">
					<span class="fl">单位类别：</span>
					<div class="selCategDiv_un fl">
						<!-- 将确定的分类增加到p标签里面 -->
						<p id="bcTypeId_add" alt="0"></p>
						<a class="classifyA" href="javascript:void(0)" title="查看分类"  onclick="selCategBankWin(2)">
							<i class="iconfont icon-fenlei2 classifyIcon"></i>
						</a>
					</div>
					<!-- input提示信息 -->
					<div id="compCategDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcTypeIdInfo"></p>
					</div>
					<i id="sucCompCateg" class="iconfont icon-duihao sucInfoIcon1"></i>
				</div>
				<div class="comAddDiv margT">
					<span>拼<i class="blank"></i>音<i class="blank"></i>码：</span>
					<input type="text" class="comInp_add" id="bcPyCode_add" readonly/>
					<!-- input提示信息 -->
					<div id="compSimpDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p></p>
					</div>
					<i id="sucCompSimp" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>联<i class="blank"></i>系<i class="blank"></i>人：</span>
					<input type="text" class="comInp_add" id="bContact_add"/>
					<!-- input提示信息 -->
					<div id="compContDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bContactInfo"></p>
					</div>
					<i id="sucCompCont" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>联系电话：</span>
					<input type="text" class="comInp_add" id="bcTel_add"/>
					<!-- input提示信息 -->
					<div id="compTelDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcTelInfo"></p>
					</div>
					<i id="sucCompTel" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>联系手机：</span>
					<input type="text" class="comInp_add" id="bcMobile_add"/>
					<!-- input提示信息 -->
					<div id="compPhoneDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcMobileInfo"></p>
					</div>
					<i id="sucCompPhone" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>单位传真：</span>
					<input type="text" class="comInp_add" id="bcFax_add"/>
					<!-- input提示信息 -->
					<div id="compFaxDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcFaxInfo"></p>
					</div>
					<i id="sucCompFax" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span class="fl">开户银行：</span>
					<div class="selBankDiv fl">
						<!-- 将确定的银行名称增加到p标签里面 -->
						<p id="bcBankName_add"></p>
						<a class="classifyA" href="javascript:void(0)" title="选择银行" onclick="selCategBankWin(3)">
							<i class="iconfont icon-fenlei2 classifyIcon"></i>
						</a>
					</div>
					<!-- input提示信息 -->
					<div id="compBankNaDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcBankNameInfo"></p>
					</div>
					<i id="sucCompBankNa" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv" style="z-index:2;">
					<span>银行卡号：</span>
					<input type="text" id="bankAcc" class="comInp_add" onkeyup="clearWord('bankAcc','pattbBankNum')" maxlength="19"/>
					<!-- 银行卡号格式化 -->
					<span id="bankTri" class="bankNumTri"></span>
					<input type="text" id="pattbBankNum" class="patternDiv posInp2" readonly />	
					<!-- input提示信息 -->
					<div id="compBankNum" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcBankNumInfo"></p>
					</div>
					<i id="sucCompBankNum" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv">
					<span>电子邮箱：</span>
					<input type="text" class="comInp_add" id="bcEmail_add"/>
					<!-- input提示信息 -->
					<div id="compEmailDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcEmailInfo"></p>
					</div>
					<i id="sucCompEmail" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comAddDiv1">
					<span>单位地址：</span>
					<input type="text" class="comInp_add1" id="bcAddress_add"/>
					<!-- input提示信息 -->
					<div id="compAddDiv" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="bcAddressInfo"></p>
					</div>
					<i id="sucCompAdd" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<a class="saveCorInfoBtn" href="javascript:void(0)" onclick="addBizContact();">添加保存</a>
				<a class="cancelBtn" href="javascript:void(0)" onclick="comCancelAdd(2)">取消</a>
				<!-- 选择单位类别数据弹层  -->
				<div class="selCategLay">
					<p>当前类别&gt;&gt;<span id="nowCateg_unit" alt="0"></span></p>
					<div id="selCategWrap_un">
						<ul id="selCategUl_un" class="clearfix"></ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selCagetBankName(1,$('#nowCateg_unit'),'暂未选择单位类别')">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(2)">取消</a>
				</div>
				<!-- 选择银行数据弹层  -->
				<div class="selBankLay">
					<p class="nowBankP">当前银行&gt&gt<span id="nowBank"></span></p>
					<input id="selBankInp" type="hidden"/>
					<div class="bankDiv">
						<ul class="bankMidWinDiv">
			    			<li>
			    				<span class="comBankIcon icbcIcon"></span>
			    				<p>中国工商银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国工商银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon abcIcon"></span>
			    				<p>中国农业银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国农业银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon ccbIcon"></span>
			    				<p>中国建设银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国建设银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon cmbIcon"></span>
			    				<p>招商银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="招商银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon bocIcon"></span>
			    				<p>中国银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon psbcIcon"></span>
			    				<p>中国邮政储蓄银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国邮政储蓄银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon commIcon"></span>
			    				<p>交通银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="交通银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon citicIcon"></span>
			    				<p>中信银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中信银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon cmbcIcon"></span>
			    				<p>中国民生银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国民生银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon cebIcon"></span>
			    				<p>中国光大银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="中国光大银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon cibIcon"></span>
			    				<p>兴业银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="兴业银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon spdbIcon"></span>
			    				<p>浦发银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="浦发银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon gdbIcon"></span>
			    				<p>广发银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="广发银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
			    			<li>
			    				<span class="comBankIcon hxbankIcon"></span>
			    				<p>华夏银行</p>
			    				<input type="radio" class="com_BankRdio" name="bankRadio" value="华夏银行"/>
			    				<span class="comCirSpan"></span>
			    			</li>
	    				</ul>
					</div>
					<a class="selCategBtn" href="javascript:void(0)" onclick="selCagetBankName(3,$('#nowBank'),'尚未选择开户银行')">确定</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="comCanCategBankWin(3)">取消</a>
				</div>
			</div>
		</div>
	</div>
	<!-- 付款状态为未付款未付清状态时的付款窗口  -->
	<div class="goPayDiv">
		<p class="goPayTit">
			<i class="iconfont icon-fukuan""></i><span id="winInfo">付款窗口</span>
			<i class="iconfont icon-close closeGoPay comTransition"  onclick="closePayWindow();"></i>
		</p>
		<input type="hidden" id="poId_pay" value=0/>
		<div class="comGoPayDiv payMargT">
			<p>总&nbsp;&nbsp;金&nbsp;额：<span id="allMoney"></span>元</p>
		</div>
		<div class="comGoPayDiv">
			<p>实付金额：<span id="payedMoney"></span>元</p>
		</div>
		<div class="comGoPayDiv">
			<p>应付金额：<span id="noPayedMoney"></span>元</p>
		</div>
		<div class="comGoPayDiv">
			<input type="text" id="currPayMoney" placeholder="最大金额不能超过应付金额"/>
			<a href="javascript:void(0)" onclick="payMoney();">付款</a>
		</div>
		<!--  
			最大金额不能超过应付金额
			金额数值只能为数字
		 -->
		<p class="goPayTipInfo"><i class="iconfont icon-tip"></i><span id="payTipInfo"></span></p>
	</div>
	<!-- 是否确认报账confirm窗口  -->
	<div class="accountDiv">
		<p>是否确认报账？</p>
		<div class="goPayAccDiv">
			<input type="hidden" id="poId_bz" value="0"/>
			<a class="sureAccBtn" href="javascript:void(0)" onclick="execReimbursement();";>确定</a>
			<a class="cancelAccBtn" href="javascript:void(0)" onclick="closeBzWindow();">取消</a>
		</div>
	</div>
	
	<div class="alertWin">
		<i class="iconfont fl"></i>
		<em class="fl"></em>
	</div>
</body>
</html>