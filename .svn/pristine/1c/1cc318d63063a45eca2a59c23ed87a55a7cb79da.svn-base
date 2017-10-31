package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.PayPurchaseInfo;

public interface PayPurchaseInfoDao {
	/**
	 * 根据主键加载采购订单付款实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的采购订单付款的主键值
	 * @return 加载的采购订单付款PO
	 */
	PayPurchaseInfo get(Session sess,int id);
	
	/**
	 * 保存采购订单付款实体，新增一条采购订单付款记录
	 * @param payPurchaseInfo 保存的采购订单付款实例
	 */
	void save(Session sess,PayPurchaseInfo payPurchaseInfo);
	
	/**
	 * 删除采购订单付款实体，删除一条采购订单付款记录
	 * @param payPurchaseInfo 删除的采购订单付款实体
	 */
	void delete(Session sess,PayPurchaseInfo payPurchaseInfo);
	
	/**
	 * 根据主键删除采购订单付款实体，删除一条采购订单付款记录
	 * @param id 需要删除采购订单付款的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条采购订单付款记录
	 * @param payPurchaseInfo 需要更新的采购订单付款
	 */
	void update(Session sess,PayPurchaseInfo payPurchaseInfo);
	
	/**
	 * 根据采购订单付款编号获取采购订单付款付款记录
	 * @description
	 * @author wm
	 * @date 2017-4-19 下午03:45:27
	 * @param poId
	 * @return
	 */
	List<PayPurchaseInfo> findInfoByPoId(Session sess,Integer poId);
}
