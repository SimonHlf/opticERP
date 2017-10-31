package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.BusinessTypeInfoDao;
import com.optic.module.BusinessTypeInfo;

@SuppressWarnings("unchecked")
public class BusinessTypeInfoDaoImpl implements BusinessTypeInfoDao {

	public BusinessTypeInfo get(Session sess, int id) {
		return (BusinessTypeInfo)sess.load(BusinessTypeInfo.class, id);
	}

	public void save(Session sess, BusinessTypeInfo businessTypeInfo) {
		sess.save(businessTypeInfo);
	}

	public void delete(Session sess, BusinessTypeInfo businessTypeInfo) {
		sess.delete(businessTypeInfo);
	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, BusinessTypeInfo businessTypeInfo) {
		sess.update(businessTypeInfo);
	}

	public List<BusinessTypeInfo> getInfoById(Session sess, Integer id) {
		String hql = " from BusinessTypeInfo as bti where bti.id = "+id;
		List<BusinessTypeInfo> btList = sess.createQuery(hql).list();
		return btList;
	}

	
	public List<BusinessTypeInfo> getBtInfoList(Session sess) {
		String hql = "from BusinessTypeInfo as bti";
		List<BusinessTypeInfo> btList = sess.createQuery(hql).list();
		return btList;
	}

	public List<BusinessTypeInfo> getInfoByName(Session sess, String btName) {
		// TODO Auto-generated method stub
		String hql = "from BusinessTypeInfo as bti where bti.btName = '"+btName+"'";
		List<BusinessTypeInfo> btList = sess.createQuery(hql).list();
		return btList;
	}

}
