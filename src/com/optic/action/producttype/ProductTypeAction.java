/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.optic.action.producttype;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.alibaba.fastjson.JSON;
import com.optic.action.base.Transcode;
import com.optic.factory.AppFactory;
import com.optic.module.ProductTypeInfo;
import com.optic.module.json.ProductTypeInfoJson;
import com.optic.service.ProducttypeinfoManager;
import com.optic.tools.Convert;
import com.optic.util.Constants;

/** 
 * MyEclipse Struts
 * Creation date: 04-05-2017
 * 
 * XDoclet definition:
 * @struts.action validate="true"
 */
public class ProductTypeAction extends DispatchAction {
	/**
	 * 添加产品类别
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	public ActionForward addProductType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProducttypeinfoManager protyManager = (ProducttypeinfoManager) AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_TYPE_INFO);
		String typeName =Transcode.unescape(request.getParameter("proTypeName"),request);
		String typeRemark =Transcode.unescape(request.getParameter("proTypeRemark"),request);
		String tPy = Convert.getFirstSpell(typeName);
		Integer ptInfo=protyManager.addProductTypeInfo(typeName, typeRemark,tPy);
		String json = JSON.toJSONString(ptInfo>0?true:false);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	//获取产品类别列表
	public ActionForward listProductType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProducttypeinfoManager protyManager = (ProducttypeinfoManager) AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_TYPE_INFO);
		String type_Py =Transcode.unescape(request.getParameter("typePy"),request);
		if(type_Py.equals("null")){
			type_Py = "";
		}
		List<ProductTypeInfo> ptInfo=protyManager.listProductTypeInfo(type_Py);
		List<ProductTypeInfo> ptinfojson= new ProductTypeInfoJson().getPtJson(ptInfo);
		String json = JSON.toJSONString(ptinfojson);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	//更新产品类别
	public ActionForward updateProductType(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProducttypeinfoManager protyManager = (ProducttypeinfoManager) AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_TYPE_INFO);
		Integer ptID =Integer.parseInt(request.getParameter("ptID"));
		String typeName =Transcode.unescape(request.getParameter("proTypeName"),request);
		String typeRemark =Transcode.unescape(request.getParameter("proTypeRemark"),request);
		String tPy = Convert.getFirstSpell(typeName);
		boolean ptFlag=protyManager.updateProductTypeInfo(ptID, typeName, typeRemark,tPy);
		String json = JSON.toJSONString(ptFlag);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	
	/**
	 * 检查指定产品类别是否存在(存在返回true)
	 * @description
	 * @author wm
	 * @date 2017-5-9 下午04:18:10
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward checkExistByName(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ProducttypeinfoManager protyManager = (ProducttypeinfoManager) AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_TYPE_INFO);
		String typeName =Transcode.unescape(request.getParameter("proTypeName"),request);
		boolean flag = protyManager.checkExistByName(typeName);
		Map<String,Boolean> map = new HashMap<String,Boolean>();
		map.put("result", flag);
		String json = JSON.toJSONString(map);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
}