package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.OutInfoDao;
import com.optic.dao.OutSubInfoDao;
import com.optic.dao.ProductInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.OutInfo;
import com.optic.module.OutSubInfo;
import com.optic.module.ProductInfo;
import com.optic.service.OutSubInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class OutSubInfoManagerImpl implements OutSubInfoManager {
	private OutSubInfoDao  outSubInfoDao;
	private Transaction tran;
	public Integer addOutSubInfo(Integer o_no_id, Integer p_id, Integer p_number,String batchNo)
			throws WEBException {
		try {
			outSubInfoDao =  (OutSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SUB_INFO);
			OutInfoDao oiDao = (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
			ProductInfoDao piDao = (ProductInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			OutSubInfo outsubInfo = new OutSubInfo();
			OutInfo outInfo = oiDao.get(sess, o_no_id);
			ProductInfo productInfo = piDao.get(sess, p_id);
			outsubInfo.setProductInfo(productInfo);
			outsubInfo.setProNumber(p_number);
			outsubInfo.setBatchNo(batchNo);
			outsubInfo.setOutInfo(outInfo);
			outSubInfoDao.save(sess, outsubInfo);
			tran.commit();
			return outsubInfo.getId();
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("增加出库时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}
	public List<OutSubInfo> getListByOid(Integer Oid) throws WEBException {
		try {
			outSubInfoDao =  (OutSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return outSubInfoDao.getInfoByoiId(sess, Oid);
		} catch (Exception e) {
			throw new WEBException("根据主键列出指定出库单信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}
	public List<OutSubInfo> getListByBatch(Integer proID) throws WEBException {
		try {
			outSubInfoDao =  (OutSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return outSubInfoDao.getOutStoreByBatch(sess, proID);
		} catch (Exception e) {
			throw new WEBException("根据指定产品当天加工领料出库单信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}
}
