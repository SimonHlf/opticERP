package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.PurchaseOrderInfoDao;
import com.optic.module.PurchaseOrderInfo;

@SuppressWarnings("unchecked")
public class PurchaseOrderInfoDaoImpl implements PurchaseOrderInfoDao{

	public PurchaseOrderInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (PurchaseOrderInfo)sess.load(PurchaseOrderInfo.class, id);
	}

	public void save(Session sess, PurchaseOrderInfo purchaseOrderInfo) {
		// TODO Auto-generated method stub
		sess.save(purchaseOrderInfo);
	}

	public void delete(Session sess, PurchaseOrderInfo purchaseOrderInfo) {
		// TODO Auto-generated method stub
		sess.delete(purchaseOrderInfo);
	}

	public void delete(Session sess, int id) {
		// TODO Auto-generated method stub
		sess.delete(this.get(sess, id));
	}

	public void update(Session sess, PurchaseOrderInfo purchaseOrderInfo) {
		// TODO Auto-generated method stub
		sess.update(purchaseOrderInfo);
	}

	public List<PurchaseOrderInfo> findInfoByOption(Session sess, Integer bcId, String poNo, String poDate_s,
			String poDate_e, Integer poStatus, Integer payStatus, Integer pageNo, Integer pageSize) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderInfo as po where 1 = 1";
		//poNo和poDate二者只能选其一
		if(!poNo.equals("")){
			hql += " and po.purONo = '"+poNo+"'";
		}else{
			if(bcId > 0){
				hql += " and po.businessContactInfo.id = "+bcId;
			}
			if(!poDate_s.equals("")){
				hql += " and SUBSTR(po.purDate,1,10) >= '"+poDate_s+"' and SUBSTR(po.purDate,1,10) <= '"+poDate_e+"'";
			}
			if(poStatus > -1){
				hql += " and po.status = "+poStatus;
			}
			if(payStatus > -2){
				hql += " and po.payStatus = "+payStatus;
			}
		}
		hql += " order by po.id desc";
		int offset = (pageNo - 1) * pageSize;
		if (offset < 0) {
			offset = 0;
		}
		List<PurchaseOrderInfo> l = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return l;
	}

	public Integer getCountByOption(Session sess, Integer bcId, String poNo, String poDate_s,
			String poDate_e, Integer poStatus, Integer payStatus) {
		// TODO Auto-generated method stub
		String hql = "select count(po.id) from PurchaseOrderInfo as po where 1 = 1";
		//poNo和poDate二者只能选其一
		if(!poNo.equals("")){
			hql += " and po.purONo = '"+poNo+"'";
		}else{
			if(bcId > 0){
				hql += " and po.businessContactInfo.id = "+bcId;
			}
			if(!poDate_s.equals("")){
				hql += " and SUBSTR(po.purDate,1,10) >= '"+poDate_s+"' and SUBSTR(po.purDate,1,10) <= '"+poDate_e+"'";
			}
			if(poStatus > -1){
				hql += " and po.status = "+poStatus;
			}
			if(payStatus > -2){
				hql += " and po.payStatus = "+payStatus;
			}
		}
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public Integer getMaxNumberByDate(Session sess,String currDate) {
		// TODO Auto-generated method stub
		String hql = "select count(po.id) from PurchaseOrderInfo as po where SUBSTR(po.purDate,1,10) = '"+currDate+"'";
		long count = (Long) sess.createQuery(hql).uniqueResult();
		return (int)count;
	}

	public List<PurchaseOrderInfo> findInfoById(Session sess, Integer id) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderInfo as po where po.id = "+id;
		List<PurchaseOrderInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<PurchaseOrderInfo> findUnFinishInfoBybcId(Session sess, Integer bcId,String purNo) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderInfo as po where po.businessContactInfo.id = "+bcId+ " and po.status < 2";
		if(!purNo.equals("")){
			hql += " and po.purONo like '%"+purNo+"%'";
		}
		return sess.createQuery(hql).list();
	}

	public List<PurchaseOrderInfo> findInfoByOption(Session sess,
			Integer bcId, String poNo, String poDate_s, String poDate_e,
			Integer poStatus, Integer payStatus) {
		// TODO Auto-generated method stub
		String hql = " from PurchaseOrderInfo as po where 1 = 1";
		//poNo和poDate二者只能选其一
		if(!poNo.equals("")){
			hql += " and po.purONo = '"+poNo+"'";
		}else{
			if(bcId > 0){
				hql += " and po.businessContactInfo.id = "+bcId;
			}
			if(!poDate_s.equals("")){
				hql += " and SUBSTR(po.purDate,1,10) >= '"+poDate_s+"' and SUBSTR(po.purDate,1,10) <= '"+poDate_e+"'";
			}
			if(poStatus > -1){
				hql += " and po.status = "+poStatus;
			}
			if(payStatus > -2){
				hql += " and po.payStatus = "+payStatus;
			}
		}
		hql += " order by po.id desc";
		List<PurchaseOrderInfo> l = sess.createQuery(hql).list();
		return l;
	}

	public List<Object> findTjInfoByOption(Session sess, Integer bcId,
			String poNo, String poDate_s, String poDate_e, Integer poStatus,
			Integer payStatus) {
		// TODO Auto-generated method stub
		String hql = "select sum(po.purTotalMoney) as ptm, sum(po.purRealMoney) as prm from PurchaseOrderInfo as po where 1 = 1";
		//poNo和poDate二者只能选其一
		if(!poNo.equals("")){
			hql += " and po.purONo = '"+poNo+"'";
		}else{
			if(bcId > 0){
				hql += " and po.businessContactInfo.id = "+bcId;
			}
			if(!poDate_s.equals("")){
				hql += " and SUBSTR(po.purDate,1,10) >= '"+poDate_s+"' and SUBSTR(po.purDate,1,10) <= '"+poDate_e+"'";
			}
			if(poStatus > -1){
				hql += " and po.status = "+poStatus;
			}
			if(payStatus > -2){
				hql += " and po.payStatus = "+payStatus;
			}
		}
		List<Object> l = sess.createQuery(hql).list();
		return l;
	}
}
