package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.OutSubInfo;

public interface OutSubInfoManager {
	/**
	 * 添加出库信息(子表)
	 * @param o_no_id 出库单主表编号
	 * @param p_id 材料编号
	 * @param p_number 材料数量
	 * @return
	 * @throws WEBException
	 */
	Integer addOutSubInfo(Integer o_no_id,Integer p_id,Integer  p_number,String batchNo) throws WEBException;
	/**
	 * 根据出库主键查询子表信息
	 * @param Oid
	 * @return
	 * @throws WEBException
	 */
	List<OutSubInfo> getListByOid(Integer Oid)throws WEBException;
	/**
	 *  查看指定产品当天加工领料
	 * @param proID 产品编号
	 * @return
	 * @throws WEBException
	 */
	List<OutSubInfo> getListByBatch(Integer proID) throws WEBException;
}
