package com.optic.service;

import java.util.List;

import com.optic.exception.WEBException;
import com.optic.module.ProductTypeInfo;

public interface ProducttypeinfoManager {
	/**
	 * 添加类别信息
	 * @param typeName 类别名称
	 * @param typeRemark 类别备注
	 * @return
	 * @throws WEBException
	 */
	Integer addProductTypeInfo(String typeName,String typeRemark ,String tPy)throws WEBException;
	/**
	 * 删除指定列表信息
	 * @param id
	 * @return
	 * @throws WEBException
	 */
	boolean deleteProductTypeInfo(Integer id)throws WEBException;
	/**
	 * 更新类别信息
	 * @param id 类别编号
	 * @param typeName 类别名称
	 * @param typeRemark 类别备注
	 * @return
	 * @throws WEBException
	 */
	boolean updateProductTypeInfo(Integer id,String typeName,String typeRemark,String tPy)throws WEBException;
	/**
	 * 获取所有类别信息
	 * @return
	 * @throws WEBException
	 */
	List<ProductTypeInfo> listProductTypeInfo(String typePy)throws WEBException;
	
	/**
	 * 检查该类别名称是否存在（存在返回true）
	 * @description
	 * @author wm
	 * @date 2017-5-9 下午04:19:24
	 * @param typeName 类别名称
	 * @return
	 * @throws WEBException
	 */
	boolean checkExistByName(String typeName)throws WEBException;
}
