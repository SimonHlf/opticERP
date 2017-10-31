package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.BusinessContactInfo;
import com.optic.module.ProductInfo;
import com.optic.module.ReturnInfo;
import com.optic.module.UserInfo;

public class ReturnInfoJson {
	
	public List<ReturnInfo> getReturnInfoJson(List<ReturnInfo> riList){
		 List<ReturnInfo> result = new ArrayList<ReturnInfo>(); 
		 for(Iterator<ReturnInfo> it = riList.iterator() ; it.hasNext();){
			 ReturnInfo ri = it.next();
			 UserInfo ui = ri.getUserInfo();
			 UserInfo user_new = new UserInfo(ui.getId(),ui.getUserName());
			 BusinessContactInfo bc = ri.getBusinessContactInfo();
			 BusinessContactInfo bc_new = new BusinessContactInfo(bc.getId(),bc.getBcName());
			 ProductInfo pro = ri.getProductInfo();
			 ProductInfo pro_new = new ProductInfo(pro.getProNo(),pro.getProName(),pro.getProSpec(),
					 pro.getProCz(),pro.getProUnit(),pro.getProNumber());
			 ReturnInfo ri_new = new ReturnInfo(ri.getId(),user_new,bc_new, pro_new,ri.getReNo(), 
					 ri.getOutNo(), ri.getOutType(), ri.getReNum(),ri.getReUName(), ri.getReStatus(),
					 ri.getRemark(), ri.getReDate());
			 result.add(ri_new);
			 
		 }
		 return result;
	}
}
