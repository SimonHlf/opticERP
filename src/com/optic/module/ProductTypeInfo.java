package com.optic.module;

import java.util.HashSet;
import java.util.Set;

/**
 * ProductTypeInfo entity. @author MyEclipse Persistence Tools
 */

public class ProductTypeInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String typeName;
	private String typeRemark;
	private String typePy;
	private Set<ProductInfo> productInfos = new HashSet<ProductInfo>();

	// Constructors

	/** default constructor */
	public ProductTypeInfo() {
	}

	/** minimal constructor */
	public ProductTypeInfo(String typeName, String typeRemark,String typePy) {
		this.typeName = typeName;
		this.typeRemark = typeRemark;
		this.typePy = typePy;
	}

	/** full constructor */
	public ProductTypeInfo(Integer id,String typeName, String typeRemark,String typePy) {
		this.id = id;
		this.typeName = typeName;
		this.typeRemark = typeRemark;
		this.typePy = typePy;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	public String getTypeRemark() {
		return typeRemark;
	}

	public void setTypeRemark(String typeRemark) {
		this.typeRemark = typeRemark;
	}
	public String getTypePy() {
		return typePy;
	}

	public void setTypePy(String typePy) {
		this.typePy = typePy;
	}
	public Set<ProductInfo> getProductInfos() {
		return productInfos;
	}

	public void setProductInfos(Set<ProductInfo> productInfos) {
		this.productInfos = productInfos;
	}

	

	// Property accessors

	

}