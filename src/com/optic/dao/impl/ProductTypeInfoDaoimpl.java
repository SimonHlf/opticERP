package com.optic.dao.impl;

import java.util.List;

import org.hibernate.Session;

import com.optic.dao.ProductTypeInfoDao;
import com.optic.module.ProductTypeInfo;

@SuppressWarnings("unchecked")
public class ProductTypeInfoDaoimpl implements ProductTypeInfoDao {

	public ProductTypeInfo get(Session sess, int id) {
		return (ProductTypeInfo)sess.load(ProductTypeInfo.class, id);
	}

	public void save(Session sess, ProductTypeInfo productTypeInfo) {
		sess.save(productTypeInfo);
	}

	public void delete(Session sess, ProductTypeInfo productTypeInfo) {
		sess.delete(productTypeInfo);

	}

	public void delete(Session sess, int id) {
		sess.delete(this.get(sess, id));

	}

	public void update(Session sess, ProductTypeInfo productTypeInfo) {
		sess.update(productTypeInfo);

	}
	
	public List<ProductTypeInfo> getInfoById(Session sess, Integer id) {
		
		String hql = " from ProductTypeInfo as pti where pti.id = "+id;
		List<ProductTypeInfo> ptList = sess.createQuery(hql).list();
		return ptList;
	}

	public List<ProductTypeInfo> getProductTypeInfoList(Session sess,String typePy) {
		String hql = " from ProductTypeInfo as pti where 1=1";
		if(!typePy.equals("")){
			hql+=" and pti.typePy='"+typePy+"'";
		}
		List<ProductTypeInfo> ptList = sess.createQuery(hql).list();
		return ptList;
	}

	public boolean checkExistByName(Session sess, String typeName) {
		// TODO Auto-generated method stub
		String hql = " from ProductTypeInfo as pti where pti.typeName = '"+typeName+"'";
		List<ProductTypeInfo> ptList = sess.createQuery(hql).list();
		if(ptList.size() > 0){
			return true;
		}
		return false;
	}
}
