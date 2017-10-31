package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.ProductTypeInfo;

public class ProductTypeInfoJson {
	public List<ProductTypeInfo> getPtJson(List<ProductTypeInfo> ptList){
		List<ProductTypeInfo> result = new ArrayList<ProductTypeInfo>();
		for(Iterator<ProductTypeInfo> it = ptList.iterator() ; it.hasNext();){
			ProductTypeInfo pti = it.next();
		    ProductTypeInfo pti_new = new ProductTypeInfo(pti.getId(), pti.getTypeName(), pti.getTypeRemark(),pti.getTypePy());
			result.add(pti_new);
		}
		return result;
	}
}
