//新增采购单、浏览采购单 导航的tab切换
function selPurchaseTab(options){
	$(".searBox a").removeClass("active");
	if(options == 1){//新增采购单
		$(".newAddPurDiv").show();
		$(".viewPurDiv").hide();
		$("#addNewPurBtn").addClass("active");
		option_tr = "inStore";
		$("#excelS").html("");
	}else if(options == 2){//浏览入库单
		$(".viewPurDiv").show();
		$(".newAddPurDiv").hide();
		$("#viewPurBtn").addClass("active");
		choiceOption("inStoreQue","active","label","insStaInpVal","iconFont");//录入状态
		//初始分页查询入库订单（近三天的所有订单）
		queryOrder(0);
		option_tr = "listInStore";
		var contentInfo = "";
		contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_in()">';
		contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
		contentInfo += '<span class="fl">导出Excel</span></a>';
		$("#excelS").html(contentInfo);
	}
}
