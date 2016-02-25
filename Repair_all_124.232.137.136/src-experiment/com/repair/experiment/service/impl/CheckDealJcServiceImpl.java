package com.repair.experiment.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.pojo.UsersPrivs;
import com.repair.experiment.dao.CheckDealJcDao;
import com.repair.experiment.service.CheckDealJcService;

public class CheckDealJcServiceImpl implements CheckDealJcService{
	@Resource(name="checkDealJcDao")
	private CheckDealJcDao checkDealJcDao;

	@Override
	public List<Object[]> findCheckDealDatePlan() {
		return checkDealJcDao.findCheckDealDatePlan();
	}

	@Override
	public void saveSignedForFinish(SignedForFinish signedForFinish) {
		checkDealJcDao.saveSignedForFinish(signedForFinish);
	}

	@Override
	public void saveDatePlanPri(DatePlanPri datePlanPri) {
		checkDealJcDao.saveDatePlanPri(datePlanPri);
	}

	@Override
	public int findJtPreDictByStatus(int type,int rjhmId) {
		return checkDealJcDao.findJtPreDictByStatus(type,rjhmId);
	}

}
