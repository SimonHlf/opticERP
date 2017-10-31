package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.PayReOutsellInfo;

public interface PayReOutsellInfoDao {
	/**
	 * 根据主键加载销售、外协出库收复款信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的销售、外协出库收复款信息的主键值
	 * @return 加载的业务销售出库信息PO
	 */
	
	PayReOutsellInfo get(Session sess,int id);
	
	/**
	 * 保存业务销售出库实体，新增一条销售、外协出库收复款信息记录
	 * @param prInfo 保存的销售、外协出库收复款信息实例
	 */
	void save(Session sess,PayReOutsellInfo prInfo);
	
	/**
	 * 删除业务销售出库实体，删除一条销售、外协出库收复款信息记录
	 * @param prInfo 删除的销售、外协出库收复款信息实体
	 */
	void delete(Session sess,PayReOutsellInfo prInfo);
	
	/**
	 * 根据主键删除业务销售出库实体，删除一条销售、外协出库收复款信息记录
	 * @param id 需要删除业务销售出库信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条业务销售、外协出库信息记录
	 * @param prInfo 需要更新的销售、外协出库收复款信息
	 */
	void update(Session sess,PayReOutsellInfo prInfo);
	
	/**
	 * 获取指定销售、外协出库的收付款记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午09:07:02
	 * @param sess
	 * @param osId 销售、外协出库编号
	 * @return
	 */
	List<PayReOutsellInfo> findInfoByOsId(Session sess,Integer osId);
}
