package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.PayReOutsellInfo;

public interface PayReOutsellInfoManager {
	
	/**
	 * 增加销售、外协出库收付款记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午10:09:23
	 * @param osId 出库记录主键
	 * @param repDate 收、付款日期
	 * @param repMoney 收、付款金额
	 * @param repStatus 收、付款标记
	 * @param repRemark 收、付款备注
	 * @return
	 * @throws WEBException
	 */
	Integer addPRO(Integer osId,Timestamp repDate,Double repMoney,Integer repStatus,String repRemark) throws WEBException;
	
	/**
	 * 根据销售、外协出库编号获取销售、外协出库收、付款信息列表
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午10:13:43
	 * @param osId 销售、外协出库编号
	 * @return
	 * @throws WEBException
	 */
	List<PayReOutsellInfo> listInfoByOsId(Integer osId) throws WEBException;
}
