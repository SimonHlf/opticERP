//新增采购单、浏览采购单 导航的tab切换
function selPurchaseTab(options){
	$(".searBox a").removeClass("active");
	if(options == 1){//新增采购单
		option_tr = "purchase";
		$(".newAddPurDiv").show();
		$(".viewPurDiv").hide();
		$("#addNewPurBtn").addClass("active");
		$("#excelS").html("");
	}else if(options == 2){//浏览采购单
		option_tr = "purchaseList";
		$(".viewPurDiv").show();
		$(".newAddPurDiv").hide();
		$("#viewPurBtn").addClass("active");
		choiceOption("comStrogStaInp","active","label","storgStatInp","iconFont");//入库状态
		choiceOption("payStaInput","active","label","payStatInp","iconFont");//付款状态
		//初始分页查询采购订单（近三天的所有订单）
		queryOrder(0);
		var contentInfo = "";
		if(roleName == "采购"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_pur()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
		}
		$("#excelS").html(contentInfo);
	}
	$(".payStatisDiv").hide();
}
