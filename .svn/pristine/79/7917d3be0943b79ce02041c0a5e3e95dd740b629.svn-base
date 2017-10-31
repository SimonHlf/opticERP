package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.OutSellSubInfo;

public interface OutSellSubInfoDao {
	/**
	 * 根据主键加载业务销售出库详细信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的业务销售出库详细信息的主键值
	 * @return 加载的业务销售出库信息PO
	 */
	
	OutSellSubInfo get(Session sess,int id);
	
	/**
	 * 保存业务销售出库实体，新增一条业务销售出库详细信息记录
	 * @param ossInfo 保存的业务销售出库详细信息实例
	 */
	void save(Session sess,OutSellSubInfo ossInfo);
	
	/**
	 * 删除业务销售出库实体，删除一条业务销售出库详细信息记录
	 * @param ossInfo 删除的业务销售出库详细信息实体
	 */
	void delete(Session sess,OutSellSubInfo ossInfo);
	
	/**
	 * 根据主键删除业务销售出库实体，删除一条业务销售出库详细信息记录
	 * @param id 需要删除业务销售出库信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条业务销售出库信息记录
	 * @param ossInfo 需要更新的业务销售出库详细信息
	 */
	void update(Session sess,OutSellSubInfo ossInfo);
	
	/**
	 * 根据销售出库信息主键获取销售出库信息详细记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:24:43
	 * @param sess
	 * @param osId 出库编号
	 * @return
	 */
	List<OutSellSubInfo> findInfoByosId(Session sess,Integer osId);
}
