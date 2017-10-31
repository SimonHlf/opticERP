package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.factory.AppFactory;
import com.optic.module.DepartmentInfo;
import com.optic.module.InStoreSubInfo;
import com.optic.module.PLossInfo;
import com.optic.module.PLossSubInfo;
import com.optic.module.ProductInfo;
import com.optic.service.ProductInfoManager;
import com.optic.util.Constants;

public class PLossJson {
	
	private PLossInfo pl;
	private String newProNo;//加工后形成的新产品编号
	private String newProName;//加工后形成的新产品名称
	public PLossInfo getPl() {
		return pl;
	}

	public void setPl(PLossInfo pl) {
		this.pl = pl;
	}

	public String getNewProNo() {
		return newProNo;
	}

	public void setNewProNo(String newProNo) {
		this.newProNo = newProNo;
	}

	public String getNewProName() {
		return newProName;
	}

	public void setNewProName(String newProName) {
		this.newProName = newProName;
	}

	public PLossJson(){
		
	}
	
	public PLossJson(PLossInfo pl,String newProNo,String newProName){
		this.pl = pl;
		this.newProNo = newProNo;
		this.newProName = newProName;
	}
	
	/**
	 * 封装材料损耗信息表
	 * @description
	 * @author wm
	 * @date 2017-6-22 上午10:44:16
	 * @param plList
	 * @return
	 * @throws Exception 
	 */
	public List<PLossJson> getPLJson(List<PLossInfo> plList) throws Exception{
		ProductInfoManager pm = (ProductInfoManager)AppFactory.instance(null).getApp(Constants.WEB_PRODUCT_INFO);
		List<PLossJson> result = new ArrayList<PLossJson>();
		for(Iterator<PLossInfo> it = plList.iterator() ; it.hasNext();){
			PLossInfo pl = it.next();
			Integer newProId = pl.getProNewId();
			InStoreSubInfo iss = pl.getIss();
			InStoreSubInfo iss_new = new InStoreSubInfo(iss.getId());
			ProductInfo pro = pl.getPro();
			ProductInfo pro_new = new ProductInfo(pro.getId(),pro.getProNo(),pro.getProSpec(),pro.getProCz());
			PLossInfo pl_new = new PLossInfo(pl.getId(), iss_new, pro_new,pl.getProNewId(),
					pl.getStartTime(), pl.getEndTime(), pl.getBatchNo(), pl.getMatchNum(),
					pl.getComNum(), pl.getLossNum(), pl.getComRate(), pl.getComStatus());
			List<ProductInfo> pList = pm.listProInfo(newProId);
			String newProNo = "";//加工后形成的新产品编号
			String newProName = "";//加工后形成的新产品名称
			if(pList.size() > 0){
				newProNo = pList.get(0).getProNo();
				newProName = pList.get(0).getProName();
			}
			PLossJson plJosn = new PLossJson(pl_new,newProNo,newProName);
			result.add(plJosn);
		}
		return result;
	}
	
	/**
	 * 封装材料损耗信息子表
	 * @description
	 * @author wm
	 * @date 2017-6-28 下午03:44:46
	 * @param plsList
	 * @return
	 */
	public List<PLossSubInfo> getPLossSubJson(List<PLossSubInfo> plsList){
		List<PLossSubInfo> result = new ArrayList<PLossSubInfo>();
		for(Iterator<PLossSubInfo> it = plsList.iterator() ; it.hasNext();){
			PLossSubInfo pls = it.next();
			DepartmentInfo dep = pls.getDepartmentInfo();
			DepartmentInfo dep_new = new DepartmentInfo(dep.getId(),dep.getDepName());
			PLossSubInfo pls_new = new PLossSubInfo(pls.getId(),dep_new,null,pls.getOutNumber(),pls.getOutDate(),
					pls.getComNumber(),pls.getLossNumber(),pls.getAssume(),pls.getRemark(),pls.getOrderNum());
			result.add(pls_new);
		}
		return result;
	}
}
