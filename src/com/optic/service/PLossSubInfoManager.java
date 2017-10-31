package com.optic.service;

import java.sql.Timestamp;
import java.util.List;

import org.hibernate.Session;

import com.optic.exception.WEBException;
import com.optic.module.PLossSubInfo;

public interface PLossSubInfoManager {
	
	/**
	 * 增加材料损耗信息子表信息（损耗量自动计算）
	 * @description
	 * @author wm
	 * @date 2017-6-22 上午09:29:41
	 * @param plId 损耗信息编号
	 * @param depId 工序（部门）编号
	 * @param inNum 领料量
	 * @param comNum 完品量
	 * @param comDate 完成日期
	 * @param assumeUser 担当
	 * @param remark 备注
	 * @return
	 * @throws WEBException
	 */
	Integer addPLS(Integer plId,Integer depId,Integer inNum,Integer comNum,
			Timestamp comDate,String assumeUser,String remark)throws WEBException;
	
	/**
	 * 根据材料损耗主表编号获取所有的子表信息
	 * @description
	 * @author wm
	 * @date 2017-6-22 上午09:36:43
	 * @param plId 主表编号
	 * @return
	 * @throws WEBException
	 */
	List<PLossSubInfo> listInfoByPlId(Integer plId)throws WEBException;
	
	/**
	 * 根据材料损耗主表编号、部门编号获取材料损耗子表信息列表
	 * @description
	 * @author wm
	 * @date 2017-6-26 下午03:56:37
	 * @param plId 损耗信息编号
	 * @param depId 工序（部门）编号
	 * @return
	 * @throws WEBException
	 */
	List<PLossSubInfo> listInfoByOption(Integer plId,Integer depId)throws WEBException;
	
	List<Object> listGoroupInfoByPlId(Integer plId)throws WEBException;
}
