package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.factory.AppFactory;
import com.optic.module.InStoreSubInfo;
import com.optic.module.ProductInfo;
import com.optic.module.PurchaseOrderSubInfo;
import com.optic.module.WhStorageInfo;
import com.optic.service.InstoreSubInfoManager;
import com.optic.util.Constants;

public class PurchaseOrderSubInfoJson {
	private PurchaseOrderSubInfo posi;
	private WhStorageInfo wsi;
	
	public PurchaseOrderSubInfoJson(){
		
	}
	
	public PurchaseOrderSubInfoJson(PurchaseOrderSubInfo posi,WhStorageInfo wsi){
		this.posi = posi;
		this.wsi = wsi;
	}
	
	public PurchaseOrderSubInfo getPosi() {
		return posi;
	}
	public void setPosi(PurchaseOrderSubInfo posi) {
		this.posi = posi;
	}
	public WhStorageInfo getWsi() {
		return wsi;
	}
	public void setWsi(WhStorageInfo wsi) {
		this.wsi = wsi;
	}
	
	/**
	 * 封装指定采购订单下所有未完成的采购订单详情
	 * @description
	 * @author wm
	 * @date 2017-6-8 下午04:06:30
	 * @param posList
	 * @return
	 * @throws Exception
	 */
	public List<PurchaseOrderSubInfoJson> getUnFinishDetailJson(List<PurchaseOrderSubInfo> posList) throws Exception{
		List<PurchaseOrderSubInfoJson> result = new ArrayList<PurchaseOrderSubInfoJson>();
		InstoreSubInfoManager isim = (InstoreSubInfoManager) AppFactory.instance(null).getApp(Constants.WEB_IN_STORE_SUB_INFO);
		for(Iterator<PurchaseOrderSubInfo> it = posList.iterator() ; it.hasNext() ;){
			PurchaseOrderSubInfo pos = it.next();
			Integer purNumber = pos.getProNumber();
			Integer purRealNumber = pos.getProRealNum();
			if(purRealNumber < purNumber){//实际入库数量小于采购数量
				ProductInfo pro = pos.getProductInfo();
				Integer proId = pro.getId();
				ProductInfo pro_new = new ProductInfo(proId,pro.getProName(),pro.getProSpec(),pro.getProCz());
				PurchaseOrderSubInfo pos_new = new PurchaseOrderSubInfo(pos.getId(),null,null,pro_new,purNumber,
						purRealNumber,pos.getProPrice(),pos.getProTotalMoney());
				//从库存录入信息子表中查找最后该商品最后一次的入库货架信息
				List<InStoreSubInfo> isiList = isim.listLastInfoByProId(proId);
				WhStorageInfo wsi_new = null;
				if(isiList.size() > 0){
					InStoreSubInfo isi = isiList.get(0);
					WhStorageInfo wsi = isi.getWhStorageInfo();
					wsi_new = new WhStorageInfo(wsi.getId(),wsi.getWhsName());
				}
				PurchaseOrderSubInfoJson posi = new PurchaseOrderSubInfoJson(pos_new,wsi_new);
				result.add(posi);
			}
		}
		return result;
	}
}
