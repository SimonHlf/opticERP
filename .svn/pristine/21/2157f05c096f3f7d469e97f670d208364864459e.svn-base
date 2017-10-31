package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.factory.DaoFactory;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;
import com.optic.dao.WhTypeInfoDao;
import com.optic.exception.WEBException;
import com.optic.module.WhTypeInfo;
import com.optic.service.WhTypeInfoManager;

public class WhTypeInfoManagerImpl implements WhTypeInfoManager{

	public Integer addWTI(String whName, String whRemark) throws WEBException {
		// TODO Auto-generated method stub
		WhTypeInfoDao wtiDao = null;
		Transaction tran = null;
		try {
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			WhTypeInfo wti = new WhTypeInfo(whName,whRemark);
			wtiDao.save(sess, wti);
			tran.commit();
			return wti.getId();
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("初始化增加仓库类别信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateWTI(Integer id, String whName, String whRemark)
			throws WEBException {
		// TODO Auto-generated method stub
		WhTypeInfoDao wtiDao = null;
		Transaction tran = null;
		try {
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			WhTypeInfo wti = wtiDao.get(sess, id);
			wti.setWhName(whName);
			wti.setWhRemark(whRemark);
			wtiDao.update(sess, wti);
			tran.commit();
			return true;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("修改指定仓库类别信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<WhTypeInfo> listAllInfo() throws WEBException {
		// TODO Auto-generated method stub
		WhTypeInfoDao wtiDao = null;
		try {
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			List<WhTypeInfo> wtiList = wtiDao.getAllInfo(sess);
			return wtiList;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("获取所有仓库类别信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delWTIById(Integer id) throws WEBException {
		// TODO Auto-generated method stub
		WhTypeInfoDao wtiDao = null;
		Transaction tran = null;
		try {
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			wtiDao.delete(sess, id);
			tran.commit();
			return true;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("删除指定仓库类别信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean checkExistByName(String wtName) throws WEBException {
		// TODO Auto-generated method stub
		WhTypeInfoDao wtiDao = null;
		try {
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			return wtiDao.checkExistByName(sess, wtName);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("检查是否存在该类别信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
