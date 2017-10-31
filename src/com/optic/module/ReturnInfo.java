package com.optic.module;

import java.sql.Timestamp;

/**
 * ReturnInfo entity. @author MyEclipse Persistence Tools
 */

public class ReturnInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private UserInfo userInfo;
	private BusinessContactInfo businessContactInfo;
	private ProductInfo productInfo;
	private String reNo;
	private String outNo;
	private Integer outType;
	private Integer reNum;
	private String reUName;
	private Integer reStatus;
	private String remark;
	private Timestamp reDate;

	// Constructors

	/** default constructor */
	public ReturnInfo() {
	}

	/** minimal constructor */
	public ReturnInfo(UserInfo userInfo,
			BusinessContactInfo businessContactInfo, ProductInfo productInfo,
			String reNo, String outNo, Integer outType, Integer reNum,
			String reUName, Integer reStatus,String remark, Timestamp reDate) {
		this.userInfo = userInfo;
		this.businessContactInfo = businessContactInfo;
		this.productInfo = productInfo;
		this.reNo = reNo;
		this.outNo = outNo;
		this.outType = outType;
		this.reNum = reNum;
		this.reUName = reUName;
		this.reStatus = reStatus;
		this.remark = remark;
		this.reDate = reDate;
	}

	/** full constructor */
	public ReturnInfo(Integer id,UserInfo userInfo,
			BusinessContactInfo businessContactInfo, ProductInfo productInfo,
			String reNo, String outNo, Integer outType, Integer reNum,
			String reUName, Integer reStatus,String remark, Timestamp reDate) {
		this.id = id;
		this.userInfo = userInfo;
		this.businessContactInfo = businessContactInfo;
		this.productInfo = productInfo;
		this.reNo = reNo;
		this.outNo = outNo;
		this.outType = outType;
		this.reNum = reNum;
		this.reUName = reUName;
		this.reStatus = reStatus;
		this.remark = remark;
		this.reDate = reDate;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public UserInfo getUserInfo() {
		return this.userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public BusinessContactInfo getBusinessContactInfo() {
		return this.businessContactInfo;
	}

	public void setBusinessContactInfo(BusinessContactInfo businessContactInfo) {
		this.businessContactInfo = businessContactInfo;
	}

	public ProductInfo getProductInfo() {
		return this.productInfo;
	}

	public void setProductInfo(ProductInfo productInfo) {
		this.productInfo = productInfo;
	}



	public String getReNo() {
		return reNo;
	}

	public void setReNo(String reNo) {
		this.reNo = reNo;
	}

	public String getOutNo() {
		return outNo;
	}

	public void setOutNo(String outNo) {
		this.outNo = outNo;
	}

	public Integer getOutType() {
		return this.outType;
	}

	public void setOutType(Integer outType) {
		this.outType = outType;
	}

	public Integer getReNum() {
		return this.reNum;
	}

	public void setReNum(Integer reNum) {
		this.reNum = reNum;
	}

	public String getReUName() {
		return this.reUName;
	}

	public void setReUName(String reUName) {
		this.reUName = reUName;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Timestamp getReDate() {
		return this.reDate;
	}

	public void setReDate(Timestamp reDate) {
		this.reDate = reDate;
	}

	public Integer getReStatus() {
		return reStatus;
	}

	public void setReStatus(Integer reStatus) {
		this.reStatus = reStatus;
	}

}