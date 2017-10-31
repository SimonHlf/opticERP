package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PLossInfoDao;
import com.optic.module.PLossInfo;

@SuppressWarnings("unchecked")
public class PLossInfoDaoImpl implements PLossInfoDao{

	public PLossInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PLossInfo) sess.load(PLossInfo.class, id);
	}

	public void save(Session sess, PLossInfo pLossInfo) {
		// TODO Auto-generated method stub
		sess.save(pLossInfo);
	}

	public void delete(Session sess, PLossInfo pLossInfo) {
		// TODO Auto-generated method stub
		sess.delete(pLossInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PLossInfo pLossInfo) {
		// TODO Auto-generated method stub
		sess.update(pLossInfo);
	}

	public List<PLossInfo> findPageInfoByOption(Session sess, String proNo,
			String sDate, String eDate, Integer comStatus, Integer pageNo,
			Integer pageSize) {
		// TODO Auto-generated method stub
		String hql = " from PLossInfo as pl where 1=1";
		if(!proNo.equals("")){
			hql += " and pl.pro.proNo = '"+proNo+"'";
		}
		if(!sDate.equals("") && !eDate.equals("")){
			hql += " and SUBSTR(pl.startTime,1,7) >= '"+sDate+"'";
			hql += " and SUBSTR(pl.startTime,1,7) <= '"+eDate+"'";
		}
		if(comStatus >= 0){
			hql += " and pl.comStatus = "+comStatus;
		}
		hql += " order by pl.id desc";
		int offset = (pageNo - 1) * pageSize;
		if (offset < 0) {
			offset = 0;
		}
		return sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
	}

	public Integer getCountByOption(Session sess, String proNo, String sDate,
			String eDate, Integer comStatus) {
		// TODO Auto-generated method stub
		String hql = "select count(pl.id) from PLossInfo as pl where 1=1";
		if(!proNo.equals("")){
			hql += " and pl.pro.proNo = '"+proNo+"'";
		}
		if(!sDate.equals("") && !eDate.equals("")){
			hql += " and SUBSTR(pl.startTime,1,7) >= '"+sDate+"'";
			hql += " and SUBSTR(pl.startTime,1,7) <= '"+eDate+"'";
		}
		if(comStatus >= 0){
			hql += " and pl.comStatus = "+comStatus;
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<PLossInfo> findInfoById(Session sess, Integer plId) {
		// TODO Auto-generated method stub
		String hql = " from PLossInfo as pl where pl.id = "+plId;
		return sess.createQuery(hql).list();
	}

	public List<PLossInfo> findUnComInfoByProId(Session sess, Integer pId) {
		// TODO Auto-generated method stub
		String hql = " from PLossInfo as pl where pl.pro.id = "+pId + " and pl.comStatus = 0";
		return sess.createQuery(hql).list();
	}

}
