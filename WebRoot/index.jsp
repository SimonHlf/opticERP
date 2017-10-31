<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 
<html>
  <head>
    <title>镜片车间ERP管理系统登录</title>
	<link id="resetLink" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" type="text/css" href="Module/login/css/login.css"/>
	<script src="Module/commonJs/jquery-1.7.2.min.js" type="text/javascript" charset="utf-8"></script>
	<script src="Module/commonJs/device.min.js" type="text/javascript" charset="utf-8"></script>
	<script type="text/javascript">
			$(function(){
				checkDevice();
			});
			function checkDevice(){
				if(device.mobile() || device.ipad()){
					var strMeta = '<meta name="viewport" content="width=device-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">';
					$("#parHead").append(strMeta);
					var cliWid = document.documentElement.clientWidth;
					$("#resetLink").attr("href","Module/css/phoneReset.css");
					$(".logBox").addClass("margTopPhone");
					if(cliWid < 380){
						$(".logBox img").addClass("phoneLogImg");
					}
					//document.addEventListener('touchmove', function (e) { e.preventDefault(); }, false);
				}else{
					$("#resetLink").attr("href","Module/css/reset.css");
					$(".logBox").addClass("margTopPc");
				}
			}
			//登录1
			function login(){
				var account = $("#userName").val();
				var password = $("#passwrod").val();
				if(account == ""){
					alert("账号不能为空");
					$("#userName").focus();
				}else if(password == ""){
					alert("密码不能为空");
					$("#passwrod").focus();
				}else{
					$.ajax({
				        type:"post",
				        async:false,
				        dataType:"json",
				        url:"login.do?action=processLogin",
				        data:{userName:account,password:password},
				        success:function (json){
				        	proccessLogin(json);
				        }
				    });
				}
			}
			//登录2
			function proccessLogin(list){
				if(list["result"] == "success"){
					var udObj =	 list["udList"];
					var depLength = udObj.length;
					if(depLength == 1){
						window.location.href = "login.do?action=goPage&depId="+udObj[0].departmentInfo.id+"&depName="+escape(escape(udObj[0].departmentInfo.depName));
					}else{
						listRole(list["udList"]);
					}
				}else if(list["result"] == "unlaw"){
					alert("输入非法字符");
					$("#userName").focus();
				}else if(list["result"] == "lock"){
					alert("账号被锁定");
				}else{
					alert("账号密码错误");
				}
			}
			//显示角色
			function listRole(list){
				$("#selectRoleWindowDiv").show();
			  	var t='<span>部门选择</span><select id="depId" style="width:110px;">';
			  	var f='<option value="-1">---请选择---</option>';
				var options = '';
				if(list==null){
					
				}else{
					for(i=0; i<list.length; i++){
					  options +=  "<option value='"+list[i].departmentInfo.id+"'>"+list[i].departmentInfo.depName+"</option>";
					}
				}
				var h='</select> ';
				var btn='<a href="javascript:void(0)" class="enterSys" id="groupLoginButton" onclick="goPage();">进入系统</a>';
				$('#selectDep').html(t+f+options+h+btn);
			}
			//成功导向
			function goPage(){
				var depId = $("#depId").val();
				var depName = $("#depId").find("option:selected").text();
				if(depId == -1){
					alert("请选择一个身份进入系统");
				}else{
					window.location.href = "login.do?action=goPage&depId="+depId+"&depName="+escape(escape(depName));
				}
			}
			//回车事件
			function enterPress(e){
				var e = e || window.event;
				if(e.keyCode == 13){
					login();
				}
			}
		</script>
  </head>
  
  <body>
    <div class="imgBg">
		<img src="Module/login/images/loginBg.jpg"/>
	</div>
	<div class="logBox">
		<img src="Module/login/images/logoImg.png" alt="镜片车间ERP管理系统"/>
		<div class="comInpDiv">
			<span class="txtSpan fl">账号：</span>
			<input type="text" id="userName" class="comInp fl" onkeypress="enterPress(event)"/>
		</div>
		<div class="comInpDiv">
			<span class="txtSpan fl">密码：</span>
			<input type="password" id="passwrod" class="comInp fl" onkeypress="enterPress(event)"/>
		</div>
		<a class="loginBtn" href="javascript:void(0)" onclick="login();"></a>
	</div>
	<!-- 身份选择 -->
	<div id='selectRoleWindowDiv' style="display:none;">
		<p>系统检测到您有多重身份，请选择一个身份进入系统！</p>
		<div id='selectDep'></div>
	</div>
  </body>
</html>
