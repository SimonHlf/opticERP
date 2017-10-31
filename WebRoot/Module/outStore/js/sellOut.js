//提交销售、外协加工出库
function addSellOut(){
	var bcId = $("#purVal").attr("alt");
	var contactName = $("#contactName").val();
	var totalPrice = $("#totalPrice").val();
	var allPrice_tr_flag = true;
	//var outNo = $("#outNo").val();//出库单编号
	//var expNo = $("#expNo").val();//出库单编号
	var num = $("#purListTable tr").length;//产品出库记录条数
	var proIdStr = "";
	var proPriceStr = "";
	var proNumStr = "";
	var proTotalPriceStr = "";
	$(".cAllPrice").each(function(i){
		if($(".cAllPrice").eq(i).html() == 0.00){
			allPrice_tr_flag = false;
			return false;
		}
	});
	if(bcId == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先选择业务往来单位");
	}else if(contactName == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写客户名称");
	}
	/*else if(outStatus == 2 && outNo == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"出库单编号不能为空");
	}else if(outStatus == 2 && expNo == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"快递单号不能为空");
	}*/
	else if(totalPrice == "" && totPriceSta == 1){//代表销售出库
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写合同总价");
	}else if(!checkInputNumberOrFloat(totalPrice) && totPriceSta == 1){
		commonTipInfoFn($("body"),$(".alertWin"),false,"合同价格应为大于0的小数或整数");
	}else if(num == 0){
		commonTipInfoFn($("body"),$(".alertWin"),false,"出库记录不能为空");
	}else if(!allPrice_tr_flag){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写完整产品出库信息");
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
		$(".cAllPrice").each(function(i){
			proTotalPriceStr += $(".cAllPrice").eq(i).html()+",";
		});
		proTotalPriceStr = proTotalPriceStr.substring(0,proTotalPriceStr.length - 1);
		var posStr = proIdStr + ":" + proPriceStr + ":" + proNumStr + ":" + proTotalPriceStr;//出库详情列表(格式为商品编号,单价,出库数量,总价 )
		$.ajax({
			type:"post",
			async:false,
			dataType:"json",
			data:{/*outNo:outNo,*/bId:bcId,bUserName:escape(contactName),aPrice:totalPrice,oType:outStatus,/*expNo:expNo,*/posStr:posStr},
			url:"outStore.do?action=addSellOut",
			success:function(json){
				if(outStatus==1){
				   switchNav($("#sellOut"),1);
				}else if(outStatus==0){//外协
				   switchNav($("#madeOut"),0);
				}
			}
		});
	}
}
//浏览销售出库和外协加工出库
function listSellOut(pageNo){
	var sTime = "" ;
	var eTime = "";
	var oSta=-1;
	var bcId=-1;
	var oNo="";
	if(sel_option == "otherOpt"){
		sTime = $("#sTime").val();
		eTime = $("#eTime").val();
		if(sTime >　eTime){
			commonTipInfoFn($("body"),$(".alertWin"),false,"起始时间不能大于结束时间");
		}
		oSta=$("input[name='compStaInp']:checked").val();
		if(oSta==undefined){
			oSta=-1;
		}
		bcId=$("#compNaInp").attr("alt");
	}else if(sel_option == "orderOpt"){
		oNo=$("#queryOutStNum").val();
		if(oNo=="请输入销售出库单号"){
			commonTipInfoFn($("body"),$(".alertWin"),false,"销售出库单号不能为空");
			return;
		}else if(oNo == "请输入外协加工出库单号"){
			commonTipInfoFn($("body"),$(".alertWin"),false,"外协加工出库单号不能为空");
		}
	}
	getPriceSum(sTime,eTime,oSta,bcId,oNo);
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osNo:oNo,
			sDate:sTime,
			eDate:eTime,
			o_sta:oSta,
			bid:bcId,
			pageNo:pageNo,
			oType:outStatus},
		url:"outStore.do?action=listOutSellInfo",
		success:function(json){
			var maincon="";
			if(json.length != 0){
				$("#paginationPar").show();
				$.each(json, function(row, obj) {
					maincon += '<li class="mainLi"><div id="mainBoxDiv_'+ obj.osInfo.id +'" class="mainBox">';
					maincon += '<h3><span>出库单 OutStoring Order</span><em>制单日期：'+getLocalDate(obj.osInfo.outDate)+'</em></h3>';
					/* toWhere 出库单编号 */
					maincon += '<div class="outStTitDiv"><p class="outStUn">To：'+obj.osInfo.businessContactInfo.bcName+'</p>';
					if(roleName=="库房"&& obj.osInfo.outSNo == ""){
						maincon+='<p class="outStOrdNum">出库单编号：<input id="outStNumInp'+obj.osInfo.id+'" value="'+ genSelloNum() +'" class="comOutStInp" type="text"/><span id="outStNumSpan'+ obj.osInfo.id +'"></span><i class="iconfont icon-edit editIcon" title="填写" onclick="showEditInp(1,'+obj.osInfo.id+','+obj.osInfo.outStatus+')"></i></p>';
					}else{
						maincon+='<p class="outStOrdNum">出库单编号：<input id="outStNumInp'+obj.osInfo.id+'" value="'+ obj.osInfo.outSNo +'" class="comOutStInp" type="text"/><span id="outStNumSpan'+ obj.osInfo.id +'">'+obj.osInfo.outSNo+'</span></p>';	
					}
					maincon += '</div>';
					/* 编号 物料名称...title层*/
					maincon += '<ul class="outStOrdLisTit clearfix">';
					maincon += '<li class="listLiWid1">编号</li><li class="listLiWid2">物料名称</li><li class="listLiWid6">材质</li><li class="listLiWid4">规格</li><li class="listLiWid3">单位</li><li class="listLiWid5 noBorLi">出库数量</li>';
					maincon += '</ul>';
					/* 编号 物料名称...data层*/
					$.each(obj.ossInfo, function(row1, obj1) {
						var count = row1+1;
						maincon+='<ul class="outStOrdLisCon clearfix"><li class="listLiWid1">'+count+'</li>';
						maincon+='<li class="listLiWid2">'+obj1.productInfo.proName+'</li>';
						maincon+='<li class="listLiWid6">'+obj1.productInfo.proCz+'</li>';
						maincon+='<li class="listLiWid4">'+obj1.productInfo.proSpec+'</li>';
						maincon+='<li class="listLiWid3">'+obj1.productInfo.proUnit+'</li><li class="listLiWid5 noBorLi">'+obj1.proNumber+'</li></ul>';
					});
					/* 快递单号 完成状态 */
					maincon+='<div class="outStOrdBotDiv">';
					if(roleName=="库房"){	
						if($("#expInp"+obj.osInfo.id).val() == ""){//增加快递单号
							maincon+='<p>快递单号：<input id="expInp'+obj.osInfo.id+'" class="comOutStInp" type="text"/><span id="expSpan'+ obj.osInfo.id +'"></span><i class="iconfont icon-edit editIcon" title="填写" onclick="showEditInp(2,'+obj.osInfo.id+','+obj.osInfo.outStatus+')"></i></p>';
						}else{//编辑快递单号
							maincon+='<p>快递单号：<input id="expInp'+obj.osInfo.id+'" class="comOutStInp" value="'+ obj.osInfo.expressNo +'" type="text"/><span id="expSpan'+ obj.osInfo.id +'">'+ obj.osInfo.expressNo +'</span><i class="iconfont icon-edit editIcon" title="编辑" onclick="showEditInp(2,'+obj.osInfo.id+','+obj.osInfo.outStatus+')"></i></p>';
						}
					}else if(roleName=="外协"){ 
						maincon+='<p>快递单号：<span>'+obj.osInfo.expressNo+'</span></p>';	
					}
					if(obj.osInfo.outStatus==0){
						maincon+='<p>完成状态：<span class="noCompSpan">未完成</span></p>';
					}else if(obj.osInfo.outStatus==1){
						maincon+='<p>完成状态：<span class="compSpan">完成</span></p>';
					}
					maincon += '</div>';
					/* 制单人 出库人 出库时间 */
					maincon+='<div id="otStBotDiv'+ obj.osInfo.id +'" class="outStOrdBotDiv2"><p>制单人：'+obj.osInfo.outUserName+'</p><p>出库人：'+obj.osInfo.outUserName+'</p><p>出库时间：'+getLocalDate(obj.osInfo.outDate)+'</p>';
					if(roleName=="库房"){
						maincon+='<input type="hidden" id="tmpNo'+obj.osInfo.id+'" value="'+obj.osInfo.outSNo+'"/>';
						maincon+='<a id="saveABtn'+ obj.osInfo.id +'" class="saveBtnA" href="javascript:void(0)" onclick="updateOutSell('+obj.osInfo.id+')">保存</a>';
					}
					maincon += '</div>';
					/*总金额 实付金额 */
					maincon += '<div class="outStOrdBotDiv2">';
					maincon += '<i class="iconfont icon-payHistory viewPayHisIcon" onclick="showPayHistory('+ obj.osInfo.id +')" title="查看付款记录"></i>';
					if(obj.osInfo.outStatus==0){//未完成状态下财务身份增加付款按钮
						if(roleName == "财务"){
							maincon += '<a class="payABtn" onclick="showPayDiv('+obj.osInfo.allPrice+','+obj.osInfo.actPrice+','+obj.osInfo.id+')" href="javascript:void(0)">';
							if(outStatus==1){
								maincon+='回款</a>';
								$("#payT").text("回");
							}else if(outStatus==0){
								maincon+='付款</a>';
								$("#payT").text("付");
							}
						}
					}
					maincon += '<em>实付金额：'+obj.osInfo.actPrice+'元</em><em>总金额：'+obj.osInfo.allPrice+'元</em>';
					maincon += '</div>';
					/* 查看付款历史记录 */
					maincon += '<div id="payHisLayerDiv_'+ obj.osInfo.id +'" class="payHisLayer">';
					maincon += '<div class="payHisTit">';
					maincon += '<p class="payHisNum">出库单编号：'+ obj.osInfo.outSNo +'</p>';
					maincon += '<p class="payHisAcc">实付金额：'+obj.osInfo.actPrice+'元</p></div>';
					maincon += '<p class="payHisLisTit"><span class="widTwo">付款时间</span><span class="widTwo">付款金额(元)</span></p>';
					maincon += '<div id="payHisListDiv_'+ obj.osInfo.id +'" class="comPayHisDiv"></div>';
					maincon += '<div class="closePayLayDiv"><i class="iconfont icon-guanbi payHisClose" title="关闭" onclick="closePayLayDiv('+ obj.osInfo.id +')"></i></div>';
					maincon += '</div>';
					
					/* 父级结束标签 */
					maincon += '</div></li>';
				});
				$("#purOrdUl").html(maincon);
				waterFall("purOrdUl","mainLi");
			}else{
				if(totPriceSta == 1){
					$("#purOrdUl").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无销售出库记录</span></div>");
				}else{
					$("#purOrdUl").html("<div class='noRecCon'><i class='iconfont icon-noListRec noListRec_1'></i><span>暂无外协加工出库记录</span></div>");
				}
				$("#paginationPar").hide();
			}
			
		}
	});
}
//财务身份下的付款
function showPayDiv(allPrice,actPrice,osId){
	$("#allMoney").text(allPrice);
	$("#payedMoney").text(actPrice);
	$("#noPayedMoney").text((parseFloat(allPrice)-parseFloat(actPrice)).toFixed(2));
	$("#poId_pay").val(osId);
	$(".layer").show();
	$(".goPayDiv").show();
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
	//queryOrder(option_a);
}
//查看付款记录
function showPayHistory(poId){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osId:poId},
		url:"outStore.do?action=listPayReOutInfo",
		success:function(json){
			if(json.length != 0){
				var con='<ul>';
				$.each(json, function(row, obj) {
					con+='<li><p class="widTwo">'+getLocalDate(obj.repDate)+'</p><p class="widTwo">'+obj.repMoney+'元</p></li>';
				});
				con+="</ul>"
				$("#payHisListDiv_"+poId).html(con);
			}else{
				$("#payHisListDiv_"+poId).html('<div class="noPayHisDiv"><i class="iconfont icon-noListRec"></i><p>暂无付款记录</p></div>');
			}
		}
	});
	$("#payHisLayerDiv_"+poId).show().height($("#mainBoxDiv_"+poId).height() - 41);
	$("#payHisListDiv_"+poId).height($("#payHisLayerDiv_"+poId).height() - 105);
	if($("#payHisListUl_"+poId).height() > $("#payHisListDiv_"+poId).height()){
		var scroll = "<div id='scrollPar_"+poId+"' class='parScrollHis'><div id='scrollSon_"+poId+"' class='sonScrollHis'></div></div>";
		$("#payHisListDiv_"+poId).append(scroll);
		$("#scrollPar_"+poId).height($("#payHisListDiv_"+poId).height());
		scrollBar("payHisListDiv_"+poId,"payHisListUl_"+poId,"scrollPar_"+poId,"scrollSon_"+poId,15);
	}
	$("#payHisListDiv_"+poId +" li:odd").addClass("oddColor");
}
//关闭付款记录窗口
function closePayLayDiv(poId){
	$("#payHisLayerDiv_"+poId).hide();
}
//总条数
function listOutSellCount(){
	var sTime = "" ;
	var eTime = "";
	var oSta=-1;
	var bcId=-1;
	var oNo="";
	if(sel_option == "otherOpt"){
		sTime = $("#sTime").val();
		eTime = $("#eTime").val();
		oSta=$("input[name='compStaInp']:checked").val();
		if(oSta==undefined){
			oSta=-1;
		}
		bcId=$("#compNaInp").attr("alt");
	}else if(sel_option == "orderOpt"){
		oNo=$("#queryOutStNum").val();
		if(oNo=="请输入销售出库单号"){
			//alert("出库单号不能为空!");
			//commonTipInfoFn($("body"),$(".alertWin"),false,"出库单号不能为空");
			return;
		}
	}
	var proCount=0;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osNo:oNo,
			sDate:sTime,
			eDate:eTime,
			o_sta:oSta,
			bid:bcId,
			oType:outStatus},
		url:"outStore.do?action=outSellCount",
		success:function(json){
			proCount=json;
		}
	});
	return proCount;
}

//分页显示往来单位
function listoutSellPage(){
	var pc=listOutSellCount();
	$("#pagination").pagination(pc,{
        callback: pageselectCallback,  //PageCallback() 为翻页调用次函数。
        prev_text: "上一页",
        next_text: "下一页 ",
        items_per_page:10,
        ellipse_text:"...",
        num_edge_entries: 2,       //两侧首尾分页条目数
        num_display_entries: 10  //连续分页主体部分分页条目数
    });
	function pageselectCallback(page_index, jq){
		listSellOut(page_index+1);
	}
	$("#pagination").css({
   	 	"left":parseInt(($("#paginationPar").width() - $("#pagination").width())/2),
   	 	"top":0
    });
}
//清除
function clearcomp(){
	$("#compNaInp").val("");
	$("#compNaInp").attr("alt","-1");
	$("#delOptComp_sell").hide();
}
//更新销售 外协出库单
function updateOutSell(osID){
	var osNo = $("#outStNumInp" + osID).val();
	var expNo =$("#expInp"+osID).val();
	var oNo =$("#tmpNo"+osID).val();
	if(osNo == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"出库单号不能为空");
		return;
	}
	if(checkOrder(osNo)&&osNo!=oNo){
		commonTipInfoFn($("body"),$(".alertWin"),false,"出库单号重复");
		return;
	}
	if(expNo==""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"快递单号不能为空");
		return;
	}
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osID:osID,
			osNo:osNo,
			expNo:expNo},
		url:"outStore.do?action=updateOutSell",
		success:function(json){
			if(json){
				commonTipInfoFn($("body"),$(".alertWin"),true,"更新成功",function(){
					window.location.reload();
				});
			}else{
				commonTipInfoFn($("body"),$(".alertWin"),false,"更新失败");
			}
		}
	});
}

//判断销售，价格出库单号是否重复
function checkOrder(oNo){
	var flag = false;
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{oiNo:oNo,
			otype:outStatus
			},
		url:"outStore.do?action=checkSelloNo",
		success:function(json){
			flag = json;
		}
	});
	return flag;
}
//判断销售，价格出库单号是否重复
function genSelloNum(){
	var osNo="";
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{
			otype:outStatus
			},
		url:"outStore.do?action=genSellNum",
		success:function(json){
			osNo=json;
		}
	});
	return osNo;
}
//获取应收账款  实收账款总额  未收账款金额 
function getPriceSum(stime,etime,osta,bcid,ono){
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osNo:ono,
			sDate:stime,
			eDate:etime,
			o_sta:osta,
			bid:bcid,
			oType:outStatus},
		url:"outStore.do?action=getPriceSum",
		success:function(json){
			$("#allp").text(json["allPrice"]+"元")
			$("#actp").text(json["actPrice"]+"元")
			$("#unp").text(json["unPrice"]+"元")
		}
	});
}
//更新实付金额
function payMoney(){
	var actPrice = $("#currPayMoney").val();
	var osId=$("#poId_pay").val();
	var noMoney = $("#noPayedMoney").text();
	if(parseFloat(actPrice) > parseFloat(noMoney)){
		commonTipInfoFn($("body"),$(".alertWin"),false,"付款金额不能大于实付金额");
		return;
	}
	$.ajax({
		type:"post",
		async:false,
		dataType:"json",
		data:{osId:osId,
			actPrice:actPrice,
			repStatus:outStatus},
		url:"outStore.do?action=updateActPrice",
		success:function(json){
			if(json){
				commonTipInfoFn($("body"),$(".alertWin"),true,"付款成功",function(){
					window.location.reload();
				});
			}else{
				commonTipInfoFn($("body"),$(".alertWin"),false,"付款失败");
			}
		}
	});
}