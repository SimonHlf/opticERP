package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.UserDepartmentInfo;

public interface UserDepartmentInfoManager {
	
	/**
	 * 增加用户部门关联信息系
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:19:03
	 * @param userId
	 * @param depId
	 * @return
	 * @throws WEBException
	 */
	public Integer addUDI(Integer userId,Integer depId)throws WEBException;
	
	/**
	 * 根据用户获取用户部门关联列表
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:19:49
	 * @param userId
	 * @return
	 * @throws WEBException
	 */
	List<UserDepartmentInfo> listInfoByUserId(Integer userId)throws WEBException;
}
