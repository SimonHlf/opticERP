package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.BusinessContactInfoDao;
import com.optic.dao.ProductInfoDao;
import com.optic.dao.PurchaseOrderInfoDao;
import com.optic.dao.PurchaseOrderSubInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.BusinessContactInfo;
import com.optic.module.ProductInfo;
import com.optic.module.PurchaseOrderInfo;
import com.optic.module.PurchaseOrderSubInfo;
import com.optic.service.PurchaseOrderSubInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class PurchaseOrderSubInfoManagerImpl implements PurchaseOrderSubInfoManager{

	public Integer addPOS(Integer poId, Integer bId, Integer pId, Integer pNum,
			Double pMoney, Double pTotalMoney) throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		PurchaseOrderInfoDao poDao = null;
		BusinessContactInfoDao bcDao = null;
		ProductInfoDao pDao = null;
		Transaction tran = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			poDao = (PurchaseOrderInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_INFO);
			bcDao = (BusinessContactInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			pDao = (ProductInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			PurchaseOrderInfo po = poDao.get(sess, poId);
			BusinessContactInfo bc = bcDao.get(sess, bId) ;
			ProductInfo pro = pDao.get(sess, pId);
			//增加采购订单详细信息时入库数量初始为0，需要在入库时进行修改
			PurchaseOrderSubInfo pos = new PurchaseOrderSubInfo(po,bc,pro,pNum,0,pMoney,pTotalMoney);
			posDao.save(sess, pos);
			tran.commit();
			return po.getId();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("增加采购订单详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updatePOS(Integer posId, Integer bId, Integer pId,
			Integer pNum, Double pMoney, Double pTotalMoney) throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		BusinessContactInfoDao bcDao = null;
		ProductInfoDao pDao = null;
		Transaction tran = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			bcDao = (BusinessContactInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			pDao = (ProductInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			PurchaseOrderSubInfo pos = posDao.get(sess, posId);
			BusinessContactInfo bc = bcDao.get(sess, bId) ;
			ProductInfo pro = pDao.get(sess, pId);
			pos.setBusinessContactInfo(bc);
			pos.setProductInfo(pro);
			pos.setProNumber(pNum);
			pos.setProPrice(pMoney);
			pos.setProTotalMoney(pTotalMoney);
			posDao.update(sess, pos);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("修改采购订单详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delPOS(Integer posId) throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		Transaction tran = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			posDao.delete(sess, posId);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("删除采购订单详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<PurchaseOrderSubInfo> listInfoByPoId(Integer poId)
			throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return posDao.findInfoByPoId(sess, poId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据采购订单编号获取采购订单详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delAllPOSByPoId(Integer poId) throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		Transaction tran = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			posDao.deleteByPoId(sess, poId);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("删除指定采购订单编号下所有的详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<PurchaseOrderSubInfo> listInfoByOption(Integer proId,
			Integer bcId) throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return posDao.findInfoByOption(sess, proId, bcId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据商品编号、供应商编号、入库数量小于商品采购数量的且订单状态不为2的记录详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateRealInNumById(Integer posId, Integer newInNum)
			throws WEBException {
		// TODO Auto-generated method stub
		PurchaseOrderSubInfoDao posDao = null;
		Transaction tran = null;
		try {
			posDao = (PurchaseOrderSubInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_PURCHASE_ORDER_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			PurchaseOrderSubInfo pos = posDao.get(sess, posId);
			if(pos != null){
				pos.setProRealNum(pos.getProRealNum() + newInNum);
				tran.commit();
				return true;
			}
			return false;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("修改指定采购子订单编号的实际入库数量时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
