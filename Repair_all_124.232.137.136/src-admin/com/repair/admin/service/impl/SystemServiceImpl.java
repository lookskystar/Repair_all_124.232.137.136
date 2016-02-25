package com.repair.admin.service.impl;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;

import com.repair.admin.dao.SystemDao;
import com.repair.admin.service.SystemService;
import com.repair.common.pojo.SystemParameter;

public class SystemServiceImpl implements SystemService{
	
	@Resource(name="systemDao")
	private SystemDao systemDao;
	
	@Override
	public String getParameterValueById(int id) {
		return systemDao.getParameterValueById(id);
	}

	@Override
	public List<SystemParameter> listSystemParameter() {
		return systemDao.listSystemParameter();
	}

	@SuppressWarnings("unchecked")
	@Override
	public void updateSystemParameter(Map<String, String> param) {
		for (Iterator iterator = param.entrySet().iterator(); iterator.hasNext();) {
			Entry<String, String> e = (Entry<String, String>) iterator.next();
			systemDao.updateSystemParameter(e.getKey(), e.getValue());
		}
	}
}
