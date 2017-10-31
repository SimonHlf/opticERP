package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.UserInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.UserInfo;
import com.optic.service.UserInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class UserInfoManagerImpl implements UserInfoManager{

	public Integer addUserInfo(String uAccount, String uPassword, String uName,
			String uTel, String uMobile, String uQq, String uAddress,
			String uStatus, Timestamp lastLoginDate, String lastLoginIp)
			throws WEBException {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean userLogin(String userName, String password)
			throws WEBException {
		// TODO Auto-generated method stub
//		UserInfoDao uDao = null;
//		Transaction tran = null;
//		try {
//			uDao = (UserInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
//			Session sess = HibernateUtil.currentSession();
//			tran = sess.beginTransaction();
//			List<UserInfo> uList = uDao.getInfoById(sess, id);
//		} catch (Exception e) {
//			// TODO Auto-generated catch block
//			throw new WEBException("判断用户登录成功状态时异常!");
//		} finally{
//			HibernateUtil.closeSession();
//		}
		return false;
	}

	public boolean updateUserInfoById(Integer userId, Timestamp lastLoginDate,
			String lastLoginIP, Integer loginTimes) throws WEBException {
		// TODO Auto-generated method stub
		UserInfoDao uDao = null;
		Transaction tran = null;
		try {
			uDao = (UserInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			UserInfo user = uDao.get(sess, userId);
			user.setLastLoginDate(lastLoginDate);
			user.setLastLoginIp(lastLoginIP);
			user.setUserLoginTimes(loginTimes);
			uDao.update(sess, user);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("修改用户登录成功时基本信息时异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateBasicInfoById(Integer userId, String uPassword,
			String uName, String uTel, String uMobile, String uQq,
			String uAddress) throws WEBException {
		// TODO Auto-generated method stub
		return false;
	}

	public List<UserInfo> listInfoByAccount(String uAccount)
			throws WEBException {
		// TODO Auto-generated method stub
		UserInfoDao uDao = null;
		try {
			uDao = (UserInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			Session sess = HibernateUtil.currentSession();
			return uDao.getInfoByAccount(sess, uAccount);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据用户账号获取用户信息列表时异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<UserInfo> listInfoById(Integer userId) throws WEBException {
		// TODO Auto-generated method stub
		UserInfoDao uDao = null;
		try {
			uDao = (UserInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			Session sess = HibernateUtil.currentSession();
			return uDao.getInfoById(sess, userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据用户编号获取用户信息列表时异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateNewPass(Integer userId, String newPass)
			throws WEBException {
		// TODO Auto-generated method stub
		UserInfoDao uDao = null;
		Transaction tran = null;
		try {
			uDao = (UserInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			UserInfo user = uDao.get(sess, userId);
			user.setUserPassword(newPass);
			uDao.update(sess, user);
			tran.commit();
			return true;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("修改用户密码时异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	
	
}
