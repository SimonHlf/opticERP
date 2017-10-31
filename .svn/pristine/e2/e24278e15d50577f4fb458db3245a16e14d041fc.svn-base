package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.OutSellInfoDao;
import com.optic.module.OutSellInfo;
import com.optic.tools.CurrentTime;

@SuppressWarnings("unchecked")
public class OutSellInfoDaoImpl implements OutSellInfoDao{

	public OutSellInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (OutSellInfo) sess.load(OutSellInfo.class, id);
	}

	public void save(Session sess, OutSellInfo osInfo) {
		// TODO Auto-generated method stub
		sess.save(osInfo);
	}

	public void delete(Session sess, OutSellInfo osInfo) {
		// TODO Auto-generated method stub
		sess.delete(osInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, OutSellInfo osInfo) {
		// TODO Auto-generated method stub
		sess.update(osInfo);
	}

	public List<OutSellInfo> findPageInfoByOption(Session sess, String osNo,
			Integer bcId, Integer oStatus, Integer oType, String sDate,
			String eDate, String expNo, Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		int offset = (pageNo-1)*pageSize;
		if(offset<0){
			offset = 0;
		}
		String hql = " from OutSellInfo as os where 1 = 1";
		if(!osNo.equals("")){
			hql += " and os.outSNo = '"+osNo+"'";
		}
		if(bcId > 0){
			hql += " and os.businessContactInfo.id = "+bcId;
		}
		if(oStatus >= 0){
			hql += " and os.outStatus = "+oStatus;
		}
		if(oType >= 0){
			hql += " and os.outType = "+oType;
		}
		if(!sDate.equals("")){
			hql += " and SUBSTR(os.outDate,1,10) >= '"+sDate+"' and SUBSTR(os.outDate,1,10) <= '"+eDate+"'";
		}
		if(!expNo.equals("")){
			hql += " and os.expressNo = '"+expNo+"'";
		}
		List<OutSellInfo> l = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return l;
	}

	public Integer getCountByOption(Session sess, String osNo, Integer bcId,
			Integer oStatus, Integer oType, String sDate, String eDate,
			String expNo) {
		// TODO Auto-generated method stub
		String hql = "select count(os.id) from OutSellInfo as os where 1 = 1";
		if(!osNo.equals("")){
			hql += " and os.outSNo = '"+osNo+"'";
		}
		if(bcId > 0){
			hql += " and os.businessContactInfo.id = "+bcId;
		}
		if(oStatus >= 0){
			hql += " and os.outStatus = "+oStatus;
		}
		if(oType >= 0){
			hql += " and os.outType = "+oType;
		}
		if(!sDate.equals("")){
			hql += " and SUBSTR(os.outDate,1,10) >= '"+sDate+"' and SUBSTR(os.outDate,1,10) <= '"+eDate+"'";
		}
		if(!expNo.equals("")){
			hql += " and os.expressNo = '"+expNo+"'";
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<OutSellInfo> getInfoByoNo(Session sess, String oNo,
			Integer otype) {
		String hql = " from OutSellInfo as os where os.outSNo='"+oNo+"'  and os.outType = "+otype;
		List<OutSellInfo> osList = sess.createQuery(hql).list();
		return osList;
	}

	public Integer getCurrOrdNum(Session sess, Integer otype) {
		String hql = "select count(os.id) from OutSellInfo as os where SUBSTR(os.outDate,1,10) = '"+ CurrentTime.getStringDate()+"'  and os.outType = "+otype+" and os.outStatus=1";
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public Double getPriceSum(Session sess, String osNo, Integer bcId,
			Integer oStatus, Integer oType, String sDate, String eDate,String sign) {
		String hql="";
		if(sign=="all"){
			hql+="select sum(os.allPrice)";
		}else if(sign=="act"){
			hql+="select sum(os.actPrice)";
		}
		hql +=" from OutSellInfo as os where 1 = 1";
		if(!osNo.equals("")){
			hql += " and os.outSNo = '"+osNo+"'";
		}
		if(bcId > 0){
			hql += " and os.businessContactInfo.id = "+bcId;
		}
		if(oStatus >= 0){
			hql += " and os.outStatus = "+oStatus;
		}
		if(oType >= 0){
			hql += " and os.outType = "+oType;
		}
		if(!sDate.equals("")){
			hql += " and SUBSTR(os.outDate,1,10) >= '"+sDate+"' and SUBSTR(os.outDate,1,10) <= '"+eDate+"'";
		}
		Double count = (Double) sess.createQuery(hql).uniqueResult();
		if(count == null){
			count = 0d;
		}
		return count;
	}
}
