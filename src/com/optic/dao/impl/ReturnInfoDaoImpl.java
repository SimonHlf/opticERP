package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.ReturnInfoDao;
import com.optic.module.ReturnInfo;

@SuppressWarnings("unchecked")
public class ReturnInfoDaoImpl implements ReturnInfoDao{

	public ReturnInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (ReturnInfo)sess.load(ReturnInfo.class, id);
	}

	public void save(Session sess, ReturnInfo returnInfo) {
		// TODO Auto-generated method stub
		sess.save(returnInfo);
	}

	public void delete(Session sess, ReturnInfo returnInfo) {
		// TODO Auto-generated method stub
		sess.delete(returnInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, ReturnInfo returnInfo) {
		// TODO Auto-generated method stub
		sess.update(returnInfo);
	}

	public List<ReturnInfo> findPageInfoByOption(Session sess,String reNo,String outNo,
			Integer outType, Integer proId, Integer bcId, Integer reStatus,
			String reDate_s, String reDate_e, Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		int offset = (pageNo-1)*pageSize;
		if(offset<0){
			offset = 0;
		}
		String hql = " from ReturnInfo as ri where 1 = 1";
		if(!reNo.equals("")){
			hql += " and ri.reNo = '"+reNo+"'";
		}
		if(!outNo.equals("")){
			hql += " and ri.outNo = '"+outNo+"'";
		}
		if(!outType.equals(-1)){
			hql += " and ri.outType = "+outType;
		}
		if(!proId.equals(-1)){
			hql += " and ri.productInfo.id = "+proId;
		}
		if(!bcId.equals(-1)){
			hql += " and ri.businessContactInfo.id = "+bcId;
		}
		if(!reStatus.equals(-1)){
			hql += " and ri.reStatus = "+reStatus;
		}
		if(!reDate_s.equals("")){
			hql += " and SUBSTR(ri.reDate,1,10) >= '"+reDate_s+"' and SUBSTR(ri.reDate,1,10) <= '"+reDate_e+"'";
		}
		List<ReturnInfo> l = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return l;
	}

	public Integer getCountByOption(Session sess,String reNo,String outNo, Integer outType,
			Integer proId, Integer bcId, Integer reStatus, String reDate_s, String reDate_e) {
		// TODO Auto-generated method stub
		String hql = "select count(re.id) from ReturnInfo as ri where 1 = 1";
		if(!reNo.equals("")){
			hql += " and ri.reNo = '"+reNo+"'";
		}
		if(!outNo.equals("")){
			hql += " and ri.outNo = '"+outNo+"'";
		}
		if(!outType.equals(-1)){
			hql += " and ri.outType = "+outType;
		}
		if(!proId.equals(-1)){
			hql += " and ri.productInfo.id = "+proId;
		}
		if(!bcId.equals(-1)){
			hql += " and ri.businessContactInfo.id = "+bcId;
		}
		if(!reStatus.equals(-1)){
			hql += " and ri.reStatus = "+reStatus;
		}
		if(!reDate_s.equals("")){
			hql += " and SUBSTR(ri.reDate,1,10) >= '"+reDate_s+"' and SUBSTR(ri.reDate,1,10) <= '"+reDate_e+"'";
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<ReturnInfo> findLastInfo(Session sess) {
		// TODO Auto-generated method stub
		String hql = " from ReturnInfo as ri order by ri.id desc";
		List<ReturnInfo> l = sess.createQuery(hql).setFirstResult(0).list();
		return l;
	}

}
