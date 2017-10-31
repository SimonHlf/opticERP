package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.InstoreSubInfoDao;
import com.optic.module.InStoreSubInfo;

@SuppressWarnings("unchecked")
public class InstoreSubInfoDaoImpl implements InstoreSubInfoDao{

	public InStoreSubInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (InStoreSubInfo) sess.load(InStoreSubInfo.class, id);
	}

	public void save(Session sess, InStoreSubInfo iss) {
		// TODO Auto-generated method stub
		sess.save(iss);
	}

	public void delete(Session sess, InStoreSubInfo iss) {
		// TODO Auto-generated method stub
		sess.delete(iss);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, InStoreSubInfo iss) {
		// TODO Auto-generated method stub
		sess.update(iss);
	}
	
	public List<InStoreSubInfo> findInfoByIsId(Session sess, Integer isId) {
		// TODO Auto-generated method stub
		String hql = " from InStoreSubInfo as iss where iss.inStoreInfo.id = "+isId;
		return sess.createQuery(hql).list();
	}

	public List<InStoreSubInfo> findLastInfoByProId(Session sess, Integer proId) {
		// TODO Auto-generated method stub
		String hql = " from InStoreSubInfo as iss where iss.productInfo.id = "+ proId + " order by id desc";
		return sess.createQuery(hql).setFirstResult(0).setMaxResults(1).list();
	}

	public List<InStoreSubInfo> findLastInfoByOption(Session sess, Integer proId,
			String inYear) {
		// TODO Auto-generated method stub
		String hql = " from InStoreSubInfo as iss where iss.productInfo.id = "+ proId + " and SUBSTR(iss.inDate,1,4) = '"+inYear+"' order by iss.id desc";
		return sess.createQuery(hql).setFirstResult(0).setMaxResults(1).list();
	}

	public List<InStoreSubInfo> findInfoByIssId(Session sess, Integer issId) {
		// TODO Auto-generated method stub
		String hql = " from InStoreSubInfo as iss where iss.id = "+issId;
		return sess.createQuery(hql).list();
	}

	public List<InStoreSubInfo> findInfoByProId(Session sess, Integer proId) {
		// TODO Auto-generated method stub
		String hql = " from InStoreSubInfo as iss where iss.productInfo.id = "+proId + " and iss.inNumber = iss.remainNum";
		return sess.createQuery(hql).list();
	}

}
