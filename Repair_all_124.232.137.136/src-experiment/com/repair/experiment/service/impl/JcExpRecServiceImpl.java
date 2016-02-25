package com.repair.experiment.service.impl;

import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.JcExpRec;
import com.repair.experiment.dao.JcExpRecDao;
import com.repair.experiment.service.JcExpRecService;

public class JcExpRecServiceImpl implements JcExpRecService{
	
	@Resource
	private JcExpRecDao jcExpRecDao;

	@Override
	public List<JcExpRec> findJcExpRecs(int rjhmId, long jceiId) {
		return jcExpRecDao.findJcExpRecs(rjhmId, jceiId);
	}
}
