package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.BusinessTypeInfo;

public interface BusinessTypeInfoDao {
	/**
	 * 根据主键加载往来单位类别信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的往来单位类别信息的主键值
	 * @return 加载的往来单位类别信息PO
	 */
	BusinessTypeInfo get(Session sess,int id);
	
	/**
	 * 新增一条往来单位类别信息记录
	 * @param BusinessTypeInfo 保存的往来单位类别信息实例
	 */
	void save(Session sess,BusinessTypeInfo businessTypeInfo);
	
	/**
	 * 删除一条往来单位类别信息记录
	 * @param BusinessTypeInfo 删除的往来单位类别信息实体
	 */
	void delete(Session sess,BusinessTypeInfo businessTypeInfo);
	
	/**
	 * 删除一条往来单位类别信息记录
	 * @author zong
	 * @param id 需要删除往来单位类别信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条往来单位类别信息记录
	 * @author zong
	 * @param BusinessTypeInfo 需要更新的往来单位类别信息
	 */
	void update(Session sess,BusinessTypeInfo businessTypeInfo);
	
	/**
	 * 根据编号获取往来单位信息类别列表
	 * @description
	 * @author zong
	 * @param id 编号
	 * @return
	 */
	List<BusinessTypeInfo> getInfoById(Session sess,Integer id);
	/**
	 * 获取往来单位类别信息列表
	 * @param sess
	 * @return
	 */
	List<BusinessTypeInfo> getBtInfoList(Session sess);
	
	/**
	 * 根据类别名称获取类别列表
	 * @description
	 * @author wm
	 * @date 2017-5-2 下午02:52:22
	 * @param sess
	 * @param btName
	 * @return
	 */
	List<BusinessTypeInfo> getInfoByName(Session sess,String btName);

}
