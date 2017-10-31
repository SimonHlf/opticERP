package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.BusinessContactInfoDao;
import com.optic.dao.ProductInfoDao;
import com.optic.dao.ReturnInfoDao;
import com.optic.dao.UserInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.ReturnInfo;
import com.optic.service.ReturnInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class ReturnInfoManagerImpl implements ReturnInfoManager{

	public Integer addRI(String reNo, String outNo, Integer outType,
			Integer proId, Integer reNumber, Integer bcId, String reUname,
			Integer userId, Integer reStatus, String remark, Timestamp reDate)
			throws WEBException {
		// TODO Auto-generated method stub
		ProductInfoDao proDao = null;
		BusinessContactInfoDao bcDao = null;
		UserInfoDao uiDao = null;
		ReturnInfoDao riDao = null;
		Transaction tran = null;
		try {
			proDao = (ProductInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			bcDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			uiDao = (UserInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			riDao = (ReturnInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_RETURN_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			ReturnInfo ri = new ReturnInfo(uiDao.get(sess, userId),bcDao.get(sess, bcId), proDao.get(sess, proId),
					reNo, outNo, outType, reNumber,reUname, reStatus,remark, reDate);
			riDao.save(sess, ri);
			tran.commit();
			return ri.getId();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("增加退货信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<ReturnInfo> listPageInfoByOption(String reNo,String outNo, Integer outType,
			Integer proId, Integer bcId, Integer reStatus, String reDate_s,
			String reDate_e, Integer pageNo, Integer pageSize)
			throws WEBException {
		// TODO Auto-generated method stub
		ReturnInfoDao riDao = null;
		try {
			riDao = (ReturnInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_RETURN_INFO);
			Session sess = HibernateUtil.currentSession();
			return riDao.findPageInfoByOption(sess, reNo, outNo, outType, proId, bcId, reStatus, reDate_s, reDate_e, pageNo, pageSize);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据条件分页获取退货信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getCountByOption(String reNo,String outNo, Integer outType,
			Integer proId, Integer bcId, Integer reStatus, String reDate_s,
			String reDate_e) throws WEBException {
		// TODO Auto-generated method stub
		ReturnInfoDao riDao = null;
		try {
			riDao = (ReturnInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_RETURN_INFO);
			Session sess = HibernateUtil.currentSession();
			return riDao.getCountByOption(sess, reNo, outNo, outType, proId, bcId, reStatus, reDate_s, reDate_e);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据条件分页获取退货信息记录条数时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<ReturnInfo> listLastInfo() throws WEBException {
		// TODO Auto-generated method stub
		ReturnInfoDao riDao = null;
		try {
			riDao = (ReturnInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_RETURN_INFO);
			Session sess = HibernateUtil.currentSession();
			return riDao.findLastInfo(sess);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("获取最后一条退货信息记录条数时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
