package com.optic.module;

import java.sql.Timestamp;
import java.util.HashSet;
import java.util.Set;

/**
 * OutInfo entity. @author MyEclipse Persistence Tools
 */

public class OutInfo implements java.io.Serializable {

	// Fields

	private Integer id;
	private UserInfo userInfo;
	private DepartmentInfo departmentInfo;
	private String outNo;
	private String applyUser;
	private Timestamp applyDate;
	private Integer outStatus;
	private String remark;
	private Set<OutSubInfo> outSubInfos = new HashSet<OutSubInfo>();

	// Constructors

	/** default constructor */
	public OutInfo() {
	}

	/** minimal constructor */
	public OutInfo(UserInfo userInfo, DepartmentInfo departmentInfo,
			String outNo, String applyUser, Timestamp applyDate, Integer outStatus,String remark) {
		this.userInfo = userInfo;
		this.departmentInfo = departmentInfo;
		this.outNo = outNo;
		this.applyUser = applyUser;
		this.applyDate = applyDate;
		this.outStatus = outStatus;
		this.remark = remark;
	}

	/** full constructor */
	public OutInfo(Integer id,UserInfo userInfo, DepartmentInfo departmentInfo,
			String outNo, String applyUser, Timestamp applyDate, Integer outStatus,String remark) {
		this.id = id;
		this.userInfo = userInfo;
		this.departmentInfo = departmentInfo;
		this.outNo = outNo;
		this.applyUser = applyUser;
		this.applyDate = applyDate;
		this.outStatus = outStatus;
		this.remark = remark;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public UserInfo getUserInfo() {
		return userInfo;
	}

	public void setUserInfo(UserInfo userInfo) {
		this.userInfo = userInfo;
	}

	public DepartmentInfo getDepartmentInfo() {
		return departmentInfo;
	}

	public void setDepartmentInfo(DepartmentInfo departmentInfo) {
		this.departmentInfo = departmentInfo;
	}

	public String getOutNo() {
		return outNo;
	}

	public void setOutNo(String outNo) {
		this.outNo = outNo;
	}

	public String getApplyUser() {
		return applyUser;
	}

	public void setApplyUser(String applyUser) {
		this.applyUser = applyUser;
	}

	public Timestamp getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(Timestamp applyDate) {
		this.applyDate = applyDate;
	}

	public Integer getOutStatus() {
		return outStatus;
	}

	public void setOutStatus(Integer outStatus) {
		this.outStatus = outStatus;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Set<OutSubInfo> getOutSubInfos() {
		return outSubInfos;
	}

	public void setOutSubInfos(Set<OutSubInfo> outSubInfos) {
		this.outSubInfos = outSubInfos;
	}

	// Property accessors

	
}