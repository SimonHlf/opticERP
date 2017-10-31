<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>产品损耗</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link href="Module/css/pagination.css" rel="stylesheet" />
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="Module/proLoss/css/proLoss.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/timeControl/css/ion.calendar.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/dist/echarts.js"></script>
<script type="text/javascript" src="Module/commonJs/echarts-2.2.1/build/themes/macarons.js"></script>
<script type="text/javascript">
var cliHei = document.documentElement.clientHeight;
var pageSize_pl = 8;
var page_index_pl = 0;
var proName_a = "";
var sDate_a = "";
var eDate_a = "";
var status_a = 0;
var roleName = "${sessionScope.login_user_dep_name}";
$(function(){
	judgeTime_1();
	inpTipFocBlur("proNameInp","请输入物料编号","#999","#666");
	choiceOption("compStaInp","active","label","compStaHidInp","iconFont");
	initYearInfo();
	showPagePLList();
	if(roleName == "财务" || roleName == "董事长"){
		var contentInfo = "";
		contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_pl()">';
		contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
		contentInfo += '<span class="fl">导出Excel</span></a>';
		$("#excelS").html(contentInfo);
	}
});
//导出材料加工损耗到excel
function downInfoToExcel_pl(){
	var inputProNo = $("#proNameInp").val();
	if(inputProNo == "请输入物料编号"){
		inputProNo = "";
	}
	var sYear = $("#sYear").val();
	var sMonth = $("#sMonth").val();
	var eYear = $("#eYear").val();
	var eMonth = $("#eMonth").val();
	var sDate = parseInt(sYear + sMonth);
	var eDate = parseInt(eYear + eMonth);
	var sData_f = sYear + "-" + sMonth;;
	var eDate_f = eYear + "-" + eMonth;
	var status = $("#compStaHidInp").val();
	var allCount = getPLCount(inputProNo,sData_f,eDate_f,status);//全部
	if(allCount > 0){
		window.location.href = "proLoss.do?action=exportInfoToExcel&proName="+inputProNo+"&sDate="+sData_f+"&eDate="+eDate_f+"&status="+status;
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"没有数据，不能进行导出");
	}
}
//初始加载年、月数据
function initYearInfo(){
	var yearArray = getCurrYearArray();
	var yearContent = "";
	for(var j = 0 ; j < yearArray.length ; j++){
		yearContent += "<option value='"+yearArray[j]+"'>"+yearArray[j]+"年</option>";
	}
	$("#sYear").html(yearContent).val(yearArray[yearArray.length - 1]);
	$("#eYear").html(yearContent).val(yearArray[yearArray.length - 1]);
	var monthContent = "";
	var monthValue = "";
	for(var i = 1 ; i <= 12 ; i++){
		if(i < 10){
			monthValue = "0"+i;
		}else{
			monthValue = i;
		}
		monthContent += "<option value='"+monthValue+"'>"+i+"月</option>";
	}
	var currMonth = getCurrMonth();
	$("#sMonth").html(monthContent).val(currMonth);
	$("#eMonth").html(monthContent).val(currMonth);
}
//查看详情
function showDetailData(plId,option,proNo){
	$("#proTitle").attr("alt",plId).html(proNo+"物料产品加工损耗详情");
	getLossDetail(plId,option);
	$(".layer").show();
	$(".detailData").show();
	$(".detailData").height(cliHei);
	$(".routeDivBox").height(cliHei - $(".detailTit").outerHeight() - $(".smNav").height() - 30);
	createLeftScroll("detailData","routeDivPar","routeDivSon",1);
}
//增加详情
function addDetailData(plId,issId,proNo,batchNo,machNum_total,comStatus){
	if(comStatus == 1){
		commonTipInfoFn($("body"),$(".alertWin"),false,"该材料已经加工完结，不能再进行加工");
	}else{
		//alert(getCurrDate("date"));
		getMadeDepList();
		$("#plId").val(plId);
		$("#issId").val(issId);
		$("#prodNameP").html(proNo);
		$("#proBatchNumP").html(batchNo);
		$("#machNum_total").val(machNum_total);
		$("#compDate").val(getCurrDate("date"));
		$(".layer").show();
		$(".addDetailDiv").show();
	}
}
//清空增加详情页面所有数据
function clearAllData(){
	$("#issId").val("0");
	$("#plId").val("0");
	$("#prodNameP").html("");
	$("#proBatchNumP").html("");
	$("#madeNum").val("");
	$("#complNum").val("");
	$("#lossNum").html("");
	$("#depId").val(0);
	$("#machNum_total").val("0");
	$("#proMadNumDiv").hide();
	$("#proCompNumDiv").hide();
	//清除工序提示层
}
//关闭增加详情
function closeAddDetail(){
	$(".layer").hide();
	$(".addDetailDiv").hide();
	clearAllData();
}
function showDiffDetail(opts){
	$(".smNav p").removeClass("active");
	if(opts == "data"){//数据式
		$("#dataTitP").addClass("active");
		$("#chartTitP").removeClass("active");
		$(".routeDivBox ").show();
		$(".chartDivBox").hide();
		$("#scrollPar_1").show();
	}else if(opts == "chart"){//图表式
		$("#dataTitP").removeClass("active");
		$("#chartTitP").addClass("active");
		$(".routeDivBox ").hide();
		$(".chartDivBox").show();
		$("#scrollPar_1").hide();
	}
	getLossDetail($("#proTitle").attr("alt"),opts);
}
function closeDetDataWin(){
	$(".layer").hide();
	$(".detailData").hide();
	if($("#scrollPar_1").length > 0){
		$("#scrollPar_1").remove();
	}
	$("#dataTitP").addClass("active");
	$("#chartTitP").removeClass("active");
	$(".routeDivBox ").show();
	$(".chartDivBox").hide();
	$("#scrollPar_1").show();
	$("#pLoss_chart_div").html("<div class='tableBox' id='pLoss_chart' style='width:99%;height:550px;'></div>");
}
//显示工序加工详情列表
function showProLossDetail(depId,depName){
	var content = "";
	var plId = $("#proTitle").attr("alt");
	$("#depTitle").html(depName);
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{depId:depId,plId:plId},
	      url:"proLoss.do?action=getSpecLossDetail",
	      success:function (json){
	    	  if(json["result"].length > 0){
	    		  for(var i = 0 ; i < json["result"].length ; i++){
	    			  content += "<li>";
	    			  content += "<p>"+json["result"][i].departmentInfo.depName+"</p>";
	    			  content += "<p>"+json["result"][i].outNumber+"</p>";
	    			  content += "<p>"+json["result"][i].comNumber+"</p>";
	    			  content += "<p>"+json["result"][i].lossNumber+"</p>";
	    			  content += "<p>"+getLocalDate(json["result"][i].outDate)+"</p>";
	    			  content += "<p>"+json["result"][i].assume+"</p>";
	    			  content += "</li>";
	    		  }
	    	  }else{
	    		  content += "<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无记录1</span></div>";
	    	  }
	    	  $("#smDetailConUl").html(content);
	      }
	  });
	$(".viewDetLay").show();
	$(".viewDetailDiv").show();
	createLeftScroll("viewDetailDiv","smDetailConDiv","smDetailConUl",2);
}

function closeVieDetWin(){
	$(".viewDetLay").hide();
	$(".viewDetailDiv").hide();
	if($("#scrollPar_2").length > 0){
		$("#scrollPar_2").remove();
	}
}
//根据条件分页获取加工损耗信息
function showPagePLList(){
	var inputProName = $("#proNameInp").val();
	if(inputProName == "请输入物料编号"){
		inputProName = "";
	}
	proName_a = inputProName;
	var sYear = $("#sYear").val();
	var sMonth = $("#sMonth").val();
	var eYear = $("#eYear").val();
	var eMonth = $("#eMonth").val();
	var sDate = parseInt(sYear + sMonth);
	var eDate = parseInt(eYear + eMonth);
	if(sDate <= eDate){
		sDate_a = sYear + "-" + sMonth;
		eDate_a = eYear + "-" + eMonth;
		status_a = $("#compStaHidInp").val();
		var allCount = getPLCount(proName_a,sDate_a,eDate_a,status_a);//全部
	    $("#Pagination_pl").pagination(allCount, {
	      callback: pageselectCallback_pl,  //PageCallback() 为翻页调用次函数。
	      prev_text: "上一页",
	      next_text: "下一页 ",
	      items_per_page:pageSize_pl,
	      current_page:page_index_pl,
	      ellipse_text:"...",
	      num_edge_entries: 2,       //两侧首尾分页条目数
	      num_display_entries: 6	//连续分页主体部分分页条目数
	    });
	    $("#Pagination_pl").css({
	 	 	"left":parseInt(($("#plTurnPage").width() - $("#Pagination_pl").width())/2),
	 	 	"top":10
	    });
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"时间段选择错误");
	}
}
//获取数量
function getPLCount(proName_a,sDate_a,eDate_a,status_a){
	var count = 0;
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{proName:proName_a,sDate:sDate_a,eDate:eDate_a,status:status_a},
	      url:"proLoss.do?action=getProLossCount",
	      success:function (json){
	    	  count = json["result"];
	      }
	  });
	return count;
}
function showLossDetail(list,option){
	var content = "";
	if(list != null){
		$("#proTitle").html(list[0][5]+"物料产品加工损耗详情");
		if(option == "data"){
			alert(list.length)
			for(var i = 0 ; i < list.length ; i++){
				content += "<div class='comRouteDiv fl'>";
				content += "<p class='prodProc'>"+list[i][4]+"</p>";
				content += "<div class='comConDiv'>";
				content += "<span class='arrowSpan'></span>";
				content += "<p>加工数量："+list[i][0]+"</p>";
				content += "<p>完品数量："+list[i][1]+"</p>";
				content += "<p>损耗数量："+list[i][2]+"</p>";
				var comnRate = (parseFloat(list[i][1]) * 100) / parseFloat(list[i][0]);
				content += "<p>完品率："+comnRate.toFixed(2)+"%</p>";
				content += "<a href='javascript:void(0)' onclick=showProLossDetail("+list[i][3]+")>查看详情</a>";
				content += "</div>";
				content += "</div>";
				content += "<div class='comLineBox horComLine fl'>";
				content += "<div class='arrowLine horzLine'>";
				content += "<span class='comTriSpan triSpanR'></span>";
				content += "</div>";
				content += "</div>";
			}
			$("#routeDivSon").html(content);
			alert(content)
		}else if(option == "chart"){
			
		}
	}
}
//获取数据列表
function getPLossList(pageNo,pageSize){
	var content = "";
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{proName:proName_a,sDate:sDate_a,eDate:eDate_a,status:status_a,pageNo:pageNo,pageSize:pageSize},
	      url:"proLoss.do?action=getProLossList",
	      success:function (json){
	    	  if(json["result"].length > 0){
	    		  $("#plTurnPage").show();
	    		  content += "<ul>";
	    		  var comStatusTxt = "";
	    		  for(var i = 0 ; i < json["result"].length ; i++){
	    			  content += "<li>";
	    			  content += "<p class=lisWid1>"+json["result"][i].pl.pro.proName+"</p>";
	    			  content += "<p class=lisWid1>"+json["result"][i].newProNo+"</p>";
	    			  content += "<p class=lisWid3>"+json["result"][i].pl.batchNo+"</p>";
	    			  content += "<p class=lisWid4>"+json["result"][i].pl.matchNum+"</p>";
	    			  content += "<p class=lisWid4>"+json["result"][i].pl.comNum+"</p>";
	    			  content += "<p class=lisWid4>"+json["result"][i].pl.lossNum+"</p>";
	    			  content += "<p class=lisWid4>"+json["result"][i].pl.comRate+"</p>";
	    			  content += "<p class=lisWid2>"+getLocalDate(json["result"][i].pl.startTime) + " 至 " + getLocalDate(json["result"][i].pl.endTime)+"</p>";
	    			  if(json["result"][i].comStatus == 0){
	    				  comStatusTxt = "未完结";
	    			  }else{
	    				  comStatusTxt = "已完结";
	    			  }
	    			  content += "<p class=lisWid4>"+comStatusTxt+"</p>";
	    			  content += "<p class=lisWid1>";
	    			  content += "<a href=javascript:void(0) onclick=showDetailData("+json["result"][i].pl.id+",'data','"+json["result"][i].pl.pro.proName+"')>查看详情</a>";
	    			  if(json["result"][i].comStatus == 0 && roleName == "库房"){
	    				  content += "<a href=javascript:void(0) onclick=addDetailData("+json["result"][i].pl.id+","+json["result"][i].pl.iss.id+",'"+json["result"][i].pl.pro.proName+"','"+json["result"][i].pl.batchNo+"',"+json["result"][i].pl.matchNum+","+json["result"][i].pl.comStatus+")>增加详情</a>";
	    			  }
	    			  content += "</p>";
	    			  content += "</li>";
	    		  }
	    		  content += "</ul>";
	    		  $("#plListDiv").html(content);
	    	  }else{
	    		  $("#plTurnPage").hide();
	    		  $("#plListDiv").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无记录</span></div>");
	    	  }
	      }
	  });
}
//显示出列表数据
function pageselectCallback_pl(page_index_pl,jq){
	getPLossList(page_index_pl+1,pageSize_pl);
}
//获取指定入库子标的主键信息的加工剩余数量
function getRemainNum(issId){
	var remainCount = 0;
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{issId:issId},
	      url:"proLoss.do?action=getInStoreRemainNum",
	      success:function (json){
	    	  remainCount = json["result"];
	      }
	});
	return remainCount;
}
//获取所有加工工序
function getMadeDepList(){
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      url:"basic.do?action=getSpecDepList&dOption=1",
	      success:function (json){
	    	  showDepList(json["result"]);
	      }
	});
}
function showDepList(depList){
	var content = "<option value=0>请选择加工工序</option>";
	for(var i = 0 ; i < depList.length ; i++){
		content += "<option value='"+depList[i].id+"'>"+depList[i].depName+"</option>";
	}
	$("#depId").html(content);
}
//获取指定加工部门、指定材料损耗编号下的剩余可加工数量（总计）
function getValidTotalMadeNum(plId,depId){
	var validMadeNum_total = 0;
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{plId:plId,depId:depId},
	      url:"proLoss.do?action=getCurrTotalMadeNum",
	      success:function (json){
	    	  validMadeNum_total = json["result"];
	      }
	});
	return validMadeNum_total;
}
/* 加工数量的blur事件 */
function calProLosNumMade(){
	var madeNum = $("#madeNum").val();
	var comNum = $("#complNum").val();
	var issId = $("#issId").val();
	var depId = $("#depId").val();
	if(madeNum == ""){
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("加工数量不能为空");
	}else if(!checkIsNumber(madeNum)){
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("加工数量格式错误");
	}else if((getRemainNum(issId) < parseInt(madeNum)) && depId == 6){//荒折为第一步，需要检查加工数量不能大于剩余加工数量
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("数量不能大于剩余加工数量");
	}else if(comNum == ""){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能为空");
	}else if(parseInt(comNum) > parseInt(madeNum)){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能超过加工数量");
	}else{
		$("#proMadNumDiv").hide();
		$("#proMadNumDiv p").html("");
		$("#proCompNumDiv").hide();
		$("#proCompNumDiv p").html("");
		$("#lossNum").html(parseInt(madeNum) - parseInt(comNum));
	}
}
/* 完品数量的blur事件 */
function calProLosNumComp(){
	var madeNum = $("#madeNum").val();
	var comNum = $("#complNum").val();
	var issId = $("#issId").val();
	var depId = $("#depId").val();
	if(comNum == ""){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能为空");
	}else if(!checkIsNumber(comNum)){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量格式错误");
	}else if(parseInt(comNum) > parseInt(madeNum)){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能超过加工数量");
	}else{
		$("#proCompNumDiv").hide();
		$("#proCompNumDiv p").html("");
		$("#lossNum").html(parseInt(madeNum) - parseInt(comNum));
	}
	
}
//增加材料加工子表详情信息
function addProduct(){
	var plId = $("#plId").val();
	var issId = $("#issId").val();
	var madeNum = $("#madeNum").val();
	var comNum = $("#complNum").val();
	var lossNum = $("#lossNum").val();
	var depId = $("#depId").val();
	var comStatus = $("#comStatus").val();
	var machNum_total = $("#machNum_total").val();//加工数量（总）
	var comDate = $("#compDate").val();
	var operator = $("#responPerInp").val();
	var flag_1 = false;
	var flag_2 = false;
	var flag_3 = false;
	var flag_0 = false;
	var flag_final = false;
	if(plId != 0 && issId != 0){
		flag_0 = true;
	}
	if(madeNum == ""){
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("加工数量不能为空");
	}else if(!checkIsNumber(madeNum)){
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("加工数量格式错误");
	}else if((getRemainNum(issId) < parseInt(madeNum)) && depId == 6){//荒折为第一步，需要检查加工数量不能大于剩余加工数量
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("数量不能大于剩余加工数量");
	//}else if(depId != 6 && (parseInt(madeNum) > parseInt(getValidTotalMadeNum(plId,depId)))){//其他加工工序需要检查加工数量不能大于可加工数量
	}else if(depId != 6 && (parseInt(madeNum) > parseInt(machNum_total))){//其他加工工序需要检查加工数量不能大于加工数量总计
		$("#proMadNumDiv").show();
		$("#proMadNumP").html("数量不能大于进货数量");
	}else{
		$("#proMadNumDiv").hide();
		flag_1 = true;
	}
	if(comNum == ""){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能为空");
	}else if(!checkIsNumber(comNum)){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量格式错误");
	}else if(parseInt(comNum) > parseInt(madeNum)){
		$("#proCompNumDiv").show();
		$("#proCompNumP").html("完品数量不能超过加工数量");
	}else{
		$("#proCompNumDiv").hide();
		flag_2 = true;
	}
	//放到blur事件中
	if(flag_1 && flag_2){
		//自动计算损耗数量
		$("#lossNum").html(parseInt(madeNum) - parseInt(comNum));
	}
	if(depId == 0){
		$("#comDepDiv").show();
		$("#comDepNumP").html("请选择加工工序");
	}else{
		$("#comDepDiv").hide();
		flag_3 = true;
	}
	if(flag_0 && flag_1 && flag_2 && flag_3 ){
		//增加材料加工详情
		if(depId == 14){
			if(confirm("出货检为加工工序最后环节，需在前面工序完成后进行添加，是否继续?")){
				flag_final = true;
			}
		}else{
			flag_final = true;
		}
		if(flag_final){
			$.ajax({
			      type:"post",
			      async:false,
			      dataType:"json",
			      data:{plId:plId,issId:issId,depId:depId,madeNum:madeNum,comNum:comNum,comDate:comDate,operator:escape(operator)},
			      url:"proLoss.do?action=addProLossSubInfo",
			      success:function (json){
			    	  if(json["result"] == "succ"){
			    		  commonTipInfoFn($("body"),$(".alertWin"),true,"增加详情成功",function(){
			    			  closeAddDetail();
				    		  //刷新数据
				    		  showPagePLList();
			    		  });
			    	  }else if(json["result"] == "complete"){//完结
			    		  commonTipInfoFn($("body"),$(".alertWin"),true,"增加详情成功",function(){
			    			  closeAddDetail();
				    		  //刷新数据
				    		  showPagePLList();
			    		  });
			    	  }else{
			    		  commonTipInfoFn($("body"),$(".alertWin"),false,"增加详情失败");
			    	  }
			      }
			});
		}	
	}
}
//获取详情数据
function getLossDetail(plId,option){
	$.ajax({
	      type:"post",
	      async:false,
	      dataType:"json",
	      data:{plId:plId},
	      url:"proLoss.do?action=getLossDetail",
	      success:function (json){
	    	 showLossDetail(json["result"],option);
	      }
	});
}
//显示详情数据
function showLossDetail(list,option){
	var madeNumArray = new Array();
	var comNumArray = new Array();
	var lossNumArray = new Array();
	var comRateArray = new Array();
	var depIdArray = new Array();
	var depNameArray = new Array();
	for(var i = 0 ; i < list.length ; i++){
		depIdArray[i] = list[i][3];
		depNameArray[i] = list[i][4];
		madeNumArray[i] = list[i][0];
		comNumArray[i] = list[i][1];
		lossNumArray[i] = list[i][2];
		var comnRate = (parseFloat(list[i][1]) * 100) / parseFloat(list[i][0]);
		comRateArray[i] = comnRate.toFixed(2);
	}
	var allDepNameStr = "荒折,沙挂,研磨,洗净,芯取,镀膜,结合,涂墨,出货检";
	var allDepIdStr = "6,7,8,9,10,11,12,13,14";
	var allDepNameArray = allDepNameStr.split(",");
	var allDepIdArray = allDepIdStr.split(",");
	var content = "";
	if(list.length != 0){
		if(option == "data"){
			for(var j = 0 ; j < allDepIdArray.length ; j++){
				var existFlag = false;
				var classVar_1 = "comRouteDiv fl";
				var classVar_2 = "comLineBox horComLine fl";
				var classVar_3 = "arrowLine horzLine";
				var classVar_4 = "comTriSpan triSpanR";
				if(j == 2){
					classVar_1 = "comRouteDiv fl";
					classVar_2 = "comLineBox vertComLine";
					classVar_3 = "arrowLine vertLine posVerLineR";
					classVar_4 = "comTriSpan triSpanB";
				}else if(j == 3){
					classVar_1 = "comRouteDiv fr posDiv";
					classVar_2 = "comLineBox horComLine fr";
					classVar_3 = "arrowLine horzLine";
					classVar_4 = "comTriSpan triSpanL";
				}else if(j == 4){
					classVar_1 = "comRouteDiv fr";
					classVar_2 = "comLineBox horComLine fr";
					classVar_3 = "arrowLine horzLine";
					classVar_4 = "comTriSpan triSpanL";
				}else if(j == 5){
					classVar_1 = "comRouteDiv fr";
					classVar_2 = "comLineBox vertComLine";
					classVar_3 = "arrowLine vertLine posVerLineL";
					classVar_4 = "comTriSpan triSpanB";
				}else if(j == 6 || j == 7){
					classVar_1 = "comRouteDiv fl";
					classVar_2 = "comLineBox horComLine fl";
					classVar_3 = "arrowLine horzLine";
					classVar_4 = "comTriSpan triSpanR";
				}else if(j == 8){
					classVar_1 = "comRouteDiv fl";
					classVar_2 = "comLineBox vertComLine";
					classVar_3 = "arrowLine vertLine posVerLineR";
					classVar_4 = "comTriSpan triSpanB";
				}
				for(var i = 0 ; i < list.length ; i++){
					if(allDepIdArray[j] == list[i][3]){
						content += "<div class='"+classVar_1+"'>";
						content += "<p class='prodProc'>"+list[i][4]+"</p>";
						content += "<div class='comConDiv'>";
						content += "<span class='arrowSpan'></span>";
						content += "<p>加工数量："+list[i][0]+"</p>";
						content += "<p>完品数量："+list[i][1]+"</p>";
						content += "<p>损耗数量："+list[i][2]+"</p>";
						var comnRate = (parseFloat(list[i][1]) * 100) / parseFloat(list[i][0]);
						content += "<p>完品率："+comnRate.toFixed(2)+"%</p>";
						content += "<a href='javascript:void(0)' onclick=showProLossDetail("+list[i][3]+",'"+list[i][4]+"')>查看详情</a>";
						content += "</div>";
						content += "</div>";
						if(j != 8){
							content += "<div class='"+classVar_2+"'>";
							content += "<div class='"+classVar_3+"'>";
							content += "<span class='"+classVar_4+"'></span>";
							content += "</div>";
							content += "</div>";
						}
						existFlag = true;
						break;
					}else{
						existFlag = false;
					}
				}
				if(existFlag == false){
					content += "<div class='"+classVar_1+"'>";
					content += "<p class='prodProc'>"+allDepNameArray[j]+"</p>";
					content += "<div class='comConDiv'>";
					content += "<span class='arrowSpan'></span>";
					content += "<p>加工数量：0</p>";
					content += "<p>完品数量：0</p>";
					content += "<p>损耗数量：0</p>";
					content += "<p>完品率：0.00%</p>";
					content += "<a href='javascript:void(0)'>查看详情</a>";
					content += "</div>";
					content += "</div>";
					if(j != 8){
						content += "<div class='"+classVar_2+"'>";
						content += "<div class='"+classVar_3+"'>";
						content += "<span class='"+classVar_4+"'></span>";
						content += "</div>";
						content += "</div>";
					}
				}
			}
			$("#routeDivSon").html(content);
		}else if(option == "chart"){
			loadChart(list);
		}
	}else{
		if(option == "data"){
			$("#routeDivSon").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无记录</span></div>");
		}else if(option == "chart"){
			$("#pLoss_chart").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无记录</span></div>");
		}
	}
}
//加载图表
function loadChart(list){
	var madeNumArray = new Array();
	var comNumArray = new Array();
	var lossNumArray = new Array();
	var comRateArray = new Array();
	for(var i = 0 ; i < list.length ; i++){
		madeNumArray[i] = list[i][0];
		comNumArray[i] = list[i][1];
		lossNumArray[i] = list[i][2];
		var comnRate = (parseFloat(list[i][1]) * 100) / parseFloat(list[i][0]);
		comRateArray[i] = comnRate.toFixed(2);
	}
	var allDepNameStr = "荒折,沙挂,研磨,洗净,芯取,镀膜,结合,涂墨,出货检";
	var allDepIdStr = "6,7,8,9,10,11,12,13,14";
	var allDepNameArray = allDepNameStr.split(",");
	var allDepIdArray = allDepIdStr.split(",");
	for(var j = 0 ; j < allDepIdArray.length ; j++){
		var existFlag = false;
		for(var i = 0 ; i < list.length ; i++){
			if(allDepIdArray[j] == list[i][3]){
				madeNumArray[j] = list[i][0];
				comNumArray[j] = list[i][1];
				lossNumArray[j] = list[i][2];
				var comnRate = (parseFloat(list[i][1]) * 100) / parseFloat(list[i][0]);
				comRateArray[j] = comnRate.toFixed(2);
				existFlag = true;
				break;
			}else{
				existFlag = false;
			}
		}
		if(existFlag == false){
			madeNumArray[j] = 0;
			comNumArray[j] = 0;
			lossNumArray[j] = 0;
			comRateArray[j] = 0.00;
		}
	}
	//路径配置
	require.config({
		paths:{
			echarts:'Module/commonJs/echarts-2.2.1/build/dist'
		}
	});
	//使用
	require(
		[
		 	'echarts',
		 	'echarts/chart/bar', // 使用柱状图就加载bar模块，按需加载
		 	'echarts/chart/line'// 使用曲线图就加载bar模块，按需加载
	    ],
	    function(ec){
			// 基于准备好的dom，初始化echarts图表
	    	var myChart = ec.init(getId('pLoss_chart'),getThemes()); 
	    	
	    	// 为echarts对象加载数据 
            myChart.setOption(getChartData("材料加工损耗统计图","加工数量","完品数量","损耗数量","完品率",
            		allDepNameArray,madeNumArray,comNumArray,lossNumArray,comRateArray)); 
		});
}
//统计图数据
function getChartData(title,chartData1,chartData2,chartData3,chartData4,xAxisDataArray,seriesData1,seriesData2,seriesData3,seriesData4){
	var option = {
		    title : {
		    	x : 'center',
		        text: title
		    },
		    tooltip : {
		        trigger: 'axis'
		    },
		    legend: {
		    	y : '35px',
		    	data:[chartData1,chartData2,chartData3,chartData4]
		    },
		    toolbox: {
		        show : true,
		        orient : 'vertical',
		        y : 'center',
		        feature : {
		        	dataView:{
	    		    	show:true,
	    		    	readOnly:false
	    		    },
	    		    magicType:{
	    		    	show:true,
	    		    	type:['line','bar']
	    		    },
	    		    restore : {show: true},
		            saveAsImage : {show: true}
		        }
		    },
		    
		    calculable : true,
		    xAxis : [
		        {
		            type : 'category',
		            axisLabel : {
		                show:true,
		                interval: 'auto',    // {number}
		                rotate: 0,
		                margin: 5,
		                formatter: '{value}',
		                textStyle: {
		                    color: '#1e90ff',
		                    fontFamily: 'sans-serif',
		                    fontSize: 12,
		                    fontStyle: 'normal'
		                }
		            },
		            data : xAxisDataArray,
		            axisPointer: {
		                type: 'shadow'
		            }
		        }
		    ],
		    yAxis : [
		        {
		            type : 'value',
		            name : '数量',
		            min : 0
		        },
		        {
		            type : 'value',
		            name : '完品率',
		            min : 0,
		            axisLabel : {
		                formatter: '{value}%'
		            }
		        },
		    ],
		    grid : {
		    	x : 70,
		    	x2 : 70,
		    	y2 : 20
		    },
		    series : [
		        {
		            name:chartData1,
		            type:'bar',
		            data:seriesData1
		        },
		        {
		            name:chartData2,
		            type:'bar',
		            data:seriesData2
		        },
		        {
		            name:chartData3,
		            type:'bar',
		            data:seriesData3
		        },
		        {
		            name:chartData4,
		            type:'line',
		            yAxisIndex: 1,
		            data:seriesData4
		        }
		    ]
		};
	return option;
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
				<li>
					<span class="navIcon four"></span>
					<span class="tri"></span>
					<input class="hidInp" type="hidden" value="库房出库"/>
				</li>
				<li class="active">
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
					<p class="fl">
						<span>物料编号：</span>
						<input id="proNameInp" class="searInp inpWid1" type="text" value="请输入物料编号" />
					</p>
					<p class="margLP fl">
						<span>时间段：</span>
						<!--input class="searInp inpWid2" type="text" /-->
						<select id="sYear"></select>
						<select id="sMonth"></select>至
						<select id="eYear"></select>
						<select id="eMonth"></select>
						<!--span class="yearSpan">年</span>
						<input class="searInp inpWid2" type="text" />
						<span class="monthSpan">月</span-->
					</p>
					<p class="margLP fl">
						<input id="compStaHidInp" type="hidden" value="-1"/>
						<span>完结状态：</span>
						<label for="noCompStaInp">
							<span class="cirSpan"></span>
							<input type="radio" id="noCompStaInp" class="compStaInp" name="compStaInp" value="0"/>
							<span>未完结</span>
						</label>
						<label for="hasCompStaInp">
							<span class="cirSpan"></span>
							<input type="radio" id="hasCompStaInp" class="compStaInp" name="compStaInp" value="1"/>
							<span>完结</span>
						</label>
					</p>
					<a class="searABtn fl" href="javascript:void(0)" onclick="showPagePLList();">
						查询
						<i class="iconfont icon-search searIcon"></i>
					</a>
					<span id="excelS"></span>
				</div>
			</div>
			<!-- 数据列表层  -->
			<div class="dataListDiv comMainWid">
				<div class="dataLisTit">
					<ul>
						<li class="lisWid1">物料编号</li>
						<li class="lisWid1">产品编号</li>
						<li class="lisWid3">批次</li>
						<li class="lisWid4">加工数量(总)</li>
						<li class="lisWid4">完工数量(总)</li>
						<li class="lisWid4">损耗数量(总)</li>
						<li class="lisWid4">完品率(总)%</li>
						<li class="lisWid2">加工时间</li>
						<li class="lisWid4">完结状态</li>
						<li class="lisWid1">操作</li>
					</ul>
				</div>
				<div class="dataLisCon" id="plListDiv"></div>
				<div id="plTurnPage" class="comTurnPagDiv">
					<div id="Pagination_pl" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- 查看详情下数据层  -->
	<div class="detailData">
		<p class="detailTit"><strong id="proTitle" alt="0"></strong><i class="iconfont icon-close closeDetTitIcon" title="关闭" onclick="closeDetDataWin()"></i></p>
		<div class="smNav">
			<p id="dataTitP" class="active" onclick="showDiffDetail('data')">数据详情</p>
			<p id="chartTitP" onclick="showDiffDetail('chart')">图表详情</p>
		</div>
		<!-- 工序路线  -->
		<div id="routeDivPar" class="routeDivBox clearfix">
			<div id="routeDivSon"></div>
		</div>
		<!-- 图表详情  -->
		<div class="chartDivBox" id="pLoss_chart_div">
			<div class="tableBox" id="pLoss_chart" style="width:99%;height:550px;"></div>
		</div>
		<!-- 查看每个工序领料损耗详情  -->
		<div class="viewDetLay"></div>
		<div class="viewDetailDiv">
			<p class="viewTit"><span id="depTitle"></span>工序加工损耗详情<i class="iconfont icon-close clVieDetIcon" title="关闭" onclick="closeVieDetWin()"></i></p>
			<ul class="smDetaLisTit">
				<li>工序</li>		
				<li>领料数量</li>
				<li>完品数量</li>
				<li>损耗数量</li>
				<li>完成日期</li>	
				<li>担当</li>
			</ul>
			<div id="smDetailConDiv">
				<ul id="smDetailConUl" class="smDetailCon"></ul>
			</div>
		</div>
	</div>
	<!-- 增加详情  -->
	<div class="addDetailDiv">
		<input type="hidden" id="plId" value="0"/>
		<input type="hidden" id="issId" value="0"/>
		<input type="hidden" id="machNum_total" value="0"/>
		<i class="iconfont icon-close closeIcon comTransition" onclick="closeAddDetail();"></i>
		<span class="decSpan"><i class="iconfont icon-detail addDetIcon"></i></span>
		<div class="comAddDiv margT">
			<span class="fl">物料编号：</span>
			<div class="comDisDiv">
				<p id="prodNameP"></p>
			</div>
		</div>
		<div class="comAddDiv margT">
			<span class="fl">生产批次：</span>
			<div class="comDisDiv">
				<p id="proBatchNumP"></p>
			</div>
		</div>
		<div class="comAddDiv">
			<span>加工数量：</span>
			<input type="text" id="madeNum" class="comInp_add" onblur="calProLosNumMade()"/>
			<div id="proMadNumDiv" class="tipDiv">
				<span class="tipTriSpan"></span>
				<p id="proMadNumP"></p>
			</div>
			<i id="sucProMadNum" class="iconfont icon-duihao sucInfoIcon"></i>
		</div>
		<div class="comAddDiv">
			<span>完品数量：</span>
			<input type="text" id="complNum" class="comInp_add" onblur="calProLosNumComp()"/>
			<div id="proCompNumDiv" class="tipDiv">
				<span class="tipTriSpan"></span>
				<p id="proCompNumP"></p>
			</div>
			<i id="sucProCompNum" class="iconfont icon-duihao sucInfoIcon"></i>
		</div>
		<div class="comAddDiv">
			<span class="fl">损耗数量：</span>
			<div class="comDisDiv">
				<p id="lossNum"></p>
			</div>
		</div>
		<div class="comAddDiv">
			<span>工<span class="blankSp"></span>序：</span>
			<select id="depId">
				<option value="0">请选择加工工序</option>
			</select>
			<div id="comDepDiv" class="tipDiv">
				<span class="tipTriSpan"></span>
				<p id="comDepNumP"></p>
			</div>
			<i id="sucComDepNum" class="iconfont icon-duihao sucInfoIcon"></i>
		</div>
		<div class="comAddDiv">
			<span class="fl">完工日期：</span>
			<input type="text" id="compDate" placeholder="请选择完工日期" class="comInp_add date" />
			<div id="compDateDiv" class="tipDiv">
				<span class="tipTriSpan"></span>
				<p id="compDateP"></p>
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
		</div>
		<div class="comAddDiv">
			<span class="fl">担<span class="blankSp"></span>当：</span>
			<input type="text" id="responPerInp" class="comInp_add" maxlength="10"/>
			<div id="responPerDiv" class="tipDiv">
				<span class="tipTriSpan"></span>
				<p id="responPerP"></p>
			</div>
		</div>
		<div class="addBot fl">
			<a href="javascript:void(0)" onclick="addProduct()">添加保存</a>
		</div>
	</div>
	<div class="alertWin">
		<i class="iconfont fl"></i>
		<em class="fl"></em>
	</div>
</body>
</html>
