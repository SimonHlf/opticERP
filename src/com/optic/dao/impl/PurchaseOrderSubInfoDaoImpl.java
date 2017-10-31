package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PurchaseOrderSubInfoDao;
import com.optic.module.PurchaseOrderSubInfo;

@SuppressWarnings("unchecked")
public class PurchaseOrderSubInfoDaoImpl implements PurchaseOrderSubInfoDao{

	public PurchaseOrderSubInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PurchaseOrderSubInfo)sess.load(PurchaseOrderSubInfo.class, id);
	}

	public void save(Session sess, PurchaseOrderSubInfo purchaseOrderSubInfo) {
		// TODO Auto-generated method stub
		sess.save(purchaseOrderSubInfo);
	}

	public void delete(Session sess, PurchaseOrderSubInfo purchaseOrderSubInfo) {
		// TODO Auto-generated method stub
		sess.delete(purchaseOrderSubInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PurchaseOrderSubInfo purchaseOrderSubInfo) {
		// TODO Auto-generated method stub
		sess.update(purchaseOrderSubInfo);
	}

	public List<PurchaseOrderSubInfo> findInfoByPoId(Session sess, Integer poId) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderSubInfo as pos where pos.purchaseOrderInfo.id = "+poId;
		List<PurchaseOrderSubInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public void deleteByPoId(Session sess, int poId) {
		// TODO Auto-generated method stub
		String hql = "delete from PurchaseOrderSubInfo as pos where pos.purchaseOrderInfo.id = "+poId;
		sess.createQuery(hql).executeUpdate();
	}

	public List<PurchaseOrderSubInfo> findInfoByOption(Session sess, Integer proId,Integer bcId) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderSubInfo as pos where pos.productInfo.id = "+proId + " and pos.businessContactInfo.id = "+ bcId;
		hql += " and pos.proRealNum < pos.proNumber and pos.purchaseOrderInfo.status < 2";
		List<PurchaseOrderSubInfo> l = sess.createQuery(hql).list();
		return l;
	}
}
