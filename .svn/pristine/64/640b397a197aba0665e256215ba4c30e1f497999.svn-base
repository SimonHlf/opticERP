package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.DepartmentInfo;
import com.optic.module.ProductInfo;
import com.optic.module.ProductTypeInfo;

public class ProductInfoJson {
	public List<ProductInfo> getPiJson(List<ProductInfo> piList){
		List<ProductInfo> result = new ArrayList<ProductInfo>();
		for(Iterator<ProductInfo> it = piList.iterator() ; it.hasNext();){
			ProductInfo proInfo = it.next();
			ProductTypeInfo pti = proInfo.getProductTypeInfo();
			ProductTypeInfo pti_new = new ProductTypeInfo(pti.getId(), pti.getTypeName(), pti.getTypeRemark(),pti.getTypePy());
			ProductInfo pi_new = new ProductInfo(proInfo.getId(),pti_new, proInfo.getProNo(), proInfo.getProName(), proInfo.getProPy(), proInfo.getProSpec(), 
					proInfo.getProCz(),proInfo.getProUnit(),proInfo.getProType2(), new DepartmentInfo(proInfo.getDepInfo().getId(),proInfo.getDepInfo().getDepName()),proInfo.getProPriceL(), proInfo.getProPriceH(),proInfo.getProPriceA(), proInfo.getProNumber(),
					proInfo.getProValNum(), proInfo.getProRemark());
			result.add(pi_new);
		}
		return result;
	}
}
