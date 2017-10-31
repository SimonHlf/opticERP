package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.InstoreInfoDao;
import com.optic.module.InStoreInfo;

@SuppressWarnings("unchecked")
public class InstoreInfoDaoImpl implements InstoreInfoDao{

	public InStoreInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (InStoreInfo)sess.load(InStoreInfo.class, id);
	}

	public void save(Session sess, InStoreInfo inStoreInfo) {
		// TODO Auto-generated method stub
		sess.save(inStoreInfo);
	}

	public void delete(Session sess, InStoreInfo inStoreInfo) {
		// TODO Auto-generated method stub
		sess.delete(inStoreInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, InStoreInfo inStoreInfo) {
		// TODO Auto-generated method stub
		sess.update(inStoreInfo);
	}

	public List<InStoreInfo> findPageInfoByOption(Session sess, String isNo,
			String isDate_s, String isDate_e, Integer inStatus, Integer proId,
			Integer bcId, Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		String hql = " from InStoreInfo as ins where 1 = 1";
		if(!isNo.equals("")){
			hql += " and ins.inONo = '"+isNo+"'";
		}else{
			if(!isDate_s.equals("")){
				hql += " and SUBSTR(ins.inDate,1,10) >= '"+isDate_s+"' and SUBSTR(ins.inDate,1,10) <= '"+isDate_e+"'";
			}
			if(inStatus > -1){
				hql += " and ins.inStatus = "+inStatus;
			}
			if(bcId > 0){
				hql += " and ins.businessContactInfo.id = "+bcId;
			}
			if(proId > 0){
				hql += " and exists (select iss.id from InStoreSubInfo as iss where iss.productInfo.id = "+proId+" and iss.inStoreInfo.id = ins.id)";
			}
		}
		hql += " order by ins.id desc";
		int offset = (pageNo - 1) * pageSize;
		if (offset < 0) {
			offset = 0;
		}
		List<InStoreInfo> l = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return l;
	}

	public Integer getCountByOption(Session sess, String isNo, String isDate_s,
			String isDate_e, Integer inStatus, Integer proId, Integer bcId) {
		// TODO Auto-generated method stub
		String hql = "select count(ins.id) from InStoreInfo as ins where 1 = 1";
		if(!isNo.equals("")){
			hql += " and ins.inONo = '"+isNo+"'";
		}else{
			if(!isDate_s.equals("")){
				hql += " and SUBSTR(ins.inDate,1,10) >= '"+isDate_s+"' and SUBSTR(ins.inDate,1,10) <= '"+isDate_e+"'";
			}
			if(inStatus > -1){
				hql += " and ins.inStatus = "+inStatus;
			}
			if(bcId > 0){
				hql += " and ins.businessContactInfo.id = "+bcId;
			}
			if(proId > 0){
				hql += " and exists (select iss.id from InStoreSubInfo as iss where iss.productInfo.id = "+proId+" and iss.inStoreInfo.id = ins.id)";
			}
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<InStoreInfo> findLastInfo(Session sess) {
		// TODO Auto-generated method stub
		String hql = " from InStoreInfo as ins order by ins.id desc";
		List<InStoreInfo> l = sess.createQuery(hql).setFirstResult(0).list();
		return l;
	}

}
