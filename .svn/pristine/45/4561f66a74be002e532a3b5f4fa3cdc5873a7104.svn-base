package com.optic.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Session;
import org.hibernate.Transaction;

import com.optic.dao.WhStorageInfoDao;
import com.optic.dao.WhTypeInfoDao;
import com.optic.exception.WEBException;
import com.optic.factory.DaoFactory;
import com.optic.module.WhStorageInfo;
import com.optic.module.WhTypeInfo;
import com.optic.service.WhStorageInfoManager;
import com.optic.tools.HibernateUtil;
import com.optic.util.Constants;

public class WhStorageInfoManagerImpl implements WhStorageInfoManager{

	public Integer addWSI(String whsName, Integer whId, String whsRemark)
			throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		WhTypeInfoDao wtiDao = null;
		Transaction tran = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			WhTypeInfo wti = wtiDao.get(sess, whId);
			WhStorageInfo wsi = new WhStorageInfo(whsName,wti,whsRemark);
			wsiDao.save(sess, wsi);
			tran.commit();
			return wti.getId();
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("增加仓库货架信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean updateWSI(Integer id, String whsName, Integer whId,
			String whsRemark) throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		WhTypeInfoDao wtiDao = null;
		Transaction tran = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			wtiDao = (WhTypeInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_TYPE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			WhStorageInfo wsi = wsiDao.get(sess, id);
			if(whsName.equals("") || whsName == null){
				
			}else{
				wsi.setWhsName(whsName);
			}
			if(whId > 0){
				wsi.setWhTypeInfo(wtiDao.get(sess, whId));
			}
			if(whsRemark.equals("") || whsRemark == null){
				
			}else{
				wsi.setWhsRemark(whsRemark);
			}
			wsiDao.update(sess, wsi);
			tran.commit();
			return true;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("修改仓库货架信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<WhStorageInfo> listAllInfoByTypeId(Integer whId)
			throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			return wsiDao.getAllInfoByTypeId(sess, whId);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("获取指定仓库类别下的仓库货架信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean delWSIById(Integer id) throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		Transaction tran = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			tran = sess.beginTransaction();
			wsiDao.delete(sess, id);
			tran.commit();
			return true;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("删除仓库货架信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public List<WhStorageInfo> listPageInfoByOption(Integer whId,
			String whsName, Integer pageNo, Integer pageSize)
			throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			return wsiDao.findPageInfoByOption(sess, whId, whsName, pageNo, pageSize);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("根据仓库类别编号、货架名称分页查询货架信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getCountByOption(Integer whId, String whsName)
			throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			return wsiDao.getCountByOption(sess, whId, whsName);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("根据仓库类别编号、货架名称分页查询货架记录条数时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public Integer getPageCount(int count, int pageSize) throws WEBException {
		// TODO Auto-generated method stub
		return (count + pageSize - 1 ) / pageSize;
	}

	public List<WhStorageInfo> listDetailInfoById(Integer whsId)
			throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			return wsiDao.findDetailInfoById(sess, whsId);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("获取指定仓库货架的详细信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

	public boolean checkExistFlagByWhsName(Integer whId,String whsName) throws WEBException {
		// TODO Auto-generated method stub
		WhStorageInfoDao wsiDao = null;
		try {
			wsiDao = (WhStorageInfoDao)DaoFactory.instance(null).getDao(Constants.DAO_WH_STORAGE_INFO);
			Session sess = HibernateUtil.currentSession();
			List<WhStorageInfo> whsList = wsiDao.findInfoByWhsName(sess, whId, whsName);
			if(whsList.size() > 0){
				return true;
			}
			return false;
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			throw new WEBException("根据货架名称查询是否存在记录信息时出现异常!");
		} finally{
			HibernateUtil.closeSession();
		}
	}

}
