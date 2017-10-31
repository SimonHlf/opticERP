package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.factory.AppFactory;
import com.optic.module.BusinessContactInfo;
import com.optic.module.DepartmentInfo;
import com.optic.module.PayPurchaseInfo;
import com.optic.module.ProductInfo;
import com.optic.module.PurchaseOrderInfo;
import com.optic.module.PurchaseOrderSubInfo;
import com.optic.module.UserInfo;
import com.optic.service.PayPurchaseInfoManager;
import com.optic.service.PurchaseOrderSubInfoManager;
import com.optic.util.Constants;

public class PurchaseOrderInfoJson {

	private PurchaseOrderInfo po;
	private List<PurchaseOrderSubInfo> posList;
	private List<PayPurchaseInfo> ppList;
	
	public PurchaseOrderInfoJson(){
		
	}
	
	public PurchaseOrderInfoJson(PurchaseOrderInfo po,List<PurchaseOrderSubInfo> posList,List<PayPurchaseInfo> ppList){
		this.po = po;
		this.posList = posList;
		this.ppList = ppList;
	}
	
	public PurchaseOrderInfo getPo() {
		return po;
	}

	public void setPo(PurchaseOrderInfo po) {
		this.po = po;
	}

	public List<PurchaseOrderSubInfo> getPosList() {
		return posList;
	}

	public void setPosList(List<PurchaseOrderSubInfo> posList) {
		this.posList = posList;
	}

	public List<PayPurchaseInfo> getPpList() {
		return ppList;
	}

	public void setPpList(List<PayPurchaseInfo> ppList) {
		this.ppList = ppList;
	}

	/**
	 * 封装采购单
	 * @description
	 * @author wm
	 * @date 2017-5-6 下午03:35:03
	 * @param poList
	 * @return
	 * @throws Exception 
	 */
	public List<PurchaseOrderInfoJson> getPOJson(List<PurchaseOrderInfo> poList) throws Exception{
		PurchaseOrderSubInfoManager posm = (PurchaseOrderSubInfoManager)AppFactory.instance(null).getApp(Constants.WEB_PURCHASE_ORDER_SUB_INFO);
		PayPurchaseInfoManager ppm = (PayPurchaseInfoManager)AppFactory.instance(null).getApp(Constants.WEB_PAY_PURCHASE_INFO);
		List<PurchaseOrderInfoJson> result = new ArrayList<PurchaseOrderInfoJson>();
		for(Iterator<PurchaseOrderInfo> it = poList.iterator() ; it.hasNext() ;){
			PurchaseOrderInfo po = it.next();
			Integer poId = po.getId();//采购单编号
			//封装采购订单详细信息
			List<PurchaseOrderSubInfo> posList_new = new ArrayList<PurchaseOrderSubInfo>();
			//根据采购单编号获取采购订单详细信息记录
			List<PurchaseOrderSubInfo> posList = posm.listInfoByPoId(poId);
			for(Iterator<PurchaseOrderSubInfo> it_1 = posList.iterator() ; it_1.hasNext() ;){
				PurchaseOrderSubInfo pos = it_1.next();
				ProductInfo pro = pos.getProductInfo();
				DepartmentInfo dep_new = new DepartmentInfo(pro.getDepInfo().getId(),pro.getDepInfo().getDepName());
				ProductInfo pro_new = new ProductInfo(pro.getId(),null,pro.getProNo(),pro.getProName(),pro.getProPy(),
						pro.getProSpec(),pro.getProCz(),pro.getProUnit(),pro.getProType2(),dep_new,pro.getProPriceL(),
						pro.getProPriceH(),pro.getProPriceA(),pro.getProNumber(),pro.getProValNum(),pro.getProRemark());

				PurchaseOrderSubInfo pos_new = new PurchaseOrderSubInfo(pos.getId(),null,null,
						pro_new,pos.getProNumber(),pos.getProRealNum(),pos.getProPrice(),pos.getProTotalMoney());
				posList_new.add(pos_new);
			}
			//封装采购订单
			BusinessContactInfo bc = new BusinessContactInfo(po.getBusinessContactInfo().getId(),po.getBusinessContactInfo().getBcName());
			UserInfo user = new UserInfo();
			user.setId(po.getUserInfo().getId());
			user.setUserName(po.getUserInfo().getUserName());
			PurchaseOrderInfo po_new  = new PurchaseOrderInfo(poId,bc,
					user, po.getPurONo(), po.getPurDate(), po.getPurTotalMoney(),
					po.getPurRealMoney(), po.getStatus(), po.getPayStatus(),
					po.getInvoiceStatus(),po.getPurRemark());
			
			//封装付款记录详细列表
			List<PayPurchaseInfo> ppList = ppm.listInfoByPoId(poId);
			List<PayPurchaseInfo> ppList_new = new ArrayList<PayPurchaseInfo>();
			for(Iterator<PayPurchaseInfo> it_2 = ppList.iterator() ; it_2.hasNext() ;){
				PayPurchaseInfo pp = it_2.next();
				PayPurchaseInfo pp_new = new PayPurchaseInfo(pp.getId(),null, pp.getPayDate(), pp.getPayMoney(), pp.getPayOption());
				ppList_new.add(pp_new);
			}
			PurchaseOrderInfoJson poJson = new PurchaseOrderInfoJson(po_new,posList_new,ppList_new);
			result.add(poJson);
		}
		return result;
	}
	
	/**
	 * 封装所有未完成全部入库的采购订单
	 * @description
	 * @author wm
	 * @date 2017-6-8 上午09:45:01
	 * @param poList
	 * @return
	 * @throws Exception
	 */
	public List<PurchaseOrderInfo> getUnFinishJson(List<PurchaseOrderInfo> poList){
		List<PurchaseOrderInfo> result = new ArrayList<PurchaseOrderInfo>();
		for(Iterator<PurchaseOrderInfo> it = poList.iterator() ; it.hasNext() ;){
			PurchaseOrderInfo po = it.next();
			PurchaseOrderInfo po_new = new PurchaseOrderInfo(po.getId(),po.getPurONo());
			result.add(po_new);
		}
		return result;
	}
	
}
