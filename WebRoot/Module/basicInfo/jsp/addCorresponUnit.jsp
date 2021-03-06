<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
		<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
		<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/basicInfo.css"/>
		<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/addCorrUnitCss.css"/>
		<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
		<link href="Module/css/pagination.css" rel="stylesheet" />
		<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
		<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
		<script src="Module/commonJs/checkStr.js" type="text/javascript" charset="utf-8"></script>
		<script src="Module/basicInfo/js/basicInfo.js" type="text/javascript" charset="utf-8"></script>
		<script src="Module/basicInfo/js/addCorresUnit.js" type="text/javascript" charset="utf-8"></script>
		<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
		<title>添加业务往来单位信息</title>
		<script type="text/javascript">
			var bcTypeId_a = "0";//单位类别筛选框对应的编号
			var roleName = "${sessionScope.login_user_dep_name}";
			$(function(){
				judgeTime("addCorrUnit");
				listBizType("listBizType");
				bankNumPattern("bankAcc","pattbBankNum");
				listBizContactPage(0,0,'',1);
			});
			//添加单位信息弹窗
			function showAddUnitWin(sta){
				if(roleName=="采购" || roleName=="库房"){
					if(sta==0){
						cleanBizConinfo();
					}
					$(".layer").show();
					$(".addNewProDiv").show();
				}else{
					commonTipInfoFn($("body"),$(".alertWin"),false,"您没有权限");
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
					<li onclick="goBasicPage('goProCategoryPage',this)"><span></span>添加产品类别</li>
					<li onclick="goBasicPage('goProPage',this)"><span></span>添加产品信息</li>
					<li class="active"  onclick="goBasicPage('goBusinessPage',this)"><span></span>添加往来单位信息</li>
					<li onclick="goBasicPage('goWHStoragePage',this)"><span></span>添加仓库货架信息</li>
				</ul>
			</div>
			<!-- 右侧对应内容  -->
			<div class="rightPart hasSmaNav">
				<!-- 头部搜索框 -->
				<div class="searWrap">
					<div class="searBox comMainWid">
						<p class="fl">
							全部&nbsp;&gt;
							<a href="javascript:void(0)">
								<span id="secMenu"></span>
							</a>
							<span class="gtSpan">&gt;</span>
						</p>
						<a class="addCategUnitBtn fr" href="javascript:void(0)" onclick="showAddCategWin()">
							<i class="iconfont icon-tianjia addCaIcon fl"></i>
							<span class="fl">添加单位类别</span>
						</a>
						<a class="addCategBtn fr" href="javascript:void(0)" onclick="showAddUnitWin(0)">
							<i class="iconfont icon-tianjia addCaIcon fl"></i>
							<span class="fl">添加单位</span>
						</a>
						<div class="searchDiv margL_pro fl">
							<input type="text" id="searInput" value="请输入单位拼音码" class="searInp fl"/>
							<a href="javascript:void(0)" class="searA fl" title="查询" onclick="listBizContactPage()">
								<i class="iconfont icon-search searIcon"></i>
							</a>
						</div>
					</div>
				</div>
				<!-- 业务单位类别层 -->
				<div class="categBox comMainWid margT_prod categHei_unit">
					<p class="titP fl">单位类别</p>
					<div id="categUlBox" class="categUlBox fl">
						<ul id="categUl"></ul>
						<a class="setBtn" href="javascript:void(0)" title="编辑" onclick="editCategWin('biz')">
							<i class="iconfont icon-shezhi fixIcon comTransition"></i>
						</a>
					</div>
				</div>
				<div class="mainCon comMainWid clearfix">
					<div class="listTit">
						<ul>
							<li class="lsWid1_un bigWid1_un ellip">单位名称</li>
							<li class="lsWid2_un bigWid2_un">拼音码</li>
							<li class="lsWid2_un bigWid2_un">单位类别</li>
							<li class="lsWid2_un bigWid2_un">联系人</li>
							<li class="lsWid3_un bigWid3_un">联系电话</li>
							<li class="lsWid3_un bigWid3_un">联系手机</li>
							<li class="lsWid3_un bigWid3_un">单位传真</li>
							<li class="lsWid3_un bigWid3_un">电子邮箱</li>
							<li class="lsWid3_un bigWid3_un">开户银行</li>
							<li class="lsWid2_un bigWid2_un">操作</li>
						</ul>
					</div>
					<div class="listCon" id="listBiz"></div>
					<!-- 翻页  -->
					<div class="ntVerTurnPage">
						<div id="pagination" class="pagination clearfix"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="layer"></div>
		<!-- 增加业务单位/编辑业务单位弹窗 -->
		<input  type="hidden" id="bcId" alt=""/>
		<div class="addNewProDiv addUnHei">
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAddProdWin_curr()"></i>
			<span class="decSpan"><i class="iconfont icon-commpany addUnitIcon"></i></span>
			<div class="comAddDiv margT">
				<span>单位名称：</span>
				<input type="text" class="comInp_add" id="bcName" onblur="getPinyinCode()"/>
				<!-- input提示信息 -->
				<div id="compNameDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcNameInfo"></p>
				</div>
				<i id="sucCompName" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv margT">
				<span class="fl">单位类别：</span>
				<div class="selCategDiv fl">
					<!-- 将确定的分类增加到p标签里面 -->
					<p id="new_bizType"></p>
					<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCateg('addCorrUint')">
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
			<div class="comAddDiv">
				<span>拼<i class="blank"></i>音<i class="blank"></i>码：</span>
				<input type="text" class="comInp_add" id="bc_py"/>
				<!-- input提示信息 -->
				<div id="compSimpDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucCompSimp" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span>联<i class="blank"></i>系<i class="blank"></i>人：</span>
				<input type="text" class="comInp_add" id="bcContact"/>
				<!-- input提示信息 -->
				<div id="compContDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bContactInfo"></p>
				</div>
				<i id="sucCompCont" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span>联系电话：</span>
				<input type="text" class="comInp_add" id="bcTel"/>
				<!-- input提示信息 -->
				<div id="compTelDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcTelInfo"></p>
				</div>
				<i id="sucCompTel" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span>联系手机：</span>
				<input type="text" class="comInp_add" id="bcMobile"/>
				<!-- input提示信息 -->
				<div id="compPhoneDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcMobileInfo"></p>
				</div>
				<i id="sucCompPhone" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span>单位传真：</span>
				<input type="text" class="comInp_add" id="bcFax"/>
				<!-- input提示信息 -->
				<div id="compFaxDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcFaxInfo"></p>
				</div>
				<i id="sucCompFax" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span>电子邮箱：</span>
				<input type="text" class="comInp_add" id="bcEmail"/>
				<!-- input提示信息 -->
				<div id="compEmailDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcEmailInfo"></p>
				</div>
				<i id="sucCompEmail" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv">
				<span class="fl">开户银行：</span>
				<div class="selBankDiv fl">
					<!-- 将确定的银行名称增加到p标签里面 -->
					<p id="bankName"></p>
					<a class="classifyA" href="javascript:void(0)" title="选择银行" onclick="selBank()">
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
				<input type="text" id="pattbBankNum" class="patternDiv" readonly />	
				<!-- input提示信息 -->
				<div id="compBankNum" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="bcBankNumInfo"></p>
				</div>
				<i id="sucCompBankNum" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv1">
				<span>单位地址：</span>
				<input type="text" class="comInp_add1" id="bcAddress"/>
				<!-- input提示信息 -->
				<div id="compAddDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucCompAdd" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="addBot fl">
				<a href="javascript:void(0)" onclick="addBizContact()">添加保存</a>
			</div>
			<!-- 查看业务单位类别层 -->
			<div class="checkCategLayer">
				<input id="bizTypeID" type="hidden" value="0"/>
				<p class="nowCategP">当前类别&gt&gt<span id="nowCateg_unit"></span></p>
				<div id="selCategWrap" class="selCategHei_un">
					<ul id="selCategUl" class="clearfix">
						
					</ul>
				</div>
				<!-- 增加单位类别/关闭按钮 -->
				<div class="selCategBot">
					<a class="addBtn btn1" href="javascript:void(0)" onclick="addNewCateg()">增加单位类别</a>
					<a class="addBtn btn2" href="javascript:void(0)" onclick="saveBiztype()">保存</a>
				</div>
				<!-- 增加业务单位类别层 -->
				<div class="addCategBox addCategBoxHei_un">
					<div class="comAddDiv2 margT3">
						<span>类别名称：</span>
						<input id="bizTname" type="text" class="comInp_add2"/>
						<!-- input提示信息 -->
						<div id="bizdiv" class="tipDiv">
							<span class="tipTriSpan"></span>
							<span id="bizinfo"></span>
						</div>
						<i class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comAddDiv2">
						<span>类别备注：</span>
						<input id="bizTremark" type="text" class="comInp_add2"/>
						<!-- input提示信息 -->
						<div class="tipDiv">
							<span class="tipTriSpan"></span>
							<span></span>
						</div>
						<i class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="addBotInner">
						<a class="saveBtn" href="javascript:void(0)" onclick="addBizType('bizTname','bizTremark','bizdiv','bizinfo','addInner')">保存</a>
						<a class="cancel" href="javascript:void(0)" onclick="cancelAddCateg('addCorrUnInfo')">取消</a>
					</div>
				</div>
			</div>
			<!--选择银行弹层 -->
			<div class="addBankBox">
				<p class="nowBankP">当前银行&gt&gt<span id="nowBank"></span></p>
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
				<!-- /关闭按钮 -->
				<div class="selCategBot">
					<a class="addBtn btn2 btnMargL" href="javascript:void(0)" onclick="saveNewBank()">保存</a>
					<a class="cancelBtn" href="javascript:void(0)" onclick="closeSelBankWin()">关闭</a>
				</div>
			</div>
		</div>
		<!-- 添加业务往来单位类别 -->
		<div class="addCategDiv">
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeAddCategWin()"></i>
			<span class="decCategSpan"><i></i></span>
			<div class="comAddCategDiv margT">
				<span>类别名称：</span>
				<input type="text" class="comInp_add" id="btName"/>
				<!-- input提示信息 -->
				<div id="categNameDiv_un" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="cateNameInfo"></p>
				</div>
				<i id="sucCategNam_un" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddCategDiv">
				<span>类别备注：</span>
				<input type="text" class="comInp_add" id="btRemark"/>
				<!-- input提示信息 -->
				<div id="categRemDiv_un" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucCategRem_un" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="addCategBot">
				<a href="javascript:void(0)" onclick="addBizType('btName','btRemark','categNameDiv_un','cateNameInfo','addOuter')">添加保存</a>
			</div>
		</div>
		<!--往来单位类别编辑层 -->
		<div class="editCategWin editHei_un">
			<div class="editWinTop">
				<p>编辑单位类别</p>
				<i class="iconfont icon-close closeIcon_2 comTransition" onclick="closeEditCategWin()"></i>
			</div>
			<div id="editConDiv" class="editCon">
				<ul id="eiitConUl"></ul>
			</div>
			<div class="editBot">
				<div class="comEditCategDiv margRedit">
					<span>类别名称：</span>
					<input id="temp_bizTypeName" type="hidden"/>
					<input id="new_bizTypeName" type="text" class="comInp_edCateg" placeholder="如：镜片耗材类"/>
					<!-- input提示信息 -->
					<div id="edit_categNameDiv_un" class="tipDiv">
						<span class="tipTriSpan"></span>
						<p id="edit_cateNameInfo"></p>
					</div>
					<i id="sucCategNam_un" class="iconfont icon-duihao sucInfoIcon"></i>
				</div>
				<div class="comEditCategDiv">
					<span>类别备注：</span>
					<input type="text" id="new_bizTypeREM" class="comInp_edCateg"/>
				</div>
			</div>
			<a class="saveEditBtn" href="javascript:void(0)" onclick="updateBizType()">保存</a>
		</div>
		<!-- 模拟alert弹层 -->
		<div class="alertWin">
			<i class="iconfont fl"></i>
			<em class="fl"></em>
		</div>
	</body>
</html>
