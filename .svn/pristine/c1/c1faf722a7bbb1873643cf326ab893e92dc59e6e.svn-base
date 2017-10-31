package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.BusinessTypeInfo;

public interface BusinessTypeInfoManager {
	/**
	 * 添加往来单位类别信息
	 * @param btName 类别名称
	 * @param btRemark 类别备注
	 * @return
	 * @throws WEBException
	 */
	Integer addBusinessTypeInfo(String btName,String btRemark )throws WEBException;
	/**
	 * 删除指定往来单位类别信息
	 * @param id
	 * @return
	 * @throws WEBException
	 */
	boolean deleteBusinessTypeInfo(Integer id)throws WEBException;
	/**
	 * 更新往来单位类别信息
	 * @param id 类别编号
	 * @param typeName 类别名称
	 * @param typeRemark 类别备注
	 * @return
	 * @throws WEBException
	 */
	boolean updateBusinessTypeInfo(Integer id,String btName,String btRemark)throws WEBException;
	/**
	 * 获取所有往来单位类别信息
	 * @return
	 * @throws WEBException
	 */
	List<BusinessTypeInfo> listBusinessTypeInfo()throws WEBException;
	
	/**
	 * 根据单位类别名称获取单位类别信息
	 * @description
	 * @author wm
	 * @date 2017-5-2 下午02:50:44
	 * @param btName
	 * @return
	 * @throws WEBException
	 */
	List<BusinessTypeInfo> listByInfo(String btName)throws WEBException;
}
