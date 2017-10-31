package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.InStoreSubInfo;

public interface InstoreSubInfoDao {
	/**
	 * 根据主键加载入库信息详细实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的入库信息的主键值
	 * @return 加载的入库信息PO
	 */
	InStoreSubInfo get(Session sess,int id);
	
	/**
	 * 保存入库信息详细实体，新增一条入库信息记录
	 * @param iss 保存的入库信息实例
	 */
	void save(Session sess,InStoreSubInfo iss);
	
	/**
	 * 删除入库信息详细实体，删除一条入库信息记录
	 * @param iss 删除的入库信息详细实体
	 */
	void delete(Session sess,InStoreSubInfo iss);
	
	/**
	 * 根据主键删除入库信息详细实体，删除一条入库信息记录
	 * @param id 需要删除入库信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条入库信息记录
	 * @param iss 需要更新的入库信息
	 */
	void update(Session sess,InStoreSubInfo iss);
	
	/**
	 * 根据入库编号获取入库详细记录列表
	 * @description
	 * @author wm
	 * @date 2017-6-7 下午04:11:48
	 * @param sess
	 * @param isId 入库主键编号
	 * @return
	 */
	List<InStoreSubInfo> findInfoByIsId(Session sess,Integer isId);
	
	/**
	 * 获取指定商品最后一次的入库记录
	 * @description
	 * @author wm
	 * @date 2017-6-10 上午08:40:40
	 * @param sess
	 * @param proId 商品编号
	 * @return
	 */
	List<InStoreSubInfo> findLastInfoByProId(Session sess,Integer proId);
	
	/**
	 * 根据产品编号获取指定年份的最后一条入库记录
	 * @description
	 * @author wm
	 * @date 2017-6-14 下午03:18:29
	 * @param sess
	 * @param proId 商品编号
	 * @param inYear 指定年份
	 * @return
	 */
	List<InStoreSubInfo> findLastInfoByOption(Session sess,Integer proId,String inYear);
	
	/**
	 * 根据入库子表主键编号获取入库详细记录列表
	 * @description
	 * @author wm
	 * @date 2017-6-23 下午04:32:28
	 * @param sess
	 * @param issId
	 * @return
	 */
	List<InStoreSubInfo> findInfoByIssId(Session sess,Integer issId);
	
	/**
	 * 根据材料编号获取加工剩余数量和入库数量相同的信息记录列表
	 * 作用：获取当前材料没有进行加工的记录
	 * @description
	 * @author wm
	 * @date 2017-6-29 下午05:02:53
	 * @param sess
	 * @param proId 材料编号
	 * @return
	 */
	List<InStoreSubInfo> findInfoByProId(Session sess,Integer proId);
}
