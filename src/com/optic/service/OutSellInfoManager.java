package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.OutSellInfo;

public interface OutSellInfoManager {

	/**
	 * 增加销售、外协出库记录
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:46:30
	 * @param osNo 出库单编号
	 * @param bcId 客户编号
	 * @param contactName 客户负责人
	 * @param allPrice 合同总价
	 * @param outStatus 标记状态
	 * @param outType 出库类型
	 * @param outDate 出库日期
	 * @param outUserId,outUserName 出库人员
	 * @param expNo 快递单号
	 * @return
	 * @throws WEBException
	 */
	Integer addOS(String osNo,Integer bcId,String contactName,Double allPrice,
			Integer outStatus,Integer outType,Timestamp outDate,Integer outUserId,String outUserName,String expNo) throws WEBException;
	
	/**
	 * 当是外协增加记录，库管进行修改时操作（库管出货动作）
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:59:42
	 * @param id 主键
	 * @param osNo 出库单编号
	 * @param outDate 出库日期
	 * @param outUserId,outUserName 出库人员
	 * @param expNo 快递单号
	 * @return
	 * @throws WEBException
	 */
	boolean updateOSInfoById(Integer id,String osNo,Timestamp outDate,Integer outUserId,String outUserName,String expNo) throws WEBException;
	
	/**
	 * 根据条件分页获取销售、外协出库记录列表
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:47:55
	 * @param osNo 出库单编号（""为全部）
	 * @param bcId 往来单位编号（0是为全部）
	 * @param oStatus 标记状态（-1为全部）
	 * @param oType 出库类型（-1为全部）
	 * @param sDate 开始时间（""为全部）
	 * @param eDate 结束时间（""为全部）
	 * @param expNo 快递单号（""为全部）
	 * @param pageNo 页码
	 * @param pageSize 每页记录条数
	 * @return
	 * @throws WEBException
	 */
	List<OutSellInfo> listPageInfoByOption(String osNo,Integer bcId, Integer oStatus, Integer oType, String sDate,
			String eDate, String expNo, Integer pageNo, Integer pageSize) throws WEBException;
	
	/**
	 * 根据条件获取销售、外协出库记录条数
	 * @description
	 * @author wm
	 * @date 2017-6-7 上午08:48:41
	 * @param osNo 出库单编号（""为全部）
	 * @param bcId 往来单位编号（0是为全部）
	 * @param oStatus 标记状态（-1为全部）
	 * @param oType 出库类型（-1为全部）
	 * @param sDate 开始时间（""为全部）
	 * @param eDate 结束时间（""为全部）
	 * @param expNo 快递单号（""为全部）
	 * @return
	 * @throws WEBException
	 */
	Integer getCountByOption(String osNo,Integer bcId, Integer oStatus, Integer oType, String sDate,
			String eDate, String expNo) throws WEBException;
	/**
	 * 根据出库单号查询
	 * @param oNo 出库单号
	 * @param otype 出库类型
	 * @return
	 * @throws WEBException
	 */
	List<OutSellInfo> getInfoByoNo(String oNo,Integer otype) throws WEBException;
	/**
	 *获取销售，加工出库最后一条记录
	 * @param otype 出库类型
	 * @return
	 * @throws WEBException
	 */
	Integer getCurrOrdNum(Integer otype) throws WEBException;
	/**
	 * 根据条件获取销售 ，加工 出库的合同总价
	 * @param osNo 出库单编号（""为全部）
	 * @param bcId 往来单位编号（0是为全部）
	 * @param oStatus 标记状态（-1为全部）
	 * @param oType 出库类型（-1为全部）
	 * @param sDate 开始时间（""为全部）
	 * @param eDate 结束时间（""为全部）
	 * @return
	 */
	Double getPriceSum(String osNo, Integer bcId,
			Integer oStatus, Integer oType, String sDate, String eDate,String sign)throws WEBException;
	/**
	 * 根据主键更新实付金额
	 * @param osId
	 * @param actPrice
	 * @return
	 * @throws WEBException
	 */
	boolean updateOSInfoByActPrice(Integer osId,Double actPrice) throws WEBException;
}
