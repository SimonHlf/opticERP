package com.optic.module;

import java.sql.Timestamp;

/**
 * InStoreSubInfo entity. @author MyEclipse Persistence Tools
 */

public class InStoreSubInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private WhStorageInfo whStorageInfo;
	private ProductInfo productInfo;
	private InStoreInfo inStoreInfo;
	private Integer inNumber;
	private Timestamp inDate;
	private String batchNo;
	private Integer remainNum;

	// Constructors

	/** default constructor */
	public InStoreSubInfo() {
	}

	/** mini constructor*/
	public InStoreSubInfo(WhStorageInfo whStorageInfo, ProductInfo productInfo,
			InStoreInfo inStoreInfo, Integer inNumber, Timestamp inDate,String batchNo,Integer remainNum) {
		this.whStorageInfo = whStorageInfo;
		this.productInfo = productInfo;
		this.inStoreInfo = inStoreInfo;
		this.inNumber = inNumber;
		this.inDate = inDate;
		this.batchNo = batchNo;
		this.remainNum = remainNum;
	}
	
	public InStoreSubInfo(Integer id) {
		this.id = id;
	}
	
	/** full constructor */
	public InStoreSubInfo(Integer id,WhStorageInfo whStorageInfo, ProductInfo productInfo,
			InStoreInfo inStoreInfo, Integer inNumber, Timestamp inDate,String batchNo,Integer remainNum) {
		this.id = id;
		this.whStorageInfo = whStorageInfo;
		this.productInfo = productInfo;
		this.inStoreInfo = inStoreInfo;
		this.inNumber = inNumber;
		this.inDate = inDate;
		this.batchNo = batchNo;
		this.remainNum = remainNum;
	}

	// Property accessors

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public WhStorageInfo getWhStorageInfo() {
		return this.whStorageInfo;
	}

	public void setWhStorageInfo(WhStorageInfo whStorageInfo) {
		this.whStorageInfo = whStorageInfo;
	}

	public ProductInfo getProductInfo() {
		return this.productInfo;
	}

	public void setProductInfo(ProductInfo productInfo) {
		this.productInfo = productInfo;
	}

	public InStoreInfo getInStoreInfo() {
		return this.inStoreInfo;
	}

	public void setInStoreInfo(InStoreInfo inStoreInfo) {
		this.inStoreInfo = inStoreInfo;
	}

	public Integer getInNumber() {
		return this.inNumber;
	}

	public void setInNumber(Integer inNumber) {
		this.inNumber = inNumber;
	}

	public Timestamp getInDate() {
		return this.inDate;
	}

	public void setInDate(Timestamp inDate) {
		this.inDate = inDate;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public Integer getRemainNum() {
		return remainNum;
	}

	public void setRemainNum(Integer remainNum) {
		this.remainNum = remainNum;
	}

}