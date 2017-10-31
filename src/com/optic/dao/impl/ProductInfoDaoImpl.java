package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.ProductInfoDao;
import com.optic.module.ProductInfo;

@SuppressWarnings("unchecked")
public class ProductInfoDaoImpl implements ProductInfoDao {

	public ProductInfo get(Session sess, int id) {
		return (ProductInfo)sess.load(ProductInfo.class, id);
	}

	public void save(Session sess, ProductInfo productInfo) {
		sess.save(productInfo);
	}

	public void delete(Session sess, ProductInfo productInfo) {
		sess.delete(productInfo);

	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));

	}

	public void update(Session sess, ProductInfo productInfo) {
		sess.update(productInfo);

	}
	
	public List<ProductInfo> getInfoById(Session sess, Integer id) {		
		String hql = " from ProductInfo as pi where pi.id = "+id;
		List<ProductInfo> pList = sess.createQuery(hql).list();
		return pList;
	}

	
	public List<ProductInfo> getProductInfoList(Session sess,Integer proTypeId , String proPy,Boolean inNumStatus,Boolean madeStatus,int pageNo, int pageSize) {
		int offset = (pageNo-1)*pageSize;
		if(offset<0){
			offset = 0;
		}
		String hql = " from ProductInfo as pi where 1=1";
		if(!proTypeId.equals(0)){
			hql += " and pi.productTypeInfo.id="+proTypeId;
		}
		if(!proPy.equals("")){
			hql += " and pi.proPy='"+proPy+"'";
		}
		if(inNumStatus){//库存量必须大于0
			hql += " and pi.proNumber > 0";
		}
		if(madeStatus){//综合加工的除外
			hql += " and pi.depInfo.depName != '综合加工'";
		}
		List<ProductInfo> pList = sess.createQuery(hql).setFirstResult(offset).setMaxResults(pageSize).list();
		return pList;
	}

	public Integer getProInfoCount(Session sess, Integer proTypeId, String proPy, Boolean inNumStatus,Boolean madeStatus) {
		String hql = "select count(pi.id) from ProductInfo as pi  where 1=1";
		if(!proTypeId.equals(0)){
			hql += " and pi.productTypeInfo.id="+proTypeId;
		}
		if(!proPy.equals("")){
			hql += " and pi.proPy='"+proPy+"'";
		}
		if(inNumStatus){//库存量必须大于0
			hql += " and pi.proNumber > 0";
		}
		if(madeStatus){//综合加工的除外
			hql += " and pi.depInfo.depName != '综合加工'";
		}
		long proCount = (Long) sess.createQuery(hql).uniqueResult();
		return  (int) proCount;
	}

	public boolean checkExistByName(Session sess, String proName) {
		// TODO Auto-generated method stub
		String hql = " from ProductInfo as pi where pi.proName = '"+proName+"'";
		List<ProductInfo> pList = sess.createQuery(hql).list();
		if(pList.size() > 0){
			return true;
		}
		return false;
	}

	public boolean checkExistByCode(Session sess, String proCode) {
		// TODO Auto-generated method stub
		String hql = " from ProductInfo as pi where pi.proNo = '"+proCode+"'";
		List<ProductInfo> pList = sess.createQuery(hql).list();
		if(pList.size() > 0){
			return true;
		}
		return false;
	}

}
