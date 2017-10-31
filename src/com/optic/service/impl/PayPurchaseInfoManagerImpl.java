package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.PayPurchaseInfoDao;
import com.optic.dao.PurchaseOrderInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.PayPurchaseInfo;
import com.optic.service.PayPurchaseInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class PayPurchaseInfoManagerImpl implements PayPurchaseInfoManager{

	public Integer addPP(Integer poId, Timestamp pDate, Double pMoney, String pOption)throws WEBException {
		// TODO Auto-generated method stub
		PayPurchaseInfoDao ppDao = null;
		PurchaseOrderInfoDao poDao = null;
		Transaction tran = null;
		//当财务进行付款时进行修改
		try {
			ppDao = (PayPurchaseInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PAY_PURCHASE_INFO);
			poDao = (PurchaseOrderInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			PayPurchaseInfo pp = new PayPurchaseInfo(poDao.get(sess, poId), pDate, pMoney,pOption);
			ppDao.save(sess, pp);
			tran.commit();
			return pp.getId();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("增加采购订单付款信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<PayPurchaseInfo> listInfoByPoId(Integer poId)throws WEBException {
		// TODO Auto-generated method stub
		PayPurchaseInfoDao ppDao = null;
		try {
			ppDao = (PayPurchaseInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PAY_PURCHASE_INFO);
			Session sess = HibernateUtil.currentSession();
			return ppDao.findInfoByPoId(sess, poId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据采购订单获取采购订单付款信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delInfoById(Integer id) throws WEBException {
		// TODO Auto-generated method stub
		PayPurchaseInfoDao ppDao = null;
		Transaction tran = null;
		try {
			ppDao = (PayPurchaseInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PAY_PURCHASE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			ppDao.delete(sess, id);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据主键删除订单付款信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
