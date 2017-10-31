package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PayReOutsellInfoDao;
import com.optic.module.PayReOutsellInfo;

@SuppressWarnings("unchecked")
public class PayReOutsellInfoDaoImpl implements PayReOutsellInfoDao{

	public PayReOutsellInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PayReOutsellInfo) sess.load(PayReOutsellInfo.class, id);
	}

	public void save(Session sess, PayReOutsellInfo prInfo) {
		// TODO Auto-generated method stub
		sess.save(prInfo);
	}

	public void delete(Session sess, PayReOutsellInfo prInfo) {
		// TODO Auto-generated method stub
		sess.delete(prInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PayReOutsellInfo prInfo) {
		// TODO Auto-generated method stub
		sess.update(prInfo);
	}

	public List<PayReOutsellInfo> findInfoByOsId(Session sess, Integer osId) {
		// TODO Auto-generated method stub
		String hql = " from PayReOutsellInfo as pr where pr.outSellInfo.id = "+osId;
		List<PayReOutsellInfo> l = sess.createQuery(hql).list();
		return l;
	}

}
