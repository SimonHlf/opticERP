package com.optic.module;

import java.util.HashSet;
import java.util.Set;

/**
 * WhStorageInfo entity. @author MyEclipse Persistence Tools
 */

public class WhStorageInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private WhTypeInfo whTypeInfo;
	private String whsName;
	private String whsRemark;
	private Set<InStoreSubInfo> inStoreSubInfos = new HashSet<InStoreSubInfo>();

	// Constructors

	/** default constructor */
	public WhStorageInfo() {
	}

	/** minimal constructor */
	public WhStorageInfo(String whsName, WhTypeInfo whTypeInfo, String whsRemark) {
		this.whTypeInfo = whTypeInfo;
		this.whsName = whsName;
		this.whsRemark = whsRemark;
	}

	public WhStorageInfo(Integer id, String whsName) {
		this.id = id;
		this.whsName = whsName;
	}
	
	/** full constructor */
	public WhStorageInfo(Integer id,WhTypeInfo whTypeInfo, String whsName,
			String whsRemark) {
		this.id = id;
		this.whTypeInfo = whTypeInfo;
		this.whsName = whsName;
		this.whsRemark = whsRemark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public WhTypeInfo getWhTypeInfo() {
		return whTypeInfo;
	}

	public void setWhTypeInfo(WhTypeInfo whTypeInfo) {
		this.whTypeInfo = whTypeInfo;
	}

	public String getWhsName() {
		return whsName;
	}

	public void setWhsName(String whsName) {
		this.whsName = whsName;
	}

	public String getWhsRemark() {
		return whsRemark;
	}

	public void setWhsRemark(String whsRemark) {
		this.whsRemark = whsRemark;
	}

	public Set<InStoreSubInfo> getInStoreSubInfos() {
		return inStoreSubInfos;
	}

	public void setInStoreSubInfos(Set<InStoreSubInfo> inStoreSubInfos) {
		this.inStoreSubInfos = inStoreSubInfos;
	}

	// Property accessors

	

}