package com.optic.dao;

import java.util.List;

import org.hibernate.Session;

import com.optic.module.UserInfo;

public interface UserInfoDao {
	/**
	 * 根据主键加载用户实体
	 * @param sess 持久化操作所需要的Hiberate Session
	 * @param id 需要加载的用户的主键值
	 * @return 加载的用户PO
	 */
	UserInfo get(Session sess,int id);
	
	/**
	 * 保存用户实体，新增一条用户记录
	 * @param userInfo 保存的用户实例
	 */
	void save(Session sess,UserInfo userInfo);
	
	/**
	 * 删除用户实体，删除一条用户记录
	 * @param userInfo 删除的用户实体
	 */
	void delete(Session sess,UserInfo userInfo);
	
	/**
	 * 根据主键删除用户实体，删除一条用户记录
	 * @param id 需要删除用户的主键
	 */
	void delete(Session sess,int id);
	
	/**
	 * 更新一条用户记录
	 * @param userInfo 需要更新的用户
	 */
	void update(Session sess,UserInfo userInfo);
	
	/**
	 * 根据编号获取用户信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-28 上午11:30:46
	 * @param id 组件
	 * @return
	 */
	List<UserInfo> getInfoById(Session sess,Integer id);
	
	/**
	 * 根据账号获取用户信息列表
	 * @description
	 * @author wm
	 * @date 2017-3-30 上午11:07:27
	 * @param sess
	 * @param uAccount
	 * @return
	 */
	List<UserInfo> getInfoByAccount(Session sess,String uAccount);
}
