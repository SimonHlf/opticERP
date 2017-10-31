package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.factory.AppFactory;
import com.optic.module.BusinessContactInfo;
import com.optic.module.OutSellInfo;
import com.optic.module.OutSellSubInfo;
import com.optic.module.ProductInfo;
import com.optic.service.OutSellSubInfoManager;
import com.optic.util.Constants;

public class OutSellInfoJson {
	private List<OutSellSubInfo>  ossInfo;
	private OutSellInfo osInfo;

	public List<OutSellSubInfo> getOssInfo() {
		return ossInfo;
	}

	public void setOssInfo(List<OutSellSubInfo> ossInfo) {
		this.ossInfo = ossInfo;
	}

	public OutSellInfo getOsInfo() {
		return osInfo;
	}

	public void setOsInfo(OutSellInfo osInfo) {
		this.osInfo = osInfo;
	}

	public OutSellInfoJson(OutSellInfo osInfo,List<OutSellSubInfo> ossInfo) {
		this.osInfo = osInfo;
		this.ossInfo = ossInfo;
	}
	public OutSellInfoJson() {
		
	}

	public List<OutSellInfoJson> getOsJson(List<OutSellInfo> osList) throws Exception{
		OutSellSubInfoManager ossManager = (OutSellSubInfoManager) AppFactory.instance(null).getApp(Constants.WEB_OUT_SELL_SUB_INFO);
		List<OutSellInfoJson> result = new ArrayList<OutSellInfoJson>();
		for(Iterator<OutSellInfo> it = osList.iterator() ; it.hasNext();){
			OutSellInfo os = it.next();
			Integer osID = os.getId();//出库单编号
			List<OutSellSubInfo> ossList_new = new ArrayList<OutSellSubInfo>();
			List<OutSellSubInfo> ossList=ossManager.listInfoByOsId(osID);
			for(Iterator<OutSellSubInfo> itr = ossList.iterator() ; itr.hasNext();){
				OutSellSubInfo oss = itr.next();
				ProductInfo pro= oss.getProductInfo();
				//ProductTypeInfo pti = pro.getProductTypeInfo();
				//ProductTypeInfo pti_new = new ProductTypeInfo(pti.getId(), pti.getTypeName(), pti.getTypeRemark(),pti.getTypePy());
				ProductInfo pro_new = new ProductInfo(pro.getId(), null, pro.getProNo(),pro.getProName(),pro.getProPy(),
						pro.getProSpec(), pro.getProCz(),pro.getProUnit(), pro.getProType2(),null,pro.getProPriceL(),pro.getProPriceH(),pro.getProPriceA(), pro.getProNumber(),pro.getProValNum(), pro.getProRemark());
				OutSellSubInfo oss_new = new OutSellSubInfo(oss.getId(), null, pro_new,oss.getProNumber(),oss.getProPrice(), oss.getTotalPrice());
				ossList_new.add(oss_new);
			}
			BusinessContactInfo bcInfo = new BusinessContactInfo(os.getBusinessContactInfo().getId(),
					null,os.getBusinessContactInfo().getBcName(),
					os.getBusinessContactInfo().getBcPy(),os.getBusinessContactInfo().getBcAddress(),
					os.getBusinessContactInfo().getBcContact(),os.getBusinessContactInfo().getBcTel(),
					os.getBusinessContactInfo().getBcMobile(),os.getBusinessContactInfo().getBcFax(),
					os.getBusinessContactInfo().getBcEmail(),os.getBusinessContactInfo().getBcBankName(),
					os.getBusinessContactInfo().getBcBankInfo(),os.getBusinessContactInfo().getBcBankNo(),
					os.getBusinessContactInfo().getBcBankUser(),os.getBusinessContactInfo().getBcType());
			OutSellInfo os_new = new OutSellInfo(osID,bcInfo,os.getBusUserName(),os.getOutSNo(),
					os.getAllPrice(),os.getActPrice(),os.getOutStatus(),os.getOutType(),os.getOutDate(),
					os.getOutUserId(),os.getOutUserName(),os.getExpressNo());
			OutSellInfoJson osJson = new OutSellInfoJson(os_new,ossList_new); 
			result.add(osJson);
		}
		return result;
	}
}
