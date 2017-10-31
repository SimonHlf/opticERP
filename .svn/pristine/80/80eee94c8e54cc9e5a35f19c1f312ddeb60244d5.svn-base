package com.optic.module.json;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import com.optic.module.PayReOutsellInfo;

public class PayReOutsellInfoJson {
	public List<PayReOutsellInfo> getProsJson(List<PayReOutsellInfo> prosList){
		List<PayReOutsellInfo> result = new ArrayList<PayReOutsellInfo>();
		for(Iterator<PayReOutsellInfo> it = prosList.iterator() ; it.hasNext();){
			PayReOutsellInfo pros = it.next();
			PayReOutsellInfo pros_new = new PayReOutsellInfo(null, null, pros.getRepMoney(), null, pros.getRepDate());
			result.add(pros_new);
		}
		return result;
	}
}
