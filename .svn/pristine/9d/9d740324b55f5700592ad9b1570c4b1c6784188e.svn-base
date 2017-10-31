package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.DepartmentInfo;

public interface DepartmentInfoManager {
	
	/**
	 * 增加部门信息
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:31:52
	 * @param dName 部门名称
	 * @param dOption 类型（0:部门,1:工序）
	 * @param dRemark 备注
	 * @return
	 * @throws WEBException
	 */
	public Integer addDep(String dName,Integer dOption,String dRemark)throws WEBException;
	
	/**
	 * 获取部门信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:32:30
	 * @return
	 * @throws WEBException
	 */
	List<DepartmentInfo> listInfo()throws WEBException;
	
	/**
	 * 只获取工序部门
	 * @description
	 * @author wm
	 * @date 2017-6-6 下午04:43:50
	 * @return
	 * @throws WEBException
	 */
	List<DepartmentInfo> listGxDepInfo()throws WEBException;
	
	/**
	 * 根据情况获取部门
	 * @description
	 * @author wm
	 * @date 2017-6-24 上午09:49:20
	 * @param dOption
	 * @return
	 * @throws WEBException
	 */
	List<DepartmentInfo> listSpecDepInfo(Integer dOption)throws WEBException;
}
