package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.OutSubInfoDao;
import com.optic.module.OutSubInfo;
import com.optic.tools.CurrentTime;

public class OutSubInfoDaoImpl implements OutSubInfoDao {

	public OutSubInfo get(Session sess, int id) {
		// TODO Auto-generated method stub
		return (OutSubInfo) sess.load(OutSubInfo.class, id);
	}

	public void save(Session sess, OutSubInfo outsubInfo) {
		sess.save(outsubInfo);
	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));

	}

	public void update(Session sess, OutSubInfo outsubInfo) {
		sess.update(outsubInfo);

	}

	@SuppressWarnings("unchecked")
	public List<OutSubInfo> getInfoByoiId(Session sess, Integer oiid) {
		String hql ="from OutSubInfo as osi where osi.outInfo.id="+oiid;
		List<OutSubInfo> osiList = sess.createQuery(hql).list();
		return osiList;
	}

	@SuppressWarnings("unchecked")
	public List<OutSubInfo> getOutStoreByBatch(Session sess, Integer proID) {
		String hql="from OutSubInfo as osi where osi.outInfo.outStatus=1  and SUBSTR(osi.outInfo.applyDate,1,10)='"+CurrentTime.getStringDate()+"'  and  osi.productInfo.id="+proID+" order by osi.id desc";
		List<OutSubInfo> osiList = sess.createQuery(hql).list();
		return osiList;
	}
}
