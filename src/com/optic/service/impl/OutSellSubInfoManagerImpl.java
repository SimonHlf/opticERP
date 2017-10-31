package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.OutSellInfoDao;
import com.optic.dao.OutSellSubInfoDao;
import com.optic.dao.ProductInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.OutSellInfo;
import com.optic.module.OutSellSubInfo;
import com.optic.module.ProductInfo;
import com.optic.service.OutSellSubInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class OutSellSubInfoManagerImpl implements OutSellSubInfoManager{
	private Transaction tran;
	private OutSellSubInfoDao ossDao;
	public Integer addOSS(Integer osId, Integer proId, Integer proNumber,
			Double proPrice, Double totalPrice) throws WEBException {
		  try {
			ossDao= (OutSellSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SELL_SUB_INFO);
			OutSellInfoDao osDao = (OutSellInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SELL_INFO);
			ProductInfoDao pDao = (ProductInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			OutSellSubInfo ossInfo = new OutSellSubInfo();
			OutSellInfo outSellInfo = osDao.get(sess, osId);
			ossInfo.setOutSellInfo(outSellInfo);
			ProductInfo productInfo = pDao.get(sess, proId);
			ossInfo.setProductInfo(productInfo);
			ossInfo.setProNumber(proNumber);
			ossInfo.setProPrice(proPrice);
			ossInfo.setTotalPrice(totalPrice);
			ossDao.save(sess, ossInfo);
			tran.commit();
			return ossInfo.getId();
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("添加销售出库子订单信息出现异常，请重试！");
		}finally{
			HibernateUtil.closeSession(); 
		}
     }

	public List<OutSellSubInfo> listInfoByOsId(Integer osId)
			throws WEBException {
		try {
			ossDao= (OutSellSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SELL_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return ossDao.findInfoByosId(sess, osId);
		} catch (Exception e) {
			throw new WEBException("根据主键列出指定出库单信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
