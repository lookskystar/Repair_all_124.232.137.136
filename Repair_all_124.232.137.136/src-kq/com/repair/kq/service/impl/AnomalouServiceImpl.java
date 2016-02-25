package com.repair.kq.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.util.fusioncharts.MSArea2DCategory;
import com.repair.common.util.fusioncharts.MSArea2DCategoryData;
import com.repair.common.util.fusioncharts.MSArea2DChart;
import com.repair.common.util.fusioncharts.MSArea2DChartSet;
import com.repair.common.util.fusioncharts.MSData2Data;
import com.repair.common.util.fusioncharts.MSData2DataSet;
import com.repair.kq.dao.AnomalouDao;
import com.repair.kq.service.AnomalouService;

public class AnomalouServiceImpl implements AnomalouService {

	private AnomalouDao anomalouDao;

	private static final SimpleDateFormat YM = new SimpleDateFormat("yyyy-MM");

	private static final SimpleDateFormat YMD = new SimpleDateFormat("yyyy-MM-dd");

	@Resource
	public void setAnomalouDao(AnomalouDao anomalouDao) {
		this.anomalouDao = anomalouDao;
	}

	@Override
	public MSArea2DChartSet createMSArea2D(Map<String, String> params) throws Exception {
		String month = params.get("month");
		String proteamId = params.get("proteamId");
		String userName = params.get("userName");

		Calendar calendar = Calendar.getInstance();
		Date now = YM.parse(month);
		calendar.setTime(now);
		// 获取时间条件的最大天数
		int monthMaxDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
		int monthMinDay = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);

		// 设置chart属性数据
		MSArea2DChartSet msArea2DChartSet = new MSArea2DChartSet();
		MSArea2DChart msArea2DChart = new MSArea2DChart();
		msArea2DChartSet.setChart(msArea2DChart);
		// 设置categories属性数据
		List<MSArea2DCategory> categories = new ArrayList<MSArea2DCategory>();
		MSArea2DCategory category = new MSArea2DCategory();
		List<MSArea2DCategoryData> categoryDatas = new ArrayList<MSArea2DCategoryData>();
		// 设置早退属性数据
		MSData2DataSet dataSetEarly = new MSData2DataSet();
		dataSetEarly.setSeriesName("早退");
		dataSetEarly.setColor("B1D1DC");
		dataSetEarly.setPlotBorderColor("B1D1DC");
		List<MSData2Data> datasEarly = new ArrayList<MSData2Data>();
		// 设置迟到属性数据
		MSData2DataSet dataSetLate = new MSData2DataSet();
		dataSetLate.setSeriesName("迟到");
		dataSetLate.setColor("C8A1D1");
		dataSetLate.setPlotBorderColor("C8A1D1");
		List<MSData2Data> datasLate = new ArrayList<MSData2Data>();
		List<Object> earlyList = anomalouDao.countAnomalousEarly(month, proteamId, userName);
		List<Object> lateList = anomalouDao.countAnomalousLate(month, proteamId, userName);
		for (int i = 0; i < monthMaxDay; i++) {
			// 设置x轴坐标
			calendar.set(Calendar.DATE, monthMinDay + i);
			Date eachDate = calendar.getTime();
			String eachDateStr = YMD.format(eachDate);
			MSArea2DCategoryData categoryData = new MSArea2DCategoryData();
			categoryData.setLabel(eachDateStr);
			categoryDatas.add(categoryData);
			// 设置早退x轴坐标对应的数据
			MSData2Data dataEarly = new MSData2Data();
			Object[] earlyAry = (Object[]) earlyList.get(i);
			dataEarly.setValue(earlyAry[1] + "");
			datasEarly.add(dataEarly);
			// 设置迟到x轴坐标对应的数据
			MSData2Data dataLate = new MSData2Data();
			Object[] lateAry =(Object[]) lateList.get(i);
			dataLate.setValue(lateAry[1] + "");
			datasLate.add(dataLate);
		}
		category.setCategory(categoryDatas);
		categories.add(category);
		msArea2DChartSet.setCategories(categories);
		// 设置统计数据
		List<MSData2DataSet> dataSets = new ArrayList<MSData2DataSet>();
		dataSetEarly.setData(datasEarly);
		dataSetLate.setData(datasLate);
		dataSets.add(dataSetEarly);
		dataSets.add(dataSetLate);
		msArea2DChartSet.setDataset(dataSets);
		return msArea2DChartSet;
	}
}
