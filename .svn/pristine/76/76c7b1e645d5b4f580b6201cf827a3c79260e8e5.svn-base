package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.OutInfo;

public interface OutInfoManager {
	/**
	 * 添加出库信息
	 * @param uId 出库人编号
	 * @param did 申请人部门编号
	 * @param oNo 出库单编号
	 * @param applyUser 申请人姓名
	 * @param applyDate 申请时间
	 * @param oSta 标记状态
	 * @param remark 备注
	 * @return
	 * @throws WEBException
	 */
	Integer addOutInfo(Integer uId,Integer did,String oNo,String applyUser,Timestamp applyDate,Integer oSta,String remark)throws WEBException;
	/**
	 * 获取出库信息列表
	 * @param o_no 出库单号
	 * @param proName 产品名称
	 * @param o_sta 领料状态
	 * @param app_date 申请时间
	 * @param pageNo
	 * @param pageSize
	 * @return
	 */
	List<OutInfo> getOiList(String o_no , Integer proid,Integer o_sta,String sDate,String eDate,int pageNo, int pageSize)throws WEBException;
	/**
	 * 获取指定条件的出库信息数
	 * @param o_no 出库单号
	 * @param proName 产品名称
	 * @param o_sta 领料状态
	 * @param app_date 申请时间
	 * @return
	 */
	Integer getOiCount(String o_no , Integer proid,Integer o_sta,String sDate,String eDate)throws WEBException;
	//	获取普通出库最后一条记录
	List<OutInfo> getLastInfo()throws WEBException;
	/**
	 * 根据普通出库单号查询
	 * @param oName
	 * @return
	 */
	List<OutInfo> getInfoByoNo( String outNo)throws WEBException;
}
