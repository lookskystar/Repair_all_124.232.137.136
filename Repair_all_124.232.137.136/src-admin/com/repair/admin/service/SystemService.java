package com.repair.admin.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.SystemParameter;

public interface SystemService {
	
	/**
	 * 查询所有
	 */
	public List<SystemParameter> listSystemParameter();
	
	/**
	 * 根据参数ID查询结果值
	 */
	public String getParameterValueById(int id);
	
	/**
	 * 修改参数
	 */
	public void updateSystemParameter(Map<String,String> param);
}
