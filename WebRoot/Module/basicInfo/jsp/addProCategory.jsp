<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
<title>添加产品类别</title>
<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/basicInfo.css"/>
<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/addProCategCss.css"/>
<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/basicInfo.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/proTypeInfo.js" type="text/javascript" charset="utf-8"></script>
<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
	var roleName = "${sessionScope.login_user_dep_name}";
	$(function(){
		judgeTime("addCateg");
		listProType();
	});
	//新增产品类别弹窗
	function addProCateg(){
		if(roleName=="采购" || roleName=="库房"){
			$("#proTypeName").val("");
			$("#proTypeRemark").val("");
			$("#ptID").val(0);
			$(".layer").show();
			$(".addCategDiv").show();	
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"您没有权限");
		}
	}
	//已有产品类别的编辑弹窗
	function categEditWin(ptID,typeName,typeRemark){
		if(roleName=="采购"  || roleName=="库房"){
			$("#ptID").val(ptID);
			$("#proTypeName").val(typeName).attr("alt",typeName);
			$("#proTypeRemark").val(typeRemark);
			$(".layer").show();
			$(".addCategDiv").show();
		}else{
			commonTipInfoFn($("body"),$(".alertWin"),false,"您没有权限");
		}
	}
	//关闭新增/编辑产品类别弹窗
	function closeAddCategWin(){
		$(".layer").hide();
		$(".addCategDiv").hide();
		$(".tipDiv").hide();
		$(".tip p").html("");
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
					<li class="active">
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
					<li>
						<span class="navIcon five"></span>
						<span class="tri"></span>
						<input class="hidInp" type="hidden" value="材料损耗跟踪"/>
					</li>
				</ul>
			</div>
			<!-- 左侧副导航  -->
			<div class="leftSmallNav">
				<ul>
					<li class="active"  onclick="goBasicPage('goProCategoryPage',this)"><span></span>添加产品类别</li>
					<li onclick="goBasicPage('goProPage',this)"><span></span>添加产品信息</li>
					<li onclick="goBasicPage('goBusinessPage',this)"><span></span>添加往来单位信息</li>
					<li onclick="goBasicPage('goWHStoragePage',this)"><span></span>添加仓库货架信息</li>
				</ul>
			</div>
			<!-- 右侧对应内容  -->
			<div class="rightPart hasSmaNav">
				<!-- 头部搜索框 -->
				<div class="searWrap">
					<div class="searBox comMainWid">
						<a class="addCategBtn fl" href="javascript:void(0)" onclick="addProCateg()">
							<i class="iconfont icon-tianjia addCaIcon fl"></i>
							<span class="fl">添加类别</span>
						</a>
						<div class="searchDiv margL_categ fl">
							<input type="text" id="searInput" value="请输入产品类别拼音码" class="searInp inpMargL fl"/>
							<a href="javascript:void(0)" class="searA fl" title="查询" onclick="listProType()">
								<i class="iconfont icon-search searIcon"></i>
							</a>
						</div>
					</div>
				</div>
				<!-- 暂无商品类别，提示添加 -->
				<div class="noInfoDiv">
					<img src="Module/basicInfo/images/noRecord.jpg" alt="暂无产品类别记录"/>
					<p>暂无产品类别记录，请先添加！</p>
				</div>
				<div class="mainConWrap">
					<div id="ptlist" class="mainCon comMainWid margT_categ clearfix"></div>
				</div>
			</div>
		</div>
		<div class="layer"></div>
		<!-- 增加商品类别弹窗 -->
		<div class="addCategDiv">
		   <input  type="hidden" id="ptID"/>
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAddCategWin()"></i>
			<span class="decCategSpan"><i></i></span>
			<div class="comAddCategDiv margT">
				<span>类别名称：</span>
				<input type="text" id="proTypeName" class="comInp_add" alt="" maxlength="10"/>
				<!-- input提示信息 -->
				<div id="categNaDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="proNameInfo"></p>
				</div>
				<i id="sucCategName" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddCategDiv">
				<span>类别备注：</span>
				<input type="text" id="proTypeRemark"  class="comInp_add" placeholder="最大长度不能超过20个字" maxlength="20"/>
				<!-- input提示信息 -->
				<div id="categRemDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucCategRem" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="addCategBot">
				<a href="javascript:void(0)" onclick="addProType()">添加保存</a>
			</div>
		</div>
		<!-- 模拟alert弹层 -->
		<div class="alertWin">
			<i class="iconfont fl"></i>
			<em class="fl"></em>
		</div>
</body>
</html>