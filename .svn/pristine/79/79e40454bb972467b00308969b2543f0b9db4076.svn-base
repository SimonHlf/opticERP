package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.OutSellSubInfoDao;
import com.optic.module.OutSellSubInfo;

@SuppressWarnings("unchecked")
public class OutSellSubInfoDaoImpl implements OutSellSubInfoDao{

	public OutSellSubInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (OutSellSubInfo) sess.load(OutSellSubInfo.class, id);
	}

	public void save(Session sess, OutSellSubInfo ossInfo) {
		// TODO Auto-generated method stub
		sess.save(ossInfo);
	}

	public void delete(Session sess, OutSellSubInfo ossInfo) {
		// TODO Auto-generated method stub
		sess.delete(ossInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, OutSellSubInfo ossInfo) {
		// TODO Auto-generated method stub
		sess.update(ossInfo);
	}

	public List<OutSellSubInfo> findInfoByosId(Session sess, Integer osId) {
		// TODO Auto-generated method stub
		String hql = " from OutSellSubInfo as oss where oss.outSellInfo.id = "+osId;
		List<OutSellSubInfo> l = sess.createQuery(hql).list();
		return l;
	}

}
