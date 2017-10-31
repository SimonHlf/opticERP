package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.UserDepartmentInfo;

public interface UserDepartmentInfoDao {
	/**
	 * 根据主键加载用户部门关联实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的用户部门关联的主键值
	 * @return 加载的用户部门关联PO
	 */
	UserDepartmentInfo get(Session sess,int id);
	
	/**
	 * 保存用户部门关联实体，新增一条用户部门关联记录
	 * @param userDepartmentInfo 保存的用户部门关联实例
	 */
	void save(Session sess,UserDepartmentInfo userDepartmentInfo);
	
	/**
	 * 删除用户部门关联实体，删除一条用户部门关联记录
	 * @param userDepartmentInfo 删除的用户部门关联实体
	 */
	void delete(Session sess,UserDepartmentInfo userDepartmentInfo);
	
	/**
	 * 根据主键删除用户部门关联实体，删除一条用户部门关联记录
	 * @param id 需要删除用户部门关联的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条用户部门关联记录
	 * @param userDepartmentInfo 需要更新的用户部门关联
	 */
	void update(Session sess,UserDepartmentInfo userDepartmentInfo);
	
	/**
	 * 根据用户编号获取该用户所属部门
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午10:15:10
	 * @param userId
	 * @return
	 */
	List<UserDepartmentInfo> findInfoByUserId(Session sess,Integer userId);
}
