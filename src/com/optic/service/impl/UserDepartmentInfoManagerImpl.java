package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.UserDepartmentInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.UserDepartmentInfo;
import com.optic.service.UserDepartmentInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class UserDepartmentInfoManagerImpl implements UserDepartmentInfoManager{

	public Integer addUDI(Integer userId, Integer depId) throws WEBException {
		// TODO Auto-generated method stub
		return null;
	}

	public List<UserDepartmentInfo> listInfoByUserId(Integer userId)
			throws WEBException {
		// TODO Auto-generated method stub
		UserDepartmentInfoDao udiDao = null;
		try {
			udiDao = (UserDepartmentInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_USER_DEP_INFO);
			Session sess = HibernateUtil.currentSession();
			return udiDao.findInfoByUserId(sess, userId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据用户编号获取用户部门关联信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
