package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.PLossSubInfo;

public interface PLossSubInfoDao {
	/**
	 * 根据主键加载材料损耗子表信息实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的材料损耗子表信息的主键值
	 * @return 加载的材料损耗子表信息PO
	 */
	PLossSubInfo get(Session sess,int id);
	
	/**
	 * 保存材料损耗信息实体，新增一条材料损耗子表信息记录
	 * @param pLossSubInfo 保存的材料损耗子表信息实例
	 */
	void save(Session sess,PLossSubInfo pLossSubInfo);
	
	/**
	 * 删除材料损耗信息实体，删除一条材料损耗子表信息记录
	 * @param pLossSubInfo 删除的材料损耗子表信息实体
	 */
	void delete(Session sess,PLossSubInfo pLossSubInfo);
	
	/**
	 * 根据主键删除材料损耗信息实体，删除一条材料损耗子表信息记录
	 * @param id 需要删除材料损耗子表信息的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条材料损耗信息记录
	 * @param pLossSubInfo 需要更新的材料损耗信息
	 */
	void update(Session sess,PLossSubInfo pLossSubInfo);
	
	/**
	 * 根据条件分页获取材料损耗子表信息列表
	 * @description
	 * @author wm
	 * @date 2017-6-21 上午11:47:14
	 * @param sess
	 * @param plId 材料损耗主键编号
	 * @return
	 */
	List<PLossSubInfo> findInfoByPlId(Session sess,Integer plId);
	
	/**
	 * 根据材料损耗主键编号、部门编号获取加工损耗子表列表
	 * @description
	 * @author wm
	 * @date 2017-6-26 下午03:51:45
	 * @param sess
	 * @param plId 材料损耗主键编号
	 * @param depId 部门编号
	 * @return
	 */
	List<PLossSubInfo> findInfoByOption(Session sess, Integer plId,Integer depId);
	
	/**
	 * 根据加工工序部门分组获取材料损耗信息统计
	 * @description
	 * @author wm
	 * @date 2017-6-27 下午02:34:43
	 * @param sess
	 * @param plId
	 * @return
	 */
	List<Object> findGoroupInfoByPlId(Session sess,Integer plId);
}
