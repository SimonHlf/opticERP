package com.optic.module;

import java.util.HashSet;
import java.util.Set;

/**
 * WhTypeInfo entity. @author MyEclipse Persistence Tools
 */

public class WhTypeInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private String whName;
	private String whRemark;
	private Set<WhStorageInfo> whStorageInfos = new HashSet<WhStorageInfo>();

	// Constructors

	/** default constructor */
	public WhTypeInfo() {
	}

	/** minimal constructor */
	public WhTypeInfo(String whName,String whRemark) {
		this.whName = whName;
		this.whRemark = whRemark;
	}

	/** full constructor */
	public WhTypeInfo(Integer id,String whName, String whRemark) {
		this.id = id;
		this.whName = whName;
		this.whRemark = whRemark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getWhName() {
		return whName;
	}

	public void setWhName(String whName) {
		this.whName = whName;
	}

	public String getWhRemark() {
		return whRemark;
	}

	public void setWhRemark(String whRemark) {
		this.whRemark = whRemark;
	}

	public Set<WhStorageInfo> getWhStorageInfos() {
		return whStorageInfos;
	}

	public void setWhStorageInfos(Set<WhStorageInfo> whStorageInfos) {
		this.whStorageInfos = whStorageInfos;
	}

	// Property accessors

	
}