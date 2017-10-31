/*
 * Generated by MyEclipse Struts
 * Template path: templates/java/JavaClass.vtl
 */
package com.optic.action.returnInfo;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.alibaba.fastjson.JSON;
import com.optic.action.base.Transcode;
import com.optic.exception.WEBException;
import com.optic.factory.AppFactory;
import com.optic.module.ReturnInfo;
import com.optic.module.json.ReturnInfoJson;
import com.optic.page.PageConst;
import com.optic.service.ProductInfoManager;
import com.optic.service.ReturnInfoManager;
import com.optic.tools.CommonTools;
import com.optic.tools.CurrentTime;
import com.optic.util.Constants;

/** 
 * MyEclipse Struts
 * Creation date: 05-31-2017
 * 
 * XDoclet definition:
 * @struts.action validate="true"
 */
public class ReturnInfoAction extends DispatchAction {
	
	//获取session中的用户ID
	private Integer getUserID(HttpServletRequest request){
        Integer userId = (Integer)request.getSession(false).getAttribute(Constants.LOGIN_USER_ID);
        return userId;
	}

	//获取session中的用户身份信息
	private String getDepName(HttpServletRequest request){
		String userDepName = (String)request.getSession(false).getAttribute(Constants.LOGIN_USER_DEP_NAME);
		return userDepName;
	}
	
	/**
	 * 根据条件获取退货记录数
	 * @description
	 * @author wm
	 * @date 2017-5-31 下午02:57:15
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	public ActionForward getReCount(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ReturnInfoManager rim = (ReturnInfoManager) AppFactory.instance(null).getApp(Constants.WEB_RETURN_INFO);
		String reNo = "";
		String outNo = "";
		Integer outType = -1;
		Integer proId = 0;
		Integer bcId = 0;
		Integer reStatus = -1;
		String reDate_s = "";
		String reDate_e = "";
		Integer option = CommonTools.getFinalInteger(request.getParameter("option"));
		if(option.equals(0)){//初始查询（近3天）
			reDate_s = String.valueOf(request.getParameter("reDate_s"));
			reDate_e = String.valueOf(request.getParameter("reDate_e"));
		}else if(option.equals(1)){//根据条件查询
			reDate_s = String.valueOf(request.getParameter("reDate_s"));
			reDate_e = String.valueOf(request.getParameter("reDate_e"));
			proId = Integer.parseInt(request.getParameter("proId"));
			bcId = Integer.parseInt(request.getParameter("bcId"));
			reStatus = Integer.parseInt(request.getParameter("reStatus"));
		}else if(option.equals(2)){//根据退货单查询
			reNo = String.valueOf(request.getParameter("reNo"));
		}else if(option.equals(3)){//根据出库单查询
			outNo = String.valueOf(request.getParameter("outNo"));
			outType = Integer.parseInt(request.getParameter("outType"));
		}
		Integer count = rim.getCountByOption(reNo, outNo, outType, proId, bcId, reStatus, reDate_s, reDate_e);
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("result", count);
		String json = JSON.toJSONString(map);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	
	/**
	 * 根据条件获取分页退货记录列表
	 * @description
	 * @author wm
	 * @date 2017-5-31 下午02:57:46
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	public ActionForward getRePageList(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ReturnInfoManager rim = (ReturnInfoManager) AppFactory.instance(null).getApp(Constants.WEB_RETURN_INFO);
		String reNo = "";
		String outNo = "";
		Integer outType = -1;
		Integer proId = 0;
		Integer bcId = 0;
		Integer reStatus = -1;
		String reDate_s = "";
		String reDate_e = "";
		Integer option = CommonTools.getFinalInteger(request.getParameter("option"));
		if(option.equals(0)){//初始查询（近3天）
			reDate_s = String.valueOf(request.getParameter("reDate_s"));
			reDate_e = String.valueOf(request.getParameter("reDate_e"));
		}else if(option.equals(1)){//根据条件查询
			reDate_s = String.valueOf(request.getParameter("reDate_s"));
			reDate_e = String.valueOf(request.getParameter("reDate_e"));
			proId = Integer.parseInt(request.getParameter("proId"));
			bcId = Integer.parseInt(request.getParameter("bcId"));
			reStatus = Integer.parseInt(request.getParameter("reStatus"));
		}else if(option.equals(2)){//根据退货单查询
			reNo = String.valueOf(request.getParameter("reNo"));
		}else if(option.equals(3)){//根据出库单查询
			outNo = String.valueOf(request.getParameter("outNo"));
			outType = Integer.parseInt(request.getParameter("outType"));
		}
		Integer count = rim.getCountByOption(reNo, outNo, outType, proId, bcId, reStatus, reDate_s, reDate_e);
		Integer pageSize = PageConst.getPageSize(String.valueOf(request.getParameter("pageSize")), 10);
		Integer pageCount = PageConst.getPageCount(count, pageSize);
		String pageNoStr = request.getParameter("pageNo");//当前页码数
		Integer pageNo = PageConst.getPageNo(pageNoStr, pageCount);	
		List<ReturnInfo> riList = rim.listPageInfoByOption(reNo, outNo, outType, proId, bcId, reStatus, reDate_s, reDate_e, pageNo, pageSize);
		List<ReturnInfo> result = new ReturnInfoJson().getReturnInfoJson(riList);
		Map<String,Object> map = new HashMap<String,Object>();
		map.put("result", result);
		String json = JSON.toJSONString(map);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	
	/**
	 * 自动获取下一个退货单号
	 * @description
	 * @author wm
	 * @date 2017-6-1 下午04:10:30
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception
	 */
	public ActionForward getNextReturnNo(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		ReturnInfoManager rim = (ReturnInfoManager) AppFactory.instance(null).getApp(Constants.WEB_RETURN_INFO);
		List<ReturnInfo> riList = rim.listLastInfo();
		String reNo_final = "";
		if(riList.size() > 0){
			reNo_final = CommonTools.getInStoreNo(riList.get(0).getReNo());
		}
		Map<String,String> map = new HashMap<String,String>();
		map.put("result", reNo_final);
		String json = JSON.toJSONString(map);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
	
	/**
	 * 增加退货记录
	 * @description
	 * @author wm
	 * @date 2017-5-31 下午02:58:19
	 * @param mapping
	 * @param form
	 * @param request
	 * @param response
	 * @return
	 * @throws Exception 
	 */
	public ActionForward addReturn(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		// TODO Auto-generated method stub
		String depName = this.getDepName(request);
		boolean flag = false;
		String msg = "";
		if(depName.equals("库房")){
			ReturnInfoManager rim = (ReturnInfoManager) AppFactory.instance(null).getApp(Constants.WEB_RETURN_INFO);
			ProductInfoManager pim = (ProductInfoManager) AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_INFO);
			String reNo = String.valueOf(request.getParameter("reNo"));
			String outNo = String.valueOf(request.getParameter("outNo"));
			Integer outType = Integer.parseInt(request.getParameter("outType"));
			Integer proId = Integer.parseInt(request.getParameter("proId"));
			Integer bcId = Integer.parseInt(request.getParameter("bcId"));
			String reUname = Transcode.unescape(request.getParameter("reUname"), request);
			Integer reStatus = Integer.parseInt(request.getParameter("reStatus"));
			Integer  reNumber = CommonTools.getFinalInteger(request.getParameter("reNumber"));
			String remark = Transcode.unescape(request.getParameter("remark"), request);
			Integer key = rim.addRI(reNo, outNo, outType, proId, reNumber, bcId, reUname, 
					this.getUserID(request), reStatus, remark, CurrentTime.getCurrentTime1());
			if(key > 0){
				if(reStatus.equals(0) || reStatus.equals(1)){//次品、报废退货--增加库存量
					flag = pim.updateProNumber(proId, reNumber, 0);
				}else if(reStatus.equals(2)){//没用完退货--增加库存、可用量
					flag = pim.updateProNumber(proId, reNumber, reNumber);
				}
			}
			if(flag){
				msg = "succ";
			}else{
				msg = "fail";
			}
		}else{
			msg = "noAbility";
		}
		
		Map<String,String> map = new HashMap<String,String>();
		map.put("result", msg);
		String json = JSON.toJSONString(map);
        PrintWriter pw = response.getWriter();  
        pw.write(json); 
        pw.flush();  
        pw.close(); 
		return null;
	}
}