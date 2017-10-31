package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.WhStorageInfo;

public interface WhStorageInfoDao {
	/**
	 * 根据主键加载仓库货架实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的仓库货架的主键值
	 * @return 加载的仓库货架PO
	 */
	WhStorageInfo get(Session sess,int id);
	
	/**
	 * 保存仓库货架实体，新增一条仓库货架记录
	 * @param WhStorageInfo 保存的仓库货架实例
	 */
	void save(Session sess,WhStorageInfo whStorageInfo);
	
	/**
	 * 删除仓库货架实体，删除一条仓库货架记录
	 * @param whStorageInfo 删除的仓库货架实体
	 */
	void delete(Session sess,WhStorageInfo whStorageInfo);
	
	/**
	 * 根据主键删除仓库货架实体，删除一条仓库货架记录
	 * @param id 需要删除仓库货架的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条仓库货架记录
	 * @param whStorageInfo 需要更新的仓库货架
	 */
	void update(Session sess,WhStorageInfo whStorageInfo);
	
	/**
	 * 根据编号获取仓库货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 上午11:30:46
	 * @param id 组件
	 * @return
	 */
	List<WhStorageInfo> getInfoById(Session sess,Integer id);
	
	/**
	 * 获取指定类别下所有仓库货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:14:56
	 * @param sess
	 * @param typeId 类别编号
	 * @return
	 */
	List<WhStorageInfo> getAllInfoByTypeId(Session sess,Integer typeId);
	
	/**
	 * 根据仓库类别编号、货架名称分页查询货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-4-6 下午03:04:05
	 * @param sess
	 * @param typeId
	 * @param whsName
	 * @return
	 */
	List<WhStorageInfo> findPageInfoByOption(Session sess,Integer typeId,String whsName,Integer pageNo,Integer pageSize);
	
	/**
	 * 根据仓库类别编号、货架名称获取货架记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-6 下午03:26:34
	 * @param sess
	 * @param typeId
	 * @param whsName
	 * @return
	 */
	Integer getCountByOption(Session sess,Integer typeId,String whsName);
	
	/**
	 * 根据货架主键获取货架详细信息
	 * @description
	 * @author wm
	 * @date 2017-4-9 上午10:04:56
	 * @param sess
	 * @param whsId
	 * @return
	 */
	List<WhStorageInfo> findDetailInfoById(Session sess,Integer whsId);
	
	/**
	 * 根据货架名称、仓库获取货架信息列表
	 * @description
	 * @author wm
	 * @date 2017-4-9 上午10:41:44
	 * @param sess
	 * @param whId
	 * @param whsName
	 * @return
	 */
	List<WhStorageInfo> findInfoByWhsName(Session sess, Integer whId,String whsName);
}
