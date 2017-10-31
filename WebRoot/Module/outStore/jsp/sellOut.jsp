<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>销售出库</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="Module/outStore/css/outSell.css"/>
<link rel="stylesheet" type="text/css" href="Module/outStore/css/commonFrame.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/pagination.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/pagination.css" />
<link rel="stylesheet" type="text/css" href="Module/commonJs/timeControl/css/ion.calendar.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script type="text/javascript" src="Module/outStore/js/sellOut.js"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script type="text/javascript">
var creScroll = true;
var dbFlag = true;
var totPriceSta = 1; //销售出库
var roleName = "${sessionScope.login_user_dep_name}";
var pyCode_a = "";
var bTypeId_a = 0;
var pageSize = 8;
var page_index_p = 0;
var page_index = 0;
var option_tr = "sellOut";
var sel_option="otherOpt";
var outStatus = 0;
var expressFlag = false; //快递单号有无
var optionStatus = "${requestScope.option}";
$(function(){
	judgeTime_1();
	bankNumPattern("bankAcc","pattbBankNum");
	waterFall("outStOrdUl","mainLi");	
	if(roleName == "外协"){
		//switchNav($("#madeOut"),0);
		switchNav($(".outClass_"+optionStatus),optionStatus)
		//去除保存按钮
		$(".outStOrdBotDiv2 a").remove();
	}else{//库管
		switchNav($(".outClass_"+optionStatus),optionStatus)
		var outTxt = "浏览销售出库单";
		if(optionStatus == 0){
			outTxt = "浏览外协加工出库单";
		}
		var contentInfo = "<a id='viewPurBtn' href='javascript:void(0)' onclick='selPurchaseTab(2)'>"+outTxt+"</a>";
		if(roleName == "财务" || roleName == "董事长"  || roleName == "库房"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_o()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
		}
		$("#functionArea").html(contentInfo);
		selPurchaseTab(2);
	}
});
//导出销售出库/加工出库到Excel
function downInfoToExcel_o(){
	if(sel_option == "orderOpt"){
		commonTipInfoFn($("body"),$(".alertWin"),false,"根据出库单号查询结果不能导出Excel");
	}else{
		var sTime = $("#sTime").val();
		var eTime = $("#eTime").val();
		var oSta=$("input[name='compStaInp']:checked").val();
		var bcId=$("#compNaInp").attr("alt");
		if(oSta==undefined){
			oSta=-1;
		}
		if(listOutSellCount() > 0){
			var urlVar = "&sDate="+sTime+"&eDate="+eTime+"&o_sta="+oSta+"&bid="+bcId+"&oType="+outStatus;
			window.location.href = "outStore.do?action=exportOsInfoToExcel"+urlVar;
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"没有数据，不能进行导出");
		}
	}
}
//新增领料出库单、浏览领料出库单 导航的tab切换
function selPurchaseTab(options){
	$(".searBox a").removeClass("active");
	if(options == 1){//新增领料出库单
		option_tr = "sellOut";
		$(".newAddOutStDiv").show();
		$(".viewOutStDiv").hide();
		$("#addNewPurBtn").addClass("active");
		$("#excelS").html("");
	}else if(options == 2){//浏览领料出库单 
		option_tr = "sellOutList";
		$(".viewOutStDiv").show();
		$(".newAddOutStDiv").hide();
		$("#viewPurBtn").addClass("active");
		choiceOption("compStaInpu","active","label","compStaInpVal","iconFont");
		$("#sTime").val("${requestScope.sTime}");
		$("#eTime").val("${requestScope.eTime}");
		listoutSellPage();
		var contentInfo = "";
		contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_o()">';
		contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
		contentInfo += '<span class="fl">导出Excel</span></a>';
		$("#excelS").html(contentInfo);
	}
}
function addNewOutStRec(options){
	var bcId = $("#purVal").attr("alt");
	var perName = $("#contactName").val();
	var totPrice = $("#totalPrice").val();
	if(bcId == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择业务往来单位");
	}else if(perName == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写客户姓名");
	}else if(totPrice == "" && totPriceSta == 1){ //totPriceSta:1代表销售出库
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写合同总价");
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
			strTrTd += "<td class='outStWid1' align='center'>"+ num +"</td>";//序号
			strTrTd += "<td class='outStWid2 proNameTd' align='center'><p id='proName'></p><i class='iconfont icon-more moreIcon' onclick='showCorrUnProInfDiv(1)' title='选择产品'></i></td>";//产品名称
			strTrTd += "<td class='outStWid3' align='center'></td>";//产品编码
			strTrTd += "<td class='outStWid4' align='center'></td>";//产品规格
			strTrTd += "<td class='outStWid8' align='center'></td>";//材质要求
			strTrTd += "<td class='outStWid9' align='center'></td>";//基本单位
			strTrTd += "<td class='outStWid5' align='center'></td>";//库存量
			strTrTd += "<td class='outStWid10' align='center'>0.00</td>";//产品单价
			strTrTd += "<td class='outStWid5' align='center'></td>";//出库量
			strTrTd += "<td class='outStWid10 cAllPrice' align='center'>0.00</td>";//总价
			strTrTd += "<td class='outStWid6 noBorR' align='center'><i class='iconfont icon-delete deleteIcon' title='删除'  onclick=clearCurrPro(this);></i></td>";//删除
			strTrTd += "</tr>";
			num++;
			$("#purListTable").append(strTrTd);
			$("#purListTable tr:odd").addClass("oddBgColor");//增加隔行换色
			if(options == 0){//表示首次进来页面暂无采购记录列表
				checkPurListLen();
			}
		}
		
	}
	
}
//检测新增出库单有无记录
function checkPurListLen(){
	if($("#purListTable tr").length != 0){
		$(".noRecDiv").hide();
		$(".addTrDiv").show();
	}
}
//新增出库单下选取商品的数据层弹窗
function showCorrUnProInfDiv(options){
	if(options == 1){//选取商品
		$(".outStInfoDiv").show();
		getCommonType("pType");
		inpTipFocBlur("searInput_pro","请输入产品拼音码","#999","#666");
		createLeftScroll("proCategDataDiv ","categDataDivPro","categDataUlPro",options);
	}else if(options == 2){//选择业务单位
		$(".corrUnDiv").show();
		getCommonType("bType");
		inpTipFocBlur("searInput","请输入往来单位拼音码","#999","#666");
		createLeftScroll("corrCategDataDiv","categDataDivPur","categDataUlPur",options);
	}
	$(".layer").show();	
}
//浏览出库单下头部的查询
function changeSearch(options){
	$(".selCondP label").removeClass("active");
	if(options == 1){//根据新增销售出库单时间查询
		$("#addInsTimSearLab").addClass("active");
		$(".searLayer").animate({"left":599});
		clearOption2();
		sel_option="otherOpt";
	}else if(options == 2){//根据销售出库单号查询
		$("#insNumSearLab").addClass("active");
		$(".searLayer").animate({"left":0});
		if(totPriceSta == 1){ //销售出库		
			inpTipFocBlur("queryOutStNum","请输入销售出库单号","#999","#666");
		}else{
			inpTipFocBlur("queryOutStNum","请输入外协加工出库单号","#999","#666");
		}
		clearOption1();
		sel_option="orderOpt";
	}
}
//清空查询条件1
function clearOption1(){
	$("#sTime").val("").attr("placeholder","请选择开始时间");
	$("#eTime").val("").attr("placeholder","请选择结束时间");
	$(".compStaInpu").each(function(i){
		if($(".compStaInpu").eq(i).is(":checked")){
			$(".compStaInpu").eq(i).attr("checked",false);
			$(".compStaInpu").eq(i).parent().removeClass("active");
			$(".compStaInpu").eq(i).parent().find("i").remove();
		}
	});
	$("#compStaInpVal").val("");
	$("#compNaInp").val("").attr("alt","-1");
	$("#delOptComp_sell").hide();
}
//清空查询条件2
function clearOption2(){
	if(totPriceSta == 1){//销售出库
		$("#queryOutStNum").val("请输入销售出库单号");
	}else{
		$("#queryOutStNum").val("请输入外协加工出库单号");
	}
	$("#sTime").val("${requestScope.sTime}");
	$("#eTime").val("${requestScope.eTime}");
}
function selCategBankWin(options){
	//1:查看产品类别   2:查看单位类别  3:选择银行
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
	}
}
function addLiActive(obj,objHtml){
	$(obj).each(function(){
		$(this).click(function(){
			$(obj).removeClass("active");
			$(this).addClass("active");
			$(objHtml).html($(this).html());
		});
	});
}
function matchingHtml(obj,objHtml){
	var htmlCon = objHtml.html();
	$(obj).each(function(i){
		if(htmlCon != "" && $(obj).eq(i).html() == htmlCon){
			$(obj).eq(i).addClass("active");
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
//清空添加单位类别信息
function clearAddBtInfo(){
	$("#typeName_add").val("");
	$("#typeRemark_add").val("");
	$("#categNameDiv").hide();
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
//清空添加产品的数据
function clearAllAddProInfo(){
	$("#proName_add").val("");
	$("#proTypeId_add").attr("alt","").html("");
	$("#nowCateg_pro").attr("alt","").html("");
	$("#proCode_add").val("");
	$("#proFormatInfo_add").val("");
	$("#proUnit_add").val("");
	$("#proMater_add").val("");
	$("#proRemark_add").val("");
	$("#categStyInp").val("");
	$("#proNameDiv").hide();
	$("#proCategDiv").hide();
	$("#proCodeDiv").hide();
	$("#proFormatDiv").hide();
	$("#basicUnit").hide();
	$("#materReqDiv").hide();
	$("#proCategStyDiv").hide();
	$(".comCategStyInp").each(function(i){
		if($(".comCategStyInp").eq(i).is(":checked")){
			$(".comCategStyInp").eq(i).attr("checked",false);
			$(".comCategStyInp").eq(i).parent().removeClass("active");
			$(".comCategStyInp").eq(i).parent().find("i").remove();
		}
	});
}
/* 新增单位类别下取消选择单位类别 取消选择银行 */
function comCanCategBankWin(options){
	//1:关闭选择产品类别   2:关闭选择单位类别  3:关闭选择银行
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
	}
}
//保存选择后的业务单位类别,开户银行
function selCagetBankName(options,objNow,strCon){
	//options 1:选择单位类别  2：选择产品类别   3：选择开户银行
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
		}
	}else{
		if(options == 1){
			commonTipInfoFn($("body"),$(".alertWin"),false,"暂未选择单位类别");
		}else if(options == 2){
			commonTipInfoFn($("body"),$(".alertWin"),false,"请选择产品类别");
		}else if(options == 3){
			commonTipInfoFn($("body"),$(".alertWin"),false,"尚未选择开户银行");
		}
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
			selPayPeoCategSty($(".comCategStyInp"),$("#categStyInp"));
		}
	});
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
	var obj = $("input[name='proId']:checked"); 
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
		strTrTd += "<td class='outStWid1' align='center'>"+ num++ +"</td>";//序号
		strTrTd += "<td class='outStWid2' align='center'><p id='proName_"+proInfo[0]+"' class='proIdClass' alt='"+proInfo[0]+"'>"+proInfo[2]+"</p><i class='iconfont icon-more moreIcon' onclick='showCorrUnProInfDiv(1)' title='选择产品'></i></td>";
		strTrTd += "<td class='outStWid3' align='center'>"+proInfo[1]+"</td>";//产品编码
		strTrTd += "<td class='outStWid4' align='center'>"+proInfo[3]+"</td>";//规格
		strTrTd += "<td class='outStWid8' align='center'>"+proInfo[4]+"</td>";//材质
		strTrTd += "<td class='outStWid9' align='center'>"+proInfo[6]+"</td>";//基本单位
		strTrTd += "<td id='storeNum_"+proInfo[0]+"' class='outStWid5' align='center'>"+proInfo[7]+"</td>";//库存量
		strTrTd += "<td id='td_price_"+proInfo[0]+"' class='outStWid10 proPriceClass' align='center' ondblclick=editElement(this,'"+proInfo[0]+"',1,'sellOut')>"+proInfo[5]+"</td>";//单价
		strTrTd += "<td id='td_num_"+proInfo[0]+"' class='outStWid5 proNumClass' align='center' ondblclick=editElement(this,'"+proInfo[0]+"',2,'sellOut')>0</td>";//出库数量
		strTrTd += "<td id='td_all_price_"+proInfo[0]+"' class='outStWid10 cAllPrice' align='center'>0.00 </td>";//总价
		strTrTd += "<td class='outStWid6' align='center'><i class='iconfont icon-delete deleteIcon' title='删除' onclick=clearCurrPro(this);></i></td>";//删除
		strTrTd += "</tr>";
		$("#purListTable").append(strTrTd);
		$("#purListTable tr:odd").addClass("oddBgColor");//增加隔行换色
	}
	closeAlertWin($(".outStInfoDiv"),"selPro");
}
function showEditInp(options,row,oSta){
	//options 1.填写销售出库单号  2.填写快递单号
	var saveABtn = "<a id='saveABtn"+ row +"' href='javascript:void(0)' class='saveBtnA' onclick='updateOutSell("+ row +","+oSta+")'>保存</a>";
	var cancelABtn = "<a id='cancelABtn"+ row +"' href='javascript:void(0)' class='cancelBtnA' onclick='cancelUpdate("+ row +")'>取消编辑</a>";
	if(options == 1){
		$("#outStNumInp"+row).show().animate({"width":170});
	}else if(options == 2){
		if($("#expSpan"+row).text() == ""){ //填写快递单号
			$("#expInp"+row).show().animate({"width":170});
		}else{//编辑快递单号
			$("#expSpan"+row).hide();
			$("#expInp"+row).show().animate({"width":170});
		}
	}
	if($("#outStNumInp"+row).val() != "" && $("#expInp"+row).val() != ""){
		if($("#saveABtn"+row).length > 0 && $("#cancelABtn"+row).length > 0){
			$("#saveABtn"+row).remove();
			$("#cancelABtn"+row).remove();
		}
		$("#otStBotDiv"+row).append(cancelABtn);
	}
}
//取消对快递单号的编辑
function cancelUpdate(ostNum){
	$("#expInp"+ostNum).animate({"width":0},function(){
		$("#expInp"+ostNum).hide();
		$("#expSpan"+ostNum).show();
		//$("#saveABtn"+ostNum).remove();
		$("#cancelABtn"+ostNum).remove();
	});
}
function switchNav(obj,options){
	outStatus = options;
	//options 1.销售出库 0.外协加工出库
	$(".leftSmallNav li").removeClass("active");
	listoutSellPage();
	if(options == 1){//销售出库
		/*
			1:谢珊进入：
				新增销售出库单  浏览销售出库单
				隐藏新增销售出库单层下的出库单编号div、快递单号div隐藏  显示合同单价div
			2:库管进入：浏览销售出库单 根据完结状态增加快递单号 出库单好信息
		*/
		$(obj).addClass("active");
		//$("#sellOutNumDiv").hide();
		//$("#sellOutExpDiv").hide();
		//$("#contPriceDiv").show();
		$("#addNewPurBtn").html("新增销售出库单");
		$("#viewPurBtn").html("浏览销售出库单");
		$("#spanCon_tim").html("根据新增销售出库单时间查询 ");
		$("#spanCon_num").html("根据销售出库单号查询 ");
		$("#queryOutStNum").val("请输入销售出库单号");
		$(".editIcon").show();
	}else if(options == 0){//外协加工出库
		/*
			库管：
				新增外协加工出库单  浏览外协加工出库单
				新增：隐藏合同总价div显示出库单号div，快递单号div
		*/
		$(obj).addClass("active");
		//$("#sellOutNumDiv").show();
		//$("#sellOutExpDiv").show();
		//$("#contPriceDiv").show();
		$("#addNewPurBtn").html("新增外协加工出库单");
		$("#viewPurBtn").html("浏览外协加工出库单");
		$("#spanCon_tim").html("根据新增外协加工出库单时间查询 ");
		$("#spanCon_num").html("根据外协加工出库单号查询 ");
		$("#queryOutStNum").val("请输入外协加工出库单号");
		//$(".editIcon").hide();
	}
	totPriceSta = options;
	if(totPriceSta == 1){ //销售出库		
		inpTipFocBlur("queryOutStNum","请输入销售出库单号","#999","#666");
	}else{
		inpTipFocBlur("queryOutStNum","请输入外协加工出库单号","#999","#666");
	}
	clearAllData();
}
//清空所有数据
function clearAllData(){
	$("#outStUnTipDiv").hide();
	$("#purVal").val("").attr("alt","0");
	$("#outStPeoTipDiv").hide();
	$("#contactName").val("");
	$("#outStNumTipDiv").hide();
	$("#outNo").val("");
	$("#outStExpTipDiv").hide();
	$("#expNo").val("");
	$("#outStPricTipDiv").hide();
	$("#totalPrice").val("");
	$("#totaMoney").val();
	$("#purListTable").html("");
	$(".noRecDiv").show();
	$(".addTrDiv").hide();
	$("#sellRemark").val("");
}
//关闭窗口
function closeAlertWin(obj,option){
	if($(".parScroll").length > 0){
		$(".parScroll").remove();
		$(".categDataUl").css({"top":0});
	}
	$(obj).hide();
	$(".layer").hide();
	if(option == "bc"){
		$("#searInput").val("请输入往来单位拼音码");
		$("#bsTurnPage").hide();
		$("#dataListTab_un").html("");
	}else if(option == "selPro"){
		$("#searInput").val("请输入产品拼音码");
		$("#Pagination_pro").hide();
		$("#dataListTab_pro").html("");
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
	alert($("#selAllPro").is(":checked"));
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
				<li>
					<span class="navIcon three"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="库房入库"/>
				</li>
				<li class="active">
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
		<!-- 左侧副导航  -->
		<div class="leftSmallNav lfSmNavWid">
			<ul>
				<li><span></span><a href="outStore.do?action=goPickingOutStore">领料出库</a></li>
				<li id="sellOut" class="comTabLi outClass_1" onclick="switchNav(this,1)"><span></span>销售出库</li>
				<li id="madeOut" class="comTabLi outClass_0" onclick="switchNav(this,0)"><span></span>外协加工出库</li>
			</ul>

		</div>
		<!-- 右侧对应内容  -->
		<div class="rightPart hasSmaNav">
			<!-- 头部搜索框 -->
			<div class="searWrap">
				<div class="searBox comMainWid">
					<p id="functionArea">
						<a id="addNewPurBtn" class="active" href="javascript:void(0)" onclick="selPurchaseTab(1)">新增销售出库单</a>
						|
						<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览销售出库单</a>
						<span id="excelS"></span>
					</p>
				</div>
			</div>
			<!-- 新增出库单  -->
			<div class="mainCon comMainWid newAddOutStDiv clearfix">
				<!-- 出库单编号层  -->
				<div class="selBusDiv clearfix">
					<div class="comSelDiv margRSel fl">
						<span>业务往来单位：</span>
						<input id="purVal" type="text" disabled="disabled" alt="0"/>
						<i class="iconfont icon-commpany addUnitIcon" onclick="showCorrUnProInfDiv(2)"></i>
						<!-- input提示信息 -->
						<div id="outStUnTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucOtStUn" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv specDivWid fl">
						<span>客户姓名：</span>
						<input id="contactName" class="specInpWid" type="text"/>
						<!-- input提示信息 -->
						<div id="outStPeoTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucOtStPeo" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<%--<div id="sellOutNumDiv" class="comSelDiv fl">
						<span>出库单编号：</span>
						<input id="outNo" type="text"/>
						<!-- input提示信息 -->
						<div id="outStNumTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucOtStNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div id="sellOutExpDiv" class="comSelDiv specDivWid1 fl">
						<span>快递单号：</span>
						<input id="expNo" class="specInpWid1" type="text"/>
						<!-- input提示信息 -->
						<div id="outStExpTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucOtStExp" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>--%>
					<div id="contPriceDiv" class="comSelDiv specDivWid fl">
						<span>合同总价：</span>
						<input id="totalPrice" class="specInpWid" type="text"/>
						<!-- input提示信息 -->
						<div id="outStPricTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucOtStPrice" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
				</div>
				<!-- 出库详情数据层  -->
				<div class="outStDataDiv">
					<table class="outStListTit" cellpadding="0" cellspacing="0">
						<tr>
							<td class="outStWid1" align="center">序号</td>
							<td class="outStWid2" align="center">产品名称</td>
							<td class="outStWid3" align="center">产品编码</td>
							<td class="outStWid4" align="center">产品规格</td>
							<td class="outStWid8" align="center">材质要求</td>
							<td class="outStWid9" align="center">单位</td>
							<td class="outStWid5" align="center">库存量</td>
							<td class="outStWid10" align="center">产品单价(元)</td>
							<td class="outStWid5" align="center">出库量</td>
							<td class="outStWid10" align="center">总价(元)</td>
							<td class="outStWid6 noBorR" align="center">操作</td>
						</tr>
					</table>
					<table id="purListTable" class="outStListTab" cellpadding="0" cellspacing="0"></table>
					<div class="noRecDiv noRecDivPos2">
						<a href="javascript:void(0)" onclick="addNewOutStRec(0)">
							<i class="iconfont icon-noRecord noRecIcon"></i>
							<span>单击增加出库记录</span>
						</a>
					</div>
					<div class="addTrDiv" title="增加一条记录">
						<img class="addTrBtn" src="Module/purchase/images/addPic.png" alt="增加一条记录" onclick="addNewOutStRec(1)"/>
					</div>
				</div>
				<!-- 外协加工出库单数据汇总层  -->
				<div class="subDataDiv">
					<div class="margL fr">
						<span class="fl">备注：</span>
						<input id="sellRemark" type="text" placeholder="最多不超过20个字" maxlength="20"/>
					</div>
					<div class="margL fr">
						<span class="fl">总金额：</span>
						<p id="totaMoney" class="fl">0.00</p>
						<span class="fl">元</span>
					</div>
					<div class="margL fr">
						<span class="fl">制单人：</span>
						<p class="fl">${sessionScope.login_real_name}</p>
					</div>
					<div class="margL fr">
						<span class="fl">制单日期：</span>
						<p class="fl">${requestScope.eTime}</p>
					</div>
				</div>
				<!-- 出库单数据提交按钮  -->
				<a class="submitOutStBtn fr" href="javascript:void(0)" onclick="addSellOut()">提交</a>
			</div>		
			<!-- 浏览销售出库单  -->
			<div class="mainCon comMainWid viewOutStDiv clearfix">
				<!-- 根据销售出库单号查询、根据新增销售出库单时间查询  -->
				<div class="queryDiv clearfix">
					<p class="selCondP">
						<label id="addInsTimSearLab" class="active" onclick="changeSearch(1)">
							<span class="cirSpan"></span>
							<span id="spanCon_tim">根据新增销售出库单时间查询</span>
							<i class="iconfont icon-duihao selSearIcon"></i>
						</label>
						<label id="insNumSearLab" class="marglLab" onclick="changeSearch(2)">
							<span class="cirSpan"></span>
							<i class="iconfont icon-duihao selSearIcon"></i>
							<span id="spanCon_num">根据销售出库单号查询</span>
						</label>
						<a href="javascript:void(0)" class="showHideA fr" onclick="showHideQueryBox()">
							<em class="comTransition"></em>
							<span>隐藏</span>
						</a>
					</p>
					<div class="queryPar clearfix">
						<div class="queryBox fl">
							<div class="comQueryDiv">
								<span>新增出库单时间：</span>
								<input type="text" id="sTime" class="date" placeholder="请选择开始日期"/>&nbsp;&nbsp;
								<input type="text" id="eTime" class="date" placeholder="请选择结束日期"/>
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
							</div>
							<div class="comQueryDiv">
								<input id="compStaInpVal" type="hidden"/>
								<span>完成状态：</span>
								<label for="noCompInp">
									<span class="cirSpan"></span>
									<input type="radio" id="noCompInp" class="compStaInpu" name="compStaInp" value="0"/>
									<span>未完成</span>
								</label>
								<label for="compInp">
									<span class="cirSpan"></span>
									<input type="radio" id="compInp" class="compStaInpu" name="compStaInp" value="1"/>
									<span>已完成</span>
								</label>
							</div>
							<div class="comQueryDiv">
								<!-- 选择产品名称  -->
								<div class="selQueryDiv specDiv">
									<span>公司名称：</span>
									<input id="compNaInp" type="text" alt="-1"/>
									<i id="delOptComp_sell" class="iconfont icon-close clearIcon" title="清除" onclick="clearcomp()"></i>
									<i class='iconfont icon-more moreIcon' title='选择公司' onclick="showCorrUnProInfDiv(2)"></i>
								</div>
							</div>
							<a class="queryStaBtn" href="javascript:void(0)" onclick="listoutSellPage()">查询</a>
						</div>
						<div class="queryBox fl">
							<p class="searchPurNum fl">
								<input type="text" id="queryOutStNum" value="请输入销售出库单号" class="searInp_outStNum fl"/>
								<a href="javascript:void(0)" class="searA fl" title="查询" onclick="listoutSellPage()">
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
				<div class="payStatisDiv" style="display:block;">
					<p>根据系统统计您的应收账款：<span class="totSp" id="allp">1000元</span>，实收账款总额：<span class="actSp" id="actp">800元</span>，未收账款金额：<span class="noPaySp" id="unp">200元</span></p>
				</div>
				<!-- 浏览入库单  -->
				<div class="viewOutStDiv">
					<ul id="purOrdUl" class="outStOrdUl clearfix">
					</ul>
				</div>
				<div id="paginationPar" class="comTurnPagDiv">
					<div id="pagination" class="pagination clearfix"></div>	
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- 选择业务单位数据弹窗  -->
	<div class="comAlertDiv corrUnDiv">
		<div class="comDataTop">
			<p>选择单位</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.corrUnDiv'),'bc')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput" value="请输入往来单位拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询" onclick="queryBusinessList(null,0)">
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
		<!-- 产品类别产品具体信息数据层  -->
		<div class="comDataDiv clearfix">
			<!-- left 类别数据  -->
			<div class="comLeftData corrCategDataDiv fl">
				<p class="categTit"><i class="iconfont icon-categ categIcon"></i><span>业务单位类别</span></p>
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
	<!-- 选择产品数据弹窗  -->
	<div class="comAlertDiv outStInfoDiv">
		<div class="comDataTop">
			<p>选择产品</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.outStInfoDiv'),'selPro')"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput_pro" value="请输入产品拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" title="查询" onclick="showProductList(null,0)">
					<i class="iconfont icon-search searIcon"></i>
				</a>
			</div>
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
							<td class="lisDaWid3" align="center">产品编码</td>
							<td class="lisDaWid3" align="center">产品规格</td>
							<td class="lisDaWid4" align="center">基本单位</td>
							<td class="lisDaWid3" align="center">材质要求</td>
							<td class="lisDaWid4 noBorR" align="center">产品库存</td>
						</tr>
					</table>
					<table id="dataListTab_pro" class="dataListTab" cellpadding="0" cellspacing="0">
						<!-- 分页的话一页8条数据  -->
					</table>
				</div>
				<!-- 翻页  -->
				<div id="proTurnPage" class="comTurnPagDiv">
					<div id="Pagination_pro" class="pagination clearfix"></div>
				</div>
				<div class="botDiv">
					<label class="selAllLab" onclick="selectAllPro()">
						<span class="checkSpan"></span>
						<input type="checkbox"/>
						<span class="selAllTxt">全选</span>
					</label>
					<!-- 选中保存按钮  -->
					<a class="saveDataBtn fr" href="javascript:void(0)" onclick="insertProList();">选择</a>
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
			<a href="javascript:void(0)" onclick="payMoney();"><span id="payT">付</span>款</a>
		</div>
		<!--  
			最大金额不能超过应付金额
			金额数值只能为数字
		 -->
		<p class="goPayTipInfo"><i class="iconfont icon-tip"></i><span id="payTipInfo"></span></p>
	</div>
	<div class="alertWin">
		<i class="iconfont fl"></i>
		<em class="fl"></em>
	</div>
</body>
</html>