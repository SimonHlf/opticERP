package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.BusinessContactInfoDao;
import com.optic.dao.InstoreInfoDao;
import com.optic.dao.ProductInfoDao;
import com.optic.dao.UserInfoDao;
import com.optic.dao.WhStorageInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.InStoreInfo;
import com.optic.service.InstoreInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class InstoreInfoManagerImpl implements InstoreInfoManager{

	WhStorageInfoDao wsDao = null;
	BusinessContactInfoDao bcDao = null;
	UserInfoDao userDao = null;
	ProductInfoDao proDao = null;
	InstoreInfoDao insDao = null;
	Transaction tran = null;
	
	public Integer addINS(Integer bcId,String inNo,Integer userId,Timestamp inDate,Integer inStatus,String remark) throws WEBException {
		// TODO Auto-generated method stub
		try {
			wsDao = (WhStorageInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			bcDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			userDao = (UserInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			proDao = (ProductInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_INFO);
			insDao = (InstoreInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_IN_STORE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			InStoreInfo ins = new InStoreInfo(bcDao.get(sess, bcId), userDao.get(sess, userId),
					inNo,inDate, inStatus, remark);
			insDao.save(sess, ins);
			tran.commit();
			return ins.getId();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("增加入库订单信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delINS(Integer inId) throws WEBException {
		// TODO Auto-generated method stub
		try {
			insDao = (InstoreInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_IN_STORE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			insDao.delete(sess, inId);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("删除入库订单信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<InStoreInfo> listPageInfoByOption(String isNo, String isDate_s,
			String isDate_e, Integer inStatus, Integer proId, Integer bcId,
			Integer pageNo, Integer pageSize) throws WEBException {
		// TODO Auto-generated method stub
		try {
			insDao = (InstoreInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_IN_STORE_INFO);
			Session sess = HibernateUtil.currentSession();
			return insDao.findPageInfoByOption(sess, isNo, isDate_s, isDate_e, inStatus, proId, bcId, pageNo, pageSize);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("分页获取入库订单信息列表时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getCountByOption(String isNo, String isDate_s,
			String isDate_e, Integer inStatus, Integer proId, Integer bcId)
			throws WEBException {
		// TODO Auto-generated method stub
		try {
			insDao = (InstoreInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_IN_STORE_INFO);
			Session sess = HibernateUtil.currentSession();
			return insDao.getCountByOption(sess, isNo, isDate_s, isDate_e, inStatus, proId, bcId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("获取入库订单信息条数时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getPageCount(int count, int pageSize) throws WEBException {
		// TODO Auto-generated method stub
		return (count + pageSize - 1 ) / pageSize;
	}

	public List<InStoreInfo> listLastInfo() throws WEBException {
		// TODO Auto-generated method stub
		try {
			insDao = (InstoreInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_IN_STORE_INFO);
			Session sess = HibernateUtil.currentSession();
			return insDao.findLastInfo(sess);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("获取最后一条入库订单信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
