package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.DepartmentInfo;

public class DepartmentInfoJson {
	public List<DepartmentInfo> getDepInfoJson(List<DepartmentInfo> dList){
		List<DepartmentInfo> result = new ArrayList<DepartmentInfo>();
		for(Iterator<DepartmentInfo> it = dList.iterator() ; it.hasNext();){
			DepartmentInfo dInfo = it.next();
			DepartmentInfo dInfo_new = new DepartmentInfo(dInfo.getId(),dInfo.getDepName(),dInfo.getDepOption(),dInfo.getDepRemark());
			result.add(dInfo_new);
		}
		return result;
	}

}
