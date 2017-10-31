package com.optic.service.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.BusinessTypeInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.BusinessTypeInfo;
import com.optic.service.BusinessTypeInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class BusinessTypeInfoManagerImpl implements BusinessTypeInfoManager {
	
	private BusinessTypeInfoDao businessTypeInfoDao;
	private Transaction tran;
	public Integer addBusinessTypeInfo(String btName, String btRemark)
			throws WEBException {
		try {
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			BusinessTypeInfo btInfo = new BusinessTypeInfo();
			btInfo.setBtName(btName);
			btInfo.setBtRemark(btRemark);
			businessTypeInfoDao.save(sess, btInfo);
			tran.commit();
			return btInfo.getId();
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("增加往来单位类别信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}	
	}

	public boolean deleteBusinessTypeInfo(Integer id) throws WEBException {
		try {
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();;
			businessTypeInfoDao.delete(sess, id);
			tran.commit();
			return true;
		} catch (Exception e) {
			throw new WEBException("删除指定往来单位类别信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateBusinessTypeInfo(Integer id, String btName,
			String btRemark) throws WEBException {
		try {
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();;
			BusinessTypeInfo btInfo =businessTypeInfoDao.get(sess, id);
			btInfo.setBtName(btName);
			btInfo.setBtRemark(btRemark);
			businessTypeInfoDao.update(sess, btInfo);
			tran.commit();
			return true;
		} catch (Exception e) {
			throw new WEBException("更新往来单位类别信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public List<BusinessTypeInfo> listBusinessTypeInfo() throws WEBException {
		List<BusinessTypeInfo> result = new ArrayList<BusinessTypeInfo>();
		try {
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			List<BusinessTypeInfo> btlist = businessTypeInfoDao.getBtInfoList(sess);
			for (Iterator<BusinessTypeInfo> itr = btlist.iterator(); itr.hasNext();) {
				BusinessTypeInfo btInfo =itr.next();
				result.add(btInfo);
			}
		} catch (Exception e) {
			throw new WEBException("列出往来单位类别信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
		return result;
	}

	public List<BusinessTypeInfo> listByInfo(String btName) throws WEBException {
		// TODO Auto-generated method stub
		try {
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessTypeInfoDao.getInfoByName(sess, btName);
		} catch (Exception e) {
			throw new WEBException("根据类别名称列出类别信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
