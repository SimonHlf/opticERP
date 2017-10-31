<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>领料出库</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/pagination.css" />
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<link rel="stylesheet" type="text/css" href="Module/outStore/css/pickingOutStore.css"/>
<link rel="stylesheet" type="text/css" href="Module/outStore/css/commonFrame.css"/>
<link rel="stylesheet" type="text/css" href="Module/commonJs/timeControl/css/ion.calendar.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/outStore/js/pickOutStore.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
<script type="text/javascript">
var creScroll = true;
var dbFlag = true;
var pageSize = 8;
var page_index_p = 0;//选择产品
var option_tr="outStore";
var pTypeId_a=0;
var pyCode_p_a ="";
var selOption="Otheropt";
var roleName = "${sessionScope.login_user_dep_name}";
var pickOption = "comOut";//普通领料
$(function(){
	$("#newMadeInfo").hide();
	$("#makeFm").text(getCurrDate("date"));
	judgeTime_1();
	convert();
	if(roleName != "库房"){
		var contentInfo = '<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览领料出库单</a>';
		if(roleName == "财务" || roleName == "董事长"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_p()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
		}
		$("#divInfo").html(contentInfo);
		selPurchaseTab(2);
	}
	genOrder();
});
//导出领料出库
function downInfoToExcel_p(){
	var outNo = $("#queryInsNum").val();
	var proid = $("#o_proid").val();
	var o_sta = $("#otSta").val();
	var sDate = $("#sTime").val();
	var eDate = $("#eTime").val();
	if(selOption=="Otheropt"){
		//查询时候存在数据
		if(listOsCount() > 0){
			window.location.href = "outStore.do?action=exportPInfoToExcel&proid="+proid+"&o_sta="+o_sta+"&sDate="+sDate+"&eDate="+eDate;
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"没有数据，不能进行导出");
		}
	}else{
		commonTipInfoFn($("body"),$(".alertWin"),false,"根据出库单号查询结果不能导出Excel");
	}
}
//新增领料出库单、浏览领料出库单 导航的tab切换
function selPurchaseTab(options){
	$("#newMadeInfo").hide();
	$(".searBox a").removeClass("active");
	if(options == 1){//新增采购单
		$(".newAddOutStDiv").show();
		$(".viewOutStDiv").hide();
		$("#addNewPurBtn").addClass("active");
		clearOption1();
		$("#excelS").html("");
	}else if(options == 2){//浏览采购单
		$(".viewOutStDiv").show();
		$(".newAddOutStDiv").hide();
		$("#viewPurBtn").addClass("active");
		clearOption2();
		//choiceOptionAns($(".comStrogStaInp"),"active",1);
		//choiceOptionAns($(".payStaInput"),"active",2);
		//初始分页查询采购订单（近三天的所有订单）
		//queryOrder(0);
		listoutstorePage();
		var contentInfo = "";
		if(roleName == "库房"){
			contentInfo += '<a id="excelTag" class="excelBtn fr" href="javascript:void(0)" onclick="downInfoToExcel_p()">';
			contentInfo += '<i class="iconfont icon-excel excelIcon fl"></i>';
			contentInfo += '<span class="fl">导出Excel</span></a>';
			$("#excelS").html(contentInfo);
		}
	}
}
function addNewOutStRec(options){
	var oNum = $("#o_no").val();
	var oAppUser = $("#applyUser").val();
	if(oNum == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请先填写出库单编号");
	}else if(oAppUser == ""){
		commonTipInfoFn($("body"),$(".alertWin"),false,"请填写申请人");
	}else{
		var flag = false;
		if(options == 0){//表示首次进来页面暂无出库记录列表
			flag = true;
		}else{
			if($("#proName").html() == ""){//如果产品名称为空则不能再增加一行空的tr
				flag = false;
			}else{
				flag = true;
			}
		}
		if(flag){//产品名称不为空
			var strTrTd = "<tr id='nullTr'>";
			var oldColor = "";
			var num = $("#outStListTab tr").length + 1;
			strTrTd += "<td class='outStWid1' align='center'>"+ num +"</td>";//序号
			strTrTd += "<td class='outStWid2 proNameTd' align='center'><p id='proName'></p><i class='iconfont icon-more moreIcon' onclick='showCorrUnProInfDiv(1)' title='选择产品'></i></td>";//产品名称
			strTrTd += "<td class='outStWid3 proNumCodeTd' align='center'></td>";//产品编码
			strTrTd += "<td class='outStWid4' align='center'></td>";//产品规格
			strTrTd += "<td class='outStWid8' align='center'></td>";//材质要求
			strTrTd += "<td class='outStWid9' align='center'></td>";//基本单位
			strTrTd += "<td class='outStWid5' align='center'></td>";//库存量
			strTrTd += "<td class='outStWid5 pNumClass' align='center' ondblclick='editElement(this)'></td>";//出库量
			strTrTd += "<td class='outStWid6 noBorR' align='center'><i class='iconfont icon-delete deleteIcon' title='删除' onclick='clearCurrPro(this)'></i></td>";//删除
			strTrTd += "</tr>";
			num++;
			$("#outStListTab").append(strTrTd);
			$("#outStListTab tr:odd").addClass("oddBgColor");//增加隔行换色
			if(options == 0){//表示首次进来页面暂无采购记录列表
				checkPurListLen();
			}
		}
	}
	
}
//检测新增出库单有无记录
function checkPurListLen(){
	if($("#outStListTab tr").length != 0){
		$(".noRecDiv").hide();
		$(".addTrDiv").show();
	}
}
//根据产品类别的高度来动态创建模拟滚动条
function createLeftScroll(){
	if($("#categDataUlPro").height() > $("#categDataDivPro").height()){
		//创建模拟滚动条
		var scroll = "<div id='scrollPar' class='parScroll'><div id='scrollSon' class='sonScroll'></div></div>";
		if(creScroll){
			$(".proCategDataDiv").append(scroll);
			scrollBar("categDataDivPro","categDataUlPro","scrollPar","scrollSon",15);
		}
		creScroll = false;
	}
}
//新增出库单下选取商品的数据层弹窗
function showCorrUnProInfDiv(options){
	if(options == 1){//选取商品
		option_tr="outStore";
		$("#selAll").hide();
	}else if(options==2){
		option_tr="outSto";	
		$("#selAll").hide();
	}else if(options == 3){//加工领料时
		
	}
	$("#dataListTab_pro").html("");
	getCommonType("pType");
	$(".outStInfoDiv").show();
	createLeftScroll();
	inpTipFocBlur("searInput_pro","请输入产品拼音码","#999","#666");
	$(".layer").show();	
}
//关闭选取供应商 选取产品弹窗的公共关闭
function closeAlertWin(obj){
	$(obj).hide();
	$(".layer").hide();
	$("#Pagination_pro").hide();
}
//双击转换可编辑状态
/*function editElement(obj){
	//dbFlag 为了防止当创建input文本框后用户如果再不断点击就会把input的html传入元素的文本节点中
    var oldHtml = obj.innerHTML;
    var newObjInp = document.createElement("input");
    if(dbFlag){
        newObjInp.type = "text";
        newObjInp.value = oldHtml;
        newObjInp.className = "comEditInp";
      	//当创建input时清空原有元素的内容
        obj.innerHTML = "";
     	//设置选择文本的内容或设置光标位置（两个参数：start,end；start为开始位置，end为结束位置；如果开始位置和结束位置相同则就是光标位置）
        newObjInp.setSelectionRange(0, oldHtml.length);
    }
    obj.appendChild(newObjInp);
    dbFlag = false;
  	//设置获得光标
    newObjInp.focus();
    newObjInp.onblur = function(){    	
    	obj.innerHTML = this.value == oldHtml ? oldHtml : this.value;
    	dbFlag = true;
    };
}*/
//浏览入库购单下头部的查询
function changeSearch(options){
	$(".selCondP label").removeClass("active");
	if(options == 1){//根据新增入库单时间查询
		$("#addInsTimSearLab").addClass("active");
		$(".searLayer").animate({"left":599});
		clearOption2();
		selOption="Otheropt";
	}else if(options == 2){//根据入库单号查询
		clearOption1();
		$("#insNumSearLab").addClass("active");
		$(".searLayer").animate({"left":0});
		inpTipFocBlur("queryInsNum","请输入出库单号","#999","#666");
		selOption="orderopt";
	}
}
//清空查询条件2
function clearOption2(){
	$("#queryInsNum").val("请输入出库单号");
	$("#sTime").val("${requestScope.sTime}");
	$("#eTime").val("${requestScope.eTime}");
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
				<li class="active"><span></span><a href="outStore.do?action=goPickingOutStore">领料出库</a></li>
				<li><span></span><a href="outStore.do?action=goSellOut&option=1">销售出库</a></li>
				<li><span></span><a href="outStore.do?action=goSellOut&option=0">外协加工出库</a></li>
			</ul>
		</div>
		<!-- 右侧对应内容  -->
		<div class="rightPart hasSmaNav">
			<!-- 头部搜索框 -->
			<div class="searWrap">
				<div class="searBox comMainWid">
					<p id="divInfo">
						<a id="addNewPurBtn" class="active" href="javascript:void(0)" onclick="selPurchaseTab(1)">新增领料出库单</a>
						<span>|</span>
						<a id="viewPurBtn" href="javascript:void(0)" onclick="selPurchaseTab(2)">浏览领料出库单</a>
						<span id="excelS"></span>
					</p>
				</div>
			</div>
			<!-- 新增出库单  -->
			<div class="mainCon comMainWid newAddOutStDiv clearfix">
				<!-- 出库单编号层  -->
				<div class="selBusDiv clearfix">
					<div class="comSelDiv fl">
						<span>出库单编号：</span>
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
						<input type="text" id="o_no" class="specInpWid" />
						<!-- input提示信息 -->
						<div id="outStNumTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p id="o_no_info"></p>
						</div>
						<i id="sucOtStNum" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv specDivWid  fl">
						<span>申请人：</span>
						<input id="applyUser" class="specInpWid" type="text"/>
						<!-- input提示信息 -->
						<div id="appUserTipDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="sucAppUser" class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comSelDiv fl" id="newMadeInfo">
						<span>新产品编码：</span>
						<input type="text" class="specInpWid" id="newMadeCode" maxlength="15"/>
						<!-- input提示信息 -->
						<div id="newProCodDiv" class="tipDiv" >
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i id="succNewProCod" class="iconfont icon-duihao sucInfoIcon"></i>
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
							<td class="outStWid5" align="center">出库量</td>
							<td class="outStWid6 noBorR" align="center">操作</td>
						</tr>
					</table>
					<table id="outStListTab" class="outStListTab" cellpadding="0" cellspacing="0"></table>
					<div class="noRecDiv noRecDivPos1">
						<a href="javascript:void(0)" onclick="addNewOutStRec(0)">
							<i class="iconfont icon-noRecord noRecIcon"></i>
							<span>单击增加出库记录</span>
						</a>
					</div>
					<div class="addTrDiv" title="增加一条记录">
						<img class="addTrBtn" src="Module/purchase/images/addPic.png" alt="增加一条记录" onclick="addNewOutStRec(1)"/>
					</div>
				</div>
				<!-- 出库数据汇总层  -->
				<input  type="hidden" id="otSta" value="-1"/>
				<div class="subOutStDataDiv">
					<div class="margL fr">
						<span class="fl">备注：</span>
						<input id="remark" type="text" placeholder="最多不超过20个字" maxlength="20"/>
					</div>
					<div class="margL fr">
						<span class="fl">领料状态：</span>
						<label for="commOutStIn">
							<input type="radio" id="commOutStIn" name="outStStaInpNam" class="comCategStyInp" value="0"/>
							<em>普通领料</em>
							<span class="cirSpan"></span>
							<!--  i class="iconfont icon-duihao"></i-->
						</label>
						<label for="madeOutStInp" class="marglLab">
							<input type="radio" id="madeOutStInp" name="outStStaInpNam"  class="comCategStyInp" value="1"/>
							<em>加工领料</em>
							<span class="cirSpan"></span>
						</label>
					</div>
					<div class="margL fr">
						<span class="fl">制单日期：</span>
						<p class="fl" id="makeFm"></p>
					</div>
					<div class="margL fr">
						<span class="fl">制单人：</span>
						<p class="fl">${sessionScope.login_real_name}</p>
					</div>
				</div>
				<!-- 出库单数据提交按钮  -->
				<a class="submitOutStBtn fr" href="javascript:void(0)" onclick="addOutInfo()">提交</a>
			</div>
			<!-- 浏览采购单  -->
			<div class="mainCon comMainWid viewOutStDiv clearfix">
				<!-- 根据采购订单单号查询、根据新增采购单时间查询  -->
				<div class="queryDiv clearfix">
					<p class="selCondP">
						<label id="addInsTimSearLab" class="active" onclick="changeSearch(1)">
							<span class="cirSpan"></span>
							<span>根据新增领料出库单时间查询</span>
							<i class="iconfont icon-duihao selSearIcon"></i>
						</label>
						<label id="insNumSearLab" class="marglLab" onclick="changeSearch(2)">
							<span class="cirSpan"></span>
							<i class="iconfont icon-duihao selSearIcon"></i>
							<span>根据领料出库单号查询</span>
						</label>
						<a href="javascript:void(0)" class="showHideA fr" onclick="showHideQueryBox()">
							<em class="comTransition"></em>
							<span>隐藏</span>
						</a>
					</p>
					<div class="queryPar clearfix">
						<div class="queryBox fl">
							<div class="comQueryDiv timeCon">
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
								<span>领料状态：</span>
								<label for="commOutStIn_vie">
									<span class="cirSpan"></span>
									<input type="radio" id="commOutStIn_vie" name="outStInpNam_vie" class="comCategStyInp" value="0"/>
									<span>普通领料</span>
								</label>
								<label for="madeOutStInp_vie">
									<span class="cirSpan"></span>
									<input type="radio" id="madeOutStInp_vie" name="outStInpNam_vie"  class="comCategStyInp" value="1"/>
									<span>加工领料</span>
								</label>
							</div>
							<div class="comQueryDiv">
								<!-- 选择产品名称  -->
								<div class="selQueryDiv">
									<span>产品名称：</span>
									<input  type="hidden" id="o_proid" value="-1" />
									<input id="proNaInp" type="text"/>
									<i class='iconfont icon-more moreIcon' title='选择产品' onclick="showCorrUnProInfDiv(2)"></i>
									<i id="delPro" class="iconfont icon-close clearIcon" title="清除" onclick="clearProName()"></i>
								</div>
							</div>
							<a class="queryStaBtn" href="javascript:void(0)" onclick="listoutstorePage()">查询</a>
						</div>
						<div class="queryBox fl">
							<p class="searchPurNum fl">
								<input type="text" id="queryInsNum" value="请输入出库单号" class="searInp_outStNum fl"/>
								<a href="javascript:void(0)" class="searA fl" onclick="listoutstorePage()" title="查询">
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
				<div class="viewOutStoreDiv">
					<ul id="purOrdUl" class="outStOrdUl clearfix"></ul>
				</div>
				<div id="pagViewTurn" class="comTurnPagDiv">
					<div id="pagination" class="pagination clearfix"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="layer"></div>
	<!-- 选择产品数据弹窗  -->
	<div class="comAlertDiv outStInfoDiv">
		<div class="comDataTop">
			<p>选择产品</p>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAlertWin($('.outStInfoDiv'))"></i>
		</div>
		<div class="searLay">
			<!-- 根据拼音码搜索层  -->
			<div class="searchDiv">
				<input type="text" id="searInput_pro" value="请输入产品拼音码" class="searInp fl"/>
				<a href="javascript:void(0)" class="searA fl" onclick="showProductList(0)" title="查询">
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
					<ul id="categDataUlPro" class="categDataUl">
						<!-- li下增加active状态为当前选中  -->
						<li><span></span><i class="iconfont icon-mingpian cardIcon"></i><p class="ellip">百货</p></li>
						<li><span></span><i class="iconfont icon-mingpian cardIcon"></i><p>文具</p></li>
						<li><span></span><i class="iconfont icon-mingpian cardIcon"></i><p>沙硅</p></li>
						<li><span></span><i class="iconfont icon-mingpian cardIcon"></i><p>学习用具</p></li>
					</ul>
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
				<div id="proTurnPage" class="comTurnPagDiv">
					  <div id="Pagination_pro" class="pagination clearfix"></div>
				</div>
				<div class="botDiv">
					<label class="selAllLab" onclick="selectAllPro()" id="selAll">
						<span class="checkSpan"></span>
						<input type="checkbox" id="selAllPro" />
						<span class="selAllTxt" >全选</span>
						<!--  i class="iconfont icon-duihao choiceAct"></i-->
					</label>
					<!-- 选中保存按钮  -->
					<a class="saveDataBtn fr" href="javascript:void(0)" onclick="insertProList()">确定</a>
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