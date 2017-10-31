package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.UserDepartmentInfoDao;
import com.optic.module.UserDepartmentInfo;

@SuppressWarnings("unchecked")
public class UserDepartmentInfoDaoImpl implements UserDepartmentInfoDao{

	public UserDepartmentInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return null;
	}

	public void save(Session sess, UserDepartmentInfo userDepartmentInfo) {
		// TODO Auto-generated method stub
		
	}

	public void delete(Session sess, UserDepartmentInfo userDepartmentInfo) {
		// TODO Auto-generated method stub
		
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		
	}

	public void update(Session sess, UserDepartmentInfo userDepartmentInfo) {
		// TODO Auto-generated method stub
		
	}

	public List<UserDepartmentInfo> findInfoByUserId(Session sess,Integer userId) {
		// TODO Auto-generated method stub
		String hql = " from UserDepartmentInfo as udi where udi.userInfo.id = "+userId;
		List<UserDepartmentInfo> l = sess.createQuery(hql).list();
		return l;
	}

}
