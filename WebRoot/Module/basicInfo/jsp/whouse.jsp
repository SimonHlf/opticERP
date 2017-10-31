<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<link rel="stylesheet" type="text/css" href="Module/css/reset.css"/>
	<link href="Module/css/pagination.css" rel="stylesheet" />
	<link rel="stylesheet" type="text/css" href="Module/css/commonCss.css"/>
	<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/basicInfo.css"/>
	<link rel="stylesheet" type="text/css" href="Module/basicInfo/css/addWhouseInfoCss.css"/>
	<link rel="stylesheet" type="text/css" href="Module/css/iconfont.css"/>
	<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="Module/commonJs/comMethod.js" type="text/javascript" charset="utf-8"></script>
	<script src="Module/basicInfo/js/basicInfo.js" type="text/javascript" charset="utf-8"></script>
	<script src="Module/basicInfo/js/commonExec.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript" src="Module/commonJs/jquery.pagination.js"></script>
	<title>添加仓库货架信息</title>
	<script type="text/javascript">
		var page_index = 0;
		var pageSize = 8;
		var whId_s = 0;//默认选择的仓库类别编号
		var whName_s = "";//默认选择的仓库类别名称
		var whsName_q = "";//查询的货架名称
		var liNumVar = "";//仓库类别中的变量
		$(function(){
			judgeTime("addWhouseCateg");
			loadWHTypeList("init",0);
			checkCategUlHei();
		});
		//清空仓库类别下所有li的active状态
		function clearAllActive(){
			$("#categUl li").each(function(i){
				$(this).eq(i).removeClass("active");
			});
		}
		//添加仓库货架信息弹窗
		function showAddWhWin(status){
			if(status == 0){//增加
				//$("#whsName_add").attr("alt",0);
				//clearAllWHInfo();
			}else{//编辑
				//status为仓库货架编号
				getWhouseDetailInfo(status);
			}
			$(".layer").show();
			$(".addNewProDiv").show();
		}
		//获取指定货架的详细信息
		function getWhouseDetailInfo(specWhsId){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"basic.do?action=getWHSDetail",
		        data:{whsId:specWhsId},
		        success:function (json){
		        	showWhouseDetailInfo(json["result"]);
		        }
		    });
		}
		//显示指定货架的详细信息
		function showWhouseDetailInfo(list){
			var content = "";
			if(list != null){
				var whsObj = list[0];
				$("#whsName_add").attr("alt",whsObj.id);
				$("#whsName_add").val(whsObj.whsName);
				$("#selCateg").text(whsObj.whTypeInfo.whName);
				$("#selCateg").attr("alt",whsObj.whTypeInfo.id);
				$("#whsRemark_add").val(whsObj.whsRemark);
			}
		}
		//获取仓库类别列表
		function loadWHTypeList(option,whId){
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"basic.do?action=getWHSTypeList",
		        success:function (json){
		        	showWHTypeList(json["wtList"],option,whId);
		        }
		    });
		}
		//显示仓库类别列表
		function showWHTypeList(list,option,whId){
			var content = "";
			if(option == "init"){
				if(list != null){
					for(var i = 0 ; i < list.length ; i++){
						if(i == 0){
							liNumVar = "li_"+list[i].id;
							content += "<li id='li_"+list[i].id+"' class='active' onclick=showPageWSList_curr(this,'"+list[i].id+"','"+list[i].whName+"',0,'"+pageSize+"','init')>"+list[i].whName+"</li>";
						}else{
							content += "<li id='li_"+list[i].id+"' onclick=showPageWSList_curr(this,'"+list[i].id+"','"+list[i].whName+"',0,'"+pageSize+"','init')>"+list[i].whName+"</li>";
						}
					}
				}
				$("#categUl").html(content);
				showPageWSList_curr($("#"+liNumVar),list[0].id,list[0].whName,0,pageSize,"init");
				//loadWSList(list[0].id,list[0].whName,0,pageSize);
			}else if(option == "edit"){
				clearAllWHTypeInfo();
				if(list != null){
					for(var i = 0 ; i < list.length ; i++){
						content += "<li>";
						content += "<a href=javascript:void(0) onclick=editWHType('"+list[i].id+"','"+list[i].whName+"','"+list[i].whRemark+"')>";
						content += "<i class='iconfont icon-edit editIcon1'></i>";
						content += "</a>";
						content += "<span>"+list[i].whName+"</span>";
						content += "</li>";
					}
				}
				$("#eiitConUl").html(content);
				checkEditCategHei();
			}else if(option == "select"){
				if(list != null){
					for(var i = 0 ; i < list.length ; i++){
						if(whId == list[i].id){
							content += "<li class='active'>";
						}else{
							content += "<li>";
						}
						content += "<span onclick=selctWHType(this,'"+list[i].id+"','"+list[i].whName+"')>"+list[i].whName+"</span>";
						content += "</li>";
					}
				}else{
					content = "<div class='noAddCateg margL6'><img src='Module/basicInfo/images/noCategWhRec1.png' alt='暂未添加仓库类别'/></div>";
				}
				$("#selCategUl").html(content);
			}
		}
		//分页获取仓库货架列表
		function showPageWSList_curr(obj,whId,whName,page_index,pageSize,opStatus){
			whId_s = whId;
			whName_s = whName;
			if(opStatus == "init"){
				whsName_q = "";
				//$("#searInput").val("请输入货架名称");
			}
			$("#categUl li").removeClass("active");
			$(obj).addClass("active");
			liNumVar = "li_"+whId;
			//给当前li_whId的标签设置active
			var allCount = getWSCount(whId,whsName_q);//全部
		    $("#Pagination").pagination(allCount, {
		        callback: pageselectCallback,  //PageCallback() 为翻页调用次函数。
		        prev_text: "上一页",
		        next_text: "下一页 ",
		        items_per_page:pageSize,
		        current_page:page_index,
		        ellipse_text:"...",
		        num_edge_entries: 2,       //两侧首尾分页条目数
		        num_display_entries: 6   //连续分页主体部分分页条目数
		    });
		    $("#Pagination").css({
		   	 	"left":parseInt(($(".ntVerTurnPage").width() - $("#Pagination").width())/2),
		   	 	"top":15
		    });	
		}
		//获取仓库货架数量
		function getWSCount(whId,whsName){
			var count = 0;
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"basic.do?action=getWHSCount",
		        data:{whId:whId,whsName:escape(whsName)},
		        success:function (json){
		        	count = json["result"];
		        }
		    });
			return count;
		}
		//显示出列表数据
		function pageselectCallback(page_index,jq){
			loadWSList(whId_s,whName_s,page_index+1,pageSize);
		}
		
		//获取仓库货架列表
		function loadWSList(whId,whName,pageNo,pageSize){
			$("#secMenu").html(whName);
			$.ajax({
		        type:"post",
		        async:false,
		        dataType:"json",
		        url:"basic.do?action=getWHSList",
		        data:{whId:whId,whsName:escape(whsName_q),pageNo:pageNo,pageSize:pageSize},
		        success:function (json){
		        	showWSList(json["wsList"]);
		        }
		    });
		}
		//显示仓库货架列表
		function showWSList(list){
			var content = "";
			if(list.length > 0){
				$(".ntVerTurnPage").show();
				content += "<ul>";
				for(var i = 0 ; i < list.length ; i++){
					content += "<li>";
					content += "<p class='lsWid1_wh bigWid1_wh'>"+list[i].whsName+"</p>";
					content += "<p class='lsWid2_wh bigWid1_wh'>"+list[i].whTypeInfo.whName+"</p>";
					content += "<p class='lsWid3_wh bigWid1_wh'>"+list[i].whsRemark+"&nbsp;</p>";
					content += "<p class='lsWid4_wh bigWid1_wh'><a href='javascript:void(0)' onclick=showAddWhWin('"+list[i].id+"');>编辑</a></p>";
					content += "</li>";
				}
				content += "</ul>";
				$("#whInfo").html(content);
				checkCategUlHei();
			}else{
				$(".ntVerTurnPage").hide();
				$("#whInfo").html("<div class='noRecCon'><i class='iconfont icon-noListRec'></i><span>暂无仓库货架记录</span></div>");
			}	
		}
		//编辑仓库类别
		function editWHType(whId,whName,whRemark){
			$("#whId").val(whId);
			$("#whName").val(whName).attr("alt",whName);
			$("#whRemark").val(whRemark).attr("alt",whRemark);
			$("#categEditDiv_wt").hide();
		}
		//清空仓库信息
		function clearAllWHTypeInfo(){
			$("#whId").val("");
			$("#whName").val("");
			$("#whRemark").val("");
		}
		//增加仓库
		function addCateg(){
			var whName = $("#whName_add").val().replace(/\s+/g, "");
			var whRemark = $("#whRemark_add").val().replace(/\s+/g, "");
			if(whName == ""){
				$("#whName_add_tips").html("仓库名称不能为空");
				$("#categNameDiv_wh").show();
			}else{
				$.ajax({
			        type:"post",
			        async:false,
			        dataType:"json",
			        url:"basic.do?action=addWHType",
			        data:{whName:escape(whName),whRemark:escape(whRemark)},
			        success:function (json){
			        	if(json["result"] == "succ"){
			        		commonTipInfoFn($("body"),$(".alertWin"),true,"增加成功",function(){
			        			closeAddCategWin();
				        		loadWHTypeList("init",0);//刷新仓库类别列表
							});
			        	}else if(json["result"] == "fail"){
			        		commonTipInfoFn($("body"),$(".alertWin"),false,"修改失败");
			        	}else if(json["result"] == "noAbility"){
			        		commonTipInfoFn($("body"),$(".alertWin"),false,"您无权进行修改");
			        	}
			        }
			    });
			}
		}
		//增加货架时选择仓库类别
		function selctWHType(obj,whId,whName){
			$("#nowCateg_wh").html(whName);
			$("#nowCateg_wh").attr("alt",whId);
			$("#selCategUl li").removeClass("active");
			$(obj).parent().addClass("active");
		}
		//确定选择仓库类别动作
		function selectCateg(){
			var whId = $("#nowCateg_wh").attr("alt");
			var whName = $("#nowCateg_wh").text();
			$("#selCateg").text(whName);
			$("#selCateg").attr("alt",whId);
			closeSelCategWin();
		}
		//根据货架名称搜索货架信息
		function queryInfoByWhsName(){
			var whsName = $("#searInput").val().replace(/\s+/g, "");
			if(whsName == "请输入货架名称"){
				whsName = "";
			}
			whsName_q = whsName;
			showPageWSList_curr(this,whId_s,whName_s,0,pageSize,"query");
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
			<div class="leftSmallNav lfSmNavWid">
				<ul>
					<li onclick="goBasicPage('goProCategoryPage',this)"><span></span>添加产品类别</li>
					<li onclick="goBasicPage('goProPage',this)"><span></span>添加产品信息</li>
					<li onclick="goBasicPage('goBusinessPage',this)"><span></span>添加往来单位信息</li>
					<li class="active" onclick="goBasicPage('goWHStoragePage',this)"><span></span>添加仓库货架信息</li>
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
							<span class="fl">添加仓库类别</span>
						</a>
						<a class="addCategUnitBtn fr" href="javascript:void(0)" onclick="showAddWhWin(0)">
							<i class="iconfont icon-tianjia addCaIcon fl"></i>
							<span class="fl">添加仓库货架</span>
						</a>
						<div class="searchDiv margL_pro fl">
							<input type="text" id="searInput" value="请输入货架名称" class="searInp fl"/>
							<a href="javascript:void(0)" class="searA fl" title="查询" onclick="queryInfoByWhsName();">
								<i class="iconfont icon-search searIcon"></i>
							</a>
						</div>
					</div>
				</div>
				<!-- 业务单位类别层 -->
				<div class="categBox comMainWid margT_prod categHei_unit">
					<p class="titP fl">仓库类别</p>
					<div id="categUlBox" class="categUlBox fl">
						<ul id="categUl"></ul>
						<a class="setBtn" href="javascript:void(0)" title="编辑" onclick="editCategWin('whouse')">
							<i class="iconfont icon-shezhi fixIcon comTransition"></i>
						</a>
					</div>
				</div>
				<div class="mainCon comMainWid clearfix">
					<div class="listTit">
						<ul>
							<li class="lsWid1_wh bigWid1_wh">仓库货架名称</li>
							<li class="lsWid2_wh bigWid1_wh">仓库类别</li>
							<li class="lsWid3_wh bigWid1_wh">仓库货架备注</li>
							<li class="lsWid4_wh bigWid1_wh">操作</li>
						</ul>
					</div>
					<div class="listCon" id="whInfo"></div>
					<!-- 翻页  -->
					<div class="ntVerTurnPage">
						<div id="Pagination" class="pagination clearfix"></div>
					</div>
				</div>
			</div>
		</div>
		<div class="layer"></div>
		<!-- 增加仓库货架信息/编辑仓库货架信息弹窗 -->
		<div class="addNewProDiv addWhHei">
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeCommWHWindow('whsName_add','selCateg','whsRemark_add','stroageNamDiv','whCategDiv','addNewProDiv',true)"></i>
			<span class="decSpan"><i class="iconfont icon-huojia addWhIcon"></i></span>
			<div class="comAddDiv margT">
				<span>货架名称：</span>
				<input type="text" class="comInp_add" id="whsName_add" alt="0"/>
				<!-- input提示信息 -->
				<div id="stroageNamDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p>货架名称不能为空</p>
				</div>
				<i id="sucStorName" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddDiv margT">
				<span class="fl">仓库类别：</span>
				<div class="selCategDiv fl">
					<!-- 将确定的分类增加到p标签里面 -->
					<p id="selCateg" alt="0"></p>
					<a class="classifyA" href="javascript:void(0)" title="查看分类" onclick="selCateg('addWhCateg')">
						<i class="iconfont icon-fenlei2 classifyIcon"></i>
					</a>
				</div>
				<!-- input提示信息 -->
				<div id="whCategDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p>仓库类别不能为空</p>
				</div>
				<i id="sucWhCateg" class="iconfont icon-duihao sucInfoIcon1"></i>
			</div>
			<div class="comAddDiv1">
				<span>货架备注：</span>
				<input type="text" class="comInp_add1" id="whsRemark_add" placeholder="最大长度不能超过20个字" maxlength="20"/>
				<!-- input提示信息 -->
				<div id="stroageRemDiv" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucStorRem" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="addBot fl">
				<a href="javascript:void(0)" onclick="addOrEditCommWH('whsName_add','selCateg','whsRemark_add','stroageNamDiv','whCategDiv','main','addNewProDiv');">添加保存</a>
			</div>
			<!-- 查看仓库类别层 -->
			<div class="checkCategLayer">
				<p class="nowCategP">当前类别&gt&gt<span id="nowCateg_wh"></span></p>
				<div id="selCategWrap" class="selCategHei_wh">
					<ul id="selCategUl" class="clearfix"></ul>
				</div>
				<!-- 增加仓库类别/关闭按钮 -->
				<div class="selCategBot">
					<a class="addBtn btn1" href="javascript:void(0)" onclick="addNewCateg()">增加仓库类别</a>
					<a class="addBtn btn2" href="javascript:void(0)" onclick="selectCateg();">确定</a>
					<!--a class="cancelBtn" href="javascript:void(0)" onclick="closeSelCategWin()">取消</a-->
				</div>
				<!-- 增加仓库类别层 -->
				<div class="addCategBox addCategBoxHei_wh">
					<div class="comAddDiv2 margT4">
						<span>类别名称：</span>
						<input type="text" class="comInp_add2" id="wtName_add2"/>
						<!-- input提示信息 -->
						<div class="tipDiv" id="wtNameDiv_wt2">
							<span class="tipTriSpan"></span>
							<p></p>
						</div>
						<i class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="comAddDiv2">
						<span>类别备注：</span>
						<input type="text" class="comInp_add2" id="wtRemark_add2" placeholder="最大长度不能超过20个字" maxlength="20"/>
						<!-- input提示信息 -->
						<div class="tipDiv">
							<span class="tipTriSpan"></span>
							<span></span>
						</div>
						<i class="iconfont icon-duihao sucInfoIcon"></i>
					</div>
					<div class="addBotInner">
						<a class="saveBtn" href="javascript:void(0)" onclick="addCommWType('addCategBox','wtName_add2','wtRemark_add2','wtNameDiv_wt2','sub_main_1','wt')">保存</a>
						<a class="cancel" href="javascript:void(0)" onclick="cancelAddCateg('addWhCategInfo')">取消</a>
					</div>
				</div>
			</div>
		</div>
		<!-- 添加仓库类别 -->
		<div class="addCategDiv">
			<i class="iconfont icon-close closeIcon comTransition" onclick="closeWTypeWindow('','addCategDiv','whName_add','whRemark_add','categNameDiv_wh')"></i>
			<span class="decCategSpan"><i></i></span>
			<div class="comAddCategDiv margT">
				<span>类别名称：</span>
				<input type="text" class="comInp_add" id="whName_add" maxlength=20/>
				<!-- input提示信息 -->
				<div id="categNameDiv_wh" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p id="whName_add_tips"></p>
				</div>
				<i id="sucCategNam_wh" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="comAddCategDiv">
				<span>类别备注：</span>
				<input type="text" class="comInp_add" id="whRemark_add" placeholder="最大长度不能超过20个字" maxlength="20"/>
				<!-- input提示信息 -->
				<div id="categRemDiv_wh" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				<i id="sucCategRem_wh" class="iconfont icon-duihao sucInfoIcon"></i>
			</div>
			<div class="addCategBot">
				<a href="javascript:void(0)" onclick="addCommWType('addCategDiv','whName_add','whRemark_add','categNameDiv_wh','main','wt')">添加保存</a>
			</div>
		</div>
		<!--仓库类别编辑层 -->
		<div class="editCategWin editHei_wh">
			<div class="editWinTop">
				<p>编辑仓库类别</p>
				<i class="iconfont icon-close closeIcon_2 comTransition" onclick="closeWTypeWindow('whId','editCategWin','whName','whRemark','categEditDiv_wt')"></i>
			</div>
			<div id="editConDiv" class="editCon">
				<ul id="eiitConUl"></ul>
			</div>
			<div class="editBot">
				<input type="hidden" id="whId"/>
				<div class="comEditCategDiv margRedit">
					<span>类别名称：</span>
					<input type="text" class="comInp_edCateg" id="whName" alt="" placeholder="如：镜片仓库"/>
					<div id="categEditDiv_wt" class="tipDiv">
					<span class="tipTriSpan"></span>
					<p></p>
				</div>
				</div>
				<div class="comEditCategDiv">
					<span>类别备注：</span>
					<input type="text" class="comInp_edCateg" id="whRemark" alt=""/>
				</div>
			</div>
			<a class="saveEditBtn" href="javascript:void(0)" onclick="editCommWType('whId','whName','whRemark','categEditDiv_wt','editCategWin','main','wt')";">保存</a>
		</div>
		<!-- 模拟alert弹层 -->
		<div class="alertWin">
			<i class="iconfont fl"></i>
			<em class="fl"></em>
		</div>
	</body>
</html>
