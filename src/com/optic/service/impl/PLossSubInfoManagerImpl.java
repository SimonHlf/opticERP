package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.DepartmentInfoDao;
import com.optic.dao.PLossInfoDao;
import com.optic.dao.PLossSubInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.PLossSubInfo;
import com.optic.service.PLossSubInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class PLossSubInfoManagerImpl implements PLossSubInfoManager{

	public Integer addPLS(Integer plId, Integer depId, Integer inNum,
			Integer comNum, Timestamp comDate, String assumeUser, String remark)
			throws WEBException {
		// TODO Auto-generated method stub
		PLossInfoDao plDao = null;
		DepartmentInfoDao depDao = null;
		PLossSubInfoDao plsDao = null;
		Transaction tran = null;
		try {
			plDao = (PLossInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_LOSS_INFO);
			depDao = (DepartmentInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_DEP_INFO);
			plsDao = (PLossSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_LOSS_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			Integer lossNum = inNum - comNum;
			PLossSubInfo pls = new PLossSubInfo(depDao.get(sess, depId), plDao.get(sess, plId),
					inNum, comDate, comNum, lossNum, assumeUser, remark, 0);
			plsDao.save(sess, pls);
			tran.commit();
			return pls.getId();
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new WEBException("增加材料损耗信息子表信息时出现异常");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<PLossSubInfo> listInfoByPlId(Integer plId) throws WEBException {
		// TODO Auto-generated method stub
		PLossSubInfoDao plsDao = null;
		try {
			plsDao = (PLossSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_LOSS_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return plsDao.findInfoByPlId(sess, plId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据材料损耗主键获取信息子表信息时出现异常");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<PLossSubInfo> listInfoByOption(Integer plId, Integer depId)
			throws WEBException {
		// TODO Auto-generated method stub
		PLossSubInfoDao plsDao = null;
		try {
			plsDao = (PLossSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_LOSS_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return plsDao.findInfoByOption(sess, plId, depId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据材料损耗主表编号、部门编号获取材料损耗子表信息列表时出现异常");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<Object> listGoroupInfoByPlId(Integer plId) throws WEBException {
		// TODO Auto-generated method stub
		PLossSubInfoDao plsDao = null;
		try {
			plsDao = (PLossSubInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_PRODUCT_LOSS_SUB_INFO);
			Session sess = HibernateUtil.currentSession();
			return plsDao.findGoroupInfoByPlId(sess, plId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			throw new WEBException("根据加工工序部门分组获取材料损耗信息统计时出现异常");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
