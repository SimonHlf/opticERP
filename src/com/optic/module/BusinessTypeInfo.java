package com.optic.module;

import java.util.HashSet;
import java.util.Set;

/**
 * BusinessTypeInfo entity. @author MyEclipse Persistence Tools
 */

public class BusinessTypeInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String btName;
	private String btRemark;
	private Set<BusinessContactInfo> businessContactInfos = new HashSet<BusinessContactInfo>();

	// Constructors

	/** default constructor */
	public BusinessTypeInfo() {
	}

	/** minimal constructor */
	public BusinessTypeInfo(String btName, String btRemark) {
		this.btName = btName;
		this.btRemark = btRemark;
	}

	/** full constructor */
	public BusinessTypeInfo(Integer id,String btName, String btRemark) {
		this.id = id;
		this.btName = btName;
		this.btRemark = btRemark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getBtName() {
		return btName;
	}

	public void setBtName(String btName) {
		this.btName = btName;
	}

	public String getBtRemark() {
		return btRemark;
	}

	public void setBtRemark(String btRemark) {
		this.btRemark = btRemark;
	}

	public Set<BusinessContactInfo> getBusinessContactInfos() {
		return businessContactInfos;
	}

	public void setBusinessContactInfos(
			Set<BusinessContactInfo> businessContactInfos) {
		this.businessContactInfos = businessContactInfos;
	}

	// Property accessors

	

}