package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.OutInfoDao;
import com.optic.module.OutInfo;

public class OutInfoDaoImpl implements OutInfoDao {

	public OutInfo get(Session sess, int id) {
		
		return (OutInfo) sess.load(OutInfo.class, id);
	}

	public void save(Session sess, OutInfo outInfo) {
		sess.save(outInfo);
	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, OutInfo outInfo) {
		sess.update(outInfo);
	}

	@SuppressWarnings("unchecked")
	public List<OutInfo> getInfoById(Session sess, Integer id) {
		String hql = " from OutInfo as oi where oi.id = "+id;
		List<OutInfo> oiList = sess.createQuery(hql).list();
		return oiList;
	}

	@SuppressWarnings("unchecked")
	public List<OutInfo> getOutSubInfoList(Session sess, String o_no,
			Integer proid, Integer o_sta, String sDate, String eDate,
			int pageNo, int pageSize) {
		int offset = (pageNo - 1) * pageSize;
		if (offset < 0) {
			offset = 0;
		}
		String hql="from OutInfo as oi where 1=1 ";
		if(!o_no.equals("")){
			hql +=" and oi.outNo='"+o_no+"'";
		}else{
			if(!proid.equals(-1)){
				hql +=" and exists(select osi.id from OutSubInfo  as osi where oi.id=osi.outInfo.id and osi.productInfo.id="+proid+")";
			}
			if(o_sta>=0){
				hql +=" and oi.outStatus="+o_sta;
			}
			if(!sDate.equals("")&&!eDate.equals("")){
				hql += " and SUBSTR(oi.applyDate,1,10) >= '"+sDate+"' and SUBSTR(oi.applyDate,1,10) <= '"+eDate+"'";
			}
		}
		hql += " order by oi.id desc";
		List<OutInfo> osiList = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return osiList;
	}

	public Integer getOutSubInfoCount(Session sess, String o_no, Integer proid,
			Integer o_sta, String sDate, String eDate) {
		String hql="select count(oi.id)from OutInfo as oi where 1=1 ";
		if(!o_no.equals("")){
			hql +=" and oi.outNo='"+o_no+"'";
		}else{
			if(!proid.equals(-1)){
				hql +=" and exists(select osi.id from OutSubInfo  as osi where oi.id=osi.outInfo.id and osi.productInfo.id="+proid+")";
			}
			if(o_sta>=0){
				hql +=" and oi.outStatus="+o_sta;
			}
			if(!sDate.equals("")&&!eDate.equals("")){
				hql += " and SUBSTR(oi.applyDate,1,10) >= '"+sDate+"' and SUBSTR(oi.applyDate,1,10) <= '"+eDate+"'";
			}
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	@SuppressWarnings("unchecked")
	public List<OutInfo> getLastInfo(Session sess) {
		String hql = " from OutInfo as oi order by oi.id desc";
		List<OutInfo> l = sess.createQuery(hql).setFirstResult(0).list();
		return l;
	}

	@SuppressWarnings("unchecked")
	public List<OutInfo> getInfoByoNo(Session sess, String outNo) {
		String hql="from OutInfo as oi where oi.outNo='"+outNo+"'";
		List<OutInfo> l = sess.createQuery(hql).setFirstResult(0).list();
		return l;
	}

}
