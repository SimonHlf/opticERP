package com.optic.service.impl;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.DepartmentInfoDao;
import com.optic.dao.OutInfoDao;
import com.optic.dao.UserInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.DepartmentInfo;
import com.optic.module.OutInfo;
import com.optic.module.UserInfo;
import com.optic.service.OutInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class OutInfoManagerImpl implements OutInfoManager {
	private OutInfoDao outInfoDao;
	private Transaction tran;
	public Integer addOutInfo(Integer uId, Integer did, String oNo,
			String applyUser, Timestamp applyDate, Integer oSta, String remark)
			throws WEBException {
		try {
			outInfoDao =  (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
			UserInfoDao  uiDao= (UserInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_USER_INFO);
			DepartmentInfoDao diDao = (DepartmentInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_DEP_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			OutInfo outInfo = new OutInfo();
			UserInfo userInfo = uiDao.get(sess, uId);
			outInfo.setUserInfo(userInfo);
			DepartmentInfo departmentInfo = diDao.get(sess, did);
			outInfo.setDepartmentInfo(departmentInfo);
			outInfo.setOutNo(oNo);
			outInfo.setApplyUser(applyUser);
			outInfo.setApplyDate(applyDate);
			outInfo.setOutStatus(oSta);
			outInfo.setRemark(remark);
			outInfoDao.save(sess, outInfo);
			tran.commit();
			return outInfo.getId();
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("增加出库信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}
	public List<OutInfo> getOiList(String o_no, Integer proid, Integer o_sta,
			String sDate, String eDate, int pageNo, int pageSize)
			throws WEBException {
		try {
			outInfoDao =  (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
			Session sess = HibernateUtil.currentSession();
			return outInfoDao.getOutSubInfoList(sess, o_no, proid, o_sta, sDate, eDate, pageNo, pageSize);
		} catch (Exception e) {
			throw new WEBException("列出出库单信息时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}
	public Integer getOiCount(String o_no, Integer proid, Integer o_sta,
			String sDate, String eDate) throws WEBException {
			try {
				outInfoDao =  (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
				Session sess = HibernateUtil.currentSession();
				return outInfoDao.getOutSubInfoCount(sess, o_no, proid, o_sta, sDate, eDate);
			} catch (Exception e) {
				throw new WEBException("列出出库单记录数时出现异常,请重试！");
			} finally{
				HibernateUtil.closeSession();
			}
	}
	public List<OutInfo> getLastInfo() throws WEBException {
		try {
			outInfoDao =  (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
			Session sess = HibernateUtil.currentSession();
			return outInfoDao.getLastInfo(sess);
		} catch (Exception e) {
			throw new WEBException("列出出库单最后一条几率时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}
	public List<OutInfo> getInfoByoNo(String outNo) throws WEBException {
		try {
			outInfoDao =  (OutInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_OUT_INFO);
			Session sess = HibernateUtil.currentSession();
			return outInfoDao.getInfoByoNo(sess, outNo);
		} catch (Exception e) {
			throw new WEBException("根据出库单号查询时出现异常,请重试！");
		} finally{
			HibernateUtil.closeSession();
		}
	}
}
