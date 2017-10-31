package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.OutSellInfoDao;
import com.optic.dao.PayReOutsellInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.OutSellInfo;
import com.optic.module.PayReOutsellInfo;
import com.optic.service.PayReOutsellInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class PayReOutsellInfoManagerImpl implements PayReOutsellInfoManager{
	private Transaction tran;
	private PayReOutsellInfoDao prDao;
	public Integer addPRO(Integer osId, Timestamp repDate, Double repMoney,
			Integer repStatus, String repRemark) throws WEBException {
		 try {
			    prDao= (PayReOutsellInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PAY_RE_OUT_SELL_INFO);
			    OutSellInfoDao osDao =  (OutSellInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_SELL_INFO);
				Session sess = HibernateUtil.currentSession();
				tran = sess.beginTransaction();
				PayReOutsellInfo prInfo = new PayReOutsellInfo();
				OutSellInfo osInfo = osDao.get(sess, osId);
				prInfo.setOutSellInfo(osInfo);
				prInfo.setRepStatus(repStatus);
				prInfo.setRepDate(repDate);
				prInfo.setRepMoney(repMoney);
				prInfo.setRepRemark(repRemark);
				prDao.save(sess, prInfo);
				tran.commit();
				return prInfo.getId();
			} catch (Exception e) {
				tran.rollback();
				throw new WEBException("添加回/付款订单信息出现异常，请重试！");
			}finally{
				HibernateUtil.closeSession(); 
			}
	}

	public List<PayReOutsellInfo> listInfoByOsId(Integer osId)
			throws WEBException {
		try {
			prDao= (PayReOutsellInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PAY_RE_OUT_SELL_INFO);
			Session sess = HibernateUtil.currentSession();
			return prDao.findInfoByOsId(sess, osId);
		} catch (Exception e) {
			throw new WEBException("根据主键列出指定出库单信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
