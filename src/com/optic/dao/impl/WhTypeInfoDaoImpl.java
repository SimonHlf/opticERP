package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.WhTypeInfoDao;
import com.optic.module.WhTypeInfo;

@SuppressWarnings("unchecked")
public class WhTypeInfoDaoImpl implements WhTypeInfoDao{

	public WhTypeInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (WhTypeInfo)sess.load(WhTypeInfo.class, id);
	}

	public void save(Session sess, WhTypeInfo whTypeInfo) {
		// TODO Auto-generated method stub
		sess.save(whTypeInfo);
	}

	public void delete(Session sess, WhTypeInfo whTypeInfo) {
		// TODO Auto-generated method stub
		sess.delete(whTypeInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, WhTypeInfo whTypeInfo) {
		// TODO Auto-generated method stub
		sess.update(whTypeInfo);
	}

	public List<WhTypeInfo> getInfoById(Session sess, Integer id) {
		// TODO Auto-generated method stub
		String hql = " from WhTypeInfo as wt where wt.id = "+id;
		List<WhTypeInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<WhTypeInfo> getAllInfo(Session sess) {
		// TODO Auto-generated method stub
		String hql = " from WhTypeInfo";
		List<WhTypeInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public boolean checkExistByName(Session sess, String wtName) {
		// TODO Auto-generated method stub
		String hql = " from WhTypeInfo as wt where wt.whName = '"+wtName+"'";
		List<WhTypeInfo> l = sess.createQuery(hql).list();
		if(l.size() > 0){
			return true;
		}
		return false;
	}

}
