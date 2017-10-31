/**
 * 检查验证类方法集合
 */

//检查是否存在该单位
function checkExistBc(bcName){
	var flag = false;
	var bcName = $("#"+bcName).val().replace(/\s+/g, ""); 
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{bcName:escape(bcName)},
	    url:"bizcontact.do?action=checkExistBsInfo",
	    success:function (json){
	    	flag = json["result"];
	    }
	});
	return flag;
}
//检查是否存在该单位类别
function checkExistBsType(typeName){
	var flag = false;
	var btName = $("#"+typeName).val().replace(/\s+/g, ""); 
	$.ajax({
		type:"post",
	    async:false,
	    dataType:"json",
	    data:{btName:escape(btName)},
	    url:"bizcontact.do?action=checkExistBtInfo",
	    success:function (json){
	    	flag = json["result"];
	    }
	});
	return flag;
}
//检查只能输入正整数或者两位以内的小数(输入正确返回true)
function checkInputNumberOrFloat(str){
	var rel = new RegExp(/^\d+(\.\d{1,2})?$/);
	if(rel.test(str)){
		return true;
	}else{
		return false;
	}
}
//保留2位小数
function toDecimal(str){
    return Math.round(str*100)/100; 
}
//验证必须为数字(合格为false)
function checkIsNumeric(str){
	var reg = new RegExp(/[^0-9]/g);
	return reg.test(str);
}
//验证必须为正整数(合格为true)
function checkIsNumber(str){
	var reg = new RegExp(/^[1-9]\d*$/);
	return reg.test(str);
}
//验证输入项正则表达式（合格返回false）
function checkInputStr(str,type){
	var rel = "";
	if(type == "xm"){
		rel = new RegExp(/^[\u4e00-\u9fa5 ]{2,8}$/); //2-8位中文（合格为false）
	}else if(type == "tel"){
		rel = new RegExp(/^0\d{2,3}-?\d{7,8}$/);//验证电话号码
	}else if(type == "mobile"){
		rel = new RegExp(/^1\d{10}$/);//验证手机号码
	}else if(type == "email"){
		rel = new RegExp(/^(\w-*\.*)+@(\w-?)+(\.\w{2,})+$/);//验证邮箱
	}
	if(!rel.test(str)){
		return true;
	}else{
		return false;
	}
}
//验证输入项必须是字母+数字
function checkInputStr_1(str){
	var rel = new RegExp(/^[0-9a-zA-Z]*$/g);
	if(rel.test(str)){
		return true;
	}
	return false;
}
//验证输入项必须为多少位的中文(合格返回false)
function checkInputChi(str,length_s,length_e){
	var rel = new RegExp(/^[\u4e00-\u9fa5]+$/);
	if(!rel.test(str)){//不是中文
		return true;
	}else{
		if(str.length >= length_s && str.length <= length_e){
			return false;
		}else{
			return true;
		}
	}
}
//判断字母、数字、中文4-8位长度
function checkTxt(inputStr){
	var reg = new RegExp(/^[a-zA-Z0-9\u4e00-\u9fa5]{4,8}$/);
	return reg.test(inputStr);
}