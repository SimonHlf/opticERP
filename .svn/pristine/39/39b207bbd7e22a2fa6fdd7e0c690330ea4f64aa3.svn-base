package com.optic.module;

import java.sql.Timestamp;

/**
 * PayPurchaseInfo entity. @author MyEclipse Persistence Tools
 */

public class PayPurchaseInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private PurchaseOrderInfo purchaseOrderInfo;
	private Timestamp payDate;
	private Double payMoney;
	private String payOption;

	// Constructors

	/** default constructor */
	public PayPurchaseInfo() {
	}

	/** minimal constructor */
	public PayPurchaseInfo(PurchaseOrderInfo purchaseOrderInfo, Timestamp payDate, Double payMoney, String payOption) {
		this.purchaseOrderInfo = purchaseOrderInfo;
		this.payDate = payDate;
		this.payMoney = payMoney;
		this.payOption = payOption;
	}
	
	/** full constructor */
	public PayPurchaseInfo(Integer id,PurchaseOrderInfo purchaseOrderInfo, Timestamp payDate, Double payMoney, String payOption) {
		this.id = id;
		this.purchaseOrderInfo = purchaseOrderInfo;
		this.payDate = payDate;
		this.payMoney = payMoney;
		this.payOption = payOption;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public PurchaseOrderInfo getPurchaseOrderInfo() {
		return purchaseOrderInfo;
	}

	public void setPurchaseOrderInfo(PurchaseOrderInfo purchaseOrderInfo) {
		this.purchaseOrderInfo = purchaseOrderInfo;
	}

	public Double getPayMoney() {
		return payMoney;
	}

	public void setPayMoney(Double payMoney) {
		this.payMoney = payMoney;
	}

	public String getPayOption() {
		return payOption;
	}

	public void setPayOption(String payOption) {
		this.payOption = payOption;
	}

	public Timestamp getPayDate() {
		return payDate;
	}

	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}

	
	// Property accessors



}