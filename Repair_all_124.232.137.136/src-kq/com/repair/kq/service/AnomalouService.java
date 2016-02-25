package com.repair.kq.service;

import java.util.Map;

import com.repair.common.util.fusioncharts.MSArea2DChartSet;

public interface AnomalouService {
	
	/**
	 * 创建MSArea2D
	 * @param params
	 * @return
	 */
	MSArea2DChartSet createMSArea2D(Map<String, String> params) throws Exception;

}
