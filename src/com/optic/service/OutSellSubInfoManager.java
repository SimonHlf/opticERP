package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.OutSellSubInfo;

public interface OutSellSubInfoManager {
	
	/**
	 * 增加销售出库详细信息记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:55:07
	 * @param osId 出库单主表编号
	 * @param proId 产品编号
	 * @param proNumber 出库数量
	 * @param proPrice 出库单价
	 * @param totalPrice 总价
	 * @return
	 * @throws WEBException
	 */
	Integer addOSS(Integer osId,Integer proId,Integer proNumber,Double proPrice,Double totalPrice) throws WEBException;
	
	/**
	 * 根据出库单主键获取出库详细记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:56:01
	 * @param osId 出库单编号
	 * @return
	 * @throws WEBException
	 */
	List<OutSellSubInfo> listInfoByOsId(Integer osId) throws WEBException;
}
