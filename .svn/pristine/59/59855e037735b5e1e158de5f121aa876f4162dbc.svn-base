package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PayPurchaseInfoDao;
import com.optic.module.PayPurchaseInfo;

@SuppressWarnings("unchecked")
public class PayPurchaseInfoDaoImpl implements PayPurchaseInfoDao{

	public PayPurchaseInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PayPurchaseInfo)sess.load(PayPurchaseInfo.class, id);
	}

	public void save(Session sess, PayPurchaseInfo payPurchaseInfo) {
		// TODO Auto-generated method stub
		sess.save(payPurchaseInfo);
	}

	public void delete(Session sess, PayPurchaseInfo payPurchaseInfo) {
		// TODO Auto-generated method stub
		sess.delete(payPurchaseInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PayPurchaseInfo payPurchaseInfo) {
		// TODO Auto-generated method stub
		sess.update(payPurchaseInfo);
	}

	public List<PayPurchaseInfo> findInfoByPoId(Session sess,Integer poId) {
		// TODO Auto-generated method stub
		String hql = " from PayPurchaseInfo as pp where pp.purchaseOrderInfo.id = "+poId;
		List<PayPurchaseInfo> l = sess.createQuery(hql).list();
		return l;
	}

}
