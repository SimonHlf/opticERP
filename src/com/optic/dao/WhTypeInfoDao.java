package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.WhTypeInfo;

public interface WhTypeInfoDao {
	/**
	 * 根据主键加载仓库类别实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的仓库类别的主键值
	 * @return 加载的仓库类别PO
	 */
	WhTypeInfo get(Session sess,int id);
	
	/**
	 * 保存仓库类别实体，新增一条仓库类别记录
	 * @param whTypeInfo 保存的仓库类别实例
	 */
	void save(Session sess,WhTypeInfo whTypeInfo);
	
	/**
	 * 删除仓库类别实体，删除一条仓库类别记录
	 * @param whTypeInfo 删除的仓库类别实体
	 */
	void delete(Session sess,WhTypeInfo whTypeInfo);
	
	/**
	 * 根据主键删除仓库类别实体，删除一条仓库类别记录
	 * @param id 需要删除仓库类别的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条仓库类别记录
	 * @param whTypeInfo 需要更新的仓库类别
	 */
	void update(Session sess,WhTypeInfo whTypeInfo);
	
	/**
	 * 根据编号获取仓库类别信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 上午11:30:46
	 * @param id 组件
	 * @return
	 */
	List<WhTypeInfo> getInfoById(Session sess,Integer id);
	
	/**
	 * 获取所有仓库类别信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 下午03:14:56
	 * @param sess
	 * @return
	 */
	List<WhTypeInfo> getAllInfo(Session sess);
	
	/**
	 * 检查该类别是否存在
	 * @description
	 * @author wm
	 * @date 2017-5-9 上午09:24:41
	 * @param sess
	 * @param wtName
	 * @return
	 */
	boolean checkExistByName(Session sess,String wtName);
}
