package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.SystemParameter;

public interface SystemDao {
	
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
	public void updateSystemParameter(String parameterName,String parameterValue);
}
