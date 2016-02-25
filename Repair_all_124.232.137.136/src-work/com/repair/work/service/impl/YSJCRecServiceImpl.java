package com.repair.work.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.YSJCRec;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.work.dao.YSJCRecDao;
import com.repair.work.service.YSJCRecService;

public class YSJCRecServiceImpl implements YSJCRecService{
	
	@Resource(name="datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	@Resource(name="ysjcRecDao")
	private YSJCRecDao ysjcRecDao;
	
	private static final SimpleDateFormat SDF = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
	
	@Override
	public YSJCRec getYSJCRecById(int recId) {
		return ysjcRecDao.getYSJCRecById(recId);
	}

	@Override
	public void updateSign(List<Integer> recIdList, int typeFlag, String xm,
			Integer allFlag, Integer rjhmId) {
		ysjcRecDao.updateSign(recIdList, typeFlag, xm, SDF.format(new Date()), allFlag, rjhmId);
	}

	@Override
	public void updateYSJCRec(YSJCRec ysjcRec) {
		ysjcRecDao.updateYSJCRec(ysjcRec);
	}

	public void addYSJCRec(int rjhmId) {
		DatePlanPri datePlanPri = datePlanPriDao.findDatePlanPriById(rjhmId);
		ysjcRecDao.insertYSJCRec(rjhmId, datePlanPri.getJcType());
	}

	public Long countYSJCRec(int rjhmId) {
		return ysjcRecDao.countYSJCRec(rjhmId);
	}

	@Override
	public List<YSJCRec> listYSJCRec(int rjhmId) {
		return ysjcRecDao.listYSJCRecByRjhmId(rjhmId);
	}
	
	@Override
	public List<YSJCRec> listYSJCRec(int rjhmId,long proteam) {
		return ysjcRecDao.listYSJCRecByRjhmId(rjhmId,proteam);
	}
	
	public long countBefSignRec(int rjhmId){
		return ysjcRecDao.countBefSignRec(rjhmId);
	}

}
