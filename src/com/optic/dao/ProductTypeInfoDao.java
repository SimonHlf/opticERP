package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.ProductTypeInfo;

public interface ProductTypeInfoDao {
	/**
	 * 根据主键加载产品类别信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的产品类别信息的主键值
	 * @return 加载的产品类别信息PO
	 */
	ProductTypeInfo get(Session sess,int id);
	
	/**
	 * 保存用户实体，新增一条产品类别信息记录
	 * @param ProductTypeInfo 保存的产品类别信息实例
	 */
	void save(Session sess,ProductTypeInfo productTypeInfo);
	
	/**
	 *删除一条产品类别信息记录
	 * @param ProductTypeInfo 删除的产品类别信息实体
	 */
	void delete(Session sess,ProductTypeInfo productTypeInfo);
	
	/**
	 * 删除一条产品类别信息记录
	 * @author zong
	 * @param id 需要删除产品类别信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条产品类别信息记录
	 * @author zong
	 * @param ProductTypeInfo 需要更新的产品类别信息
	 */
	void update(Session sess,ProductTypeInfo productTypeInfo);
	
	/**
	 * 根据编号获取产品信息类别列表
	 * @description
	 * @author zong
	 * @param id 编号
	 * @return
	 */
	List<ProductTypeInfo> getInfoById(Session sess,Integer id);
	/**
	 * 获取产品类别信息列表
	 * @param sess
	 * @return
	 */
	List<ProductTypeInfo> getProductTypeInfoList(Session sess,String typePy);
	
	/**
	 * 检查指定类别名称是否已存在
	 * @description
	 * @author wm
	 * @date 2017-5-9 下午04:20:34
	 * @param sess
	 * @param typeName
	 * @return
	 */
	boolean checkExistByName(Session sess,String typeName);
}
