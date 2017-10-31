package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.BusinessContactInfo;

public interface BusinessContactInfoManager {
	/**
	 * 添加业务往来单位
	 * @param bcName 单位名称
	 * @param bcPy 单位拼音码
	 * @param bcAddress 单位地址
	 * @param bcContact 单位联系人
	 * @param bcTel 电话
	 * @param bcMobile 手机号码
	 * @param bcFax 传真
	 * @param bcEmail 电子邮件
	 * @param bcBankName 银行姓名
	 * @param bcBankInfo 支行信息
	 * @param bcBankNo  银行卡号码
	 * @param bcBankUser 银行卡户名
	 * @return
	 * @throws WEBException
	 */
	Integer addBusinessContactInfo(String bcName,Integer bcTypeID,String bcPy,String bcAddress,String bcContact,String bcTel,String bcMobile,
	String bcFax,String bcEmail,String bcBankName,String bcBankInfo,String bcBankNo,String bcBankUser)throws WEBException;
	/**
	 * 删除指定编号的往来单位
	 * @param id 往来单位编号
	 * @return
	 * @throws WEBException
	 */
	boolean deleteBCInfoByID(Integer id)throws WEBException;
	/**
	 * 更新往来单位
	 * @param id 单位编号
	 * @param bcName 单位名称
	 * @param bcPy 单位拼音码
	 * @param bcAddress 单位地址
	 * @param bcContact 单位联系人
	 * @param bcTel 电话
	 * @param bcMobile 手机号码
	 * @param bcFax 传真
	 * @param bcEmail 电子邮件
	 * @param bcBankName 银行姓名
	 * @param bcBankInfo 支行信息
	 * @param bcBankNo  银行卡号码
	 * @param bcBankUser 银行卡户名
	 * @return
	 * @throws WEBException
	 */
	boolean updateBusinessContactInfo(Integer id,Integer bctypeId,String bcName,String bcPy,String bcAddress,String bcContact,String bcTel,String bcMobile,
			String bcFax,String bcEmail,String bcBankName,String bcBankInfo,String bcBankNo,String bcBankUser)throws WEBException;
	/**
	 * 根据条件分页获取记录列表
	 * @description
	 * @author wm
	 * @date 2017-4-24 上午09:17:56
	 * @param bizTypeId 单位类别(0为全部)
	 * @param bcPy 单位拼音码(""为全部)
	 * @param pageNo
	 * @param pageSize
	 * @return
	 * @throws WEBException
	 */
	List<BusinessContactInfo> listBusinessContactInfo(Integer bizTypeId,String bcPy,Integer pageNo,Integer pageSize)throws WEBException;
	/**
	 * 根据指定往来单位查看信息
	 * @param bcId 编号
	 * @return
	 * @throws WEBException
	 */
	List<BusinessContactInfo> listBcInfoByOption(Integer bcId)throws WEBException;
	
	/**
	 * 根据条件获取记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-24 上午09:17:18
	 * @param bizTypeId 单位类别(0为全部)
	 * @param bcPy 单位拼音码(""为全部)
	 * @return
	 * @throws WEBException
	 */
	Integer getCountByOption(Integer bizTypeId,String bcPy)throws WEBException; 
	
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
	 * 根据单位名称获取单位信息列表
	 * @description
	 * @author wm
	 * @date 2017-5-2 下午03:14:16
	 * @param bcName
	 * @return
	 * @throws WEBException
	 */
	List<BusinessContactInfo> listInfoByName(String bcName) throws WEBException;
	
	/**
	 * 根据类型获取指定公司
	 * @description
	 * @author wm
	 * @date 2017-6-9 下午03:20:58
	 * @param bcType 类型
	 * @return
	 * @throws WEBException
	 */
	List<BusinessContactInfo> listSpecInfo(Integer bcType) throws WEBException;
}
