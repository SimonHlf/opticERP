package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.PurchaseOrderSubInfo;

public interface PurchaseOrderSubInfoDao {
	/**
	 * 根据主键加载采购子订单实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的采购子订单的主键值
	 * @return 加载的采购子订单PO
	 */
	PurchaseOrderSubInfo get(Session sess,int id);
	
	/**
	 * 保存采购子订单实体，新增一条采购子订单记录
	 * @param purchaseOrderSubInfo 保存的采购子订单实例
	 */
	void save(Session sess,PurchaseOrderSubInfo purchaseOrderSubInfo);
	
	/**
	 * 删除采购子订单实体，删除一条采购子订单记录
	 * @param purchaseOrderSubInfo 删除的采购子订单实体
	 */
	void delete(Session sess,PurchaseOrderSubInfo purchaseOrderSubInfo);
	
	/**
	 * 根据主键删除采购子订单实体，删除一条采购子订单记录
	 * @param id 需要删除采购子订单的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 根据指定采购订单删除所有采购子订单实体
	 * @param poId 需要删除采购子订单的采购订单编号
	 */
	void deleteByPoId(Session sess,int poId);
	
	/**
	 * 更新一条采购子订单记录
	 * @param purchaseOrderSubInfo 需要更新的采购子订单
	 */
	void update(Session sess,PurchaseOrderSubInfo purchaseOrderSubInfo);
	
	/**
	 * 根据订单编号查询采购子订单列表
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:05:14
	 * @param sess
	 * @param poId 采购订单编号
	 * @return
	 */
	List<PurchaseOrderSubInfo> findInfoByPoId(Session sess,Integer poId);
	
	/**
	 * 根据商品编号、供应商编号、入库数量小于商品采购数量的且订单状态不为2的记录
	 * @description
	 * @author wm
	 * @date 2017-5-23 上午10:05:35
	 * @param sess
	 * @param proId 商品编号
	 * @param bcId 供应商编号
	 * @return
	 */
	List<PurchaseOrderSubInfo> findInfoByOption(Session sess, Integer proId,Integer bcId);
}
