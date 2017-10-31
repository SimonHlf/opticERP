package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.BusinessContactInfoDao;
import com.optic.module.BusinessContactInfo;

@SuppressWarnings("unchecked")
public class BusinessContactInfoDaoImpl implements BusinessContactInfoDao {

	public BusinessContactInfo get(Session sess, int id) {
		return (BusinessContactInfo) sess.load(BusinessContactInfo.class, id);
	}

	public void save(Session sess, BusinessContactInfo bcinfo) {
		sess.save(bcinfo);
	}

	public void delete(Session sess, BusinessContactInfo bcinfo) {
		sess.delete(bcinfo);

	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, BusinessContactInfo bcinfo) {
		sess.update(bcinfo);

	}

	public List<BusinessContactInfo> getInfoById(Session sess, Integer id) {
		String hql = " from BusinessContactInfo as bc where bc.id="+id;
		List<BusinessContactInfo> bcList = sess.createQuery(hql).list();
		return bcList;
	}

	public List<BusinessContactInfo> getBCInfoList(Session sess,Integer bizTypeId,String bcPy,Integer pageNo,Integer pageSize) {
		int offset = (pageNo-1)*pageSize;
		if(offset<0){
			offset = 0;
		}
		String hql = " from BusinessContactInfo as bc where 1=1";
		if(!bizTypeId.equals(0)){
			hql+=" and bc.businessTypeInfo.id="+bizTypeId;
		}
		if(!bcPy.equals("")){
			hql+=" and bc.bcPy='"+bcPy+"'";
		}
		List<BusinessContactInfo> bcList = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return bcList;
	}

	public Integer getCountByOption(Session sess, Integer bizTypeId, String bcPy) {
		// TODO Auto-generated method stub
		String hql = "select count(bc.id) from BusinessContactInfo as bc where 1=1";
		if(!bizTypeId.equals(0)){
			hql+=" and bc.businessTypeInfo.id="+bizTypeId;
		}
		if(!bcPy.equals("")){
			hql+=" and bc.bcPy='"+bcPy+"'";
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<BusinessContactInfo> getInfoByName(Session sess, String bcName) {
		// TODO Auto-generated method stub
		String hql = " from BusinessContactInfo as bc where bc.bcName = '"+bcName+"'";
		List<BusinessContactInfo> bcList = sess.createQuery(hql).list();
		return bcList;
	}

	public List<BusinessContactInfo> findSpecInfo(Session sess,Integer bcType) {
		// TODO Auto-generated method stub
		String hql = " from BusinessContactInfo as bc where bc.bcType = "+bcType;
		return sess.createQuery(hql).list();
	}

}
