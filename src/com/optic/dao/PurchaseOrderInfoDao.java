package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.PurchaseOrderInfo;

public interface PurchaseOrderInfoDao {
	
	/**
	 * 根据主键加载采购订单实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的采购订单的主键值
	 * @return 加载的采购订单PO
	 */
	PurchaseOrderInfo get(Session sess,int id);
	
	/**
	 * 保存采购订单实体，新增一条采购订单记录
	 * @param purchaseOrderInfo 保存的采购订单实例
	 */
	void save(Session sess,PurchaseOrderInfo purchaseOrderInfo);
	
	/**
	 * 删除采购订单实体，删除一条采购订单记录
	 * @param purchaseOrderInfo 删除的采购订单实体
	 */
	void delete(Session sess,PurchaseOrderInfo purchaseOrderInfo);
	
	/**
	 * 根据主键删除采购订单实体，删除一条采购订单记录
	 * @param id 需要删除采购订单的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条采购订单记录
	 * @param purchaseOrderInfo 需要更新的采购订单
	 */
	void update(Session sess,PurchaseOrderInfo purchaseOrderInfo);
	
	/**
	 * 根据条件查询采购订单列表
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:05:14
	 * @param sess
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @param pageNo 页码
	 * @param pageSize 每页条数
	 * @return
	 */
	List<PurchaseOrderInfo> findInfoByOption(Session sess,Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus, Integer pageNo, Integer pageSize);
	
	/**
	 * 根据条件查询采购订单数量
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:07:47
	 * @param sess
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 */
	Integer getCountByOption(Session sess,Integer bcId,String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus);
	
	/**
	 * 获取采购订单记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-21 下午04:17:31
	 * @param sess
	 * @param currDate
	 * @return
	 */
	Integer getMaxNumberByDate(Session sess,String currDate);
	
	/**
	 * 根据主键获取该订单信息
	 * @description
	 * @author wm
	 * @date 2017-5-7 下午03:37:29
	 * @param sess
	 * @param id
	 * @return
	 */
	List<PurchaseOrderInfo> findInfoById(Session sess,Integer id);
	
	/**
	 * 获取指定厂家的未完成的采购信息
	 * @description
	 * @author wm
	 * @date 2017-6-8 上午09:13:23
	 * @param sess
	 * @param bcId 厂家编号
	 * @param purNo 采购单号
	 * @return
	 */
	List<PurchaseOrderInfo> findUnFinishInfoBybcId(Session sess,Integer bcId,String purNo);
	
	/**
	 * 根据条件查询采购订单列表
	 * @description
	 * @author wm
	 * @date 2017-7-3 上午08:08:16
	 * @param sess
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 */
	List<PurchaseOrderInfo> findInfoByOption(Session sess,Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus);
	
	/**
	 * 获取指定公司的采购订单付款统计
	 * @description
	 * @author wm
	 * @date 2017-7-3 上午09:14:42
	 * @param sess
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 */
	List<Object> findTjInfoByOption(Session sess,Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus);
}
