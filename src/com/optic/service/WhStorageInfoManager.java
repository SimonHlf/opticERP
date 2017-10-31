package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.WhStorageInfo;

public interface WhStorageInfoManager {
	
	/**
	 * 增加仓库货架信息记录
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午04:08:51
	 * @param whsName 货架名称
	 * @param whId 仓库类别编号
	 * @param whsRemark 货架备注
	 * @return
	 * @throws WEBException
	 */
	Integer addWSI(String whsName,Integer whId,String whsRemark)throws WEBException; 
	
	/**
	 * 修改指定货架的仓库货架信息记录
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午04:08:51
	 * @param id 货架编号
	 * @param whsName 货架名称 （为null或者""时不修改）
	 * @param whId 仓库类别编号（小于等于0时不修改）
	 * @param whsRemark 货架备注（为null或者""时不修改）
	 * @return
	 * @throws WEBException
	 */
	boolean updateWSI(Integer id,String whsName,Integer whId,String whsRemark)throws WEBException; 
	
	/**
	 * 获取指定仓库类别下所有的仓库货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:44:063
	 * @param whId 货架类别编号
	 * @return
	 * @throws WEBException
	 */
	List<WhStorageInfo> listAllInfoByTypeId(Integer whId)throws WEBException; 
	
	/**
	 * 删除指定编号的仓库货架（当货架上没有产品记录时可以删除）
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:44:48
	 * @param id 主键
	 * @return
	 * @throws WEBException
	 */
	boolean delWSIById(Integer id)throws WEBException; 
	
	/**
	 * 根据仓库类别编号、货架名称分页查询货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-4-6 下午03:29:12
	 * @param whId
	 * @param whsName
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws WEBException
	 */
	List<WhStorageInfo> listPageInfoByOption(Integer whId,String whsName,Integer pageNo,Integer pageSize)throws WEBException; 
	
	/**
	 * 根据仓库类别编号、货架名称分页查询货架记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-6 下午03:30:14
	 * @param whId
	 * @param whsName
	 * @return
	 * @throws WEBException
	 */
	Integer getCountByOption(Integer whId,String whsName)throws WEBException; 
	
	/**
	 * 根据货架编号获取货架详细信息
	 * @description
	 * @author wm
	 * @date 2017-4-8 上午11:40:21
	 * @param whsId
	 * @return
	 * @throws WEBException
	 */
	List<WhStorageInfo> listDetailInfoById(Integer whsId)throws WEBException; 
	
	/**
	 * 根据货架名称、指定仓库下查询是否存在记录
	 * @description
	 * @author wm
	 * @date 2017-4-9 上午10:40:04
	 * @param whsName
	 * @return
	 * @throws WEBException
	 */
	boolean checkExistFlagByWhsName(Integer whId,String whsName)throws WEBException; 
	
	/**
	 * 计算总页数
	 * @description
	 * @author wm
	 * @date 2016-4-10 上午10:24:57
	 * @param count 总记录数
	 * @param pageSize 每页记录数
	 * @return 总页数
	 * @throws WEBException
	 */
	Integer getPageCount(int count, int pageSize) throws WEBException;
}
