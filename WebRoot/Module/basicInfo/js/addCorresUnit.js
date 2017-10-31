//选择银行
function selBank(){
	$(".addBankBox").show().animate({"opacity":0.9});
	if($(".selBankDiv p").html() == ""){
		$("#nowBank").html("暂未选择银行");
	}
	choiceOptionBankCard();
}
function closeSelBankWin(){
	$(".addBankBox").animate({"opacity":0},function(){
		$(".addBankBox").hide();
		if($(".bankMidWinDiv li b").length > 0){
			$(".bankMidWinDiv li").removeClass("active");
			$(".bankMidWinDiv li b").remove();
		}
	});
}
//新增银行卡和更换银行卡
function choiceOptionBankCard(){
	$(".com_BankRdio").each(function(){
		$(this).on("click",function(){
			$(this).attr("checked",true);
			$(".bankMidWinDiv li").removeClass("active");
			$(this).parent("li").addClass("active");
			$(this).parent("li").append("<b></b>").siblings().find('b').remove();
			$("#nowBank").html($(this).val());
		});
	});
}
//添加往来单位类别
function addBizType(nPara,rPara,tipdiv,tipEle,opt){
	if(roleName=="采购" || roleName=="库房"){
		var btName =  $("#"+nPara).val();
	    var btRemark=  $("#"+rPara).val();
	    if(btName == ""){
			$("#"+tipdiv).show();
			$("#"+tipEle).html("类别名称不能为空");
		}else if(btName.length >= 8){
			$("#"+tipdiv).show();
			$("#"+tipEle).html("类别名称长度不能超过8位");
		}else{
			if(checkExistBsType("btName") || checkExistBsType("bizTname")){
				$("#"+tipdiv).show();
				$("#"+tipEle).html("该类别已存在");
			}else{
				$("#"+tipdiv).hide();
				$("#"+tipEle).html("");
				$.ajax({
					type:"post",
					dataType:"json",
					async:false,
					data:{btName:escape(btName),
						  btRemark:escape(btRemark)
						 },
					url:"bizcontact.do?action=addBizType",
					success:function(json){
						if(json==true){
							commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
								listBizType("listBizType");
								listBizType("addBiz");
								$("#"+nPara).val("");
								$("#"+rPara).val("");
								if(opt == "addOuter"){
									closeAddCategWin();
								}else if(opt == "addInner"){
									cancelAddCateg("addCorrUnInfo");
								}
							});
						}else{
							commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
						}
					}
				});
	      }
	   }
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"您没有权限");
	}
}
//获取往来单位类别
function listBizType(para){
	$.ajax({
		type:"post",
		dataType:"json",
		url:"bizcontact.do?action=listBizType",
		success:function(json){
			if(para=="addBiz"){
				var bizT="";
				if(json.length != 0){
					$.each(json, function(row, obj) {
					  var btName=obj.btName;
					  bizT+='<li onclick="addBiztype(this,this.innerHTML,'+obj.id+')">'+btName+'</li>';
					});
					$("#selCategUl").html(bizT);
				}else{
					var noCategRecStr = "<div class='noAddCateg margL4'><img src='Module/basicInfo/images/noCategUnit1.png' alt='暂未添加业务往来单位类别'/></div>";
					$("#selCategUl").append(noCategRecStr);
				}
			}else if(para=="listBizType"){
				if(json==""){
					var noCategRecStr = "<div class='noAddCateg margL3'><img src='Module/basicInfo/images/noCategUnit.png' alt='暂未添加业务单位类别' onclick='showAddCategWin()'/></div>";
					$("#categUlBox").append(noCategRecStr);
				}
				var bizT="<li id='li_0' class='ellip' onclick=listBizContactPage(0,'全部',1) alt=全部>全部</li>";
				$.each(json, function(row, obj) {
				  var btName=obj.btName;
				  bizT += '<li id=li_'+obj.id+' onclick="listBizContactPage('+obj.id+',\''+btName+'\',1)" alt="'+obj.btName+'">'+btName+'</li>';
				});
				$("#categUl").html(bizT);
				$("#secMenu").html($("#categUl li:first").html());
				$("#categUl li:first").attr("class","active");
				$(".setBtn").show();
				checkCategUlHei();
			}else if(para=="updateBizType"){
				var bizT="";
				$.each(json, function(row, obj) {
					  var btName=obj.btName;
					  bizT+='<li onclick="editBizType('+obj.id+',\''+btName+'\',\''+obj.btRemark+'\')"><a href="javascript:void(0)"><i class="iconfont icon-edit editIcon1"></i></a><span>'+btName+'</span></li>';
				});
					$("#eiitConUl").html(bizT);
					checkEditCategHei();
				}
			}
	});
}

//更新往来单位类别
function updateBizType(){
	if(roleName=="采购"  || roleName=="库房"){
		var btID=$("#bizTypeID").val();
		var btName =$("#new_bizTypeName").val();
		var btRemark=$("#new_bizTypeREM").val();
		var tempName =$("#temp_bizTypeName").val();
	/*	if(btName==tempName){
			listBizType("updateBizType");
			listBizType("listBizType");
			closeEditCategWin();
			return;
		}*/
		if(btName==""){
			commonTipInfoFn($("body"),$(".alertWin"),false,"往来单位类型名称不能为空");
			return;
		}else if(btName.length >= 8){
			commonTipInfoFn($("body"),$(".alertWin"),false,"类别名称长度不能超过8位");
			return;
		}
		if(btName!=tempName){
			if(checkExistBsType("new_bizTypeName")){
				commonTipInfoFn($("body"),$(".alertWin"),false,"该类别已存在");
				return;
			}
		}
		$.ajax({
			type:"post",
			dataType:"json",
			async:false,
			data:{btID:btID,
				btName:escape(btName),
				btRemark:escape(btRemark)
				 },
			url:"bizcontact.do?action=updateBizType",
			success:function(json){
				if(json==true){
					commonTipInfoFn($("body"),$(".alertWin"),true,"更新成功",function(){
						listBizType("updateBizType");
						listBizType("listBizType");
						$("#new_bizTypeName").val("");
						$("#new_bizTypeREM").val("");
						$("#temp_bizTypeName").val("");
						closeEditCategWin();
					});
				}else{
					commonTipInfoFn($("body"),$(".alertWin"),false,"更新失败");
				}
			}
		});
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"您没有权限");
	}
}
//往来单位拼音码
function getPinyinCode(){
	var bcName=$("#bcName").val();
	if(bcName == ""){
		$("#compNameDiv").show();
		$("#bcNameInfo").html("单位名称不能为空");
		return;
	}else{
		$("#compNameDiv").hide();
	}
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		data:{
			bcName:escape(bcName)
			 },
		url:"bizcontact.do?action=getPinyinCode",
		success:function(json){
			$("#bc_py").val(json);
		}
	});
}
//选中往来单位类别
function addBiztype(obj,btName,btID){
	$("#nowCateg_unit").text(btName);
	$("#bizTypeID").val(btID);
	$("#selCategUl li").removeClass("active");
	$(obj).addClass("active");
}
//选择往来单位类别
function saveBiztype(){
	if($("#nowCateg_unit").text() == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择单位类别");
	}else{
		$("#new_bizType").text($("#nowCateg_unit").text());
		closeSelCategWin();
	}
}
//选择银行
function saveNewBank(){
	if($("#nowBank").text() == "" || $("#nowBank").text() == "暂未选择银行"){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请选择银行");
	}else{
		$("#bankName").text($("#nowBank").text());
		closeSelBankWin();
	}
}
//当前需要编辑的往来单位类别
function editBizType(btID,btName,btRemark){
	$("#bizTypeID").val(btID);
	$("#new_bizTypeName").val(btName);
	$("#temp_bizTypeName").val(btName);
	$("#new_bizTypeREM").val(btRemark);
}
//关闭添加、修改单位窗体
function closeAddProdWin_curr(){
	$(".addNewProDiv").hide();
	$(".layer").hide();
	$(".tipDiv").hide();
	$(".tipDiv p").html("");
	$("#bcId").val("0").attr("alt","");
	$("#bizTypeID").val("0")
}
//添加往来单位
function addBizContact(){
		var bcName = $("#bcName").val();
		var bcName_base = $("#bcId").attr("alt");//传递过来的单位名称
		var bcAddress = $("#bcAddress").val();
		var bcContact =$("#bcContact").val();
		var bcTel = $("#bcTel").val();
		var bcMobile = $("#bcMobile").val();
		var bcFax =$("#bcFax").val();
		var bcEmail = $("#bcEmail").val();
		var bcBankName = $("#bankName").text();
		var bcBankNo = $("#bankAcc").val();	
		var bcId = $("#bcId").val();
		var bcTypeID = $("#bizTypeID").val();
		var bcPy = $("#bc_py").val();
		if(bcName == ""){
			$("#compNameDiv").show();
			$("#bcNameInfo").html("单位名称不能为空");
			return;
		}else{
			if(checkExistBc("bcName") && bcName_base != bcName){
				$("#compNameDiv").show();
				$("#bcNameInfo").html("已存在该单位");
				return;
			}else{
				$("#compNameDiv").hide();
			}
		}
		if(bcTypeID == 0){
			$("#compCategDiv").show();
			$("#bcTypeIdInfo").html("单位类别不能为空");
			return;
		}else{
			$("#compCategDiv").hide();
		}
		if(bcContact == ""){
			$("#compContDiv").show();
			$("#bContactInfo").html("联系人不能为空");
			return;
		}else if(checkInputStr(bcContact,"xm")){
			$("#compContDiv").show();
			$("#bContactInfo").html("联系人必须为2-8位中文");
			return;
		}else{
			$("#compContDiv").hide();
		}
		if(bcTel != ""){
			if(checkInputStr(bcTel,"tel")){
				$("#compTelDiv").show();
				$("#bcTelInfo").html("单位联系电话格式错误");
				return;
			}else{
				$("#compTelDiv").hide();
			}
		}else{
			$("#compTelDiv").hide();
		}
		if(bcMobile != ""){
			if(checkInputStr(bcMobile,"mobile")){
				$("#compPhoneDiv").show();
				$("#bcMobileInfo").html("单位联系手机格式错误");
				return;
			}else{
				$("#compPhoneDiv").hide();
			}
		}else{
			$("#compPhoneDiv").hide();
		}
		if(bcFax != ""){
			if(checkInputStr(bcFax,"tel")){
				$("#compFaxDiv").show();
				$("#bcFaxInfo").html("单位传真格式错误");
				return;
			}else{
				$("#compFaxDiv").hide();
			}
		}else{
			$("#compFaxDiv").hide();
		}
		if(bcEmail != ""){
			if(checkInputStr(bcEmail,"email")){
				$("#compEmailDiv").show();
				$("#bcEmailInfo").html("单位电子邮箱格式错误");
				return;
			}else{
				$("#compEmailDiv").hide();
			}
		}else{
			$("#compEmailDiv").hide();
		}
		if(bcBankName != "" && bcBankNo == ""){
			$("#compBankNaDiv").hide();
			$("#compBankNum").show();
			$("#bcBankNumInfo").html("银行卡号不能为空");
			return;
		}else if(bcBankName == "" && bcBankNo != ""){
			$("#compBankNum").hide();
			$("#compBankNaDiv").show();
			$("#bcBankNameInfo").html("开户银行不能为空");
			return;
		}else{
			$("#compBankNum").hide();
			$("#compBankNaDiv").hide();
		}
		if(bcId==0){
		    $.ajax({
				type:"post",
				dataType:"json",
				async:false,
				data:{
					bcName:escape(bcName),
					bcTypeID:bcTypeID,
					bcPy:escape(bcPy),
					bcAddress:escape(bcAddress),
					bcContact:escape(bcContact),
					bcTel:bcTel,
					bcMobile:bcMobile,
					bcFax:bcFax,
					bcEmail:bcEmail,
					bcBankName:escape(bcBankName),
					bcBankNo:bcBankNo
					 },
				url:"bizcontact.do?action=addBizContact",
				success:function(json){
					if(json==true){
						commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
							closeAddProdWin_curr();
							listBizContactPage(bcTypeId_a,$("#li_"+bcTypeId_a).attr("alt"),1);
						});	
					}else{
						commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
					}
				}
		    }); 
		 }else{
			 $.ajax({
					type:"post",
					dataType:"json",
					async:false,
					data:{
						bcId:bcId,
						bcName:escape(bcName),
						bcTypeID:bcTypeID,
						bcPy:escape(bcPy),
						bcAddress:escape(bcAddress),
						bcContact:escape(bcContact),
						bcTel:bcTel,
						bcMobile:bcMobile,
						bcFax:bcFax,
						bcEmail:bcEmail,
						bcBankName:escape(bcBankName),
						bcBankNo:bcBankNo
						 },
					url:"bizcontact.do?action=updateBizContact",
					success:function(json){
						if(json==true){
							commonTipInfoFn($("body"),$(".alertWin"),true,"保存成功",function(){
								closeAddProdWin_curr();
								listBizContactPage(bcTypeId_a,$("#li_"+bcTypeId_a).attr("alt"),1);
							});	
						}else{
							commonTipInfoFn($("body"),$(".alertWin"),false,"保存失败，请重试");
						}
					}
			    }); 
		 }
}
//获取往来单位列表
function getBizContact(bcID,bcPY,pageNo){
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		data:{
			typeId_c:bcID,
			py_c:bcPY,
			pageNo:pageNo
			 },
		url:"bizcontact.do?action=listPageBizContact",
		success:function(json){
				var biz="<ul>";
				$.each(json, function(row, obj){
					$(obj).each(function(nrow,nobj){ 
						biz+='<li><p class="lsWid1_un bigWid1_un ellip">'+nobj.bcName+'<p>';
						biz+='<p class="lsWid2_un bigWid2_un">'+nobj.bcPy+'<p>';
						biz+='<p class="lsWid2_un bigWid2_un">'+nobj.businessTypeInfo.btName+'</p>';
						if(nobj.bcContact==""){
							biz+='<p class="lsWid2_un bigWid2_un">&nbsp;</p>';
						}else{
							biz+='<p class="lsWid2_un bigWid2_un">'+nobj.bcContact+'</p>';
						}
						if(nobj.bcTel==""){
							biz+='<p class="lsWid3_un bigWid3_un">&nbsp;</p>';
						}else{
							biz+='<p class="lsWid3_un bigWid3_un">'+nobj.bcTel+'</p>';
						}
						if(nobj.bcMobile==""){
							biz+='<p class="lsWid3_un bigWid3_un">&nbsp;</p>';
						}else{
							biz+='<p class="lsWid3_un bigWid3_un">'+nobj.bcMobile+'</p>';
						}
						if(nobj.bcFax==""){
							biz+='<p class="lsWid3_un bigWid3_un">&nbsp;</p>';
						}else{
							biz+='<p class="lsWid3_un bigWid3_un">'+nobj.bcFax+'</p>';
						}
						if(nobj.bcEmail==""){
							biz+='<p class="lsWid3_un bigWid3_un ellip">&nbsp;<p>';
						}else{
							biz+='<p class="lsWid3_un bigWid3_un ellip">'+nobj.bcEmail+'<p>';
						}
						if(nobj.bcBankName==""){
							biz+='<p class="lsWid3_un bigWid3_un ellip">&nbsp;</p>';
						}else{
							biz+='<p class="lsWid3_un bigWid3_un ellip">'+nobj.bcBankName+'</p>';
						}
						biz+='<p class="lsWid2_un bigWid2_un"><a href="javascript:void(0)" onclick="updateBizContact('+nobj.id+')">查看编辑</a><p></li>';
					}); 
				});
				biz+="</ul>";
				$("#listBiz").html(biz);
				checkCategUlHei();
		}
	});
	if($("#listBiz li").length == 0){
		$(".ntVerTurnPage").hide();
		$("#listBiz").html('<div class="noRecCon"><i class="iconfont icon-noListRec"></i><span>暂无单位信息</span></div>');
	}else{
		$(".ntVerTurnPage").show();
	}
}
//根据条件获取往来单位几率数
function getBizContactCount(bcID,bcPY){
	var bizCount;
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		data:{
			typeId_c:bcID,
			py_c:bcPY
			 },
		url:"bizcontact.do?action=getBizContactCount",
		success:function(json){
			bizCount =json["result"];
		}
	});
	return bizCount;
}
//分页显示往来单位
function listBizContactPage(bcID,btName,pageNo){
	bcTypeId_a = bcID;//单位类别
	if(btName!=''){
		$("#secMenu").text(btName);
	}
	$("#categUl li").removeClass("active");
	$("#li_"+bcID).addClass("active");
	var bcPY=$("#searInput").val();
	if(bcPY=='请输入单位拼音码'){
		bcPY='';
	}
	var pc=getBizContactCount(bcID,bcPY);
	$("#pagination").pagination(pc, {
        callback: pageselectCallback,  //PageCallback() 为翻页调用次函数。
        prev_text: "上一页",
        next_text: "下一页 ",
        items_per_page:10,
        ellipse_text:"...",
        num_edge_entries: 2,       //两侧首尾分页条目数
        num_display_entries: 10  //连续分页主体部分分页条目数
    });
	function pageselectCallback(page_index, jq){
		getBizContact(bcID,bcPY,page_index+1);
	}
	$("#pagination").css({
   	 	"left":parseInt(($(".ntVerTurnPage").width() - $("#pagination").width())/2),
   	 	"top":15
    });
}

//修改指定往来单位信息
function updateBizContact(id){
	$.ajax({
		type:"post",
		dataType:"json",
		async:false,
		url:"bizcontact.do?action=listBizContactById&bcId="+id,
		success:function(json){
			$.each(json, function(row, obj) {
				$("#bcName").val(obj.bcName);
				$("#bcId").attr("alt",obj.bcName);
				$("#new_bizType").text(obj.businessTypeInfo.btName);
				$("#bizTypeID").val(obj.businessTypeInfo.id);
				$("#bc_py").val(obj.bcPy);
				$("#bcContact").val(obj.bcContact);
				$("#bcTel").val(obj.bcTel);
				$("#bcMobile").val(obj.bcMobile);
				$("#bcFax").val(obj.bcFax);
				$("#bcEmail").val(obj.bcEmail);
				$("#bankName").text(obj.bcBankName);
				$("#bankAcc").val(obj.bcBankNo);
				$("#bcAddress").val(obj.bcAddress);
			});
			$("#bcId").val(id);
			showAddUnitWin(id);
		}
	});
}
//清空添加往来单位
function cleanBizConinfo(){
	$("#bcName").val("");
	$("#new_bizType").text("");
	$("#bc_py").val("");
	$("#bcContact").val("");
	$("#bcTel").val("");
	$("#bcMobile").val("");
	$("#bcFax").val("");
	$("#bcEmail").val("");
	$("#bankName").text("");
	$("#bankAcc").val("");
	$("#bcAddress").val("");
	$("#bcId").val(0);
}