package com.repair.work.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.OilAssayDetailRecorer;
import com.repair.common.pojo.OilAssayItem;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.common.pojo.OilAssaySubItem;
import com.repair.work.dao.OilAssayDao;
import com.repair.work.service.OilAssayService;

/**
 * 油水化验ServiceImpl
 * @author Administrator
 *
 */
public class OilAssayServiceImpl implements OilAssayService {
	
	@Resource(name="oilAssayDao")
	private OilAssayDao oilAssayDao;

	@Override
	public List<DatePlanPri> findAssayJcs() {
		return oilAssayDao.findAssayJcs();
	}

	@Override
	public List<OilAssayPriRecorder> findOilAssayPriRecorderAll() {
		return oilAssayDao.findOilAssayPriRecorderAll();
	}

	@Override
	public void saveOilAssayPriRecorder(OilAssayPriRecorder recorder) {
		oilAssayDao.saveOilAssayPriRecorder(recorder);
	}

	@Override
	public DatePlanPri findDatePlanPriById(int dpId) {
		return oilAssayDao.findDatePlanPriById(dpId);
	}

	@Override
	public OilAssayPriRecorder findOilAssayPriRecorderById(long recId) {
		return oilAssayDao.findOilAssayPriRecorderById(recId);
	}

	@Override
	public void updateOilAssayPriRecorder(OilAssayPriRecorder recorder) {
		oilAssayDao.updateOilAssayPriRecorder(recorder);
	}

	@Override
	public List<OilAssayItem> findOilAssayItemByJcType(String jcType) {
		return oilAssayDao.findOilAssayItemByJcType(jcType);
	}

	@Override
	public List<OilAssaySubItem> findOilAssaySubItemByItemId(int itemId) {
		return oilAssayDao.findOilAssaySubItemByItemId(itemId);
	}

	@Override
	public List<Map<String,Object>> findOilDetailRecorderByRecId(int itemId,long recId,String jcType) {
		if(oilAssayDao.findOilDetailRecorderCount(itemId, recId)==0){
			oilAssayDao.saveOilDetailRecorder(itemId, recId,jcType);//将油水化验记录信息插入到记录明细表中
		}
		List<Object[]> list=oilAssayDao.findOilDetailRecorder(itemId, recId);
		List<Map<String,Object>> details=new ArrayList<Map<String,Object>>();
		
		for(Object[] obj:list){
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("recdetailid", obj[0]);
			map.put("subitemtitle", obj[1]);
			map.put("minVal", obj[2]);
			map.put("maxVal", obj[3]);
			map.put("realdeteval", obj[4]);
			map.put("quagrade", obj[5]);
			map.put("receiptpeo", obj[6]);
			map.put("fintime", obj[7]);
			details.add(map);
		}
		return details;
	}

	@Override
	public OilAssayDetailRecorer findDetailRecorderById(long recDetailId) {
		return oilAssayDao.findDetailRecorderById(recDetailId);
	}

	@Override
	public void updateOilAssayDetailRecorer(OilAssayDetailRecorer detailRecorder) {
		oilAssayDao.updateOilAssayDetailRecorer(detailRecorder);
	}

	@Override
	public Object[] findMaxMinValue(long recDetailId) {
		return oilAssayDao.findMaxMinValue(recDetailId);
	}

	@Override
	public OilAssayPriRecorder findOilAssayRecByDailyId(Integer rjhmId) {
		return oilAssayDao.findOilAssayRecByDailyId(rjhmId);
		
	}

}
