package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.DepartmentInfo;

public interface DepartmentInfoDao {
	/**
	 * 根据主键加载部门实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的部门的主键值
	 * @return 加载的部门PO
	 */
	DepartmentInfo get(Session sess,int id);
	
	/**
	 * 保存部门实体，新增一条部门记录
	 * @param departmentInfo 保存的部门实例
	 */
	void save(Session sess,DepartmentInfo departmentInfo);
	
	/**
	 * 删除部门实体，删除一条部门记录
	 * @param departmentInfo 删除的部门实体
	 */
	void delete(Session sess,DepartmentInfo departmentInfo);
	
	/**
	 * 根据主键删除部门实体，删除一条部门记录
	 * @param id 需要删除部门的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条部门记录
	 * @param departmentInfo 需要更新的部门
	 */
	void update(Session sess,DepartmentInfo departmentInfo);
	
	/**
	 * 获取所有部门信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:29:42
	 * @param sess
	 * @return
	 */
	List<DepartmentInfo> findInfo(Session sess);
	
	/**
	 * 只获取工序部门(有、无工序都包括)
	 * @description
	 * @author wm
	 * @date 2017-6-6 下午04:42:03
	 * @param sess
	 * @return
	 */
	List<DepartmentInfo> findGxDepInfo(Session sess);
	
	
	/**
	 * 根据需要获取部门
	 * @description
	 * @author wm
	 * @date 2017-6-6 下午04:42:03
	 * @param sess
	 * @return
	 */
	List<DepartmentInfo> findSpecDepInfo(Session sess,Integer dOption);
	
}
