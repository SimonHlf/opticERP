package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.BusinessContactInfo;

public interface BusinessContactInfoDao {
	/**
	 * 根据主键加载业务往来单位信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的业务往来单位信息的主键值
	 * @return 加载的业务往来单位信息PO
	 */
	
	BusinessContactInfo get(Session sess,int id);
	
	/**
	 * 保存业务往来单位实体，新增一条业务往来单位信息记录
	 * @param bcinfo 保存的业务往来单位信息实例
	 */
	void save(Session sess,BusinessContactInfo bcinfo);
	
	/**
	 * 删除业务往来单位实体，删除一条业务往来单位信息记录
	 * @param bcinfo 删除的业务往来单位信息实体
	 */
	void delete(Session sess,BusinessContactInfo bcinfo);
	
	/**
	 * 根据主键删除业务往来单位实体，删除一条业务往来单位信息记录
	 * @author zong
	 * @param id 需要删除业务往来单位信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条业务往来单位信息记录
	 * @author zong
	 * @param bcinfo 需要更新的业务往来单位信息
	 */
	void update(Session sess,BusinessContactInfo bcinfo);
	
	/**
	 * 根据编号获取业务往来单位信息列表
	 * @description
	 * @author zong
	 * @param id 编号
	 * @return
	 */
	List<BusinessContactInfo> getInfoById(Session sess,Integer id);
	/**
	 * 获取业务往来单位信息列表
	 * @param sess
	 * @return
	 */
	List<BusinessContactInfo> getBCInfoList(Session sess,Integer bizTypeId,String bcPy,Integer pageNo,Integer pageSize);
	
	/**
	 * 根据条件获取单位记录条数
	 * @description
	 * @author wm
	 * @date 2017-4-24 上午09:22:01
	 * @param sess
	 * @param bizTypeId 单位类别(0为全部)
	 * @param bcPy 单位拼音码(""为全部)
	 * @return
	 */
	Integer getCountByOption(Session sess,Integer bizTypeId,String bcPy);
	
	/**
	 * 根据单位名称获取单位记录信息
	 * @description
	 * @author wm
	 * @date 2017-5-2 下午03:15:14
	 * @param sess
	 * @param bcName
	 * @return
	 */
	List<BusinessContactInfo> getInfoByName(Session sess,String bcName);
	
	/**
	 * 获取采购人员外出采购的指定公司（bc_type为1）
	 * @description
	 * @author wm
	 * @date 2017-6-9 下午03:19:16
	 * @param sess
	 * @param bcType 类型
	 * @return
	 */
	List<BusinessContactInfo> findSpecInfo(Session sess,Integer bcType);

}
