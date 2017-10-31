package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.DepartmentInfo;
import com.optic.module.UserDepartmentInfo;

public class UserDepJson {
	
	/**
	 * 重组用户部门信息数据
	 * @description
	 * @author wm
	 * @date 2017-4-1 上午10:16:30
	 * @param udList
	 * @return
	 */
	public List<UserDepartmentInfo> getUserDepJson(List<UserDepartmentInfo> udList){
		List<UserDepartmentInfo> result = new ArrayList<UserDepartmentInfo>();
		for(Iterator<UserDepartmentInfo> it = udList.iterator() ; it.hasNext();){
			UserDepartmentInfo ud = it.next();
			DepartmentInfo dep = ud.getDepartmentInfo();
			DepartmentInfo dep_new = new DepartmentInfo(dep.getId(),dep.getDepName(),dep.getDepOption(),"");
			UserDepartmentInfo ud_new = new UserDepartmentInfo(ud.getId(),dep_new,null);
			result.add(ud_new);
		}
		return result;
	}
}
