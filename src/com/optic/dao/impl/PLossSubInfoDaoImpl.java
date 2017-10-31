package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PLossSubInfoDao;
import com.optic.module.PLossSubInfo;

@SuppressWarnings("unchecked")
public class PLossSubInfoDaoImpl implements PLossSubInfoDao{

	public PLossSubInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PLossSubInfo) sess.load(PLossSubInfo.class, id);
	}

	public void save(Session sess, PLossSubInfo pLossSubInfo) {
		// TODO Auto-generated method stub
		sess.save(pLossSubInfo);
	}
	

	public void delete(Session sess, PLossSubInfo pLossSubInfo) {
		// TODO Auto-generated method stub
		sess.delete(pLossSubInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PLossSubInfo pLossSubInfo) {
		// TODO Auto-generated method stub
		sess.update(pLossSubInfo);
	}

	public List<PLossSubInfo> findInfoByPlId(Session sess, Integer plId) {
		// TODO Auto-generated method stub
		String hql = " from PLossSubInfo as pls where pls.proLossInfo.id = "+plId;
		return sess.createQuery(hql).list();
	}
	
	public List<PLossSubInfo> findInfoByOption(Session sess, Integer plId,Integer depId) {
		// TODO Auto-generated method stub
		String hql = " from PLossSubInfo as pls where pls.proLossInfo.id = "+plId + " and pls.departmentInfo.id = "+depId;
		return sess.createQuery(hql).list();
	}
	
	public List<Object> findGoroupInfoByPlId(Session sess,Integer plId){
		String hql = "select sum(pls.outNumber),sum(pls.comNumber),sum(pls.lossNumber),pls.departmentInfo.id,pls.departmentInfo.depName,pls.proLossInfo.pro.proNo";
		hql += " from PLossSubInfo as pls where pls.proLossInfo.id = "+plId + " group by pls.departmentInfo.id order by pls.departmentInfo.id";
		return sess.createQuery(hql).list();
	}
}
