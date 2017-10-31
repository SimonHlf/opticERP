package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.UserInfoDao;
import com.optic.module.UserInfo;

@SuppressWarnings("unchecked")
public class UserInfoDaoImpl implements UserInfoDao{

	public UserInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (UserInfo)sess.load(UserInfo.class, id);
	}

	public void save(Session sess, UserInfo userInfo) {
		// TODO Auto-generated method stub
		sess.save(userInfo);
	}

	public void delete(Session sess, UserInfo userInfo) {
		// TODO Auto-generated method stub
		sess.delete(userInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, UserInfo userInfo) {
		// TODO Auto-generated method stub
		sess.update(userInfo);
	}

	public List<UserInfo> getInfoById(Session sess,Integer id) {
		// TODO Auto-generated method stub
		String hql = " from UserInfo as ui where ui.id = "+id;
		List<UserInfo> uList = sess.createQuery(hql).list();
		return uList;
	}

	public List<UserInfo> getInfoByAccount(Session sess, String uAccount) {
		// TODO Auto-generated method stub
		String hql = " from UserInfo as ui where ui.userAccount = '"+uAccount+"'";
		List<UserInfo> uList = sess.createQuery(hql).list();
		return uList;
	}

}
