package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.factory.AppFactory;
import com.optic.module.DepartmentInfo;
import com.optic.module.OutInfo;
import com.optic.module.OutSubInfo;
import com.optic.module.ProductInfo;
import com.optic.module.ProductTypeInfo;
import com.optic.module.UserInfo;
import com.optic.service.OutSubInfoManager;
import com.optic.util.Constants;

public class OutInfoJson {
	private List<OutSubInfo>  osInfo;
	private OutInfo outInfo;

	public List<OutSubInfo> getOsInfo() {
		return osInfo;
	}
	public void setOsInfo(List<OutSubInfo> osInfo) {
		this.osInfo = osInfo;
	}
	public OutInfo getOutInfo() {
		return outInfo;
	}
	public void setOutInfo(OutInfo outInfo) {
		this.outInfo = outInfo;
	}
	public OutInfoJson(OutInfo outInfo,List<OutSubInfo> osInfo) {
		this.outInfo = outInfo;
		this.osInfo = osInfo;
	}
	public OutInfoJson() {
	}
	public List<OutInfoJson> getOiJson(List<OutInfo> oiList) throws Exception{
		OutSubInfoManager osiManager = (OutSubInfoManager) AppFactory.instance(null).getApp(Constants.WEB_OUT_SUB_INFO);
		List<OutInfoJson> result = new ArrayList<OutInfoJson>();
		for(Iterator<OutInfo> it = oiList.iterator() ; it.hasNext();){
			OutInfo oi = it.next();
			Integer oiId = oi.getId();//出库单编号
			List<OutSubInfo> osiList_new = new ArrayList<OutSubInfo>();
			List<OutSubInfo> osiList=osiManager.getListByOid(oiId);
			for(Iterator<OutSubInfo> itr = osiList.iterator() ; itr.hasNext();){
				OutSubInfo osi = itr.next();
				ProductInfo pro= osi.getProductInfo();
				ProductTypeInfo pti = pro.getProductTypeInfo();
				ProductTypeInfo pti_new = new ProductTypeInfo(pti.getId(), pti.getTypeName(), pti.getTypeRemark(),pti.getTypePy());
				ProductInfo pro_new = new ProductInfo(pro.getId(), pti_new, pro.getProNo(),pro.getProName(),pro.getProPy(),
						pro.getProSpec(), pro.getProCz(),pro.getProUnit(), pro.getProType2(),null,pro.getProPriceL(),pro.getProPriceH(),pro.getProPriceA(), pro.getProNumber(),pro.getProValNum(), pro.getProRemark());
				OutSubInfo osi_new = new OutSubInfo(osi.getId(), null, pro_new,osi.getBatchNo(), osi.getProNumber());
				osiList_new.add(osi_new);
			}
			UserInfo userInfo = new UserInfo(oi.getUserInfo().getId(), oi.getUserInfo().getUserAccount(),
					oi.getUserInfo().getUserPassword(),oi.getUserInfo().getUserName(), oi.getUserInfo().getUserTel(),
					oi.getUserInfo().getUserMobile(),oi.getUserInfo().getUserQq(),oi.getUserInfo().getUserAddress(), 
					oi.getUserInfo().getUserStatus(),oi.getUserInfo().getLastLoginDate(),oi.getUserInfo().getLastLoginIp(),oi.getUserInfo().getUserLoginTimes());
			DepartmentInfo departmentInfo = new DepartmentInfo(oi.getDepartmentInfo().getId(), oi.getDepartmentInfo().getDepName(), oi.getDepartmentInfo().getDepOption(), oi.getDepartmentInfo().getDepRemark());
			OutInfo oi_new = new OutInfo(oiId,userInfo,departmentInfo,oi.getOutNo(),oi.getApplyUser(),oi.getApplyDate(),oi.getOutStatus(),oi.getRemark());
			OutInfoJson oiJson = new OutInfoJson(oi_new,osiList_new); 
			result.add(oiJson);
		}
		return result;
	}
}
