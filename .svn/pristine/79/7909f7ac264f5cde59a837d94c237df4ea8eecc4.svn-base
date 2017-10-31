package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.ReturnInfo;

public interface ReturnInfoDao {
		/**
		 * 根据主键加载往来单位类别信息实体
		 * @param sess 持久化操作所需要的Hiberate Session
		 * @param id 需要加载的往来单位类别信息的主键值
		 * @return 加载的往来单位类别信息PO
		 */
		ReturnInfo get(Session sess,int id);
		
		/**
		 * 新增一条往来单位类别信息记录
		 * @param returnInfo 保存的往来单位类别信息实例
		 */
		void save(Session sess,ReturnInfo returnInfo);
		
		/**
		 * 删除一条往来单位类别信息记录
		 * @param returnInfo 删除的往来单位类别信息实体
		 */
		void delete(Session sess,ReturnInfo returnInfo);
		
		/**
		 * 删除一条往来单位类别信息记录
		 * @param id 需要删除往来单位类别信息的主键
		 */
		void delete(Session sess,int id);
		
		/**
		 * 更新一条往来单位类别信息记录
		 * @param returnInfo 需要更新的往来单位类别信息
		 */
		void update(Session sess,ReturnInfo returnInfo);
		
		/**
		 * 根据条件分页获取退货信息列表
		 * @description
		 * @author wm
		 * @date 2017-5-31 上午09:10:50
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
		 */
		List<ReturnInfo> findPageInfoByOption(Session sess,String reNo,String outNo,Integer outType,Integer proId,Integer bcId,
				Integer reStatus,String reDate_s, String reDate_e,Integer pageNo,Integer pageSize);
		
		
		/**
		 * 根据条件获取退货记录条数
		 * @description
		 * @author wm
		 * @date 2017-5-31 上午09:15:15
		 * @param reNo 退货单号（""时为全部）
		 * @param outNo 出库单号（""时为全部）
		 * @param outType 出库单类型（-1时为全部）
		 * @param proId 产品编号（-1时为全部）
		 * @param bcId 供应商编号（-1时为全部）
		 * @param reStatus 退货状态（-1时为全部）
		 * @param reDate_s 退货开始日期（""时为全部）
		 * @param reDate_e 退货结束日期（""时为全部）
		 * @return
		 */
		Integer getCountByOption(Session sess,String reNo,String outNo,Integer outType,Integer proId,Integer bcId,
				Integer reStatus,String reDate_s, String reDate_e);
		
		/**
		 * 获取最后一条记录
		 * @description
		 * @author wm
		 * @date 2017-6-1 下午04:14:07
		 * @param sess
		 * @return
		 */
		List<ReturnInfo> findLastInfo(Session sess);
}
