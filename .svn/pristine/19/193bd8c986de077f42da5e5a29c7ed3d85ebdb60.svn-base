package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;

import com.optic.exception.WEBException;
import com.optic.module.InStoreInfo;
import com.optic.module.PurchaseOrderInfo;

public interface PurchaseOrderInfoManager {
	
	/**
	 * 增加采购订单
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:37:49
	 * @param bId 供应商编号
	 * @param poNo 采购订单编号
	 * @param purUserId 采购人员
	 * @param pDate 采购日期
	 * @param pTotalMoney 采购总金额
	 * @param status 标记状态
	 * @param payStatus 付款状态
	 * @param invoiceStatus 发票状态
	 * @param pRemark 订单备注
	 * @return
	 * @throws WEBException
	 */
	Integer addPO(Integer bId,String poNo,Integer purUserId,Timestamp pDate,Double pTotalMoney,
			Integer status,Integer payStatus,Integer invoiceStatus, String pRemark)throws WEBException;
	
	/**
	 * 修改订单基本信息
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:40:05
	 * @param poId
	 * @param bId
	 * @param poNo
	 * @param purUserId
	 * @param pDate
	 * @param pTotalMoney
	 * @return
	 * @throws WEBException
	 */
	boolean updateBasicOP(Integer poId,Integer bId,String poNo,Integer purUserId,Timestamp pDate,Double pTotalMoney)throws WEBException;
	
	/**
	 * 修改实际付款总额（可分期付款）
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:41:40
	 * @param poId
	 * @param payMoney 每次付款的实际金额
	 * @return
	 * @throws WEBException
	 */
	boolean updateActivePayMoney(Integer poId,Double payMoney)throws WEBException;
	
	/**
	 * 修改订单标记状态、付款状态
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:42:52
	 * @param poId
	 * @param status （null时不修改）
	 * @param payStatus（null时不修改）
	 * @return
	 * @throws WEBException
	 */
	boolean updateStatus(Integer poId,Integer status,Integer payStatus)throws WEBException;
	
	/**
	 * 根据条件分页获取采购订单信息列表
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:48:36
	 * @param bcId 供应商编号
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws WEBException
	 */
	List<PurchaseOrderInfo> listPageInfoByOption(Integer bcId, String poNo,String poDate_s,String poDate_e,
			Integer poStatus,Integer payStatus, Integer pageNo, Integer pageSize)throws WEBException;
	
	/**
	 * 根据条件获取采购订单记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:48:57
	 * @param bcId 供应商编号
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 * @throws WEBException
	 */
	Integer getCountByOption(Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus)throws WEBException; 
	
	/**
	 * 计算总页数
	 * @description
	 * @author wm
	 * @date 2016-4-10 上午10:24:57
	 * @param count 总记录数
	 * @param pageSize 每页记录数
	 * @return 总页数
	 * @throws WEBException
	 */
	Integer getPageCount(int count, int pageSize) throws WEBException;
	
	/**
	 * 根据主键删除采购订单（只有采购中的采购单才能删除。已付款、已入库的单子不能删除。）
	 * @description
	 * @author wm
	 * @date 2017-4-19 上午10:56:46
	 * @param poId
	 * @return
	 * @throws WEBException
	 */
	boolean delPO(Integer poId) throws WEBException;
	
	/**
	 * 获取当天采购订单记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-21 下午04:20:48
	 * @param currDate 当天时间
	 * @return
	 * @throws WEBException
	 */
	Integer getMaxCountByDate(String currDate) throws WEBException;
	
	/**
	 * 根据主键获取采购订单详细信息
	 * @description
	 * @author wm
	 * @date 2017-5-7 下午03:36:19
	 * @param poId
	 * @return
	 * @throws WEBException
	 */
	List<PurchaseOrderInfo> listInfoById(Integer poId) throws WEBException;
	
	
	/**
	 * 获取指定厂家的所有未完成的采购订单列表
	 * @description
	 * @author wm
	 * @date 2017-6-8 上午09:35:42
	 * @param bcId 厂家编号
	 * @param purNo 采购单号（""为全部）
	 * @return
	 * @throws WEBException
	 */
	List<PurchaseOrderInfo> listUnFinishInfoBybcId(Integer bcId,String purNo) throws WEBException;
	
	/**
	 * 根据条件查询采购订单列表
	 * @description
	 * @author wm
	 * @date 2017-7-3 上午09:06:55
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 */
	List<PurchaseOrderInfo> listInfoByOption(Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus) throws WEBException ;
	
	/**
	 * 根据条件查询统计财务信息
	 * @description
	 * @author wm
	 * @date 2017-7-3 上午09:06:55
	 * @param bcId 供应商编号（0表示全部）
	 * @param poNo 采购订单编号（""表示全部）
	 * @param poDate_s 采购日期开始（""表示全部）
	 * @param poDate_e 采购日期结束（""表示全部）
	 * @param poStatus 标记状态（-1表示全部）
	 * @param payStatus 付款状态（-2表示全部）
	 * @return
	 */
	List<Object> listTjInfoByOption(Integer bcId, String poNo,String poDate_s,String poDate_e,Integer poStatus,Integer payStatus) throws WEBException ;

}
