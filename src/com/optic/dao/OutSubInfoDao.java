package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.OutSubInfo;

public interface OutSubInfoDao {
	/**
	 * 根据主键加载出库信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的出库信息的主键值
	 * @return 加载的出库信息PO
	 */
	OutSubInfo get(Session sess,int id);
	
	/**
	 * 保存出库实体，新增一条出库信息记录
	 * @param OutInfo 保存的出库信息实例
	 */
	void save(Session sess,OutSubInfo outsubInfo);
	
	
	
	/**
	 * 根据主键删除出库实体，删除一条出库信息记录
	 * @author zong
	 * @param id 需要删除出库信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条出库信息记录
	 * @author zong
	 * @param OutInfo 需要更新的出库信息
	 */
	void update(Session sess,OutSubInfo outsubInfo);
	
	/**
	 * 根据编号获取出库信息列表
	 * @description
	 * @author zong
	 * @param id 编号
	 * @return
	 */
	List<OutSubInfo> getInfoByoiId(Session sess,Integer oiid);	
	/**
	 * 查看指定产品当天加工领料
	 * @param sess
	 * @param proID 产品编号
	 * @return
	 */
	List<OutSubInfo> getOutStoreByBatch(Session sess,Integer proID);
}
