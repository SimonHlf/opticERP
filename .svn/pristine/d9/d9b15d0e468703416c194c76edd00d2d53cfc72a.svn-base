package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.BusinessTypeInfo;

public class BusinessTypeInfoJson {
	public List<BusinessTypeInfo> getBizTypeJson(List<BusinessTypeInfo> bizTypeList){
		List<BusinessTypeInfo> result = new ArrayList<BusinessTypeInfo>();
		for(Iterator<BusinessTypeInfo> it = bizTypeList.iterator() ; it.hasNext();){
			BusinessTypeInfo bizType = it.next();
			BusinessTypeInfo bizType_new = new BusinessTypeInfo(bizType.getId(), bizType.getBtName(), bizType.getBtRemark());
			result.add(bizType_new);
		}
		return result;
	}
}
