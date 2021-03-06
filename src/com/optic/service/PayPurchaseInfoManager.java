package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.PayPurchaseInfo;

public interface PayPurchaseInfoManager {
	
	/**
	 * 增加指定采购订单的付款信息记录
	 * @description
	 * @author wm
	 * @date 2017-4-19 下午03:50:31
	 * @param poId
	 * @param pDate
	 * @param pMoney
	 * @param pOption
	 * @return
	 * @throws WEBException
	 */
	Integer addPP(Integer poId, Timestamp pDate, Double pMoney,String pOption)throws WEBException;
	
	/**
	 * 根据采购订单编号获取付款记录列表
	 * @description
	 * @author wm
	 * @date 2017-4-19 下午03:52:38
	 * @param poId
	 * @return
	 * @throws WEBException
	 */
	List<PayPurchaseInfo> listInfoByPoId(Integer poId)throws WEBException;
	
	/**
	 * 根据主键删除付款记录
	 * @description
	 * @author wm
	 * @date 2017-5-7 下午03:51:19
	 * @param id
	 * @return
	 * @throws WEBException
	 */
	boolean delInfoById(Integer id)throws WEBException;
}
