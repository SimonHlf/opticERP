package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.WhStorageInfoDao;
import com.optic.module.WhStorageInfo;

@SuppressWarnings("unchecked")
public class WhStorageInfoDaoImpl implements WhStorageInfoDao{

	public WhStorageInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (WhStorageInfo)sess.load(WhStorageInfo.class, id);
	}

	public void save(Session sess, WhStorageInfo whStorageInfo) {
		// TODO Auto-generated method stub
		sess.save(whStorageInfo);
	}

	public void delete(Session sess, WhStorageInfo whStorageInfo) {
		// TODO Auto-generated method stub
		sess.delete(whStorageInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, WhStorageInfo whStorageInfo) {
		// TODO Auto-generated method stub
		sess.update(whStorageInfo);
	}

	public List<WhStorageInfo> getInfoById(Session sess, Integer id) {
		// TODO Auto-generated method stub
		String hql = " from WhStorageInfo as whsi where whsi.id = "+id;
		List<WhStorageInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<WhStorageInfo> getAllInfoByTypeId(Session sess, Integer typeId) {
		// TODO Auto-generated method stub
		String hql = " from WhStorageInfo as whsi where whsi.whTypeInfo.id = "+typeId;
		List<WhStorageInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<WhStorageInfo> findPageInfoByOption(Session sess, Integer typeId,
			String whsName, Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		String hql = " from WhStorageInfo as whsi where 1=1";
		if(typeId > 0){
			hql += " and whsi.whTypeInfo.id = "+typeId;
		}
		if(!whsName.equals("")){
			hql += " and whsi.whsName like '%"+whsName+"%'";
		}
		int offset = (pageNo - 1) * pageSize;
		if (offset < 0) {
			offset = 0;
		}
		List<WhStorageInfo> l = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return l;
	}

	public Integer getCountByOption(Session sess, Integer typeId, String whsName) {
		// TODO Auto-generated method stub
		String hql = "select count(whsi.id) from WhStorageInfo as whsi where 1=1";
		if(typeId > 0){
			hql += " and whsi.whTypeInfo.id = "+typeId;
		}
		if(!whsName.equals("")){
			hql += " and whsi.whsName like '%"+whsName+"%'";
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<WhStorageInfo> findDetailInfoById(Session sess, Integer whsId) {
		// TODO Auto-generated method stub
		String hql = " from WhStorageInfo as whsi where whsi.id = "+whsId;
		List<WhStorageInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<WhStorageInfo> findInfoByWhsName(Session sess, Integer whId, String whsName) {
		// TODO Auto-generated method stub
		String hql = " from WhStorageInfo as whsi where whsi.whsName = '"+whsName+"' and whsi.whTypeInfo.id = "+whId;
		List<WhStorageInfo> l = sess.createQuery(hql).list();
		return l;
	}

}
