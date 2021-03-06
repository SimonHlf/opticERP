package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.WhTypeInfo;

public interface WhTypeInfoManager {
	
	/**
	 * 增加仓库类别表
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:20:24
	 * @param whName
	 * @param whRemark
	 * @return
	 * @throws WEBException
	 */
	Integer addWTI(String whName,String whRemark)throws WEBException; 
	
	/**
	 * 修改指定的仓库类别
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:39:56
	 * @param whName 类别名称
	 * @param whRemark 类别备注
	 * @return
	 * @throws WEBException
	 */
	boolean updateWTI(Integer id,String whName,String whRemark)throws WEBException; 
	
	/**
	 * 获取所有的仓库类别信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:44:06
	 * @return
	 * @throws WEBException
	 */
	List<WhTypeInfo> listAllInfo()throws WEBException; 
	
	/**
	 * 删除指定编号的仓库类别（当没有仓库货架记录时可以删除）
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:44:48
	 * @param id 主键
	 * @return
	 * @throws WEBException
	 */
	boolean delWTIById(Integer id)throws WEBException; 
	
	/**
	 * 检查该类别名称是否存在
	 * @description
	 * @author wm
	 * @date 2017-5-9 上午09:23:22
	 * @param wtName
	 * @return
	 * @throws WEBException
	 */
	boolean checkExistByName(String wtName)throws WEBException; 
}
