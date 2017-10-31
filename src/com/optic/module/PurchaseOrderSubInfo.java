package com.optic.module;

/**
 * PurchaseOrderSubInfo entity. @author MyEclipse Persistence Tools
 */

public class PurchaseOrderSubInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private PurchaseOrderInfo purchaseOrderInfo;
	private BusinessContactInfo businessContactInfo;
	private ProductInfo productInfo;
	private Integer proNumber;
	private Integer proRealNum;
	private Double proPrice;
	private Double proTotalMoney;

	// Constructors

	/** default constructor */
	public PurchaseOrderSubInfo() {
	}

	/** minimal constructor */
	public PurchaseOrderSubInfo(PurchaseOrderInfo purchaseOrderInfo,
			BusinessContactInfo businessContactInfo, ProductInfo productInfo,
			Integer proNumber, Integer proRealNum, Double proPrice, Double proTotalMoney) {
		this.purchaseOrderInfo = purchaseOrderInfo;
		this.businessContactInfo = businessContactInfo;
		this.productInfo = productInfo;
		this.proNumber = proNumber;
		this.proRealNum = proRealNum;
		this.proPrice = proPrice;
		this.proTotalMoney = proTotalMoney;
	}

	/** full constructor */
	public PurchaseOrderSubInfo(Integer id,PurchaseOrderInfo purchaseOrderInfo,
			BusinessContactInfo businessContactInfo, ProductInfo productInfo,
			Integer proNumber, Integer proRealNum, Double proPrice, Double proTotalMoney) {
		this.id = id;
		this.purchaseOrderInfo = purchaseOrderInfo;
		this.businessContactInfo = businessContactInfo;
		this.productInfo = productInfo;
		this.proNumber = proNumber;
		this.proRealNum = proRealNum;
		this.proPrice = proPrice;
		this.proTotalMoney = proTotalMoney;
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

	public BusinessContactInfo getBusinessContactInfo() {
		return businessContactInfo;
	}

	public void setBusinessContactInfo(BusinessContactInfo businessContactInfo) {
		this.businessContactInfo = businessContactInfo;
	}

	public ProductInfo getProductInfo() {
		return productInfo;
	}

	public void setProductInfo(ProductInfo productInfo) {
		this.productInfo = productInfo;
	}

	public Integer getProNumber() {
		return proNumber;
	}

	public void setProNumber(Integer proNumber) {
		this.proNumber = proNumber;
	}

	public Integer getProRealNum() {
		return proRealNum;
	}

	public void setProRealNum(Integer proRealNum) {
		this.proRealNum = proRealNum;
	}

	public Double getProPrice() {
		return proPrice;
	}

	public void setProPrice(Double proPrice) {
		this.proPrice = proPrice;
	}

	public Double getProTotalMoney() {
		return proTotalMoney;
	}

	public void setProTotalMoney(Double proTotalMoney) {
		this.proTotalMoney = proTotalMoney;
	}

	
	// Property accessors

	

}