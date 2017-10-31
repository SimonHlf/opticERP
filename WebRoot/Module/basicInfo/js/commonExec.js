//该js为基本信息里面的公用添加动作

/**
 * 检查所有存在的公用方法
 * @param nameVar 需要检查是否存在的名字
 * @param option 检查那个属性
 * @returns {Boolean}
 */
function checkExistByName(nameVar,option){
	var name = $("#"+nameVar).val().replace(/\s+/g, "");
	var data = {};
	var nameStr = "";//key
	var url = "";
	if(option == "wt"){//仓库类别
		nameStr = "whName";
		url = "basic.do?action=checkExistByWtName";
	}else if(option == "proType"){//产品类别
		nameStr = "proTypeName";
		url = "producttype.do?action=checkExistByName";
	}else if(option == "pro"){
		nameStr = "proName";
		url = "productInfo.do?action=checkExistByName";
	}else if(option == "proCode"){//根据产品编码查询
		nameStr = "proCode";
		url = "productInfo.do?action=checkExistByCode";
	}
	data[nameStr] = escape(name);
	var existFlag = false;
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:url,
        data:data,
        success:function (json){
        	existFlag = json["result"];
        }
    });
	return existFlag;
}

/**
 * 添加产品类别
 * @param winDiv 产品类别窗口class变量
 * @param typeNameVar 类别名称id变量
 * @param remarkVar 类别备注id变量
 * @param tips 提示层div的id变量
 * @param tipsTxt 提示内容
 * @param module 那个模块调用
 * @param option 检查那个属性
 */
function addCommProType(winDiv,typeNameVar,remarkVar,tips,module,option){
	var typeName = $("#"+typeNameVar).val().replace(/\s+/g, "");
	var remark = $("#"+remarkVar).val().replace(/\s+/g, "");
	if(typeName == ""){
		$("#"+tips).find("p").html("类别名称不能为空");
		$("#"+tips).show();
	}else if(checkInputChi(typeName,2,8)){
		$("#"+tips).find("p").html("类别名称只能是2-8位的中文");
		$("#"+tips).show();
	}else if(checkExistByName(typeNameVar,option)){
		$("#"+tips).find("p").html("该类别名称已存在");
		$("#"+tips).show();
	}else{
		$("#"+tips).hide();
		//执行添加产品类别动作
	    $.ajax({
			type:"post",
			dataType:"json",
			data:{proTypeName:escape(typeName),proTypeRemark:escape(remark)},
			url:"producttype.do?action=addProductType",
			success:function(json){
				if(json==true){
					commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
						closeAddProTypeWindow(winDiv,typeNameVar,remarkVar,tips,module);
					});
				}else{
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
				}
			}
		});
	}
}

/**
 * 关闭增加产品类别窗口
 * @param winDiv 产品类别窗口class变量
 * @param typeNameVar 类别名称id变量
 * @param remarkVar 类别备注id变量
 * @param tips 提示层div的id变量
 * @param module 那个模块调用
 */
function closeAddProTypeWindow(winDiv,typeNameVar,remarkVar,tips,module){
	$("."+winDiv).hide();
	//清空数据
	$("#"+typeNameVar).val("");
	$("#"+remarkVar).val("");
	//隐藏提示层
	$("#"+tips).hide();
	//刷新产品类别数据
	if(module == "purchase"){//采购模块调用
		getCommonType("pType");
		if($("#categDataUlPro").height() > $("#categDataDivPro").height() && $("#scrollPar_2").length > 0){
			scrollBar("categDataDivPro","categDataUlPro","scrollPar_2","scrollSon_2",15);
		}
		$(".addNewDataDiv").hide();
		$(".closeIcon").show();
	}
}

/**
 * 增加仓库类别方法
 * @param wtNameVar 仓库类别名称
 * @param wtRemarkVar 仓库类别备注
 * @param tips 提示DIV
 * @param wtDiv 仓库类别窗口
 * @param module 那个模块调用
 * @param option 检查那个属性
 */
function addCommWType(winDiv,wtNameVar,wtRemarkVar,tips,module,option){
	var whName = $("#"+wtNameVar).val().replace(/\s+/g, "");
	var whRemark = $("#"+wtRemarkVar).val().replace(/\s+/g, "");
	if(whName == ""){
		$("#"+tips).find("p").html("仓库类别名称不能为空");
		$("#"+tips).show();
	}else{
		if(checkExistByName(wtNameVar,option)){
			$("#"+tips).find("p").html("仓库类别已存在");
			$("#"+tips).show();
		}else{
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"basic.do?action=addWHType",
		        data:{whName:escape(whName),whRemark:escape(whRemark)},
		        success:function (json){
		        	if(json["result"] == "succ"){
		        		//alert("增加成功");
		        		commonTipInfoFn($("body"),$(".alertWin"),true,"增加成功");
		        		if(module == "main"){//添加仓库货架主页面仓库类别区域
		        			closeWTypeWindow("",winDiv,wtNameVar,wtRemarkVar,tips);
			        		loadWHTypeList("init",0);//刷新仓库类别列表
		        		}else if(module == "sub_main_1"){//添加仓库货架主页面添加仓库货架内部添加类别区域
		        			cancelAddCateg('addWhCategInfo');
		        			//清空数据
		        			$("#"+wtNameVar).val("");
		        			$("#"+wtRemarkVar).val("");
		        			$("#"+tips).hide();
		        			loadWHTypeList("select",0);//刷新仓库类别列表
		        		}else if(module == "inStore"){//入库时增加仓库类别
		        			//关闭增加窗口
		        			comCancelAdd(6);
		        			//comCanCategBankWin(2);
		        		}
		        		//清空数据
		        		$("#"+wtNameVar).val("");
	        			$("#"+wtRemarkVar).val("");
	        			$("#"+tips).hide();
		        	}else if(json["result"] == "fail"){
		        		commonTipInfoFn($("body"),$(".alertWin"),false,"修改失败");
		        	}else if(json["result"] == "noAbility"){
		        		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权进行修改");
		        	}
		        }
		    });
		}
	}
}

/**
 * 修改仓库类别
 * @param wtIdVar 仓库类别编号
 * @param wtNameVar 仓库类别名称
 * @param wtRemarkVar 仓库类别备注
 * @param wtNameTips 类别名称提示层
 * @param winDiv 窗口div
 * @param module 那个模块调用
 * @param option 检查那个属性
 */
function editCommWType(wtIdVar,wtNameVar,wtRemarkVar,wtNameTips,winDiv,module,option){
	var wtId = $("#"+wtIdVar).val().replace(/\s+/g, "");
	var whName = $("#"+wtNameVar).val().replace(/\s+/g, "");
	var whRemark = $("#"+wtRemarkVar).val().replace(/\s+/g, "");
	var whName_base = $("#"+wtNameVar).attr("alt").replace(/\s+/g, "");
	var whRemark_base = $("#"+wtRemarkVar).attr("alt").replace(/\s+/g, "");
	if(whName == ""){
		$("#"+wtNameTips).find("p").html("类别名称不能为空");
		$("#"+wtNameTips).show();
	}else if(wtId == ""){
		$("#"+wtNameTips).find("p").html("请选择一个类别进行修改");
		$("#"+wtNameTips).show();
	}else if((whName == whName_base) && (whRemark == whRemark_base)){//没做任何修改
		//不执行数据库修改
		closeWTypeWindow(wtIdVar,winDiv,wtNameVar,wtRemarkVar,wtNameTips);
		if(module == "main"){//添加仓库主页面中编辑仓库类别
			loadWHTypeList("init",0);//刷新仓库类别列表
		}
	}else if((whName != whName_base) && checkExistByName(wtNameVar,option)){//类别名称发生变化，需要进行类别名称是否存在判断
		$("#"+wtNameTips).find("p").html("该类别名称已存在");
		$("#"+wtNameTips).show();
	}else{
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:"basic.do?action=updateWHType",
	        data:{whId:wtId,whName:escape(whName),whRemark:escape(whRemark)},
	        success:function (json){
	        	if(json["result"] == "succ"){
	        		alert("修改成功");
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"修改成功",function(){
	        			closeWTypeWindow(wtIdVar,winDiv,wtNameVar,wtRemarkVar,wtNameTips);
	        		});
	        		if(module == "main"){//添加仓库主页面中编辑仓库类别
	        			loadWHTypeList("init",0);//刷新仓库类别列表
	        		}
	        	}else if(json["result"] == "fail"){
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"修改失败");
	        	}else if(json["result"] == "noAbility"){
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权进行修改");
	        	}
	        }
	    });
	}
}

/**
 * 关闭仓库类别窗口
 * @param wtIdVar 仓库类别编号
 * @param wtNameVar 仓库类别名称
 * @param wtRemarkVar 仓库类别备注
 * @param wtDiv 仓库类别窗口
 * @param tips 提示DIV
 */
function closeWTypeWindow(wtIdVar,winDiv,wtNameVar,wtRemarkVar,wtNameTips){
	$(".layer").hide();
	$("."+winDiv).hide();
	if(wtIdVar != ""){//编辑窗口类别时用
		$("#"+wtIdVar).val("");
	}
	$("#"+wtNameVar).val("");
	$("#"+wtRemarkVar).val("");
	$("#"+wtNameTips).hide();
}

/**
 * 添加，修改仓库货架通用方法
 * @param whVar 货架变量
 * @param wtVar 仓库类别变量
 * @param whRemarkVar 货架备注变量
 * @param whNameTips 货架名称提示
 * @param wtTips 仓库类别提示
 * @param module 模块调用
 * @param winDiv 窗口class
 */
function addOrEditCommWH(whVar,wtVar,whRemarkVar,whNameTips,wtTips,module,winDiv){
	var whsId = $("#"+whVar).attr("alt");//只有编辑时才存在（货架编号）
	var whsName = $("#"+whVar).val().replace(/\s+/g, "");//货架名称
	var whId = $("#"+wtVar).attr("alt");//仓库类别编号
	var whName = $("#"+wtVar).text();//仓库类别名称
	var whsRemark = $("#"+whRemarkVar).val().replace(/\s+/g, "");
	var actionStr = "增加";//默认增加
	var urlStr = "basic.do?action=addWHS";//默认增加
	var flag_wh = false;//货架标记
	var flag_wt = false;//货架类别标记
	if(whsName == ""){
		$("#"+whNameTips).show();
	}else{
		$("#"+whNameTips).hide();
		flag_wh = true;
	}
	if(whId == 0){//类别为空
		$("#"+wtTips).show();
	}else{
		$("#"+wtTips).hide();
		flag_wt = true;
	}
	if(whsId != 0){//修改动作
		actionStr = "修改";
		urlStr = "basic.do?action=updateWHS";
	}
	if(flag_wh && flag_wt){
		$.ajax({
	        type:"post",
	        async:false,
	        dataType:"json",
	        url:urlStr,
	        data:{whsId:whsId,whsName:escape(whsName),whId:whId,whsRemark:escape(whsRemark)},
	        success:function (json){
	        	if(json["result"] == "succ"){
	        		//alert(actionStr+"成功");
	        		commonTipInfoFn($("body"),$(".alertWin"),true,actionStr+"成功");
	        		if(module == "main"){//添加仓库货架主页面添加仓库货架
	        			closeCommWHWindow(whVar,wtVar,whRemarkVar,whNameTips,wtTips,winDiv,true);
	        			showPageWSList_curr($("#"+liNumVar),whId,whName,0,pageSize,"init");//刷新仓库货架列表(增加那个仓库下的货架就刷新那个仓库下的货架列表)
		        		//让该li_whId的元素保留active，其他去除active
	        		}else if(module == "inStore"){//入库时增加货架
	        			comCancelAdd(5);
	        		}
	        	}else if(json["result"] == "fail"){
	        		//alert(actionStr+"失败");
	        		commonTipInfoFn($("body"),$(".alertWin"),false,actionStr+"失败");
	        	}else if(json["result"] == "noAbility"){
	        		//alert("您无权进行"+actionStr);
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权进行"+actionStr);
	        	}else if(json["result"] == "exist"){
	        		$("#"+whNameTips).find("p").html("已存在该货架");
	        		$("#"+whNameTips).show();
	        	}
	        }
	    });
	}
}

/**
 * 关闭添加货架窗口(清空数据)
 * @param whVar 货架变量
 * @param wtVar 仓库类别变量
 * @param whRemarkVar 货架备注变量
 * @param whNameTips 货架名称提示
 * @param wtTips 仓库类别提示
 * @param winDiv 窗口class
 * @param flag layer层是否隐藏true-隐藏
 */
function closeCommWHWindow(whVar,wtVar,whRemarkVar,whNameTips,wtTips,winDiv,flag){
	$("#"+whVar).val("").attr("alt",0);;
	$("#"+wtVar).text("").attr("alt","0");
	$("#"+whRemarkVar).val("");
	$("#"+whNameTips).hide();
	$("#"+wtTips).hide();
	if(flag){
		$(".layer").hide();
	}
	$("."+winDiv).hide();
}
//----------------------------------采购、入库通用start--------------------------------------//
//获取单位类别/产品类别列表
function getCommonType(option){
	var content = "";
	var urlStr = "";
	var txtContent = "";
	var li_txt = "";
	var ul_tag = "";
	var div_tag = "";
	if(option == "bType"){//获取往来单位类别
		urlStr = "bizcontact.do?action=listBizType";
		txtContent = "暂无单位类别，请添加";
		li_txt = "b";
		ul_tag = "categDataUlPur";
		div_tag = "categDataDivPur";
	}else if(option == "pType"){//获取产品类别
		urlStr = "producttype.do?action=listProductType";
		txtContent = "暂无产品类别，请添加";
		li_txt = "p";
		ul_tag = "categDataUlPro";
		div_tag = "categDataDivPro";
	}else if(option == "selBtype"){//增加往来单位中选择单位类别
		urlStr = "bizcontact.do?action=listBizType";
		txtContent = "暂无单位类别，请添加";
		ul_tag = "selCategUl_un";
	}else if(option == "wType"){//货架类别
		urlStr = "basic.do?action=getWHSTypeList";
		txtContent = "暂无单位类别，请添加";
		ul_tag = "categDataUlWh";
		div_tag = "categDataDivWh";
	}
	$.ajax({
        type:"post",
        async:false,
        dataType:"json",
        url:urlStr,
        success:function (json){
        	if(json != null){
        		if(option == "bType"){
        			for(var i = 0 ; i < json.length ; i++){
            			content += "<li id='li_"+li_txt+"_"+json[i].id+"'><span></span><i class='iconfont icon-mingpian cardIcon'></i><p onclick=queryBusinessList(this,"+json[i].id+")>"+json[i].btName+"</p></li>";
            		}
        		}else if(option == "pType"){
        			for(var i = 0 ; i < json.length ; i++){
            			content += "<li id='li_"+li_txt+"_"+json[i].id+"'><span></span><i class='iconfont icon-product proIcon'></i><p onclick=showProductList(this,"+json[i].id+")>"+json[i].typeName+"</p></li>";
            		}
        		}else if(option == "selBtype"){
        			for(var i = 0 ; i < json.length ; i++){
        				content += "<li onclick=selectBsTypeInfo('"+json[i].id+"');>"+json[i].btName+"</li>";
        			}
        		}else if(option == "wType"){
        			for(var i = 0 ; i < json["wtList"].length ; i++){
        				content += "<li><span></span><i class='iconfont icon-whose whIcon'></i><p onclick=showPageWSList_curr(this,'"+json["wtList"][i].id+"') title='"+json["wtList"][i].whRemark+"'>"+json["wtList"][i].whName+"</p></li>";
        			}
        		}
        		$("#"+ul_tag).html(content);
        	}else{
        		if(option == "selBtype"){
        			$("#selCategWrap_un").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无单位类别，请添加</span></div>");
        		}else{
        			$("#"+div_tag).html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec'></i><p>"+txtContent+"</p></div>");
        		}
        	}
        }
    });
}

//获取往来单位列表
function queryBusinessList(obj,bTypeId){
	bTypeId_a = bTypeId;
	if(bTypeId != 0){//根据类别查询
		pyCode_a = "";
	}else{//根据拼音码查询
		bTypeId_a = 0;
		var input_pyCode = $("#searInput").val();
		if(input_pyCode == "请输入往来单位拼音码"){
			input_pyCode = "";
		}
		pyCode_a = input_pyCode;
	}
	var allCount = getBusCount(bTypeId_a,pyCode_a);//全部
	$("#categDataUlPur li").removeClass("active");
	$(obj).parent().addClass("active");
    $("#Pagination").pagination(allCount, {
        callback: pageselectCallback,  //PageCallback() 为翻页调用次函数。
        prev_text: "上一页",
        next_text: "下一页 ",
        items_per_page:pageSize,
        current_page:page_index,
        ellipse_text:"...",
        num_edge_entries: 2,       //两侧首尾分页条目数
        num_display_entries: 6	//连续分页主体部分分页条目数
    });
    $("#Pagination").css({
   	 	"left":parseInt(($("#bsTurnPage").width() - $("#Pagination").width())/2),
   	 	"top":20
    });
}

//根据条件获取单位记录数
function getBusCount(){
	var count = 0;
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{typeId_c:bTypeId_a,py_c:pyCode_a},
	    url:"bizcontact.do?action=getBizContactCount",
	    success:function (json){
	    	count = json["result"];
	    }
	});
	return count;
}
//根据条件获取单位记录列表
function getBusList(pageNo,pageSize){
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{typeId_c:bTypeId_a,py_c:pyCode_a,pageNo:pageNo,pageSize:pageSize},
	    url:"bizcontact.do?action=listPageBizContact",
	    success:function (json){
	    	showBusList(json["result"]);
	    }
	});
}
//显示单位记录列表
function showBusList(list){
	var content = "";
	var num = 0;
	if(list.length > 0){
		$("#bsTurnPage").show();
		for(var i = 0 ; i < list.length ; i++){
			num++;
			content += "<tr id='"+list[i].id+"' alt='"+list[i].bcName+"' altVal='"+list[i].bcContact+"'>";
			content += "<td class=listDataWid1 align=center>"+num+"</td>";
			content += "<td class=listDataWid2 ellip align=center>"+list[i].bcName+"</td>";
			content += "<td class=listDataWid3 align=center>"+list[i].bcPy+"</td>";
			content += "<td class=listDataWid3 align=center>"+list[i].bcContact+"</td>";
			content += "<td class=listDataWid4 align=center>"+list[i].bcTel+"</td>";
			content += "<td class=listDataWid4 align=center>"+list[i].bcMobile+"</td>";
			content += "<td class=listDataWid2 align=center>"+list[i].bcEmail+"</td>";
			content += "<td class=listDataWid5 noBorR ellip align=center>"+list[i].bcAddress+"</td>";
			content += "</tr>";
		}
		$("#dataListTab_un").html(content);
		$("#dataListTab_un tr:odd").addClass("oddBgColor1");
		doubleTrClick();
	}else{
		$("#bsTurnPage").hide();
		$("#dataListTab_un").html("<div class='noRecCon1'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无单位</span></div>");
	}
} 
//自动创建入库单编号
function autoCreateInsOrder(){
	var insOrder = "";
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    url:"inStore.do?action=getInNo",
	    success:function (json){
	    	insOrder = json["result"];
	    }
	});
	return insOrder;
}
//tr行双击事件
function doubleTrClick(){
	$("#dataListTab_un tr").dblclick(function() {
		if(option_tr == "purchaseList"){//浏览采购单
			$("#unNaInp").attr("alt",$(this).attr("id")).val($(this).attr("alt"));
			closeAlertWin($('.purDataDiv'),"selBus");
			$("#delOptComp").show();
		}else if(option_tr == "sellOutList"){
			$("#compNaInp").attr("alt",$(this).attr("id")).val($(this).attr("alt"));
			closeAlertWin($('.corrUnDiv'),'bc');
			$("#delOptComp_sell").show();
		}else{
			$("#purVal").attr("alt",$(this).attr("id")).val($(this).attr("alt"));
			if(option_tr == "inStore"){//入库动作
				//自动生产采购订单编号
				var insOrder = autoCreateInsOrder();
				if(insOrder != ""){
					var insOrderArray = insOrder.split("_");
					var preSuffix = insOrderArray[0];
					var lastNum = insOrderArray[1];
					$("#preSuffix").val(preSuffix);
					$("#insOrder_add").val(lastNum);
					closeAlertWin($('.purDataDiv'),"bc");
				}else{
					$("#insOrder_add").val("0001");
					closeAlertWin($('.purDataDiv'),"bc");
				}
				//根据供应商获取该供应商所有未完成的采购订单列表
				showUnFiPurOrder();
			}else if(option_tr == "listInStore"){//浏览入库单时
				$("#compNaInp").val($(this).attr("alt")).attr("alt",$(this).attr("id"));
				closeAlertWin($('.purDataDiv'),"bc");
				$("#delOptComp").show();
			}else if(option_tr == "purchase"){//新增
				$("#purOrderNum").val(autoCreatePurOrder());
				closeAlertWin($('.purDataDiv'),"selBus");
			}else if(option_tr == "sellOut"){//销售出库
				closeAlertWin($(".corrUnDiv"),"");
				$("#contactName").val($(this).attr("altVal"));
			}
		}
	});
}
//显示出列表数据
function pageselectCallback(page_index,jq){
	getBusList(page_index+1,pageSize);
}

//点击产品类别/输入商品名称获取产品列表
function showProductList(obj,pTypeId){
	if(pTypeId > 0){//点击产品类别
		pTypeId_a = pTypeId;
		pyCode_p_a = "";
	}else{//搜索商品名称
		pTypeId_a = 0;
		var input_pCode = $("#searInput_pro").val().replace(/\s+/g, "");;
		if(input_pCode == "请输入产品拼音码"){
			input_pCode = "";
		}
		pyCode_p_a = input_pCode;
	}
	var allCount = getProCount(pTypeId_a,pyCode_p_a);//全部
	$("#categDataUlPro li").removeClass("active");
	$(obj).parent().addClass("active");
    $("#Pagination_pro").pagination(allCount, {
        callback: pageselectCallback_pro,  //PageCallback() 为翻页调用次函数。
        prev_text: "上一页",
        next_text: "下一页 ",
        items_per_page:pageSize,
        current_page:page_index_p,
        ellipse_text:"...",
        num_edge_entries: 2,       //两侧首尾分页条目数
        num_display_entries: 6	//连续分页主体部分分页条目数
    });
    $("#Pagination_pro").css({
   	 	"left":parseInt(($("#proTurnPage").width() - $("#Pagination_pro").width())/2),
   	 	"top":20
    });
}
//根据条件获取产品数量
function getProCount(){
	var count = 0;
	var optionVal = "none";
	if(option_tr == "outStore"){//加工领料出库//库存必须大于0且加工过后的产品不能再加工
		optionVal = "outStore";
	}else if(option_tr == "sellOut"){//销售、外协加工出库//库存必须大于0
		optionVal = "sellOut";
	}
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{protypeId:pTypeId_a,propy:pyCode_p_a,option:optionVal},
		url:"productInfo.do?action=getProCount",
		success:function(json){
			count = json;
		}
	});
	return count;
}
//根据条件获取产品列表
function getProList(pageNo,pageSize){
	var optionVal = "none";
	if(option_tr == "outStore"){//加工领料出库//库存必须大于0且加工过后的产品不能再加工
		optionVal = "outStore";
	}else if(option_tr == "sellOut"){//销售、外协加工出库//库存必须大于0
		optionVal = "sellOut";
	}
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{protypeId:pTypeId_a,propy:pyCode_p_a,option:optionVal,pageNo:pageNo,pageSize:pageSize},
		url:"productInfo.do?action=listProduct",
		success:function(json){
			if(json.length > 0){
				$("#Pagination_pro").show();
				var count = 0;
				var content = "";
				if(option_tr == "purchase"){//采购、出库调用
					for(var i = 0 ; i < json.length ; i++){
						var selProInfo = json[i].id + "," + json[i].proNo + "," + json[i].proName + "," + json[i].proSpec + "," + json[i].proCz + "," + json[i].proPriceL + "," + json[i].proUnit;
						content += "<tr onclick=selPro('p_"+json[i].id+"');>";
						content += "<td class=lisDaWid1 align=center>";
						content += "<label class=tabLabel>";
						content += "<span class=checkSpan></span>";
						content += "<input type=checkbox name=proId id='p_"+json[i].id+"' value='"+selProInfo+"'/>";
						content += "</label></td>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proNumber+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proSpec+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proPriceA+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proPriceH+"</td>";
						content += "<td class=lisDaWid3 noBorR align=center>"+json[i].proPriceL+"</td>";
					}
					$("#dataListTab_pro").html(content);
				}else if(option_tr == "inStore"){//入库
					for(var i = 0 ; i < json.length ; i++){
						var selProInfo = json[i].proNo + "," +  json[i].proUnit + "," + json[i].proSpec;
						content += "<tr id='"+json[i].id+"' alt='"+json[i].proName+"' altVar='"+selProInfo+"'>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proNo+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proNumber+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proSpec+"</td>";
						//content += "<td class=lisDaWid3 align=center>"+json[i].proPriceA+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proPriceH+"</td>";
						content += "<td class='lisDaWid4 noBorR' align=center>"+json[i].proPriceL+"</td>";
					}
					$("#dataListTab_pro").html(content);
					$("#dataListTab_pro tr:odd").addClass("oddBgColor1");
					doubleTrClickPro();
				}else if(option_tr == "listInStore"){//浏览入库
					for(var i = 0 ; i < json.length ; i++){
						content += "<tr id='"+json[i].id+"' alt='"+json[i].proName+"'>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proNo+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proNumber+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proSpec+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proPriceH+"</td>";
						content += "<td class='lisDaWid4 noBorR' align=center>"+json[i].proPriceL+"</td>";
					}
					$("#dataListTab_pro").html(content);
					$("#dataListTab_pro tr:odd").addClass("oddBgColor1");
					doubleTrClickPro_1();
				}else if(option_tr == "sellOut"){//销售出库
					for(var i = 0 ; i < json.length ; i++){
						var selProInfo = json[i].id + "," + json[i].proNo + "," + json[i].proName + "," + json[i].proSpec + "," + json[i].proCz + "," + json[i].proPriceL + "," + json[i].proUnit + "," + json[i].proNumber;
						content += "<tr onclick=selPro('p_"+json[i].id+"');>";
						content += "<td class=lisDaWid1 align=center>";
						content += "<label class=tabLabel>";
						content += "<span class=checkSpan></span>";
						content += "<input type=checkbox name=proId id='p_"+json[i].id+"' value='"+selProInfo+"'/>";
						content += "</label></td>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proNo+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proSpec+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proUnit+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proCz+"</td>";
						content += "<td class=lisDaWid4 noBorR align=center>"+json[i].proNumber+"</td>";
					}
					$("#dataListTab_pro").html(content);
				}else if(option_tr == "outStore"){
					for(var i = 0 ; i < json.length ; i++){
						var selProInfo = json[i].id + "," + json[i].proNo + "," + json[i].proName + "," + json[i].proSpec + "," + json[i].proCz + "," + json[i].proNumber + "," + json[i].proUnit;
						content += "<tr onclick=selPro('p_"+json[i].id+"');>";
						content += "<td class=lisDaWid1 align=center>";
						content += "<label class=tabLabel>";
						content += "<span class=checkSpan></span>";
						content += "<input type=checkbox name=proId id='p_"+json[i].id+"' value='"+selProInfo+"'/>";
						content += "</label></td>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proNo+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proSpec+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proUnit+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proCz+"</td>";
						content += "<td class=lisDaWid4 noBorR align=center>"+json[i].proNumber+"</td>";
					}
					$("#dataListTab_pro").html(content);
				}else if(option_tr =="outSto"){//浏览领料出库单下的选择产品
					for(var i = 0 ; i < json.length ; i++){
						var selProInfo = json[i].id + "," + json[i].proName;
						content += "<tr onclick=selSpro('p_"+json[i].id+"');>";
						content += "<td class=lisDaWid1 align=center>";
						content += "<label class=tabLabel>";
						content += "<span class=checkSpan_cir></span>";
						content += "<input type=radio name=proId id='p_"+json[i].id+"' value='"+selProInfo+"'/>";
						content += "</label></td>";
						count++;
						content += "<td class=lisDaWid1 align=center>"+count+"</td>";
						content += "<td class=lisDaWid2 align=center>"+json[i].proName+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proNo+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proSpec+"</td>";
						content += "<td class=lisDaWid4 align=center>"+json[i].proUnit+"</td>";
						content += "<td class=lisDaWid3 align=center>"+json[i].proCz+"</td>";
						content += "<td class=lisDaWid4 noBorR align=center>"+json[i].proNumber+"</td>";
					}
					$("#dataListTab_pro").html(content);
				}
			}else{
				$("#Pagination_pro").hide();
				$("#dataListTab_pro").html("<div class='noRecCon1'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无产品记录</span></div>");
			}
		}
	});
}
//tr行双击事件(pro)
function doubleTrClickPro(){
	$("#dataListTab_pro tr").dblclick(function() {
		$("#proId_add").attr("alt",$(this).attr("id")).val($(this).attr("alt"));
		var pro_array = $(this).attr("altVar").split(",");
		$("#proNo_add").val(pro_array[0]);
		$("#proUnit_add1").val(pro_array[1]);
		$("#proSpec_add").val(pro_array[2]);
		closeAlertWin($('.proInfoDiv'),"pro");
	});
}
//tr行双击事件(pro)
function doubleTrClickPro_1(){
	$("#dataListTab_pro tr").dblclick(function() {
		$("#proNaInp").attr("alt",$(this).attr("id")).val($(this).attr("alt"));
		$("#delOptPro").show();
		closeAlertWin($('.proInfoDiv'),"pro");
	});
}
//显示出列表数据
function pageselectCallback_pro(page_index_p,jq){
	getProList(page_index_p+1,pageSize);
}

//----------------------------------采购、入库通用end--------------------------------------//


/**
 * 关闭选择货架窗口（入库选择时用）
 * @param winDiv 产品类别窗口class变量
 * @param whNameVar 货架名称id变量
 * @param whIdVar 货架id变量
 */
function closeSelWHWindow(whNameVar,whIdVar,winDiv){
	$("#"+whNameVar).val("请输入货架编号");
	//去除所有选中状态
	$("#whListUl li").each(function(){
		$("#whListUl li").removeClass("active");
	});
	$("#"+whIdVar).attr("alt","").val("0");
	$(".layer").hide();
	$("."+winDiv).hide();
}
//弹窗下增加产品基本信息--取消时清空添加产品的数据
function clearAllAddProInfo(){
	$("#proName_add").val("");
	$("#proTypeId_add").attr("alt","").html("");
	$("#nowCateg_pro").attr("alt","").html("");
	$("#madDepInp").val("");
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
	$("#proTechTipDiv").hide();
	$("#madeDepP").html("");
	$(".comCategStyInp").each(function(i){
		if($(".comCategStyInp").eq(i).is(":checked")){
			$(".comCategStyInp").eq(i).attr("checked",false);
			$(".comCategStyInp").eq(i).parent().removeClass("active");
			$(".comCategStyInp").eq(i).parent().find("i").remove();
		}
	});
}
/* 弹窗内部增加产品基信息下、增加单位信息、增加货架信息下的查看各个对应类别下调用公共方法 */
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
/* 弹窗内部增加产品基本信息时的保存通用方法 */
//添加产品
function addPro(){
   var proName =  $("#proName_add").val().replace(/\s+/g, "");
   var ptID=  $("#proTypeId_add").attr("alt").replace(/\s+/g, "");
   var pro_no=  $("#proCode_add").val().replace(/\s+/g, "");
   var pro_spec=  $("#proFormatInfo_add").val().replace(/\s+/g, "");
   var pro_unit=  $("#proUnit_add").val().replace(/\s+/g, "");
   var pro_cz=  $("#proMater_add").val().replace(/\s+/g, "");
   var pro_remark=  $("#proRemark_add").val().replace(/\s+/g, ""); //备注
   var pt_type = $("#categStyInp").val().replace(/\s+/g, ""); //类别类型
   var madeDep = $("#madDepInp").val().replace(/\s+/g, "");//加工工艺
   var proNameFlag = false;
   var proTypeFlag = false;
   var proNoFlag = false;
   var proUnitFlag = false;
   var proSpecFlag = false;
   var proCzFlag = false;
   var ptTypeFlag = false;
   var madeDepFlag = false;
   if(proName == ""){
	   $("#proName_add_tips").html("产品名称不能为空");
	   $("#proNameDiv").show();
   }else{
	   if(checkExistByName("proName_add","pro")){
		   $("#proName_add_tips").html("已存在该产品");
		   $("#proNameDiv").show();
	   }else{
		   proNameFlag = true;
		   $("#proNameDiv").hide(); 
	   }
   }
   if(ptID == 0){
	   $("#proTypeId_add_tips").html("产品类别不能为空");
	   $("#proCategDiv").show();
   }else{
	   proTypeFlag = true;
	   $("#proCategDiv").hide();
   }
   if(pro_no == ""){
	   $("#proCode_add_tips").html("产品编码不能为空");
	   $("#proCodeDiv").show();
   }else{
	   proNoFlag = true;
	   $("#proCodeDiv").hide();
   }
   if(pro_spec == ""){
	   $("#proFormatInfo_add_tips").html("产品规格不能为空");
	   $("#proFormatDiv").show();
   }else{
	   proSpecFlag = true;
	   $("#proFormatDiv").hide();
   }
   if(pro_unit == ""){
	   $("#proUnit_add_tips").html("基本单位不能为空");
	   $("#basicUnit").show();
   }else{
	   proUnitFlag = true;
	   $("#basicUnit").hide();
   }
   if(pro_cz == ""){
	   $("#proMater_add_tips").html("材质要求不能为空");
	   $("#materReqDiv").show();
   }else{
	   proCzFlag = true;
	   $("#materReqDiv").hide();
   }
   if(pt_type == ""){
	   $("#categStyInp_tips").html("类别类型不能为空");
	   $("#proCategStyDiv").show();
   }else{
	   ptTypeFlag = true;
	   $("#proCategStyDiv").hide();
   }
   if(madeDep == ""){
	   $("#proTechTipDiv").show();
	   $("#proTechTipDiv p").html("加工工艺不能为空");
   }else{
	   madeDepFlag = true;
	   $("#proTechTipDiv").hide();
	   $("#proTechTipDiv p").html("");
   }
   if(proNameFlag && proTypeFlag && proNoFlag && proSpecFlag && proUnitFlag && proCzFlag && ptTypeFlag && madeDepFlag){
	   $.ajax({
			type:"post",
			async:false,
			dataType:"json",
			data:{proName:escape(proName),ptID:ptID,pro_no:pro_no,pro_spec:escape(pro_spec),pro_unit:escape(pro_unit),
				pro_cz:escape(pro_cz),pro_remark:escape(pro_remark),pt_type:pt_type,madeDep:madeDep},
			url:"productInfo.do?action=addProduct",
			success:function(json){
				if(json==true){
	        		commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
	        			comCancelAdd(4);
	        		});
				}else{
	        		commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
				}
			}
		});
   }
}
//获取加工工艺信息
function ProcessMade(){
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"productInfo.do?action=listProcessInfo",
		success:function(json){
			var conTxt="";
			$.each(json, function(row, obj) {
				conTxt+='<li onclick="selProcMade(this,\''+obj.depName+'\','+obj.id+')">'+obj.depName+'</li>';
			});
			$("#selCategUl_made").html(conTxt);
		}
	});
}
//选中加工工艺
function selProcMade(obj,depName,depID){
	$("#madDepInp").val(depID);
	$("#nowCateg_made").text(depName);
	$("#selCategUl_made li").removeClass("active");
	$(obj).addClass("active");
}
//获取系统时间
function getSysTime(obj){
	var oDate = new Date();
	var strTime = oDate.getFullYear() +"-"+ (oDate.getMonth()+1)+"-"+ oDate.getDate();
	$(obj).html(strTime);
}
//浏览功能下的展开和收缩
var onOff = true;
function showHideQueryBox(){
	if(onOff){
		$(".borSpan").hide();
		$(".searLayer").hide();
		$(".queryPar").slideUp();
		$(".showHideA span").html("展开");
		$(".showHideA em").addClass("roataEmUp").removeClass("roataEmDown");
	}else{
		$(".showHideA em").addClass("roataEmDown").removeClass("roataEmUp");
		$(".showHideA span").html("隐藏");
		$(".queryPar").slideDown(function(){
			$(".searLayer").show();
			$(".borSpan").show();
		});
	}
	onOff = !onOff;
}

//浏览采购单下的数据瀑布流
function waterFall(parent,box){
	var oParent = getId(parent);
	var aBoxes = getByClass(parent,box);
	if(aBoxes.length > 0){
		//计算父级层下一行显示的列数(父级宽/box的宽)
		var oBoxW = aBoxes[0].offsetWidth;
		var cols = Math.floor(1200 / oBoxW);
		var hArr = [];
		for(var i=0;i<aBoxes.length;i++){
			aBoxes[i].setAttribute("id","mainLi_"+i);
			if(i<cols){//表示第一行
				hArr.push(aBoxes[i].offsetHeight);
				aBoxes[0].style.marginRight = 20+ "px";
				var maxH = Math.max.apply(null,hArr);
				var maxHIndex = getMinhIndex(hArr,maxH);
				oParent.style.height = hArr[maxHIndex] + "px";
			}else{
				var minH = Math.min.apply(null,hArr);//计算一组数组中的最小高度
				var index = getMinhIndex(hArr,minH); //获取最小高度的index索引
				aBoxes[i].style.position = "absolute";
				aBoxes[i].style.top = minH+ "px";
				//aBoxes[i].style.left = oBoxW * index + "px";
				aBoxes[i].style.left = aBoxes[index].offsetLeft + "px";
				hArr[index] += aBoxes[i].offsetHeight;
				oParent.style.height = hArr[index] + "px";
				
			}
		}
	}
}
//获取一组数据中的最小高度对应的索引值
function getMinhIndex(arr,val){
	for(var i in arr){
		if(arr[i] == val){
			return i;
		}
	}
};
//获取Class公共方法
function getByClass(oParent,sClass){
	var aEle = document.getElementsByTagName("*");
	var aResult = [];
	for(var i=0;i<aEle.length;i++){
		if(aEle[i].className == sClass){
			aResult.push(aEle[i]);
		}
	}
	return aResult;
}