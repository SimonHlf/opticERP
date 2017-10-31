package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.ReturnInfo;

public interface ReturnInfoManager {
	
		/**
		 * 增加退货记录
		 * @description
		 * @author wm
		 * @date 2017-5-31 上午09:41:45
		 * @param reNo 退货单据号
		 * @param outNo 出库单号
		 * @param outType 出库类型
		 * @param proId 产品编号
		 * @param reNumber 退货数量
		 * @param bcId 供应商编号
		 * @param reUname 供应商负责人
		 * @param userId 操作人员编号
		 * @param reStatus 退货状态
		 * @param remark 备注
		 * @param reDate 退货日期
		 * @return
		 * @throws WEBException
		 */
		Integer addRI(String reNo,String outNo,Integer outType,Integer proId,Integer reNumber,
				Integer bcId,String reUname,Integer userId,Integer reStatus,String remark,Timestamp reDate)throws WEBException;
		/**
		 * 根据条件分页获取退货记录列表
		 * @description
		 * @author wm
		 * @date 2017-5-31 上午09:41:56
		 * @param reNo 退货单号（""时为全部）
		 * @param outNo 出库单号（""时为全部）
		 * @param outType 出库单类型（-1时为全部）
		 * @param proId 产品编号（-1时为全部）
		 * @param bcId 供应商编号（-1时为全部）
		 * @param reStatus 退货状态（-1时为全部）
		 * @param reDate_s 退货开始日期（""时为全部）
		 * @param reDate_e 退货结束日期（""时为全部）
		 * @param pageNo 页码
		 * @param pageSize 每页记录条数
		 * @return
		 * @throws WEBException
		 */
		List<ReturnInfo> listPageInfoByOption(String reNo,String outNo,Integer outType, Integer proId, Integer bcId, Integer reStatus,
				String reDate_s, String reDate_e, Integer pageNo, Integer pageSize)throws WEBException;
		
		/**
		 * 根据条件获取退货记录条数
		 * @description
		 * @author wm
		 * @date 2017-5-31 上午09:42:12
		 * @param reNo 退货单号（""时为全部）
		 * @param outNo 出库单号（""时为全部）
		 * @param outType 出库单类型（-1时为全部）
		 * @param proId 产品编号（-1时为全部）
		 * @param bcId 供应商编号（-1时为全部）
		 * @param reStatus 退货状态（-1时为全部）
		 * @param reDate_s 退货开始日期（""时为全部）
		 * @param reDate_e 退货结束日期（""时为全部）
		 * @return
		 * @throws WEBException
		 */
		Integer getCountByOption(String reNo,String outNo,
				Integer outType, Integer proId, Integer bcId, Integer reStatus,
				String reDate_s, String reDate_e)throws WEBException;
		
		/**
		 * 获取最后一条记录
		 * @description
		 * @author wm
		 * @date 2017-6-1 下午04:13:20
		 * @return
		 * @throws WEBException
		 */
		List<ReturnInfo> listLastInfo() throws WEBException;
}
