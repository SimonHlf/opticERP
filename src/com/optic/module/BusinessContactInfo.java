package com.optic.module;

import java.util.HashSet;
import java.util.Set;

/**
 * BusinessContactInfo entity. @author MyEclipse Persistence Tools
 */

public class BusinessContactInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private BusinessTypeInfo businessTypeInfo;
	private String bcName;
	private String bcPy;
	private String bcAddress;
	private String bcContact;
	private String bcTel;
	private String bcMobile;
	private String bcFax;
	private String bcEmail;
	private String bcBankName;
	private String bcBankInfo;
	private String bcBankNo;
	private String bcBankUser;
	private Integer bcType;
	private Set<InStoreInfo> inStoreInfos = new HashSet<InStoreInfo>();
	private Set<PurchaseOrderSubInfo> purchaseOrderSubInfos = new HashSet<PurchaseOrderSubInfo>();
	private Set<OutSellInfo> outSellInfos = new HashSet<OutSellInfo>();
	private Set<PurchaseOrderInfo> purchaseOrderInfos = new HashSet<PurchaseOrderInfo>();
	private Set<ReturnInfo> returnInfos = new HashSet<ReturnInfo>();

	// Constructors

	/** default constructor */
	public BusinessContactInfo() {
	}

	/** minimal constructor */
	public BusinessContactInfo(BusinessTypeInfo businessTypeInfo, String bcName,
			String bcPy, String bcAddress, String bcContact, String bcTel,
			String bcMobile, String bcFax, String bcEmail, String bcBankName,
			String bcBankInfo, String bcBankNo, String bcBankUser,Integer bcType) {
		this.businessTypeInfo = businessTypeInfo;
		this.bcName = bcName;
		this.bcPy = bcPy;
		this.bcAddress = bcAddress;
		this.bcContact = bcContact;
		this.bcTel = bcTel;
		this.bcMobile = bcMobile;
		this.bcFax = bcFax;
		this.bcEmail = bcEmail;
		this.bcBankName = bcBankName;
		this.bcBankInfo = bcBankInfo;
		this.bcBankNo = bcBankNo;
		this.bcBankUser = bcBankUser;
		this.bcType = bcType;
	}

	public BusinessContactInfo(Integer id,String bcName){
		this.id = id;
		this.bcName = bcName;
	}
	
	/** full constructor */
	public BusinessContactInfo(Integer id,BusinessTypeInfo businessTypeInfo, String bcName,
			String bcPy, String bcAddress, String bcContact, String bcTel,
			String bcMobile, String bcFax, String bcEmail, String bcBankName,
			String bcBankInfo, String bcBankNo, String bcBankUser,Integer bcType) {
		this.id = id;
		this.businessTypeInfo = businessTypeInfo;
		this.businessTypeInfo = businessTypeInfo;
		this.bcName = bcName;
		this.bcPy = bcPy;
		this.bcAddress = bcAddress;
		this.bcContact = bcContact;
		this.bcTel = bcTel;
		this.bcMobile = bcMobile;
		this.bcFax = bcFax;
		this.bcEmail = bcEmail;
		this.bcBankName = bcBankName;
		this.bcBankInfo = bcBankInfo;
		this.bcBankNo = bcBankNo;
		this.bcBankUser = bcBankUser;
		this.bcType = bcType;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public BusinessTypeInfo getBusinessTypeInfo() {
		return businessTypeInfo;
	}

	public void setBusinessTypeInfo(BusinessTypeInfo businessTypeInfo) {
		this.businessTypeInfo = businessTypeInfo;
	}

	public String getBcName() {
		return bcName;
	}

	public void setBcName(String bcName) {
		this.bcName = bcName;
	}

	public String getBcPy() {
		return bcPy;
	}

	public void setBcPy(String bcPy) {
		this.bcPy = bcPy;
	}

	public String getBcAddress() {
		return bcAddress;
	}

	public void setBcAddress(String bcAddress) {
		this.bcAddress = bcAddress;
	}

	public String getBcContact() {
		return bcContact;
	}

	public void setBcContact(String bcContact) {
		this.bcContact = bcContact;
	}

	public String getBcTel() {
		return bcTel;
	}

	public void setBcTel(String bcTel) {
		this.bcTel = bcTel;
	}

	public String getBcMobile() {
		return bcMobile;
	}

	public void setBcMobile(String bcMobile) {
		this.bcMobile = bcMobile;
	}

	public String getBcFax() {
		return bcFax;
	}

	public void setBcFax(String bcFax) {
		this.bcFax = bcFax;
	}

	public String getBcEmail() {
		return bcEmail;
	}

	public void setBcEmail(String bcEmail) {
		this.bcEmail = bcEmail;
	}

	public String getBcBankName() {
		return bcBankName;
	}

	public void setBcBankName(String bcBankName) {
		this.bcBankName = bcBankName;
	}

	public String getBcBankInfo() {
		return bcBankInfo;
	}

	public void setBcBankInfo(String bcBankInfo) {
		this.bcBankInfo = bcBankInfo;
	}

	public String getBcBankNo() {
		return bcBankNo;
	}

	public void setBcBankNo(String bcBankNo) {
		this.bcBankNo = bcBankNo;
	}

	public String getBcBankUser() {
		return bcBankUser;
	}

	public void setBcBankUser(String bcBankUser) {
		this.bcBankUser = bcBankUser;
	}

	public Set<InStoreInfo> getInStoreInfos() {
		return inStoreInfos;
	}

	public void setInStoreInfos(Set<InStoreInfo> inStoreInfos) {
		this.inStoreInfos = inStoreInfos;
	}

	public Set<PurchaseOrderSubInfo> getPurchaseOrderSubInfos() {
		return purchaseOrderSubInfos;
	}

	public void setPurchaseOrderSubInfos(
			Set<PurchaseOrderSubInfo> purchaseOrderSubInfos) {
		this.purchaseOrderSubInfos = purchaseOrderSubInfos;
	}

	public Set<OutSellInfo> getOutSellInfos() {
		return outSellInfos;
	}

	public void setOutSellInfos(Set<OutSellInfo> outSellInfos) {
		this.outSellInfos = outSellInfos;
	}

	public Set<PurchaseOrderInfo> getPurchaseOrderInfos() {
		return purchaseOrderInfos;
	}

	public void setPurchaseOrderInfos(Set<PurchaseOrderInfo> purchaseOrderInfos) {
		this.purchaseOrderInfos = purchaseOrderInfos;
	}

	public Set<ReturnInfo> getReturnInfos() {
		return returnInfos;
	}

	public void setReturnInfos(Set<ReturnInfo> returnInfos) {
		this.returnInfos = returnInfos;
	}

	public Integer getBcType() {
		return bcType;
	}

	public void setBcType(Integer bcType) {
		this.bcType = bcType;
	}

	

	

	// Property accessors

	
}