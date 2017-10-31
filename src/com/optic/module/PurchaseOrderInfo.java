package com.optic.module;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * PurchaseOrderInfo entity. @author MyEclipse Persistence Tools
 */

public class PurchaseOrderInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private BusinessContactInfo businessContactInfo;
	private UserInfo userInfo;
	private String purONo;
	private Timestamp purDate;
	private Double purTotalMoney;
	private Double purRealMoney;
	private Integer status;
	private Integer payStatus;
	private Integer invoiceStatus;
	private String purRemark;
	private Set<PurchaseOrderSubInfo> purchaseOrderSubInfos = new HashSet<PurchaseOrderSubInfo>();
	private Set<PayPurchaseInfo> payPurchaseInfos = new HashSet<PayPurchaseInfo>();

	// Constructors

	/** default constructor */
	public PurchaseOrderInfo() {
	}

	/** minimal constructor */
	public PurchaseOrderInfo(BusinessContactInfo businessContactInfo,
			UserInfo userInfo, String purONo, Timestamp purDate, Double purTotalMoney,
			Double purRealMoney, Integer status, Integer payStatus,
			Integer invoiceStatus,String purRemark) {
		this.businessContactInfo = businessContactInfo;
		this.userInfo = userInfo;
		this.purONo = purONo;
		this.purDate = purDate;
		this.purTotalMoney = purTotalMoney;
		this.purRealMoney = purRealMoney;
		this.status = status;
		this.payStatus = payStatus;
		this.invoiceStatus = invoiceStatus;
		this.purRemark = purRemark;
	}
	
	/** minimal constructor */
	public PurchaseOrderInfo(Integer id,String purONo) {
		this.id = id;
		this.purONo = purONo;
	}

	/** full constructor */
	public PurchaseOrderInfo(Integer id,BusinessContactInfo businessContactInfo,
			UserInfo userInfo, String purONo, Timestamp purDate, Double purTotalMoney,
			Double purRealMoney, Integer status, Integer payStatus,
			Integer invoiceStatus,String purRemark) {
		this.id = id;
		this.businessContactInfo = businessContactInfo;
		this.userInfo = userInfo;
		this.purONo = purONo;
		this.purDate = purDate;
		this.purTotalMoney = purTotalMoney;
		this.purRealMoney = purRealMoney;
		this.status = status;
		this.payStatus = payStatus;
		this.invoiceStatus = invoiceStatus;
		this.purRemark = purRemark;
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

	public String getPurONo() {
		return purONo;
	}

	public void setPurONo(String purONo) {
		this.purONo = purONo;
	}

	public Timestamp getPurDate() {
		return purDate;
	}

	public void setPurDate(Timestamp purDate) {
		this.purDate = purDate;
	}

	public Double getPurTotalMoney() {
		return purTotalMoney;
	}

	public void setPurTotalMoney(Double purTotalMoney) {
		this.purTotalMoney = purTotalMoney;
	}

	public Double getPurRealMoney() {
		return purRealMoney;
	}

	public void setPurRealMoney(Double purRealMoney) {
		this.purRealMoney = purRealMoney;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(Integer payStatus) {
		this.payStatus = payStatus;
	}

	public String getPurRemark() {
		return purRemark;
	}

	public void setPurRemark(String purRemark) {
		this.purRemark = purRemark;
	}

	public Set<PurchaseOrderSubInfo> getPurchaseOrderSubInfos() {
		return purchaseOrderSubInfos;
	}

	public void setPurchaseOrderSubInfos(
			Set<PurchaseOrderSubInfo> purchaseOrderSubInfos) {
		this.purchaseOrderSubInfos = purchaseOrderSubInfos;
	}

	public Set<PayPurchaseInfo> getPayPurchaseInfos() {
		return payPurchaseInfos;
	}

	public void setPayPurchaseInfos(Set<PayPurchaseInfo> payPurchaseInfos) {
		this.payPurchaseInfos = payPurchaseInfos;
	}

	public Integer getInvoiceStatus() {
		return invoiceStatus;
	}

	public void setInvoiceStatus(Integer invoiceStatus) {
		this.invoiceStatus = invoiceStatus;
	}

	
	// Property accessors

	
}