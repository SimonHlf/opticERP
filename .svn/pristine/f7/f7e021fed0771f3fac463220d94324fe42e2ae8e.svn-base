package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.WhStorageInfo;
import com.optic.module.WhTypeInfo;

public class WHTypeJson {
	
	/**
	 * 重组仓库json
	 * @description
	 * @author wm
	 * @date 2017-4-5 下午03:50:19
	 * @param wtList
	 * @return
	 */
	public List<WhTypeInfo> getWHTypeJson(List<WhTypeInfo> wtList){
		List<WhTypeInfo> result = new ArrayList<WhTypeInfo>();
		for(Iterator<WhTypeInfo> it = wtList.iterator() ; it.hasNext();){
			WhTypeInfo wt = it.next();
			WhTypeInfo wt_new = new WhTypeInfo(wt.getId(),wt.getWhName(),wt.getWhRemark());
			result.add(wt_new);
		}
		return result;
	}
	
	/**
	 * 重组仓库货架json
	 * @description
	 * @author wm
	 * @date 2017-4-5 下午03:52:36
	 * @param whsList
	 * @return
	 */
	public List<WhStorageInfo> getWHSJson(List<WhStorageInfo> whsList){
		List<WhStorageInfo> result = new ArrayList<WhStorageInfo>();
		for(Iterator<WhStorageInfo> it = whsList.iterator() ; it.hasNext();){
			WhStorageInfo ws = it.next();
			WhTypeInfo wt = ws.getWhTypeInfo();
			WhTypeInfo wt_new = new WhTypeInfo(wt.getId(),wt.getWhName(),wt.getWhRemark());
			WhStorageInfo ws_new = new WhStorageInfo(ws.getId(),wt_new,ws.getWhsName(),ws.getWhsRemark());
			result.add(ws_new);
		}
		return result;
	}
}
