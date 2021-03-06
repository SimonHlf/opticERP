package com.optic.service.impl;

import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.BusinessContactInfoDao;
import com.optic.dao.BusinessTypeInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.BusinessContactInfo;
import com.optic.module.BusinessTypeInfo;
import com.optic.service.BusinessContactInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class BusinessContactInfoManagerImpl implements
		BusinessContactInfoManager {
	private BusinessContactInfoDao businessContactInfoDao;
	private BusinessTypeInfoDao businessTypeInfoDao;
	private Transaction tran;
	public Integer addBusinessContactInfo(String bcName,Integer bcTypeID,String bcPy,
			String bcAddress, String bcContact, String bcTel, String bcMobile,
			String bcFax, String bcEmail, String bcBankName, String bcBankInfo,
			String bcBankNo, String bcBankUser) throws WEBException {
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			BusinessContactInfo bcinfo = new BusinessContactInfo();
			BusinessTypeInfo businessTypeInfo = businessTypeInfoDao.get(sess, bcTypeID);
			bcinfo.setBcName(bcName);
			bcinfo.setBusinessTypeInfo(businessTypeInfo);
			bcinfo.setBcPy(bcPy);
			bcinfo.setBcAddress(bcAddress);
			bcinfo.setBcContact(bcContact);
			bcinfo.setBcTel(bcTel);
			bcinfo.setBcMobile(bcMobile);
			bcinfo.setBcFax(bcFax);
			bcinfo.setBcEmail(bcEmail);
			bcinfo.setBcBankName(bcBankName);
			bcinfo.setBcBankInfo(bcBankInfo);
			bcinfo.setBcBankNo(bcBankNo);
			bcinfo.setBcBankUser(bcBankUser);
			bcinfo.setBcType(0);
			businessContactInfoDao.save(sess, bcinfo);
			tran.commit();
			return bcinfo.getId();
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("增加往来单位信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean deleteBCInfoByID(Integer id) throws WEBException {
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			businessContactInfoDao.delete(sess, id);
			tran.commit();
			return true;
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("删除指定往来单位信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateBusinessContactInfo(Integer id,Integer bctypeId, String bcName,
			String bcPy, String bcAddress, String bcContact, String bcTel,
			String bcMobile, String bcFax, String bcEmail, String bcBankName,
			String bcBankInfo, String bcBankNo, String bcBankUser)
			throws WEBException {
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			businessTypeInfoDao = (BusinessTypeInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			BusinessContactInfo bcinfo = businessContactInfoDao.get(sess, id);
			BusinessTypeInfo businessTypeInfo = businessTypeInfoDao.get(sess, bctypeId);
			bcinfo.setBusinessTypeInfo(businessTypeInfo);
			bcinfo.setBcName(bcName);
			bcinfo.setBcPy(bcPy);
			bcinfo.setBcAddress(bcAddress);
			bcinfo.setBcContact(bcContact);
			bcinfo.setBcTel(bcTel);
			bcinfo.setBcMobile(bcMobile);
			bcinfo.setBcFax(bcFax);
			bcinfo.setBcEmail(bcEmail);
			bcinfo.setBcBankName(bcBankName);
			bcinfo.setBcBankInfo(bcBankInfo);
			bcinfo.setBcBankNo(bcBankNo);
			bcinfo.setBcBankUser(bcBankUser);
			businessContactInfoDao.update(sess, bcinfo);
			tran.commit();
			return true;
		} catch (Exception e) {
			tran.rollback();
			throw new WEBException("更新往来单位信息时出现异常!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public List<BusinessContactInfo> listBusinessContactInfo(Integer bizTypeId,String bcPy,Integer pageNo,Integer pageSize)
			throws WEBException {
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessContactInfoDao.getBCInfoList(sess, bizTypeId, bcPy, pageNo, pageSize);
		} catch (Exception e) {
			throw new WEBException("列出往来单位信息时出现异常,请重试!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getCountByOption(Integer bizTypeId, String bcPy)
			throws WEBException {
		// TODO Auto-generated method stub
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessContactInfoDao.getCountByOption(sess, bizTypeId, bcPy);
		} catch (Exception e) {
			e.printStackTrace();
			throw new WEBException("列出往来单位信息时出现异常,请重试!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getPageCount(int count, int pageSize) throws WEBException {
		// TODO Auto-generated method stub
		return (count + pageSize - 1 ) / pageSize;
	}

	public List<BusinessContactInfo> listInfoByName(String bcName)
			throws WEBException {
		// TODO Auto-generated method stub
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessContactInfoDao.getInfoByName(sess, bcName);
		} catch (Exception e) {
			throw new WEBException("根据单位名称列出往来单位信息时出现异常,请重试!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public List<BusinessContactInfo> listBcInfoByOption(Integer bcId)
			throws WEBException {
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessContactInfoDao.getInfoById(sess, bcId);
		} catch (Exception e) {
			throw new WEBException("根据指定编号列出往来单位信息时出现异常,请重试!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

	public List<BusinessContactInfo> listSpecInfo(Integer bcType) throws WEBException {
		// TODO Auto-generated method stub
		try {
			businessContactInfoDao = (BusinessContactInfoDao) DaoFactory.instance(null).getDao(Constants.DAO_BUSINESS_CONTACT_INFO);
			Session sess = HibernateUtil.currentSession();
			return businessContactInfoDao.findSpecInfo(sess,bcType);
		} catch (Exception e) {
			throw new WEBException("根据类型获取专属往来单位信息时出现异常,请重试!");
		}finally{
			HibernateUtil.closeSession();
		}
	}

}
