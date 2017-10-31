package com.optic.module;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * InStoreInfo entity. @author MyEclipse Persistence Tools
 */

public class InStoreInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private BusinessContactInfo businessContactInfo;
	private UserInfo userInfo;
	private String inONo;
	private Timestamp inDate;
	private Integer inStatus;
	private String remark;
	private Set<InStoreSubInfo> inStoreSubInfos = new HashSet<InStoreSubInfo>();

	// Constructors

	/** default constructor */
	public InStoreInfo() {
	}

	/** minimal constructor */
	public InStoreInfo(BusinessContactInfo businessContactInfo, UserInfo userInfo,
			String inONo,Timestamp inDate, Integer inStatus, String remark) {
		this.businessContactInfo = businessContactInfo;
		this.userInfo = userInfo;
		this.inONo = inONo;
		this.inDate = inDate;
		this.inStatus = inStatus;
		this.remark = remark;
	}

	/** full constructor */
	public InStoreInfo(Integer id,BusinessContactInfo businessContactInfo, UserInfo userInfo,
			String inONo,Timestamp inDate, Integer inStatus, String remark) {
		this.id = id;
		this.businessContactInfo = businessContactInfo;
		this.userInfo = userInfo;
		this.inONo = inONo;
		this.inDate = inDate;
		this.inStatus = inStatus;
		this.remark = remark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BusinessContactInfo getBusinessContactInfo() {
		return businessContactInfo;
	}

	public void setBusinessContactInfo(BusinessContactInfo businessContactInfo) {
		this.businessContactInfo = businessContactInfo;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public String getInONo() {
		return inONo;
	}

	public void setInONo(String inONo) {
		this.inONo = inONo;
	}

	public Timestamp getInDate() {
		return inDate;
	}

	public void setInDate(Timestamp inDate) {
		this.inDate = inDate;
	}

	public Integer getInStatus() {
		return inStatus;
	}

	public void setInStatus(Integer inStatus) {
		this.inStatus = inStatus;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set<InStoreSubInfo> getInStoreSubInfos() {
		return inStoreSubInfos;
	}

	public void setInStoreSubInfos(Set<InStoreSubInfo> inStoreSubInfos) {
		this.inStoreSubInfos = inStoreSubInfos;
	}

	
	// Property accessors

	

}