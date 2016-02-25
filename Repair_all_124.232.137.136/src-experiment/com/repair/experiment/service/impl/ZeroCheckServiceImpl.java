package com.repair.experiment.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.ZeroCheck;
import com.repair.experiment.dao.ZeroCheckDao;
import com.repair.experiment.service.ZeroCheckService;

public class ZeroCheckServiceImpl implements ZeroCheckService{
	@Resource(name="zeroCheckDao")
	private ZeroCheckDao zeroCheckDao;

	@Override
	public List<DatePlanPri> findCheckDatePlanPri(UsersPrivs user) {
		return zeroCheckDao.findCheckDatePlanPri(user);
	}

	@Override
	public void saveZeroCheck(ZeroCheck zeroCheck) {
		zeroCheckDao.saveZeroCheck(zeroCheck);
	}

	@Override
	public ZeroCheck findZeroCheckByUserDpId(DatePlanPri datePlanPri,
			UsersPrivs user) {
		return zeroCheckDao.findZeroCheckByUserDpId(datePlanPri, user);
	}

	@Override
	public List<ZeroCheck> findZeroCheckByDpId(int dpId) {
		return zeroCheckDao.findZeroCheckByDpId(dpId);
	}

}
