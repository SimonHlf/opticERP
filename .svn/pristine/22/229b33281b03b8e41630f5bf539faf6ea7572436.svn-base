package com.optic.module;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * PLossInfo entity. @author MyEclipse Persistence Tools
 */

public class PLossInfo implements java.io.Serializable {

	// Fields

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Integer id;
	private InStoreSubInfo iss;//入库子表编号
	private ProductInfo pro;//领料材料编号
	private Integer proNewId;//新产品编号
	private Timestamp startTime;//开始加工时间
	private Timestamp endTime;//完结时间
	private String batchNo;//批次
	private Integer matchNum;//加工数量
	private Integer comNum;//完品数量
	private Integer lossNum;//损耗数量
	private Double comRate;//完品率
	private Integer comStatus;//完成状态
	private Set<PLossSubInfo> proLossSubInfos = new HashSet<PLossSubInfo>();

	// Constructors

	/** default constructor */
	public PLossInfo() {
		
	}

	/** minimal constructor */
	public PLossInfo(InStoreSubInfo iss, ProductInfo pro,Integer proNewId,
			Timestamp startTime, Timestamp endTime, String batchNo, Integer matchNum,
			Integer comNum, Integer lossNum, Double comRate, Integer comStatus) {
		this.iss = iss;
		this.pro = pro;
		this.proNewId = proNewId;
		this.startTime = startTime;
		this.endTime = endTime;
		this.batchNo = batchNo;
		this.matchNum = matchNum;
		this.comNum = comNum;
		this.lossNum = lossNum;
		this.comRate = comRate;
		this.comStatus = comStatus;
	}

	/** full constructor */
	public PLossInfo(Integer id, InStoreSubInfo iss, ProductInfo pro,Integer proNewId,
			Timestamp startTime, Timestamp endTime, String batchNo, Integer matchNum,
			Integer comNum, Integer lossNum, Double comRate, Integer comStatus) {
		this.id = id;
		this.iss = iss;
		this.pro = pro;
		this.proNewId = proNewId;
		this.startTime = startTime;
		this.endTime = endTime;
		this.batchNo = batchNo;
		this.matchNum = matchNum;
		this.comNum = comNum;
		this.lossNum = lossNum;
		this.comRate = comRate;
		this.comStatus = comStatus;
	}

	// Property accessors
	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public InStoreSubInfo getIss() {
		return iss;
	}

	public void setIss(InStoreSubInfo iss) {
		this.iss = iss;
	}

	public ProductInfo getPro() {
		return pro;
	}

	public void setPro(ProductInfo pro) {
		this.pro = pro;
	}

	
	public Timestamp getStartTime() {
		return startTime;
	}

	public void setStartTime(Timestamp startTime) {
		this.startTime = startTime;
	}

	public Timestamp getEndTime() {
		return endTime;
	}

	public void setEndTime(Timestamp endTime) {
		this.endTime = endTime;
	}

	public String getBatchNo() {
		return batchNo;
	}

	public void setBatchNo(String batchNo) {
		this.batchNo = batchNo;
	}

	public Integer getMatchNum() {
		return matchNum;
	}

	public void setMatchNum(Integer matchNum) {
		this.matchNum = matchNum;
	}

	public Integer getComNum() {
		return comNum;
	}

	public void setComNum(Integer comNum) {
		this.comNum = comNum;
	}

	public Integer getLossNum() {
		return lossNum;
	}

	public void setLossNum(Integer lossNum) {
		this.lossNum = lossNum;
	}

	public Double getComRate() {
		return comRate;
	}

	public void setComRate(Double comRate) {
		this.comRate = comRate;
	}

	public Integer getComStatus() {
		return comStatus;
	}

	public void setComStatus(Integer comStatus) {
		this.comStatus = comStatus;
	}

	public Set<PLossSubInfo> getProLossSubInfos() {
		return proLossSubInfos;
	}

	public void setProLossSubInfos(Set<PLossSubInfo> proLossSubInfos) {
		this.proLossSubInfos = proLossSubInfos;
	}

	public Integer getProNewId() {
		return proNewId;
	}

	public void setProNewId(Integer proNewId) {
		this.proNewId = proNewId;
	}	
}