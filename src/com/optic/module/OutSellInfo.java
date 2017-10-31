package com.optic.module;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * OutSellInfo entity. @author MyEclipse Persistence Tools
 */

public class OutSellInfo implements java.io.Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// Fields

	private Integer id;
	private BusinessContactInfo businessContactInfo;
	private String busUserName;
	private String outSNo;
	private Double allPrice;
	private Double actPrice;
	private Integer outStatus;
	private Integer outType;
	private Timestamp outDate;
	private Integer outUserId;
	private String outUserName;
	private String expressNo;
	private Set<OutSellSubInfo> outSellSubInfos = new HashSet<OutSellSubInfo>();
	private Set<PayReOutsellInfo> payReOutsellInfos = new HashSet<PayReOutsellInfo>();

	// Constructors

	/** default constructor */
	public OutSellInfo() {
	}

	/** minimal constructor */
	public OutSellInfo(BusinessContactInfo businessContactInfo, String busUserName, String outSNo,
			Double allPrice, Double actPrice,Integer outStatus,Integer outType,Timestamp outDate,Integer outUserId,
			String outUserName,String expressNo) {
		this.businessContactInfo = businessContactInfo;
		this.busUserName = busUserName;
		this.outSNo = outSNo;
		this.allPrice = allPrice;
		this.actPrice = actPrice;
		this.outStatus = outStatus;
		this.outType = outType;
		this.outDate = outDate;
		this.outUserId = outUserId;
		this.outUserName = outUserName;
		this.expressNo = expressNo;
	}

	/** full constructor */
	public OutSellInfo(Integer id,BusinessContactInfo businessContactInfo, String busUserName, String outSNo,
			Double allPrice, Double actPrice,Integer outStatus,Integer outType,Timestamp outDate,Integer outUserId,
			String outUserName,String expressNo) {
		this.id = id;
		this.businessContactInfo = businessContactInfo;
		this.busUserName = busUserName;
		this.outSNo = outSNo;
		this.allPrice = allPrice;
		this.actPrice = actPrice;
		this.outStatus = outStatus;
		this.outType = outType;
		this.outDate = outDate;
		this.outUserId = outUserId;
		this.outUserName = outUserName;
		this.expressNo = expressNo;
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

	public String getOutSNo() {
		return outSNo;
	}

	public void setOutSNo(String outSNo) {
		this.outSNo = outSNo;
	}

	public Double getAllPrice() {
		return allPrice;
	}

	public void setAllPrice(Double allPrice) {
		this.allPrice = allPrice;
	}

	public Integer getOutStatus() {
		return outStatus;
	}

	public void setOutStatus(Integer outStatus) {
		this.outStatus = outStatus;
	}

	public Timestamp getOutDate() {
		return outDate;
	}

	public void setOutDate(Timestamp outDate) {
		this.outDate = outDate;
	}

	public Integer getOutUserId() {
		return outUserId;
	}

	public void setOutUserId(Integer outUserId) {
		this.outUserId = outUserId;
	}

	public String getOutUserName() {
		return outUserName;
	}

	public void setOutUserName(String outUserName) {
		this.outUserName = outUserName;
	}

	public String getExpressNo() {
		return expressNo;
	}

	public void setExpressNo(String expressNo) {
		this.expressNo = expressNo;
	}

	public Set<OutSellSubInfo> getOutSellSubInfos() {
		return outSellSubInfos;
	}

	public void setOutSellSubInfos(Set<OutSellSubInfo> outSellSubInfos) {
		this.outSellSubInfos = outSellSubInfos;
	}

	public String getBusUserName() {
		return busUserName;
	}

	public void setBusUserName(String busUserName) {
		this.busUserName = busUserName;
	}

	public Integer getOutType() {
		return outType;
	}

	public void setOutType(Integer outType) {
		this.outType = outType;
	}

	public Double getActPrice() {
		return actPrice;
	}

	public void setActPrice(Double actPrice) {
		this.actPrice = actPrice;
	}

	public Set<PayReOutsellInfo> getPayReOutsellInfos() {
		return payReOutsellInfos;
	}

	public void setPayReOutsellInfos(Set<PayReOutsellInfo> payReOutsellInfos) {
		this.payReOutsellInfos = payReOutsellInfos;
	}

	// Property accessors

}