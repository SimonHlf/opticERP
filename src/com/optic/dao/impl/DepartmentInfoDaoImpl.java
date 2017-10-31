package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.DepartmentInfoDao;
import com.optic.module.DepartmentInfo;

@SuppressWarnings("unchecked")
public class DepartmentInfoDaoImpl implements DepartmentInfoDao{

	public DepartmentInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (DepartmentInfo)sess.load(DepartmentInfo.class, id);
	}

	public void save(Session sess, DepartmentInfo departmentInfo) {
		// TODO Auto-generated method stub
		sess.save(departmentInfo);
	}

	public void delete(Session sess, DepartmentInfo departmentInfo) {
		// TODO Auto-generated method stub
		sess.delete(departmentInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, DepartmentInfo departmentInfo) {
		// TODO Auto-generated method stub
		sess.update(departmentInfo);
	}

	public List<DepartmentInfo> findInfo(Session sess) {
		// TODO Auto-generated method stub
		String hql = " from DepartmentInfo";
		List<DepartmentInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<DepartmentInfo> findGxDepInfo(Session sess) {
		// TODO Auto-generated method stub
		String hql = " from DepartmentInfo as dep where dep.depOption = 1 or dep.depOption = 2";
		List<DepartmentInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<DepartmentInfo> findSpecDepInfo(Session sess, Integer dOption) {
		// TODO Auto-generated method stub
		String hql = " from DepartmentInfo as dep where dep.depOption = "+dOption;
		return sess.createQuery(hql).list();
	}

}
