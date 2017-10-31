package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.ProductInfo;

public interface ProductInfoDao {
	/**
	 * 根据主键加载产品信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的产品信息的主键值
	 * @return 加载的产品信息PO
	 */
	ProductInfo get(Session sess,int id);
	
	/**
	 * 保存产品实体，新增一条产品信息记录
	 * @param productInfo 保存的产品信息实例
	 */
	void save(Session sess,ProductInfo productInfo);
	
	/**
	 * 删除产品实体，删除一条产品信息记录
	 * @param productInfo 删除的产品信息实体
	 */
	void delete(Session sess,ProductInfo productInfo);
	
	/**
	 * 根据主键删除产品实体，删除一条产品信息记录
	 * @author zong
	 * @param id 需要删除产品信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条产品信息记录
	 * @author zong
	 * @param productInfo 需要更新的产品信息
	 */
	void update(Session sess,ProductInfo productInfo);
	
	/**
	 * 根据编号获取产品信息列表
	 * @description
	 * @author zong
	 * @param id 编号
	 * @return
	 */
	List<ProductInfo> getInfoById(Session sess,Integer id);
	/**
	 * 获取产品信息列表
	 * @param sess
	 * @return
	 */
	List<ProductInfo> getProductInfoList(Session sess,Integer proTypeId , String proPy,Boolean inNumoStatus,Boolean madeStatus,int pageNo, int pageSize);
	
	/**
	 * 获取产品信息条数
	 * @description
	 * @author wm
	 * @date 2017-8-4 下午05:00:38
	 * @param sess
	 * @param proTypeId 产品类型
	 * @param proPy 产品拼音码
	 * @param inNumStatus 库存大于0标识
	 * @param madeStatus 综合加工除外标记
	 * @return
	 */
	Integer getProInfoCount(Session sess, Integer proTypeId,String proPy,Boolean inNumStatus,Boolean madeStatus);
	
	/**
	 * 检查是否存在该产品
	 * @description
	 * @author wm
	 * @date 2017-5-10 上午10:13:55
	 * @param sess
	 * @param proName
	 * @return
	 */
	boolean checkExistByName(Session sess,String proName);
	
	/**
	 * 根据产品编码检查是否存在该产品
	 * @description
	 * @author wm
	 * @date 2017-7-16 上午08:58:48
	 * @param sess
	 * @param proCode 产品编码
	 * @return
	 */
	boolean checkExistByCode(Session sess,String proCode);

}
